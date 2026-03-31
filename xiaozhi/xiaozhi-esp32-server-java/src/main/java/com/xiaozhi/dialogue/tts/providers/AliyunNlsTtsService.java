package com.xiaozhi.dialogue.tts.providers;

import com.alibaba.nls.client.protocol.NlsClient;
import com.alibaba.nls.client.protocol.OutputFormatEnum;
import com.alibaba.nls.client.protocol.SampleRateEnum;
import com.alibaba.nls.client.protocol.tts.SpeechSynthesizer;
import com.alibaba.nls.client.protocol.tts.SpeechSynthesizerListener;
import com.alibaba.nls.client.protocol.tts.SpeechSynthesizerResponse;
import com.xiaozhi.dialogue.token.TokenService;
import com.xiaozhi.dialogue.tts.TtsService;
import com.xiaozhi.entity.SysConfig;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.nio.ByteBuffer;
import java.util.concurrent.CountDownLatch;

/**
 * 阿里云NLS标准语音合成服务
 * 使用阿里云智能语音交互SDK实现TTS功能
 */
public class AliyunNlsTtsService implements TtsService {
    private static final Logger logger = LoggerFactory.getLogger(AliyunNlsTtsService.class);

    private static final String PROVIDER_NAME = "aliyun-nls";

    // 阿里云NLS服务的默认URL
    private static final String NLS_URL = "wss://nls-gateway.aliyuncs.com/ws/v1";

    // 阿里云配置
    private final SysConfig config;
    private final String voiceName;
    private final String outputPath;
    
    // 语音参数
    private final Float pitch;
    private final Float speed;

    // Token管理器
    private final TokenService tokenService;

    public AliyunNlsTtsService(SysConfig config, String voiceName, Float pitch, Float speed, String outputPath, TokenService tokenService) {
        this.config = config;
        this.voiceName = voiceName;
        this.pitch = pitch;
        this.speed = speed;
        this.outputPath = outputPath;
        this.tokenService = tokenService;
    }

    /**
     * 创建新的NLS客户端实例
     * 为每个TTS请求创建独立的客户端，避免WebSocket连接竞争
     */
    private NlsClient createClient() throws Exception {
        String accessToken = tokenService.getToken();
        if (accessToken == null) {
            throw new RuntimeException("无法获取阿里云Token");
        }
        return new NlsClient(NLS_URL, accessToken);
    }

    @Override
    public String getProviderName() {
        return PROVIDER_NAME;
    }

    @Override
    public String getVoiceName() {
        return voiceName;
    }

    @Override
    public Float getSpeed() {
        return speed;
    }

    @Override
    public Float getPitch() {
        return pitch;
    }

    @Override
    public String textToSpeech(String text) throws Exception {
        if (text == null || text.isEmpty()) {
            logger.warn("文本内容为空！");
            return null;
        }

        ByteArrayOutputStream outputStream = new ByteArrayOutputStream();
        CountDownLatch latch = new CountDownLatch(1);
        NlsClient client = null;
        SpeechSynthesizer synthesizer = null;

        try {
            // 为每个请求创建独立的客户端实例
            client = createClient();

            synthesizer = new SpeechSynthesizer(client, new SpeechSynthesizerListener() {
                @Override
                public void onComplete(SpeechSynthesizerResponse response) {
                    logger.info("NLS语音合成完成 - TaskId: {}", response.getTaskId());
                    latch.countDown();
                }

                @Override
                public void onFail(SpeechSynthesizerResponse response) {
                    logger.error("NLS语音合成失败 - TaskId: {}, Status: {}, StatusText: {}",
                            response.getTaskId(), response.getStatus(), response.getStatusText());
                    latch.countDown();
                }

                @Override
                public void onMessage(ByteBuffer message) {
                    byte[] buffer = new byte[message.remaining()];
                    message.get(buffer);
                    try {
                        outputStream.write(buffer);
                    } catch (IOException e) {
                        logger.error("写入音频数据失败", e);
                    }
                }
            });

            // 设置appKey
            synthesizer.setAppKey(config.getApiKey());
            // 设置语音输出格式
            synthesizer.setFormat(OutputFormatEnum.WAV);
            // 设置采样率
            synthesizer.setSampleRate(SampleRateEnum.SAMPLE_RATE_16K);
            // 设置语音
            synthesizer.setVoice(voiceName);
            // 设置音量
            synthesizer.setVolume(100);
            
            // 设置语速和音调（映射：0.5-2.0 → -500~500）
            int nlsSpeed = (int)Math.round((speed - 1.0f) * 500);
            int nlsPitch = (int)Math.round((pitch - 1.0f) * 500);
            nlsSpeed = Math.max(-500, Math.min(500, nlsSpeed));
            nlsPitch = Math.max(-500, Math.min(500, nlsPitch));
            
            synthesizer.setSpeechRate(nlsSpeed);
            synthesizer.setPitchRate(nlsPitch);

            synthesizer.setText(text);
            synthesizer.start();

            // 设置超时时间，避免无限等待
            if (!latch.await(30, java.util.concurrent.TimeUnit.SECONDS)) {
                logger.error("NLS语音合成超时");
                throw new RuntimeException("语音合成超时");
            }

            // 检查是否有音频数据生成
            byte[] audioData = outputStream.toByteArray();
            if (audioData.length == 0) {
                throw new RuntimeException("未生成音频数据");
            }

            String audioFileName = getAudioFileName();
            String filePath = outputPath + audioFileName;

            File outputDir = new File(outputPath);
            if (!outputDir.exists()) {
                outputDir.mkdirs();
            }

            try (FileOutputStream fileOutputStream = new FileOutputStream(filePath)) {
                fileOutputStream.write(audioData);
            }

            return filePath;

        } catch (Exception e) {
            logger.error("阿里云NLS语音合成失败: {}", e.getMessage(), e);
            throw e;
        } finally {
            // 确保资源被正确清理
            if (synthesizer != null) {
                try {
                    synthesizer.close();
                } catch (Exception e) {
                    logger.warn("关闭SpeechSynthesizer失败", e);
                }
            }
            if (client != null) {
                try {
                    client.shutdown();
                } catch (Exception e) {
                    logger.warn("关闭NlsClient失败", e);
                }
            }
        }
    }
}

package com.xiaozhi.dialogue.tts.providers;

import com.alibaba.dashscope.aigc.multimodalconversation.AudioParameters;
import com.alibaba.dashscope.aigc.multimodalconversation.MultiModalConversation;
import com.alibaba.dashscope.aigc.multimodalconversation.MultiModalConversationParam;
import com.alibaba.dashscope.aigc.multimodalconversation.MultiModalConversationResult;
import com.alibaba.dashscope.audio.tts.SpeechSynthesisAudioFormat;
import com.alibaba.dashscope.audio.tts.SpeechSynthesisParam;
import com.alibaba.dashscope.audio.tts.SpeechSynthesizer;
import com.xiaozhi.dialogue.tts.TtsService;
import com.xiaozhi.entity.SysConfig;
import com.xiaozhi.utils.AudioUtils;

import cn.hutool.core.util.StrUtil;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.net.URL;
import java.nio.ByteBuffer;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;
import java.util.concurrent.Future;
import java.util.concurrent.TimeUnit;
import java.util.concurrent.TimeoutException;
import java.util.HashMap;
import java.util.Map;

public class AliyunTtsService implements TtsService {
    private static final Logger logger = LoggerFactory.getLogger(AliyunTtsService.class);

    private static final String PROVIDER_NAME = "aliyun";
    // 添加重试次数常量
    private static final int MAX_RETRY_ATTEMPTS = 3;
    // 添加重试间隔常量（毫秒）
    private static final long RETRY_DELAY_MS = 1000;
    // 添加TTS操作超时时间（秒）
    private static final long TTS_TIMEOUT_SECONDS = 5;
    
    // 使用共享的线程池，避免频繁创建和销毁
    private static final ExecutorService sharedExecutor = Executors.newCachedThreadPool();
    
    // 音色映射表：将音色名称映射到AudioParameters.Voice枚举
    // Qwen3音色（17个，支持多语种）
    private static final Map<String, AudioParameters.Voice> VOICE_MAP = new HashMap<>();

    static {
        VOICE_MAP.put("Cherry", AudioParameters.Voice.CHERRY);          // 芊悦 - 阳光积极、亲切自然小姐姐
        VOICE_MAP.put("Ethan", AudioParameters.Voice.ETHAN);            // 晨煦 - 标准普通话，阳光温暖
        VOICE_MAP.put("Nofish", AudioParameters.Voice.NOFISH);          // 不吃鱼 - 不会翘舌音的设计师
        VOICE_MAP.put("Jennifer", AudioParameters.Voice.JENNIFER);      // 詹妮弗 - 品牌级、电影质感般美语女声
        VOICE_MAP.put("Ryan", AudioParameters.Voice.RYAN);              // 甜茶 - 节奏拉满，戏感炸裂
        VOICE_MAP.put("Katerina", AudioParameters.Voice.KATERINA);      // 卡捷琳娜 - 御姐音色，韵律回味十足
        VOICE_MAP.put("Elias", AudioParameters.Voice.ELIAS);            // 墨讲师 - 学科严谨性与叙事技巧
        VOICE_MAP.put("Jada", AudioParameters.Voice.JADA);              // 上海-阿珍 - 风风火火的沪上阿姐
        VOICE_MAP.put("Dylan", AudioParameters.Voice.DYLAN);            // 北京-晓东 - 北京胡同里长大的少年
        VOICE_MAP.put("Sunny", AudioParameters.Voice.SUNNY);            // 四川-晴儿 - 甜到你心里的川妹子
        VOICE_MAP.put("Li", AudioParameters.Voice.LI);                  // 南京-老李 - 耐心的瑜伽老师
        VOICE_MAP.put("Marcus", AudioParameters.Voice.MARCUS);          // 陕西-秦川 - 面宽话短，心实声沉
        VOICE_MAP.put("Roy", AudioParameters.Voice.ROY);                // 闽南-阿杰 - 诙谐直爽、市井活泼
        VOICE_MAP.put("Peter", AudioParameters.Voice.PETER);            // 天津-李彼得 - 天津相声，专业捧人
        VOICE_MAP.put("Rocky", AudioParameters.Voice.ROCKY);            // 粤语-阿强 - 幽默风趣的阿强
        VOICE_MAP.put("Kiki", AudioParameters.Voice.KIKI);              // 粤语-阿清 - 甜美的港妹闺蜜
        VOICE_MAP.put("Eric", AudioParameters.Voice.ERIC);              // 四川-程川 - 跳脱市井的四川成都男子
    }

    // 阿里云配置
    private final String apiKey;
    private final String voiceName;
    private final String outputPath;
    
    // 语音参数
    private final Float pitch;
    private final Float speed;

    public AliyunTtsService(SysConfig config,
            String voiceName, Float pitch, Float speed, String outputPath) {
        this.apiKey = config.getApiKey();
        this.voiceName = voiceName;
        this.pitch = pitch;
        this.speed = speed;
        this.outputPath = outputPath;
    }

    /**
     * 解析音色参数，支持格式：
     * 4. "cosyvoice-v2:longanyang" - 指定模型和音色（冒号分隔）
     * 5. "cosyvoice-v3-flash:longanyang" - 指定模型和音色（冒号分隔）
     * 6. "cosyvoice-v3-plus:longanyang" - 指定模型和音色（冒号分隔）
     * 7. "longanyang" - 只有音色，默认使用 cosyvoice-v2
     *
     * @param voiceParam 音色参数
     * @return [模型名, 音色名]
     */
    private String[] parseCosyVoiceParam(String voiceParam) {
        if (voiceParam == null || voiceParam.isEmpty()) {
            return new String[]{"cosyvoice-v2", voiceParam};
        }

        // 检查是否是音色克隆返回的格式（如：cosyvoice-v3-plus-voiceclone-xxx）
        if (voiceParam.startsWith("cosyvoice-v3-plus-")) {
            return new String[]{"cosyvoice-v3-plus", voiceParam};
        } else if (voiceParam.startsWith("cosyvoice-v3-flash-")) {
            return new String[]{"cosyvoice-v3-flash", voiceParam};
        } else if (voiceParam.startsWith("cosyvoice-v2-")) {
            return new String[]{"cosyvoice-v2", voiceParam};
        }

        // 检查是否包含模型前缀（冒号分隔格式，如：cosyvoice-v3-plus:longanyang）
        if (voiceParam.contains(":")) {
            String[] parts = voiceParam.split(":", 2);
            String model = parts[0];
            String voice = parts.length > 1 ? parts[1] : "";

            // 验证模型名称是否为有效的 CosyVoice 模型
            if ("cosyvoice-v2".equals(model) || "cosyvoice-v3-flash".equals(model) || "cosyvoice-v3-plus".equals(model)) {
                return new String[]{model, voice};
            }
            // 如果模型名称无效，将整个字符串视为音色名
            logger.warn("无效的 CosyVoice 模型名称: {}, 使用默认模型 cosyvoice-v2", model);
            return new String[]{"cosyvoice-v2", voiceParam};
        }

        // 没有模型前缀，使用默认模型
        return new String[]{"cosyvoice-v2", voiceParam};
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
        try {
            if (voiceName.contains("sambert")) {
                return ttsSambert(text);
            } else if (VOICE_MAP.get(voiceName) != null) {
                return ttsQwen(text);
            } else {
                return ttsCosyvoice(text);
            }
        } catch (Exception e) {
            logger.error("语音合成aliyun -使用{}模型语音合成失败：", voiceName, e);
            throw new Exception("语音合成失败");
        }
    }

    private String ttsQwen(String text) {
        int attempts = 0;
        while (attempts < MAX_RETRY_ATTEMPTS) {
            try {
                AudioParameters.Voice voice = VOICE_MAP.get(voiceName);
                MultiModalConversationParam param = MultiModalConversationParam.builder()
                        .model("qwen3-tts-flash")
                        .apiKey(apiKey)
                        .text(text)
                        .voice(voice)
                        .build();
                
                // 使用共享线程池而不是每次创建新的
                Future<MultiModalConversationResult> future = sharedExecutor.submit(() -> {
                    MultiModalConversation conv = new MultiModalConversation();
                    return conv.call(param);
                });
                
                // 等待结果，设置超时
                MultiModalConversationResult result;
                try {
                    result = future.get(TTS_TIMEOUT_SECONDS, TimeUnit.SECONDS);
                } catch (TimeoutException e) {
                    future.cancel(true);
                    logger.warn("语音合成aliyun - 使用{}模型超时，正在重试 ({}/{})", voiceName, attempts + 1, MAX_RETRY_ATTEMPTS);
                    attempts++;
                    if (attempts >= MAX_RETRY_ATTEMPTS) {
                        logger.error("语音合成aliyun - 使用{}模型多次超时，放弃重试", voiceName);
                        return StrUtil.EMPTY;
                    }
                    // 等待一段时间后重试
                    TimeUnit.MILLISECONDS.sleep(RETRY_DELAY_MS);
                    continue;
                }
                
                // 检查结果是否有效
                if (result == null || result.getOutput() == null || 
                    result.getOutput().getAudio() == null || 
                    result.getOutput().getAudio().getUrl() == null) {
                    
                    logger.warn("语音合成aliyun - 使用{}模型返回无效结果，正在重试 ({}/{})", voiceName, attempts + 1, MAX_RETRY_ATTEMPTS);
                    attempts++;
                    if (attempts >= MAX_RETRY_ATTEMPTS) {
                        logger.error("语音合成aliyun - 使用{}模型多次返回无效结果，放弃重试", voiceName);
                        return StrUtil.EMPTY;
                    }
                    // 等待一段时间后重试
                    TimeUnit.MILLISECONDS.sleep(RETRY_DELAY_MS);
                    continue;
                }
                
                String audioUrl = result.getOutput().getAudio().getUrl();
                String outPath = outputPath + getAudioFileName();
                File file = new File(outPath);
                
                // 下载音频文件到本地，也使用共享线程池
                Future<Boolean> downloadFuture = sharedExecutor.submit(() -> {
                    try (InputStream in = new URL(audioUrl).openStream();
                            FileOutputStream out = new FileOutputStream(file)) {
                        byte[] buffer = new byte[1024];
                        int bytesRead;
                        while ((bytesRead = in.read(buffer)) != -1) {
                            out.write(buffer, 0, bytesRead);
                        }
                        return true;
                    } catch (Exception e) {
                        return false;
                    }
                });
                
                try {
                    Boolean downloadSuccess = downloadFuture.get(TTS_TIMEOUT_SECONDS, TimeUnit.SECONDS);
                    if (!downloadSuccess) {
                        throw new IOException("下载音频文件失败");
                    }
                } catch (TimeoutException e) {
                    downloadFuture.cancel(true);
                    logger.warn("语音合成aliyun - 使用{}模型下载音频超时，正在重试 ({}/{})", voiceName, attempts + 1, MAX_RETRY_ATTEMPTS);
                    attempts++;
                    if (attempts >= MAX_RETRY_ATTEMPTS) {
                        logger.error("语音合成aliyun - 使用{}模型多次下载超时，放弃重试", voiceName);
                        return StrUtil.EMPTY;
                    }
                    // 等待一段时间后重试
                    TimeUnit.MILLISECONDS.sleep(RETRY_DELAY_MS);
                    continue;
                }
                
                return outPath;
            } catch (Exception e) {
                attempts++;
                if (attempts < MAX_RETRY_ATTEMPTS) {
                    logger.warn("语音合成aliyun - 使用{}模型失败，正在重试 ({}/{}): {}", voiceName, attempts, MAX_RETRY_ATTEMPTS, e.getMessage());
                    try {
                        // 等待一段时间后重试
                        TimeUnit.MILLISECONDS.sleep(RETRY_DELAY_MS);
                    } catch (InterruptedException ie) {
                        Thread.currentThread().interrupt();
                        logger.error("重试等待被中断", ie);
                        return StrUtil.EMPTY;
                    }
                } else {
                    logger.error("语音合成aliyun - 使用{}模型语音合成失败，已达到最大重试次数：", voiceName, e);
                    return StrUtil.EMPTY;
                }
            }
        }
        return StrUtil.EMPTY;
    }

    // cosyvoice默认并发只有3个，所以需要增加一个重试机制
    private String ttsCosyvoice(String text) {
        int attempts = 0;
        // 解析音色参数，获取模型名和音色名
        String[] parsed = parseCosyVoiceParam(voiceName);
        String modelName = parsed[0];
        String actualVoiceName = parsed[1];
        logger.info("使用 CosyVoice TTS - 模型: {}, 音色: {}", modelName, actualVoiceName);

        while (attempts < MAX_RETRY_ATTEMPTS) {
            try {
                com.alibaba.dashscope.audio.ttsv2.SpeechSynthesisParam param =
                com.alibaba.dashscope.audio.ttsv2.SpeechSynthesisParam.builder()
                                .apiKey(apiKey)
                                .model(modelName)  // 使用解析出的模型名
                                .voice(actualVoiceName)  // 使用解析出的音色名
                                .speechRate(speed)
                                .pitchRate(pitch)
                                .format(com.alibaba.dashscope.audio.ttsv2.SpeechSynthesisAudioFormat.WAV_16000HZ_MONO_16BIT)
                                .build();

                // 使用共享线程池
                Future<ByteBuffer> future = sharedExecutor.submit(() -> {
                    com.alibaba.dashscope.audio.ttsv2.SpeechSynthesizer synthesizer =
                        new com.alibaba.dashscope.audio.ttsv2.SpeechSynthesizer(param, null);
                    return synthesizer.call(text);
                });

                // 等待结果，设置超时
                ByteBuffer audio;
                try {
                    audio = future.get(TTS_TIMEOUT_SECONDS, TimeUnit.SECONDS);
                    logger.info("CosyVoice语音合成成功 - 模型: {}, 音色: {}", modelName, actualVoiceName);
                } catch (TimeoutException e) {
                    future.cancel(true);
                    logger.warn("语音合成aliyun - 使用{}模型超时，正在重试 ({}/{}) - 音色: {}", modelName, attempts + 1, MAX_RETRY_ATTEMPTS, actualVoiceName);
                    attempts++;
                    if (attempts >= MAX_RETRY_ATTEMPTS) {
                        logger.error("语音合成aliyun - 使用{}模型多次超时，放弃重试 - 音色: {}", modelName, actualVoiceName);
                        return StrUtil.EMPTY;
                    }
                    // 等待一段时间后重试
                    TimeUnit.MILLISECONDS.sleep(RETRY_DELAY_MS);
                    continue;
                }

                // 检查返回的ByteBuffer是否为null
                if (audio == null) {
                    attempts++;
                    if (attempts < MAX_RETRY_ATTEMPTS) {
                        logger.warn("语音合成aliyun - 使用{}模型返回null，正在重试 ({}/{}) - 音色: {}", modelName, attempts, MAX_RETRY_ATTEMPTS, actualVoiceName);
                        // 等待一段时间后重试
                        TimeUnit.MILLISECONDS.sleep(RETRY_DELAY_MS);
                        continue;
                    } else {
                        logger.error("语音合成aliyun - 使用{}模型多次返回null，放弃重试 - 音色: {}", modelName, actualVoiceName);
                        return StrUtil.EMPTY;
                    }
                }

                String outPath = outputPath + getAudioFileName();
                File file = new File(outPath);
                try (FileOutputStream fos = new FileOutputStream(file)) {
                    fos.write(audio.array());
                } catch (IOException e) {
                    logger.error("语音合成aliyun -使用{}模型语音合成失败 - 音色: {}", modelName, actualVoiceName, e);
                    return StrUtil.EMPTY;
                }
                return outPath;
            } catch (Exception e) {
                attempts++;
                if (attempts < MAX_RETRY_ATTEMPTS) {
                    logger.warn("语音合成aliyun - 使用{}模型失败，正在重试 ({}/{}) - 音色: {}: {}", modelName, attempts, MAX_RETRY_ATTEMPTS, actualVoiceName, e.getMessage());
                    try {
                        // 等待一段时间后重试
                        TimeUnit.MILLISECONDS.sleep(RETRY_DELAY_MS);
                    } catch (InterruptedException ie) {
                        Thread.currentThread().interrupt();
                        logger.error("重试等待被中断 - 模型: {}", modelName, ie);
                        return StrUtil.EMPTY;
                    }
                } else {
                    logger.error("语音合成aliyun -使用{}模型语音合成失败，已达到最大重试次数 - 音色: {}", modelName, actualVoiceName, e);
                    return StrUtil.EMPTY;
                }
            }
        }
        return StrUtil.EMPTY;
    }

    public String ttsSambert(String text) {
        int attempts = 0;
        while (attempts < MAX_RETRY_ATTEMPTS) {
            try {
                SpeechSynthesisParam param = SpeechSynthesisParam.builder()
                        .apiKey(apiKey)
                        .model(voiceName)
                        .text(text)
                        .rate(speed)
                        .pitch(pitch)
                        .sampleRate(AudioUtils.SAMPLE_RATE)
                        .format(SpeechSynthesisAudioFormat.WAV)
                        .build();
                
                // 使用共享线程池
                Future<ByteBuffer> future = sharedExecutor.submit(() -> {
                    SpeechSynthesizer synthesizer = new SpeechSynthesizer();
                    return synthesizer.call(param);
                });
                
                // 等待结果，设置超时
                ByteBuffer audio;
                try {
                    audio = future.get(TTS_TIMEOUT_SECONDS, TimeUnit.SECONDS);
                } catch (TimeoutException e) {
                    future.cancel(true);
                    logger.warn("语音合成aliyun - 使用{}模型超时，正在重试 ({}/{})，文本：{}", voiceName, attempts + 1, MAX_RETRY_ATTEMPTS, text);
                    attempts++;
                    if (attempts >= MAX_RETRY_ATTEMPTS) {
                        logger.error("语音合成aliyun - 使用{}模型多次超时，放弃重试，文本：{}", voiceName, text);
                        return StrUtil.EMPTY;
                    }
                    // 等待一段时间后重试
                    TimeUnit.MILLISECONDS.sleep(RETRY_DELAY_MS);
                    continue;
                }
                
                // 检查返回的ByteBuffer是否为null
                if (audio == null) {
                    attempts++;
                    if (attempts < MAX_RETRY_ATTEMPTS) {
                        logger.warn("语音合成aliyun - 使用{}模型返回null，正在重试 ({}/{})", voiceName, attempts, MAX_RETRY_ATTEMPTS);
                        // 等待一段时间后重试
                        TimeUnit.MILLISECONDS.sleep(RETRY_DELAY_MS);
                        continue;
                    } else {
                        logger.error("语音合成aliyun - 使用{}模型多次返回null，放弃重试", voiceName);
                        return StrUtil.EMPTY;
                    }
                }
                
                String outPath = outputPath + getAudioFileName();
                File file = new File(outPath);
                try (FileOutputStream fos = new FileOutputStream(file)) {
                    fos.write(audio.array());
                } catch (IOException e) {
                    logger.error("语音合成aliyun - 使用{}模型失败：", voiceName, e);
                    return StrUtil.EMPTY;
                }
                return outPath;
            } catch (Exception e) {
                attempts++;
                if (attempts < MAX_RETRY_ATTEMPTS) {
                    logger.warn("语音合成aliyun - 使用{}模型失败，正在重试 ({}/{}): {}", voiceName, attempts, MAX_RETRY_ATTEMPTS, e.getMessage());
                    try {
                        // 等待一段时间后重试
                        TimeUnit.MILLISECONDS.sleep(RETRY_DELAY_MS);
                    } catch (InterruptedException ie) {
                        Thread.currentThread().interrupt();
                        logger.error("重试等待被中断", ie);
                        return StrUtil.EMPTY;
                    }
                } else {
                    logger.error("语音合成aliyun - 使用{}模型失败，已达到最大重试次数：", voiceName, e);
                    return StrUtil.EMPTY;
                }
            }
        }
        return StrUtil.EMPTY;
    }
}
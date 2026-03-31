package com.xiaozhi.dialogue.service;

import com.xiaozhi.communication.common.ChatSession;
import com.xiaozhi.communication.common.SessionManager;
import com.xiaozhi.dialogue.llm.ChatService;
import com.xiaozhi.dialogue.llm.intent.IntentDetector;
import com.xiaozhi.dialogue.llm.intent.IntentDetector.UserIntent;
import com.xiaozhi.dialogue.llm.memory.*;
import com.xiaozhi.dialogue.service.VadService.VadStatus;
import com.xiaozhi.dialogue.stt.SttService;
import com.xiaozhi.dialogue.stt.factory.SttServiceFactory;
import com.xiaozhi.dialogue.tts.TtsService;
import com.xiaozhi.dialogue.tts.factory.TtsServiceFactory;
import com.xiaozhi.entity.SysConfig;
import com.xiaozhi.entity.SysDevice;
import com.xiaozhi.entity.SysRole;
import com.xiaozhi.event.ChatAbortEvent;
import com.xiaozhi.event.ChatSessionCloseEvent;
import com.xiaozhi.service.*;

import com.xiaozhi.utils.AudioUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.ai.chat.messages.MessageType;
import org.springframework.ai.chat.messages.UserMessage;
import org.springframework.ai.chat.model.ChatResponse;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.ApplicationContext;
import org.springframework.stereotype.Service;
import org.springframework.util.Assert;
import org.springframework.util.ObjectUtils;
import org.springframework.util.StringUtils;

import jakarta.annotation.Resource;
import reactor.core.publisher.Flux;

import java.nio.file.Path;
import java.util.*;
import java.util.function.Supplier;

/**
 * 对话处理服务
 * 负责处理语音识别和对话生成的业务逻辑
 * 由于DialogueService 是无状态的，未来可以考虑拆分得更细一些，真正的面向对象编程（状态与过程封装）。
 */
@Service
public class DialogueService{
    private static final Logger logger = LoggerFactory.getLogger(DialogueService.class);
    
    // 从配置文件读取TTS相关参数
    @Value("${tts.timeout.ms:10000}")
    private long TTS_TIMEOUT_MS;
    
    @Value("${tts.max.retry.count:1}")
    private int MAX_RETRY_COUNT;
    
    @Value("${tts.retry.delay.ms:1000}")
    private long TTS_RETRY_DELAY_MS;
    
    @Value("${tts.max.concurrent.per.session:3}")
    private int MAX_CONCURRENT_PER_SESSION;

    @Resource
    private ApplicationContext applicationContext;

    @Resource
    private ChatService chatService;

    @Resource
    private TtsServiceFactory ttsFactory;

    @Resource
    private SttServiceFactory sttFactory;

    @Resource
    private MessageService messageService;

    @Resource
    private VadService vadService;

    @Resource
    private SessionManager sessionManager;

    @Resource
    private SysMessageService sysMessageService;
    
    @Resource
    private SysConfigService configService;
    
    @Resource
    private SysRoleService roleService;

    @Resource
    private IntentDetector intentDetector;

    @Resource
    private GoodbyeMessageSupplier goodbyeMessages;

    @Resource
    private TimeoutMessageSupplier timeoutMessages;

    @org.springframework.context.event.EventListener
    public void onApplicationEvent(ChatSessionCloseEvent event) {
        ChatSession chatSession = event.getSession();
        if(chatSession != null) {
            cleanupSession(chatSession);
        }
    }

    @org.springframework.context.event.EventListener
    public void onApplicationEvent(ChatAbortEvent event) {
        ChatSession chatSession = event.getSession();
        String reason = event.getReason();
        abortDialogue(chatSession, reason);
    }

    /**
     * 处理音频数据
     */
    public void processAudioData(ChatSession session, byte[] opusData) {
        if (session == null || opusData == null || opusData.length == 0) {
            return;
        }
        String sessionId = session.getSessionId();
        
        try {
            // 如果正在唤醒响应中,忽略音频数据,避免被唤醒词误触发VAD
            // 如果会话标记为即将关闭,忽略音频数据,避免在播放告别语时触发新的对话
            if (session.isInWakeupResponse() || session.isCloseAfterChat()) {
                return;
            }

            SysDevice device = session.getSysDevice();
            // 如果设备未注册或未绑定，忽略音频数据
            if (device == null || ObjectUtils.isEmpty(device.getRoleId())) {
                return;
            }
            SysRole role = roleService.selectRoleById(device.getRoleId());
            // 获取STT和TTS配置
            SysConfig sttConfig = role.getSttId() != null ? configService.selectConfigById(role.getSttId())
                    : null;

            // 处理VAD
            VadService.VadResult vadResult = vadService.processAudio(sessionId, opusData);
            if (vadResult == null || vadResult.getStatus() == VadStatus.ERROR
                    || vadResult.getProcessedData() == null) {
                return;
            }

            // 检测到语音活动，更新最后活动时间
            sessionManager.updateLastActivity(sessionId);
            // 根据VAD状态处理
            switch (vadResult.getStatus()) {
                case SPEECH_START:
                    // 检测到语音开始

                    if(session.getSynthesizer()!=null && session.getSynthesizer().isDialog()){
                        //检测到vad，触发当前语音打断事件
                        applicationContext.publishEvent(new ChatAbortEvent(session, "检测到vad"));
                    }
                    startStt(session, sessionId, sttConfig, device, vadResult.getProcessedData());
                    break;

                case SPEECH_CONTINUE:
                    // 语音继续，发送数据到流式识别
                    if (sessionManager.isStreaming(sessionId)) {
                        sessionManager.sendAudioData(sessionId, vadResult.getProcessedData());
                    }
                    break;

                case SPEECH_END:
                    // 语音结束，完成流式识别
                    if (sessionManager.isStreaming(sessionId)) {
                        sessionManager.completeAudioStream(sessionId);
                        sessionManager.setStreamingState(sessionId, false);
                    }
                    break;

                default:
                    break;
            }
        } catch (Exception e) {
            logger.error("处理音频数据失败: {}", e.getMessage(), e);
        }
    }

    /**
     * 启动语音识别
     */
    private void startStt(
            ChatSession session,
            String sessionId,
            SysConfig sttConfig,
            SysDevice device,
            byte[] initialAudio) {
        Assert.notNull(session, "session不能为空");

        Thread.startVirtualThread(() -> {
            try {
                // 如果已经在进行流式识别，先清理旧的资源
                sessionManager.closeAudioStream(sessionId);

                // 创建新的音频数据接收管道
                sessionManager.createAudioStream(sessionId);
                sessionManager.setStreamingState(sessionId, true);

                // 获取STT服务
                SttService sttService = sttFactory.getSttService(sttConfig);
                if (sttService == null) {
                    logger.error("无法获取STT服务 - Provider: {}", sttConfig != null ? sttConfig.getProvider() : "null");
                    return;
                }

                // 发送初始音频数据
                if (initialAudio != null && initialAudio.length > 0) {
                    sessionManager.sendAudioData(sessionId, initialAudio);
                }

                final String finalText;
                if (sessionManager.getAudioStream(sessionId) != null) {
                    finalText = sttService.streamRecognition(sessionManager.getAudioStream(sessionId));
                    if (!StringUtils.hasText(finalText)) {
                        return;
                    }
                } else {
                    return;
                }
                messageService.sendSttMessage(session, finalText);

                // 立即发送start消息，通知设备进入说话状态，避免在LLM处理期间错误监听环境声音
                messageService.sendTtsMessage(session, null, "start");

                // 获取当前语音活动的PCM数据
                List<byte[]> pcmFrames = vadService.getPcmData(session.getSessionId());
                UserMessage userMessage = saveUserAudio(session, pcmFrames, finalText);

                // 设置LLM生成消息的时间戳作为Assistant消息的创建时间戳，也用于约定保存音频文件的路径。一定要在LLM前设置时间戳。
                final Long assistantTimeMillis =  System.currentTimeMillis();
                session.setAssistantTimeMillis(assistantTimeMillis);

                // 优先检测用户意图，如果检测到明确意图则直接处理，不走 LLM
                UserIntent intent = intentDetector.detectIntent(finalText);
                if (intent != null) {
                    handleIntent(session, intent, finalText);
                    return;
                }

                boolean useFunctionCall = true;
                Flux<ChatResponse> chatResponseFlux =chatService.chatStream(session, userMessage, useFunctionCall);
                // 初始化对话状态
                Synthesizer synthesizer = initSynthesizer(session);
                synthesizer.startSynthesis(chatResponseFlux);
            } catch (Exception e) {
                logger.error("流式识别错误: {}", e.getMessage(), e);
            }
        });
    }

    /**
     * 保存用户音频数据
     */
    private UserMessage saveUserAudio(ChatSession session, List<byte[]> pcmFrames, String finalText) {


            // 设置用户收到音频的时间戳作为用户消息的创建时间戳，也用于约定保存音频文件的路径。
            final Long userTimeMillis =  System.currentTimeMillis();
            UserMessage userMessage = new UserMessage(finalText);
            userMessage.getMetadata().put(ChatMemory.TIME_MILLIS_KEY,userTimeMillis);
            if (pcmFrames != null && !pcmFrames.isEmpty()) {
                // 计算总大小并合并PCM帧
                int totalSize = pcmFrames.stream().mapToInt(frame -> frame.length).sum();
                byte[] fullPcmData = new byte[totalSize];
                int offset = 0;

                for (byte[] frame : pcmFrames) {
                    System.arraycopy(frame, 0, fullPcmData, offset, frame.length);
                    offset += frame.length;
                }
                try {
                // 保存为WAV文件
                Path path = session.getAudioPath(MessageType.USER.getValue(), userTimeMillis);
                AudioUtils.saveAsWav(path,fullPcmData);
                logger.debug("用户音频已保存: {}", path.toString());

                userMessage.getMetadata().put(ChatMemory.AUDIO_PATH,path);
                } catch (Exception e) {
                    logger.error("保存用户音频失败: {}", e.getMessage(), e);
                }
            }
            return userMessage;
    }

    /**
     * 初始化对话状态
     */
    private Synthesizer initSynthesizer(ChatSession chatSession) {

        SysDevice device = chatSession.getSysDevice();
        Assert.notNull(device, "device cannot be null");
        SysRole role = roleService.selectRoleById(device.getRoleId());
        Assert.notNull(role, "role cannot be null");
        // 新增加的设备很有可能没有配置TTS，采用默认Edge需要传递null
        SysConfig ttsConfig = null;
        if (role.getTtsId() != null) {
            ttsConfig = configService.selectConfigById(role.getTtsId());
        }
        TtsService ttsService = ttsFactory.getTtsService(ttsConfig, role.getVoiceName(), role.getTtsPitch(), role.getTtsSpeed());

        return initFileSynthesizer(chatSession, ttsService);
    }

    /**
     * 初始化Synthesizer
     */
    private Synthesizer initFileSynthesizer(ChatSession chatSession, TtsService ttsService) {
        Player player = chatSession.getPlayer();
        if(player == null){
            player = new FilePlayer( chatSession, messageService, sessionManager, sysMessageService);
            chatSession.setPlayer(player);
        }
        FileSynthesizer synthesizer = new FileSynthesizer(chatSession, messageService, ttsService, player);
        chatSession.setSynthesizer(synthesizer);
        return synthesizer;
    }

    /**
     * 处理语音唤醒
     */
    public void handleWakeWord(ChatSession session, String text) {
        logger.info("检测到唤醒词: \"{}\"", text);
        try {
            // 设置唤醒响应状态,在响应期间忽略VAD检测
            session.setInWakeupResponse(true);

            SysDevice device = session.getSysDevice();
            if (device == null) {
                return;
            }

            Player player = new FilePlayer(session, messageService, sessionManager, sysMessageService);
            if(session.getPlayer()==null){
                // 正常都应该是这个
                session.setPlayer(player);
            }

            // 设置 assistantTimeMillis（唤醒场景需要）
            if (session.getAssistantTimeMillis() == null) {
                session.setAssistantTimeMillis(System.currentTimeMillis());
            }
            
            wakeUp(session, text, session.getConversation().getRole());
        } catch (Exception e) {
            logger.error("处理唤醒词失败: {}", e.getMessage(), e);
        }
    }

    private FileSynthesizer wakeUp(ChatSession session, String text, SysRole role) {
        Assert.notNull(role, "role cannot be null");
        // 获取TTS配置
        SysConfig ttsConfig;
        if (role.getTtsId() != null) {
            ttsConfig = configService.selectConfigById(role.getTtsId());
        } else {
            ttsConfig = null;
        }
        String voiceName = role.getVoiceName();
        TtsService ttsService = ttsFactory.getTtsService(ttsConfig, voiceName, role.getTtsPitch(), role.getTtsSpeed());
        // 唤醒词场景强制使用非流式Synthesizer（用于播放音效和欢迎语）
        Player player = session.getPlayer();

        if(player == null){
            player = new FilePlayer(session, messageService, sessionManager, sysMessageService);
            logger.debug("当前session.player为null，新建一个FilemPlayer");
            session.setPlayer(player);
        }else{
            logger.debug("当前session.player: {}", player.getClass());
        }

        FileSynthesizer synthesizer = new FileSynthesizer(session, messageService, ttsService, player);
        session.setSynthesizer(synthesizer);

        messageService.sendSttMessage(session, text);

        // 获取欢迎语
        UserMessage userMessage = saveUserAudio(session, null, text);
        boolean useFunctionCall = false;
        Flux<ChatResponse> responseFlux = chatService.chatStream(session, userMessage, useFunctionCall);
        synthesizer.startSynthesis(responseFlux);
        return synthesizer;
    }


    /**
     * 处理文本消息交互
     * 如果指定了输出文本，则用指定的文本生成语音
     * 
     * @param session
     * @param inputText    输入文本
     */
    public void handleText(ChatSession session, String inputText ) {
        // 初始化对话状态
        String sessionId = session.getSessionId();

        try {
            SysDevice device = sessionManager.getDeviceConfig(sessionId);
            if (device == null) {
                return;
            }
            sessionManager.updateLastActivity(sessionId);
            // 发送识别结果
            messageService.sendSttMessage(session, inputText);
            messageService.sendTtsMessage(session, null, "start");
            logger.info("处理聊天文字输入: \"{}\"", inputText);

            UserMessage userMessage = saveUserAudio(session, null, inputText);

            // 设置LLM生成消息的时间戳作为Assistant消息的创建时间戳，也用于约定保存音频文件的路径。一定要在LLM前设置时间戳。
            final Long assistantTimeMillis = System.currentTimeMillis();
            session.setAssistantTimeMillis(assistantTimeMillis);

            // 优先检测用户意图，如果检测到明确意图则直接处理，不走 LLM
            UserIntent intent = intentDetector.detectIntent(inputText);
            if (intent != null) {
                handleIntent(session, intent, inputText);
                return;
            }

            // 使用句子切分处理流式响应
            boolean useFunctionCall = true;
            Flux<ChatResponse> chatResponseFlux =chatService.chatStream(session, userMessage, useFunctionCall);

            Synthesizer synthesizer = initSynthesizer(session);
            synthesizer.startSynthesis(chatResponseFlux);
        } catch (Exception e) {
            logger.error("处理文本消息失败: {}", e.getMessage(), e);
        }
    }

    /**
     * 处理检测到的用户意图
     * 
     * @param session 聊天会话
     * @param intent 检测到的意图
     * @param userInput 用户输入文本
     */
    private void handleIntent(ChatSession session, IntentDetector.UserIntent intent, String userInput) {

        logger.info("处理用户意图: type={}, input=\"{}\"", intent.getType(), userInput);

        switch (intent.getType()) {
            case "EXIT":
                // 处理退出意图
                sendGoodbyeMessage(session);
                break;
            
            // 未来可以添加更多意图处理
            // case "WELCOME":
            //     sendWelcomeMessage(session);
            //     break;
            // case "HELP":
            //     sendHelpMessage(session);
            //     break;
            
            default:
                logger.warn("未知的意图类型: {}", intent.getType());
                break;
        }
    }


    /**
     * 发送告别语并在播放完成后关闭会话
     *
     * @param session WebSocket会话
     * @return 发送的告别语
     */
    public String sendGoodbyeMessage(ChatSession session) {
        return sendExitMessage(session, goodbyeMessages, "用户主动退出");
    }

    /**
     * 发送超时提示语并在播放完成后关闭会话
     * 用于会话超时自动退出
     *
     * @param session WebSocket会话
     * @return 发送的超时提示语
     */
    public String sendTimeoutMessage(ChatSession session) {
        return sendExitMessage(session, timeoutMessages, "会话超时退出");
    }

    /**
     * 发送退出消息的通用方法
     *
     * @param session WebSocket会话
     * @param messageSupplier 消息供应器(告别语或超时提示语)
     * @param reason 退出原因(用于日志)
     * @return 发送的消息
     */
    private String sendExitMessage(ChatSession session, Supplier<String> messageSupplier, String reason) {
        try {
            if (session != null) {

                // 随机选择一条告别语
                String goodbyeMessage = messageSupplier.get();

                // 设置会话在完成后关闭
                session.setCloseAfterChat(true);

                // 设置assistantTimeMillis
                final Long assistantTimeMillis = System.currentTimeMillis();
                session.setAssistantTimeMillis(assistantTimeMillis);

                // 发送start消息，通知设备进入说话状态
                messageService.sendTtsMessage(session, null, "start");

                // 直接处理告别语，不通过LLM
                Synthesizer synthesizer = initSynthesizer(session);
                synthesizer.append(goodbyeMessage);
                synthesizer.setLast();
                return goodbyeMessage;
            } else {
                // 会话已关闭，直接清理资源
                sessionManager.closeSession(session);
                return "goodbye!";
            }
        } catch (Exception e) {
            logger.error("发送退出消息失败: {}", e.getMessage(), e);
            return "goodbye!";
        }
    }

    /**
     * 中止当前对话
     */
    public void abortDialogue(ChatSession session, String reason) {
        try {
            String sessionId = session.getSessionId();
            logger.info("中止对话 - SessionId: {}, Reason: {}", sessionId, reason);

            // 关闭音频流
            sessionManager.closeAudioStream(sessionId);
            sessionManager.setStreamingState(sessionId, false);

            if (sessionManager.isMusicPlaying(sessionId)) {
                if(session.getPlayer() instanceof MusicService.MusicPlayer musicPlayer){
                    musicPlayer.stop();
                }
                if(session.getPlayer() instanceof HuiBenService.HuiBenPlayer huiBenPlayer){
                    huiBenPlayer.stop();
                }
                return;
            }
            // 清空句子队列
            var synthesizer = session.getSynthesizer();
            if(synthesizer!=null){
                synthesizer.clearAllSentences();
                synthesizer.cancel();
                session.setSynthesizer(null);
            }

            // 终止语音发送
            Player player = session.getPlayer();
            if(player!=null){
                player.stop();
            }

            // 无论player是否存在，都需要发送stop消息通知设备进入聆听状态
            // 这是因为设备可能在还未创建player时就发送了abort消息
            messageService.sendTtsMessage(session, null, "stop");
        } catch (Exception e) {
            logger.error("中止对话失败: {}", e.getMessage(), e);
        }
    }

    /**
     * 清理会话资源
     */

    public void cleanupSession(ChatSession session) {
        //清理对话上下文状态信息
        Synthesizer synthesizer = session.getSynthesizer();
        if(synthesizer!=null){
            synthesizer.cancel();
        }
        session.setSynthesizer( null);

        // 清理ChatSession中可能绑定的播放器资源
        if(session.getPlayer()!=null){
            session.getPlayer().stop();
        }
    }

}
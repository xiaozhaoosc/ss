package com.xiaozhi.dialogue.service;

import com.xiaozhi.communication.common.ChatSession;
import com.xiaozhi.communication.common.SessionManager;
import com.xiaozhi.utils.OpusProcessor;
import io.jsonwebtoken.lang.Assert;
import lombok.Data;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.io.IOException;
import java.util.PriorityQueue;

/**
 *
 * 播放器，负责处理音频播放（下发至终端设备）。
 * 其生命周期大致与ChatSession相当，当没有播放音乐或绘本之类的时候，播放器不用切换。
 * 收到Abort事件时，才是需要主动停止播放的场景。其它时候应该都是自然停止。
 * 需要打断时从ChatSession 找到这个播放器用来打断并清理队列中的资源。
 * 后期可以考虑 通过Composite的模式支持更多 需要播放的音频格式类型。播放器应该是有与终端设备约定的格式的。
 * TODO 所以 后续重构方向应该是将这个播放器做成 针对不同的格式的 播放器。
 *
 * setCloseAfterChat，只来源于两处，
 * @see com.xiaozhi.dialogue.llm.tool.function.SessionExitFunction
 * @see DialogueService#sendGoodbyeMessage(ChatSession)
 * 在SessionExitFunction工作时，这个工具是找不到Player的，即使在ChatSession里也可能是没有被初始化的Player实例的。
 * SessionExitFunction 正常返回一个GoodbyeMessage给到 DialogueService, 然后由DialogueService处理语音合成及播放。
 * sendGoodbyeMessage方法是被 checkInactiveSessions 所设用。
 *
 * @see com.xiaozhi.event.ChatAbortEvent
 * 用户真正关心的是从说完话到开始播音的时间间隔。不是TTS的生成时间。所以Player需要有一个Instant。
 *
 * 问：是否需要实现Runnable接口？
 * 答：不是所有的Player实现类都需要实现Runnable，也可以通过ExecutorService / ScheduledExecutorService实现，可者聚合多个Player（Composite模式）。
 *
 */
@Data
public abstract class Player{
    private static final Logger logger = LoggerFactory.getLogger(Player.class);
    private PriorityQueue<Sentence> queue = new PriorityQueue<Sentence>((sentence1, sentence2)->sentence1.getSeq()-sentence2.getSeq());



    protected final ChatSession session;
    protected final OpusProcessor opusProcessor = new OpusProcessor();
    private final MessageService messageService;
    protected final SessionManager sessionManager;

    /**
     * 音频播放器构造方法
     * TODO  如何才能去掉这个SessionManager? closeAfterChat的实现方式，稍微绕了一点，需要SessionManager。
     * Player本身是一个动态的过程，如果选择Observation 暴露内部的运行状态与事件，将 closeAfterChat 由外部实现是否会更好些？
     * @param session
     * @param messageService
     * @param sessionManager
     */
    protected Player(ChatSession session, MessageService messageService, SessionManager sessionManager) {
        Assert.notNull(session, "session不能为空");
        Assert.notNull(messageService, "messageService不能为空");
        Assert.notNull(sessionManager, "sessionManager不能为空");
        this.session = session;
        this.messageService = messageService;
        this.sessionManager = sessionManager;
    }

    /**
     * 发送TTS句子开始消息
     */
    protected void sendSentenceStart( String text) {
        messageService.sendTtsMessage(session, text, "sentence_start");
    }

    /**
     * 发送Opus帧数据
     */
    public void sendOpusFrame( byte[] opusFrame) throws IOException {
        messageService.sendBinaryMessage(session, opusFrame);
        // logger.debug("发送Opus帧数据: {}", opusFrame.length);
    }

    /**
     * 发送表情信息。如果句子里没有分析出表情，则默认返回 happy
     */
    protected void sendEmotion( String emotion) {
        messageService.sendEmotion(session, emotion);
    }
    /**
     * 发送停止消息
     * 此方法不对外暴露，只有播放器能发起停止消息。外部应该通过stop 或其它间接方式停止，而不是直接向设备发送TTS停止消息。
     */
    protected void sendStop() {
        // 清除唤醒响应标记,允许恢复VAD检测
        if (session.isInWakeupResponse()) {
            session.setInWakeupResponse(false);
        }

        messageService.sendTtsMessage(session, null, "stop");
        // 检查是否需要关闭会话
        // TODO 除了 isCloseAfterChat 标记，还有监听器或 观察者模式 可以考虑。
        if (session.isCloseAfterChat()) {
            // 再清理会话资源
            sessionManager.closeSession(session);
        }
    }

    public void append(Sentence sentence) {
        Assert.notNull(sentence, "sentence不能为空");
        // 启动音频发送任务
        getQueue().add(sentence);
    }

    public abstract void play();

    /**
     * 用于中断或用户打断时，清理资源。
     * 但这个对象是否需要被销毁取决于是否需要更换播放器。
     * 当ChatSession更换了播放器，此对象没有相应的引用自然就可以GC回收了。
     * 自然说完的时候，内部会控制sendStop，但内部不能调用这个stop方法。
     * 也不需要显式调用sendStop方法， sendStop被保留为 protected方法，用于内部调用，当播放队列被清空时，在内部会自然sendStop。
     */
    public void stop() {
        // 清理音频发送任务
        this.queue.clear();
        // 通知子类停止播放
        onStop();
        logger.info("已取消音频发送任务 - SessionId: {}", session.getSessionId());
    }

    /**
     * 子类可以重写此方法来处理停止逻辑
     * 例如设置播放标志、中断线程等
     */
    protected void onStop() {
        // 默认实现为空，子类可以重写
    }

}

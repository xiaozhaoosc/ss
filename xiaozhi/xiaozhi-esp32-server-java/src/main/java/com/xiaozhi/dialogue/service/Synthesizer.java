package com.xiaozhi.dialogue.service;

import com.xiaozhi.communication.common.ChatSession;
import lombok.AccessLevel;
import lombok.Data;
import lombok.Getter;
import lombok.Setter;
import org.springframework.ai.chat.model.ChatResponse;
import org.springframework.util.Assert;
import org.springframework.util.StringUtils;
import reactor.core.Disposable;
import reactor.core.publisher.Flux;

import java.time.Duration;
import java.time.Instant;
import java.util.List;
import java.util.concurrent.CopyOnWriteArrayList;


/**
 * 用于存放一轮对话（即一问一答）过程中的状态数据。
 * 阶段：VAD -> STT -> LLM -> TTS -> Player
 * Synthesizer 实际是属于TTS阶段，是对TTS 不同Provider的封装。不同TTS Provider返回的数据格式不同，而Player与终端设备约定的数据格式通常只能一种。
 * 而从wav-> opus的转换是更应该发生在 Synthesizer 而非 Player。
 * 格式转换时原始形态的RAW数据可以很大，但网络传输及在内存缓冲区等候传输则应该尽可能是压缩后的，以便减少对内存资源的占用。
 * ChatModel输出的是有顺利的文本， Player播放的是有顺序的音频流。在Synthesizer拆解的句子也应该由Synthesizer恢复原来的顺序。
 * TODO Sentence 的seq 不应该是Player需要考虑与使用的。
 * TODO 一个原始的wav文件可能较大，没必要全部装进内存里，可以一边读取一边转换成opus编码，以减少内存资源的占用。
 *
 * 理想的情况：
 * var textFlux = chatModel.stream(prompt);
 * var audioFlux = synthesizer.synthesize(textFlux);
 * var player = player.play(audioFlux);
 *
 * chatModel与 LLM配置有关，每个虚拟Role的LLM配置是确定的。
 * synthesizer与TTS配置有关，每个虚拟Role的TTS配置是确定的。基于这个考虑，也可以做成非一次性的，
 * 播放器与终端设备有关，每个播放器与网络连接是绑定的。
 * TODO 目前TtsService接口设计形态 是与synthesizer是差距较多的， 可以先将synthenizer看作是TtsService的一层高层封装。以后再考虑动TtsService。
 *
 * 如果对于同一轮对话的多个语句需要多个线程并发执行TTS，可以提交多个任务，但需要控制并发数量，避免线程过多导致性能下降。
 * Semaphore semaphore = getSessionSemaphore(sessionId);
 *
 * TODO 在add时，将audioPath保存起来，方便后续处理？ 如果audioPath是add后再set的呢？还是在remove时可靠些。
 * TODO 可以考虑增加 Semaphore 控制同一个Dialogue 的TTS线程数量。也可以直接通过提交 N个Runnable对象的方式实现。
 * 通过实测发现，只要第一个句子的音频能播放，则后续句子的生成速度不会影响播放。
 */
@Data
public abstract class Synthesizer {
    private static final org.slf4j.Logger logger = org.slf4j.LoggerFactory.getLogger(Synthesizer.class);


    // 大模型ChatModel开始的时间。
    // TODO 考虑其它的监控时间的方式，例如基于micrometer的Observersation。
    //  另一种考虑，是将时间点转移至Sentence里。当LLM输出后拆解出来的每一句话都是同类型的处理。每一阶段的模型的处理时间点都是可以被记录的。
    //  但如何追踪？如果有一个类似于traceId的概念，例如将UserMessage的时间戳作为这个traceId，那就可以全程记录。
    //  可能需要考虑微服务架构的方式，先拆解保存再恢复链路关系。
    private final Instant createdAt=Instant.now();

    // 用于存放句子的队列。
    // TODO  需要将sentenceQueue对象保护起来，不再对外提供。需要findUsage检查代码。考虑删这字段。
    @Getter(AccessLevel.NONE)
    @Setter(AccessLevel.NONE)
    private final List<Sentence> sentenceQueue= new CopyOnWriteArrayList<Sentence>();

    protected final ChatSession chatSession;
    protected final Player player;

    @Getter(AccessLevel.NONE)
    @Setter(AccessLevel.NONE)
    protected final StringBuffer readyTts = new StringBuffer();

    // 用于保存Flux订阅，以便在cancel时取消订阅
    protected volatile Disposable fluxSubscription;

    // 标记是否已被中止（用于打断场景）
    protected volatile boolean aborted = false;

    abstract void cancel();

    /**
     * 检查是否已被中止
     * @return true表示已被中止
     */
    public boolean isAborted() {
        return aborted;
    }

    // 跟踪LLM的回复完成
    protected volatile boolean isLast = false;

    private int firstChatDurationMillis = 0 ;

    /**
     * 构造函数。语音合成器、播放器的生命周期是可以不一样的。
     * 当语音合成器完成了一轮对话里AI响应的全部文本的合成，此对象就可以丢弃（被垃圾回收）。而此时的播放器很可能还正在播放。
     * 而且同一个语音合成器，可以根据场景组合不同的播放器。所以播放器不在语音合成器内部new对象。
     * @param chatSession 当前会话
     * @param player 播放音频的播放器
     */
    public Synthesizer(ChatSession chatSession, Player player) {
        this.chatSession = chatSession;
        this.player = player;

    }

    public void clearAllSentences(){
        sentenceQueue.clear();
        readyTts.setLength(0); // StringBuffer 使用 setLength(0) 清空内容
    }

    public boolean hasSentence(){
        return sentenceQueue.size() > 0;
    }

    public void removeSentence(Sentence sentence){
        sentenceQueue.remove(sentence);

    }

    public List<Sentence> getSentenceQueue(){
        return List.copyOf(sentenceQueue);
    }

    public void append(String text){
        this.readyTts.append(text);
    }

    /**
     * 为了避免形成的句子混乱，这里确保线程安全
     * 创建句子对象并弹出
      */
    public synchronized Sentence pollSentence() {
        // TODO 如果语音合成对于大句子太耗时，则将readyTts重新换成List，用短句。
        String text = readyTts.toString();
        if(!StringUtils.hasText(text)){
            return null;
        }
        Long assistantTimeMillis = chatSession.getAssistantTimeMillis();
        Assert.notNull(assistantTimeMillis, "assistantTimeMillis cannot be null");


        // 处理表情符号
        Sentence sentence = new Sentence(text);

        // 设置对话ID
        sentence.setAssistantTimeMillis(assistantTimeMillis);

        // 添加到句子队列
        sentenceQueue.add(sentence);
        // 记录首句响应时间
        // TODO 考虑其它的记录的方式
        long firstChatDuration = Duration.between(createdAt,sentence.getCreatedAt()).toMillis();
        if (firstChatDurationMillis == 0) {
            this.setFirstChatDurationMillis((int) firstChatDuration);
        }
        // 检查处理后的文本是否为空（即只有表情符号）
        if (sentence.getText4Speech() == null || sentence.getText4Speech().trim().isEmpty()) {

            sentence.setAudio(null);

            // 如果只有表情符号，直接标记为准备好但不生成音频
            logger.info("跳过纯表情符号TTS处理 - 序号: {}, 内容: \"{}\"", sentence.getSeq(), text);
        }

        logger.info("处理LLM返回的句子: seq={}, text={}, responseTime={}毫秒",
                sentence.getSeq(), text,   firstChatDuration);
        readyTts.delete(0, text.length());
        return sentence;
    }

    /**
     * 是否正在对话中
     * @return
     */
    public boolean isDialog() {
        return !isLast || hasSentence() || sentenceQueue.size() > 0;
    }

    /**
     * 设置语音合成过程结束。
     * setLast并没有Flux优雅，但好理解。先这么用着，后续再考虑 Flux是否更合适。
     */
    public void setLast() {
        this.isLast = true;
    }

    public void startSynthesis(Flux<ChatResponse> chatResponseFlux) {
        // 保存订阅引用，以便在cancel时取消
        fluxSubscription = new DialogueHelper().convert2sentence(chatResponseFlux)
                .subscribe(sentence -> {
                            // 检查是否已被中止，避免abort后继续追加内容
                            if (!aborted) {
                                this.append(sentence);
                            }
                        },
                        e -> {
                            // 检查是否已被中止
                            if (!aborted) {
                                logger.error("流式响应出错: {}", e);
                                // 发送错误信号
                                this.append("抱歉，我在处理您的请求时遇到了问题。");
                                this.setLast();
                            }
                        },
                        () -> {
                            // 检查是否已被中止
                            if (!aborted) {
                                this.setLast();
                            }
                        }
                );
    }

}

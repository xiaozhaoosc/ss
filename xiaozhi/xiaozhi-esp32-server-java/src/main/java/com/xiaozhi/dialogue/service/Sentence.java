package com.xiaozhi.dialogue.service;

import com.xiaozhi.utils.EmojiUtils;
import lombok.Data;
import lombok.extern.slf4j.Slf4j;

import java.nio.file.Files;
import java.nio.file.Path;
import java.time.Duration;
import java.time.Instant;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
import java.util.concurrent.atomic.AtomicInteger;

/**
 * 句子对象，用于跟踪每个句子的处理状态
 * TODO isLast不可依靠，有可能是最后一句，但是没有标记上。再检查一次
 * TODO 句子对象，也做成继承体系，一个是SentenceWithPath，一个是SentenceWithBytes。但文本是必须的。
 * TODO ByteBuffer 比 List<byte[]> 快很多。
 *
 */
@Slf4j
@Data
public class Sentence implements Comparable<Sentence>{
    // 用于控制句子的序列号。
    private static final AtomicInteger sentenceCounter = new AtomicInteger(0);

    // 获取句子序列号
    private int seq = sentenceCounter.incrementAndGet();;
    // 可能带有颜文字的原始句子。
    private final String text;
    // 可以用来生成TTS的纯文本，表情符号被过滤掉，表情符号不适合TTS
    private String text4Speech =null;
    // 包含所有匹配的表情符号
    private List<String> moods=null;
    // audio path
    private Path audioPath = null;
    // 标记是否需要合并到最终音频文件（默认true）
    private boolean shouldMerge = true;

    private Long assistantTimeMillis = null; // 对话ID

    //private ByteBuffer pcmBuffer = new ByteBuffer();
    private boolean isSynthesisCompleted = false;
    // 用于记录每一个句子的形成时间，也就对同一个DialogueContext，两次handleSentence方法调用的时间间隔。
    private final Instant createdAt = Instant.now();
    private Instant beginSynthesis = Instant.now();
    private Instant endSynthesis = Instant.now();
    // 用于标记语音合成的重试次数
    public int retryCount = 0;
    // 用于标记语音合成是否重试
    public boolean isRetry = false;

    public Sentence(String text) {
        this.text = text;
    }

    public Sentence(String text, String audioPath) {
        this.text = text;
        this.setAudio(Path.of(audioPath));
    }

    public void setAudio(Path audioPath){
        if(Files.exists(audioPath)){
            this.audioPath = audioPath;
        }else{
            log.error("音频文件不存在：{}",audioPath);
        }
    }

    public long getSynthesisDuration() {
        return Duration.between(beginSynthesis,endSynthesis).toMillis();
    }

    /**
     * 获取情感词列表的不可修改副本
     */
    public List<String> getMoods() {
        if(moods==null){
            moods = new ArrayList<>();
            this.text4Speech = EmojiUtils.processSentence(text,moods);
        }
        return Collections.unmodifiableList(moods);
    }

    public String getText4Speech() {
        if(text4Speech ==null){
            moods = new ArrayList<>();
            this.text4Speech = EmojiUtils.processSentence(text,moods);
        }
        return text4Speech;
    }

    public boolean isOnlyEmoji() {
        // 表情符号通常不超过4个字符
        return moods != null && !moods.isEmpty() &&
                (text.trim().length() <= 4);
    }

    @Override
    public int compareTo(Sentence other) {
        // 优先级：重试任务 > 序号小的句子。
        // TODO 仅适用于TTS重试时，但如果是在播放音频时，可能会有bug。
        if (this.isRetry != other.isRetry) {
            return this.isRetry ? -1 : 1;
        }
        return Integer.compare(this.getSeq(), other.getSeq());
    }
}

package com.xiaozhi.dialogue.service;

import com.xiaozhi.communication.common.ChatSession;
import lombok.extern.slf4j.Slf4j;

import java.time.Instant;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;
import java.util.concurrent.Future;

@Slf4j
public abstract class ThreadSynthesizer extends Synthesizer implements Runnable{

    private static final ExecutorService ttsExecutor = Executors.newVirtualThreadPerTaskExecutor();
    private final Future ttsFuture;
    public ThreadSynthesizer(ChatSession chatSession, Player player) {
        super(chatSession, player);
        this.ttsFuture = ttsExecutor.submit(this);
    }

    public void cancel() {
        // 设置中止标志，防止后续操作
        aborted = true;

        // 取消Flux订阅，停止LLM流式输出
        if (fluxSubscription != null && !fluxSubscription.isDisposed()) {
            fluxSubscription.dispose();
        }
        // 取消TTS任务线程
        ttsFuture.cancel(true);
    }

    @Override
    public void run() {
        // 由以前的processTtsTaskQueue递归改为循环处理
        while (!aborted && (!isLast || readyTts.length() > 0)) {
            // 耗时操作需及时更新最后活动时间，避免误判为会话终止
            chatSession.setLastActivityTime(Instant.now());

            // 等待播放队列为空才合成下一句，每次队列中只保持1句待播放
            if (readyTts.length() == 0 || !player.getQueue().isEmpty()) {
                try {
                    Thread.sleep(60); // 等待 60ms，避免空转占用 CPU
                } catch (InterruptedException e) {
                    Thread.currentThread().interrupt();
                    break;
                }
                continue;
            }

            Sentence sentence = this.pollSentence();
            // 防止只返回换行符等空白字符
            if (sentence != null) {
                sentence.setBeginSynthesis(Instant.now());
                doSynthesize(sentence);
            }

        }

        // 检查是否因为abort而退出
        if (aborted) {
            log.info("TTS任务已被中止 - SessionId: {}", chatSession.getSessionId());
        } else {
            // 在异步流式的情况下，上面的TTS很有可能还没有完全结束。
            log.info("已经没有更多句子需要TTS了，告诉Player已提交了最后一个句子");
        }
    }

    abstract protected void doSynthesize(Sentence sentence);
}

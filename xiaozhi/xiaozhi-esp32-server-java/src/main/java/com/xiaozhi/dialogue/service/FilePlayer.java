package com.xiaozhi.dialogue.service;

import com.xiaozhi.communication.common.ChatSession;
import com.xiaozhi.communication.common.SessionManager;
import com.xiaozhi.dialogue.llm.memory.Conversation;
import com.xiaozhi.service.SysMessageService;
import com.xiaozhi.utils.AudioUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.nio.file.Path;
import java.time.Instant;
import java.util.ArrayList;
import java.util.List;
import java.util.concurrent.TimeUnit;

/**
 * 基于本地文件下发终端设备的播放器
 */
public class FilePlayer extends ThreadPlayer{

    private static final Logger logger = LoggerFactory.getLogger(FilePlayer.class);
    // 仅播放文本的 Sleep 时长
    private static final long ONLY_TEXT_SLEEP_TIME_MS = 500;
    // 帧发送时间间隔略小于OPUS_FRAME_DURATION_MS，避免因某些调度原因，导致没能在规定时间内发送，设备出现杂音
    final long OPUS_FRAME_SEND_INTERVAL_MS = AudioUtils.OPUS_FRAME_DURATION_MS;

    // Burst模式相关变量
    private long startTimestamp;      // 播放开始的时间戳（纳秒）
    private long playPosition;        // 当前播放位置（纳秒）

    // 存储模型回复的每个句子所对应的音频路径
    private final List<String> audioFilesToMerge = new ArrayList<>();
    // 状态与 sendStart sendStop保持同步。用于控制内部循环，在中断时可以及时打断。
    // 使用volatile确保多线程可见性
    private volatile boolean isPlaying = true;
    private final SysMessageService sysMessageService;

    public FilePlayer(ChatSession session, MessageService messageService,SessionManager sessionManager, SysMessageService sysMessageService) {
        super(session, messageService,sessionManager);
        this.sysMessageService = sysMessageService;
    }

    public FilePlayer(ChatSession session, MessageService messageService,SessionManager sessionManager) {
        this(session, messageService,sessionManager,null);

    }

    @Override
    protected void onStop() {
        // 立即停止播放循环
        isPlaying = false;
        logger.debug("FilePlayer已停止播放 - SessionId: {}", session.getSessionId());
    }


    public void run() {

        // 注意：start消息现在由DialogueService在开始处理用户请求时发送，
        // 而不是在这里发送，这样可以避免在LLM处理期间设备仍处于监听状态

        // 每次run开始时重置播放状态
        isPlaying = true;

        // 初始化播放时间戳（在循环开始前设置一次）
        startTimestamp = System.currentTimeMillis();
        playPosition = -OPUS_FRAME_SEND_INTERVAL_MS * 2; // -120ms预缓冲

        // 注意：start消息现在由DialogueService在开始处理用户请求时发送，
        // 而不是在这里发送，这样可以避免在LLM处理期间设备仍处于监听状态
        // 修改循环条件：不仅检查队列是否有数据，还要检查Synthesizer是否还在对话中
        // 这样可以避免队列暂时为空但Synthesizer还在生成句子时误判结束
        // 同时检查synthesizer是否被中止，如果中止则立即退出播放
        while (isPlaying && (this.getQueue().size() > 0 ||
               (session.getSynthesizer() != null && session.getSynthesizer().isDialog()
                && !session.getSynthesizer().isAborted()))) {
            Sentence sentence = this.getQueue().poll();
            if (sentence == null) {
                try {
                    Thread.sleep(60); // 等待 60ms，避免空转占用 CPU
                } catch (InterruptedException e) {
                    Thread.currentThread().interrupt();
                    break;
                }
                continue;
            }

            Path audioPath = sentence.getAudioPath();
            String text = sentence.getText();
            logger.info("向设备发送音频消息（sendAudioMessage） - SessionId: {}, 文本: {}, 音频路径: {}", session.getSessionId(),
                    text, audioPath);
            // TODO  处理 等待正确顺序的句子出现。并且设置延时。


            if (audioPath == null) {
                if (text != null && !text.isEmpty()) {

                    // 检查是否是纯表情符号（通过检查句子是否有moods但没有实际文本内容）
                    if (sentence.isOnlyEmoji()) {
                        // 纯表情符号，只发送表情，不发送文本
                        this.sendEmotion( null);
                    } else {
                        // 有实际文本内容，发送异常提示
                        this.sendSentenceStart(text);
                        // 发送句子表情
                        this.sendEmotion( null);
                    }
                    try {
                        TimeUnit.MILLISECONDS.sleep(ONLY_TEXT_SLEEP_TIME_MS);
                    } catch (InterruptedException e) {
                        logger.error("等待表情播放失败", e);
                    }
                }
                // 没有音频、没有文本、还没结束，则下一轮循环。
                continue;
            }

            // 发送句子开始标记
            this.sendSentenceStart(text);

            // 发送句子表情
            this.sendEmotion(null);
            
            // 只有需要合并的音频才添加到合并列表
            if (sentence.isShouldMerge()) {
                audioFilesToMerge.add(audioPath.toString());
            }
            try {
                // 处理音频文件
                List<byte[]> opusFrames = AudioUtils.readAsOpus(audioPath.toString());
                if (opusFrames == null || opusFrames.isEmpty()) {
                    continue;
                }
                for (byte[] frame : opusFrames) {
                    // 更新活跃时间
                    session.setLastActivityTime(Instant.now());

                    // 检查会话是否关闭
                    if (!session.isOpen()) {
                        break;
                    }

                    // 检查synthesizer是否被中止，如果中止则立即停止播放
                    if (session.getSynthesizer() != null && session.getSynthesizer().isAborted()) {
                        logger.info("检测到对话已被中止，停止音频播放 - SessionId: {}", session.getSessionId());
                        isPlaying = false;
                        break;
                    }

                    // 计算目标发送时间（绝对时间戳）
                    long targetSendTime = startTimestamp + playPosition;

                    // 等待到目标时间（如果playPosition是负值，会立即通过，实现预缓冲）
                    long delay = targetSendTime - System.currentTimeMillis();
                    if (delay > 0) {
                        Thread.sleep(delay);
                    }

                    // 发送当前帧
                    this.sendOpusFrame(frame);

                    // 更新播放位置（每帧增加60ms）
                    playPosition += OPUS_FRAME_SEND_INTERVAL_MS;
                } // end for 发送一个句子的所有帧

                // 补偿预缓冲(120ms) + 预缓冲后第一帧(60ms) + 首句最后一帧(60ms) + 句子间隔(60ms) = 300ms
                playPosition += OPUS_FRAME_SEND_INTERVAL_MS * 5;
                logger.debug("句子播放完毕，等待360ms后播放下一句");
            } catch (Exception e) {
                // 发生错误，取消调度任务
                logger.error("非流式帧处理失败", e);
            }
        } // end while,此时队列一定到了最后一个句子并且队列为空。

        // 等待设备播放完最后一句的缓冲时间
        // 确保设备有足够时间播放完所有音频后再发送stop
        try {
            Thread.sleep(500); // 500ms缓冲时间
        } catch (InterruptedException e) {
            Thread.currentThread().interrupt();
        }
        
        sendStop();
        isPlaying = false;
        logger.debug("对话 {} 播放结束", session.getSessionId());
        saveAssistantResponse();
    }


    /**
     * 保存助手的完整响应（文本和合并音频）
     * TODO 改为在AudioService里保存音频文件。
     */
    private void saveAssistantResponse() {

        Long assistantTimeMillis = session.getAssistantTimeMillis();
        try {
            // 合并音频文件
            if (!audioFilesToMerge.isEmpty()) {
                Path path = session.getAudioPath(Conversation.MESSAGE_TYPE_ASSISTANT, assistantTimeMillis);
                // 这里可能只有一条音频，合并可能会报错，尝试输出所有合并音频的路径
                logger.info("合并音频文件数量: {}", audioFilesToMerge.size());
                AudioUtils.mergeAudioFiles(path, audioFilesToMerge);
                // 保存合并后的音频路径
                logger.info("对话 {} 的音频已合并: {}", assistantTimeMillis, path);
                // 音频合并完成，删除源文件后，dialogueAudioPaths也应一并清除。
                audioFilesToMerge.clear();
                if (sysMessageService != null) {
                    //合并完成，更新消息表路径、时长信息
                    String deviceId = session.getSysDevice().getDeviceId().replace("-", ":");
                    Integer roleId = session.getSysDevice().getRoleId();
                    String fileName = path.getFileName().toString();
                    String createTime = fileName.substring(0, fileName.indexOf("-" + Conversation.MESSAGE_TYPE_ASSISTANT));
                    sysMessageService.updateMessageByAudioFile(deviceId, roleId,
                            Conversation.MESSAGE_TYPE_ASSISTANT, createTime, path.toString());
                }
            }
        } catch (Exception e) {
            logger.error("保存助手响应失败 - 对话ID: {}, 错误: {}", assistantTimeMillis, e.getMessage(), e);
        }
    }

}
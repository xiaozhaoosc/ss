package com.xiaozhi.dialogue.service;

import com.xiaozhi.communication.common.ChatSession;
import com.xiaozhi.communication.common.SessionManager;
import com.xiaozhi.utils.AudioUtils;
import lombok.extern.slf4j.Slf4j;
import org.jetbrains.annotations.Nullable;

import java.io.File;
import java.nio.file.Path;
import java.util.List;

/**
 * 基于线程方式实现的播放器，实测通过Thread的sleep方法，即使是纳秒时间依然是不够精确的。
 * 而小智固件程序默认的处理方式，终端设备没有缓存，需要服务器端准确按时的下发音频帧，否则终端设备会有沙沙声。
 * TODO 后续考虑通过 ScheduledExecutorService 来实现。它主要是得益于多线程频繁被唤醒，所以从DelayedWorkQueue获得的元素可以时间更精确。
 */
@Slf4j
public abstract class ThreadPlayer extends Player implements Runnable{
    protected volatile Thread  playingThread =null;

    protected ThreadPlayer(ChatSession session, MessageService messageService, SessionManager sessionManager) {
        super(session, messageService, sessionManager);
    }

    @Override
    public void play() {
        synchronized ( this) {
            if (playingThread == null) {
                this.playingThread = Thread.startVirtualThread(this);
            }
        }
    }

    @Override
    public void stop() {
        super.stop();
        if(playingThread != null && playingThread.isAlive()){
            // 向线程发起中断信号，用以唤醒sleep中的线程进而让它自行清理资源。
            // 当前的关闭逻辑不能直接发起线程中断，会导致mysql数据库连接资源意外关闭，从而抛出异常。
            //playingThread.interrupt();
        }
        playingThread = null;
    }
}

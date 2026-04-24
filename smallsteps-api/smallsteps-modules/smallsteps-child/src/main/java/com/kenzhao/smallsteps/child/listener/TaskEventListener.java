package com.kenzhao.smallsteps.child.listener;

import com.kenzhao.smallsteps.child.service.IScoreService;
import com.kenzhao.smallsteps.task.event.TaskLitUpEvent;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.context.event.EventListener;
import org.springframework.stereotype.Component;

/**
 * 任务事件监听器
 */
@Slf4j
@Component
@RequiredArgsConstructor
public class TaskEventListener {

    private final IScoreService scoreService;

    @EventListener
    public void handleTaskLitUpEvent(TaskLitUpEvent event) {
        log.info("接收到任务点亮事件: {}, childId: {}, points: {}", event.getTaskTitle(), event.getChildId(), event.getPoints());
        String reason = String.format("确认点亮任务星星: %s", event.getTaskTitle());
        scoreService.addPoints(event.getChildId(), event.getPoints(), event.getTaskId(), reason);
    }
}

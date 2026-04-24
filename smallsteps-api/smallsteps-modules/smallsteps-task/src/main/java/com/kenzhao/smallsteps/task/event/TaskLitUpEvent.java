package com.kenzhao.smallsteps.task.event;

import lombok.Getter;
import org.springframework.context.ApplicationEvent;

/**
 * 任务点亮事件
 */
@Getter
public class TaskLitUpEvent extends ApplicationEvent {

    private final Long logId;
    private final Long childId;
    private final int points;
    private final Long taskId;
    private final String taskTitle;

    public TaskLitUpEvent(Object source, Long logId, Long childId, int points, Long taskId, String taskTitle) {
        super(source);
        this.logId = logId;
        this.childId = childId;
        this.points = points;
        this.taskId = taskId;
        this.taskTitle = taskTitle;
    }
}

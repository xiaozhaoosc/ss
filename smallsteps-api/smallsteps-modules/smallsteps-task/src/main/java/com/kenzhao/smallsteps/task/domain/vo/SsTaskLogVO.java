package com.kenzhao.smallsteps.task.domain.vo;

import com.kenzhao.smallsteps.task.domain.SsTaskLog;
import io.github.linpeilie.annotations.AutoMapper;
import lombok.Data;

import java.io.Serial;
import java.io.Serializable;
import java.time.LocalDate;
import java.time.LocalDateTime;

/**
 * 任务执行记录视图对象
 */
@Data
@AutoMapper(target = SsTaskLog.class)
public class SsTaskLogVO implements Serializable {

    @Serial
    private static final long serialVersionUID = 1L;

    private Long id;
    private Long taskId;
    private Long childId;
    private String status;
    private String proof;
    private Integer rewardSnap;
    private String titleSnap;
    private LocalDate targetDate;
    private LocalDateTime startTime;
    private LocalDateTime finishTime;
    private Integer actualDuration;
}

package com.kenzhao.smallsteps.task.domain;

import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import com.kenzhao.smallsteps.common.mybatis.core.domain.BaseEntity;
import lombok.Data;
import lombok.EqualsAndHashCode;

import java.util.Date;

/**
 * 任务执行记录对象 ss_task_log
 */
@Data
@EqualsAndHashCode(callSuper = true)
@TableName("ss_task_log")
public class SsTaskLog extends BaseEntity {

    private static final long serialVersionUID = 1L;

    /** 记录ID */
    @TableId
    private Long id;

    /** 任务ID */
    private Long taskId;

    /** 儿童ID */
    private Long childId;

    /** 状态 (0:任务中, 1:已完成, 2:已失效, 3:待点亮) */
    private String status;

    /** 完成时间 */
    private Date finishTime;

    /** 证明材料 (存JSON) */
    private String proofData;

    /** 自主性评分 (1-5) */
    private Integer autonomyScore;
}

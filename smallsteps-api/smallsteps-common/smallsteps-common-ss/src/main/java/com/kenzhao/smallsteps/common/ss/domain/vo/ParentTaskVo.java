package com.kenzhao.smallsteps.common.ss.domain.vo;

import lombok.Data;

import java.io.Serial;
import java.io.Serializable;
import java.util.Date;

/**
 * 家长任务发布视图对象 parent_task
 */
@Data
public class ParentTaskVo implements Serializable {

    @Serial
    private static final long serialVersionUID = 1L;

    /** 任务ID */
    private Long taskId;

    /** 用户ID */
    private Long userId;

    /** 父任务ID */
    private Long parentId;

    /** 任务标题 */
    private String title;

    /** 任务描述 */
    private String description;

    /** 奖励积分 */
    private Integer rewardPoints;

    /** 任务状态 (1: 进行中, 2: 已完成, 0: 待发布) */
    private String status;

    /** 状态名称 */
    private String statusName;

    /** 截止时间 */
    private Date deadline;

    /** 灯光效果 */
    private String lightEffect;

    /** 音效索引 */
    private String audioEffect;

    /** 创建者 */
    private Long createBy;

    /** 创建时间 */
    private Date createTime;

    /** 更新者 */
    private Long updateBy;

    /** 更新时间 */
    private Date updateTime;

    /** 子任务步骤 */
    private java.util.List<TaskStepTemplateVo> steps;
}

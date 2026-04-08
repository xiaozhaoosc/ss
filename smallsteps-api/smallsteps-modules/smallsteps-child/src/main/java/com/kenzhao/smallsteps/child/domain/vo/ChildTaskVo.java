package com.kenzhao.smallsteps.child.domain.vo;

import lombok.Data;

/**
 * 儿童任务执行视图对象
 */
@Data
public class ChildTaskVo {

    /**
     * 任务ID
     */
    private Long taskId;

    /**
     * 任务标题
     */
    private String title;

    /**
     * 任务描述
     */
    private String description;

    /**
     * 任务状态
     */
    private String status;

    /**
     * 奖励点数
     */
    private Integer rewardPoints;

    /**
     * 开始时间
     */
    private String startTime;

    /**
     * 完成时间
     */
    private String completeTime;

    /**
     * 语音反馈
     */
    private String voiceFeedback;

    /**
     * 灯光效果
     */
    private String lightEffect;
}
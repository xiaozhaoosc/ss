package com.kenzhao.smallsteps.task.domain.dto;

import lombok.Data;

/**
 * 任务创建 DTO
 */
@Data
public class SsTaskCreateDTO {
    /** 任务标题 */
    private String title;
    /** 奖励分数/星星 */
    private Integer rewardPoints;
    /** 儿童ID */
    private Long childId;
    /** 任务描述 */
    private String description;
}

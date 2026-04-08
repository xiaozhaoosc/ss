package com.kenzhao.smallsteps.parent.domain.bo;

import lombok.Data;

/**
 * 家长成长观察业务对象
 */
@Data
public class ParentGrowthBo {

    /**
     * 记录ID
     */
    private Long recordId;

    /**
     * 用户ID
     */
    private Long userId;

    /**
     * 日期
     */
    private String date;

    /**
     * 情绪状态
     */
    private String emotionState;

    /**
     * 情绪评分
     */
    private Integer emotionScore;

    /**
     * 能力类型
     */
    private String abilityType;

    /**
     * 能力评分
     */
    private Integer abilityScore;

    /**
     * 观察记录
     */
    private String observation;

    /**
     * 时间段
     */
    private String period;

    /**
     * 开始日期
     */
    private String startDate;

    /**
     * 结束日期
     */
    private String endDate;
}
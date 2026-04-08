package com.kenzhao.smallsteps.child.domain.vo;

import lombok.Data;

/**
 * 儿童成就系统视图对象
 */
@Data
public class ChildAchievementVo {

    /**
     * 成就ID
     */
    private Long achievementId;

    /**
     * 成就名称
     */
    private String achievementName;

    /**
     * 成就描述
     */
    private String description;

    /**
     * 勇气碎片数量
     */
    private Integer shardCount;

    /**
     * 星星数量
     */
    private Integer starCount;

    /**
     * 成就状态
     */
    private String status;

    /**
     * 获得时间
     */
    private String obtainTime;

    /**
     * 奖励信息
     */
    private String rewardInfo;
}
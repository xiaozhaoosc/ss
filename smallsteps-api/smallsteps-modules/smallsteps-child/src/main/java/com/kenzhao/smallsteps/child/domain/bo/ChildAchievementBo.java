package com.kenzhao.smallsteps.child.domain.bo;

import lombok.Data;

/**
 * 儿童成就系统业务对象
 */
@Data
public class ChildAchievementBo {

    /**
     * 成就ID
     */
    private Long achievementId;

    /**
     * 用户ID
     */
    private Long userId;

    /**
     * 勇气碎片数量
     */
    private Integer shardCount;

    /**
     * 星星数量
     */
    private Integer starCount;

    /**
     * 奖励ID
     */
    private Long rewardId;

    /**
     * 奖励名称
     */
    private String rewardName;
}
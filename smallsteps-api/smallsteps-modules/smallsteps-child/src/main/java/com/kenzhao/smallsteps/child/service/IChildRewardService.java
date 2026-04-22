package com.kenzhao.smallsteps.child.service;

/**
 * 儿童奖励Service接口
 */
public interface IChildRewardService {

    /**
     * 兑换心愿礼物
     * @param rewardId 奖励ID
     * @param childId 儿童ID
     * @return 是否申请成功
     */
    Boolean redeemReward(Long rewardId, Long childId);
}

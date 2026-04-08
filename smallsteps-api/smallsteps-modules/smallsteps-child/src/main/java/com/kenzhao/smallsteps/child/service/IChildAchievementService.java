package com.kenzhao.smallsteps.child.service;

import com.kenzhao.smallsteps.child.domain.bo.ChildAchievementBo;
import com.kenzhao.smallsteps.child.domain.vo.ChildAchievementVo;

import java.util.List;

/**
 * 儿童成就系统服务接口
 */
public interface IChildAchievementService {

    /**
     * 收集勇气碎片
     */
    ChildAchievementVo collectCourageShard(Long userId, Integer shardCount);

    /**
     * 查询星星余额
     */
    Integer getStarsBalance(Long userId);

    /**
     * 兑换奖励
     */
    ChildAchievementVo exchangeReward(ChildAchievementBo bo);

    /**
     * 查询成就列表
     */
    List<ChildAchievementVo> queryAchievementList(Long userId);

    /**
     * 根据成就ID查询成就详情
     */
    ChildAchievementVo queryById(Long achievementId);
}
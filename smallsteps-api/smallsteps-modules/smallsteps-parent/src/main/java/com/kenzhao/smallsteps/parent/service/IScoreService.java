package com.kenzhao.smallsteps.parent.service;

import com.kenzhao.smallsteps.parent.domain.ChildScore;
import com.baomidou.mybatisplus.extension.service.IService;

/**
 * 积分服务接口
 * 
 * @author kenzhao
 * @date 2026-02-03
 */
public interface IScoreService extends IService<ChildScore> {
    /**
     * 获取用户当前积分信息
     * 
     * @param userId 用户ID
     * @return 积分信息
     */
    ChildScore getChildScore(Long userId);

    /**
     * 增加积分
     * 
     * @param userId   用户ID
     * @param points   积分数
     * @param sourceId 来源ID (任务ID)
     * @param reason   原因
     */
    void addPoints(Long userId, Integer points, Long sourceId, String reason);

    /**
     * 扣除积分 (兑换)
     * 
     * @param userId   用户ID
     * @param points   积分数
     * @param sourceId 来源ID (奖励ID)
     * @param reason   原因
     * @return 是否成功
     */
    boolean deductPoints(Long userId, Integer points, Long sourceId, String reason);
}

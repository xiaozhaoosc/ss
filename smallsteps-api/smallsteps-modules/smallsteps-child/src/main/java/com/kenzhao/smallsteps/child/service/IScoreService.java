package com.kenzhao.smallsteps.child.service;

import com.kenzhao.smallsteps.common.mybatis.core.page.PageQuery;
import com.kenzhao.smallsteps.common.mybatis.core.page.TableDataInfo;
import com.kenzhao.smallsteps.common.ss.domain.ChildScore;

import java.util.Map;

/**
 * 积分服务接口
 */
public interface IScoreService {
    /**
     * 获取用户积分
     *
     * @param userId 用户ID
     * @return 用户积分
     */
    public ChildScore getChildScore(Long userId);

    /**
     * 添加积分
     *
     * @param userId 用户ID
     * @param points 积分数量
     * @param taskId 任务ID
     * @param reason 原因
     * @return 结果
     */
    public boolean addPoints(Long userId, int points, Long taskId, String reason);

    /**
     * 扣除积分
     *
     * @param userId 用户ID
     * @param points 积分数量
     * @param rewardId 奖励ID
     * @param reason 原因
     * @return 结果
     */
    public boolean deductPoints(Long userId, int points, Long rewardId, String reason);

    /**
     * 获取积分历史
     *
     * @param userId 用户ID
     * @param pageQuery 分页参数
     * @return 积分历史
     */
    public TableDataInfo<Map<String, Object>> getScoreHistory(Long userId, PageQuery pageQuery);
}

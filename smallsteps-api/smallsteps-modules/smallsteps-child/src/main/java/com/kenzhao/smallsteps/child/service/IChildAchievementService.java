package com.kenzhao.smallsteps.child.service;

import com.kenzhao.smallsteps.common.ss.domain.ChildAchievement;
import java.util.List;

/**
 * 儿童成就服务接口
 */
public interface IChildAchievementService {

    List<ChildAchievement> selectChildAchievementList(ChildAchievement childAchievement);

    ChildAchievement selectChildAchievementById(Long id);

    int insertChildAchievement(ChildAchievement childAchievement);

    int updateChildAchievement(ChildAchievement childAchievement);

    int deleteChildAchievementById(Long id);

    int deleteChildAchievementByIds(Long[] ids);

    /**
     * 奖励星星
     */
    int rewardStars(Long childId, Integer stars);

    /**
     * 奖励勇气碎片
     */
    int rewardCourageFragments(Long childId, Integer fragments);

    /**
     * 兑换奖励
     */
    int exchangeReward(Long childId, Integer costStars, String rewardName);

    /**
     * 查询儿童连击天数 (Streak)
     */
    public Integer selectStreakByChildId(Long childId);

    /**
     * 查询儿童成就统计
     */

    List<ChildAchievement> selectAchievementStatsByChildId(Long childId);

    /**
     * 总星星数
     */
    Integer selectTotalStarsByChildId(Long childId);

    /**
     * 总勇气碎片数
     */
    Integer selectTotalCourageFragmentsByChildId(Long childId);

    /**
     * 检查并解锁勋章
     */
    void checkAndUnlockBadges(Long childId);
}

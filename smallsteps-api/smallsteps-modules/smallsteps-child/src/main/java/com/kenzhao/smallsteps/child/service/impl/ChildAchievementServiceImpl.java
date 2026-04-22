package com.kenzhao.smallsteps.child.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.kenzhao.smallsteps.child.mapper.ChildAchievementMapper;
import com.kenzhao.smallsteps.child.service.IChildAchievementService;
import com.kenzhao.smallsteps.common.ss.domain.ChildAchievement;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.Arrays;
import java.util.List;

/**
 * 儿童成就服务实现
 */
@Service
@RequiredArgsConstructor
public class ChildAchievementServiceImpl implements IChildAchievementService {

    private final ChildAchievementMapper baseMapper;

    @Override
    public List<ChildAchievement> selectChildAchievementList(ChildAchievement childAchievement) {
        return baseMapper.selectList(new LambdaQueryWrapper<ChildAchievement>()
            .eq(childAchievement.getChildId() != null, ChildAchievement::getChildId, childAchievement.getChildId())
            .eq(childAchievement.getType() != null, ChildAchievement::getType, childAchievement.getType())
            .like(childAchievement.getName() != null, ChildAchievement::getName, childAchievement.getName()));
    }

    @Override
    public ChildAchievement selectChildAchievementById(Long id) {
        return baseMapper.selectById(id);
    }

    @Override
    public int insertChildAchievement(ChildAchievement childAchievement) {
        return baseMapper.insert(childAchievement);
    }

    @Override
    public int updateChildAchievement(ChildAchievement childAchievement) {
        return baseMapper.updateById(childAchievement);
    }

    @Override
    public int deleteChildAchievementById(Long id) {
        return baseMapper.deleteById(id);
    }

    @Override
    public int deleteChildAchievementByIds(Long[] ids) {
        return baseMapper.deleteByIds(Arrays.asList(ids));
    }

    @Override
    public int rewardStars(Long childId, Integer stars) {
        return updateCount(childId, "STAR", "我的星星", stars);
    }

    @Override
    public int rewardCourageFragments(Long childId, Integer fragments) {
        return updateCount(childId, "FRAGMENT", "勇气碎片", fragments);
    }

    private int updateCount(Long childId, String type, String name, Integer amount) {
        ChildAchievement achievement = baseMapper.selectOne(new LambdaQueryWrapper<ChildAchievement>()
            .eq(ChildAchievement::getChildId, childId)
            .eq(ChildAchievement::getType, type));
        
        if (achievement == null) {
            achievement = new ChildAchievement();
            achievement.setChildId(childId);
            achievement.setType(type);
            achievement.setName(name);
            achievement.setCount(amount);
            return baseMapper.insert(achievement);
        } else {
            achievement.setCount(achievement.getCount() + amount);
            return baseMapper.updateById(achievement);
        }
    }

    @Override
    public int exchangeReward(Long childId, Integer costStars, String rewardName) {
        ChildAchievement stars = baseMapper.selectOne(new LambdaQueryWrapper<ChildAchievement>()
            .eq(ChildAchievement::getChildId, childId)
            .eq(ChildAchievement::getType, "STAR"));
        
        if (stars == null || stars.getCount() < costStars) {
            return 0;
        }
        
        stars.setCount(stars.getCount() - costStars);
        return baseMapper.updateById(stars);
    }

    @Override
    public Integer selectStreakByChildId(Long childId) {
        // 模拟逻辑：返回一个固定值或基于某种记录计算
        // 实际开发中通过查询每日打卡记录计算
        return 5; 
    }

    @Override
    public List<ChildAchievement> selectAchievementStatsByChildId(Long childId) {
        return baseMapper.selectList(new LambdaQueryWrapper<ChildAchievement>()
            .eq(ChildAchievement::getChildId, childId));
    }

    @Override
    public Integer selectTotalStarsByChildId(Long childId) {
        ChildAchievement stars = baseMapper.selectOne(new LambdaQueryWrapper<ChildAchievement>()
            .eq(ChildAchievement::getChildId, childId)
            .eq(ChildAchievement::getType, "STAR"));
        return stars != null ? stars.getCount() : 0;
    }

    @Override
    public Integer selectTotalCourageFragmentsByChildId(Long childId) {
        ChildAchievement fragments = baseMapper.selectOne(new LambdaQueryWrapper<ChildAchievement>()
            .eq(ChildAchievement::getChildId, childId)
            .eq(ChildAchievement::getType, "FRAGMENT"));
        return fragments != null ? fragments.getCount() : 0;
    }

    @Override
    @org.springframework.transaction.annotation.Transactional
    public void checkAndUnlockBadges(Long childId) {
        // 1. 恒心大师 (7天连击)
        Integer streak = selectStreakByChildId(childId);
        if (streak >= 7) {
            unlockBadge(childId, "恒心大师", "坚持打卡7天，你太棒了！", "consistency_medal");
        }

        // 2. 星光熠熠 (100颗星星)
        Integer totalStars = selectTotalStarsByChildId(childId);
        if (totalStars >= 100) {
            unlockBadge(childId, "星光熠熠", "累积获得100颗星星，你闪闪发光！", "star_medal");
        }

        // 3. 早起鸟 (08:00前完成)
        if (java.time.LocalTime.now().isBefore(java.time.LocalTime.of(8, 0))) {
            unlockBadge(childId, "早起鸟", "太阳公公还没起床你就完成任务啦！", "early_bird");
        }
    }

    private void unlockBadge(Long childId, String name, String remark, String icon) {
        // 检查是否已经获得过该勋章
        ChildAchievement existing = baseMapper.selectOne(new LambdaQueryWrapper<ChildAchievement>()
            .eq(ChildAchievement::getChildId, childId)
            .eq(ChildAchievement::getType, "BADGE")
            .eq(ChildAchievement::getName, name));
        
        if (existing == null) {
            ChildAchievement badge = new ChildAchievement();
            badge.setChildId(childId);
            badge.setType("BADGE");
            badge.setName(name);
            badge.setRemark(remark);
            badge.setIcon(icon);
            badge.setCount(1);
            baseMapper.insert(badge);
        }
    }
}

package com.kenzhao.smallsteps.child.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.kenzhao.smallsteps.child.domain.ChildAchievement;
import com.kenzhao.smallsteps.child.mapper.ChildAchievementMapper;
import com.kenzhao.smallsteps.child.service.IChildAchievementService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

/**
 * 儿童成就服务实现
 */
@Service
@RequiredArgsConstructor
public class ChildAchievementServiceImpl implements IChildAchievementService {

    private final ChildAchievementMapper childAchievementMapper;
    private final com.kenzhao.smallsteps.parent.mapper.ChildTaskMapper childTaskMapper;

    @Override
    public Integer selectStreakByChildId(Long childId) {
        List<String> dates = childTaskMapper.selectFinishedDatesByChildId(childId);
        if (dates == null || dates.isEmpty()) {
            return 0;
        }
        java.time.LocalDate today = java.time.LocalDate.now();
        int streak = 0;
        java.time.LocalDate currentCheck = today;
        if (!dates.contains(today.toString())) {
            currentCheck = today.minusDays(1);
        }
        while (dates.contains(currentCheck.toString())) {
            streak++;
            currentCheck = currentCheck.minusDays(1);
        }
        return streak;
    }

    @Override
    public List<ChildAchievement> selectChildAchievementList(ChildAchievement childAchievement) {
        return childAchievementMapper.selectList(new LambdaQueryWrapper<ChildAchievement>()
                .eq(childAchievement.getChildId() != null, ChildAchievement::getChildId, childAchievement.getChildId())
                .eq(childAchievement.getType() != null, ChildAchievement::getType, childAchievement.getType()));
    }

    @Override
    public ChildAchievement selectChildAchievementByAchievementId(Long achievementId) {
        return childAchievementMapper.selectById(achievementId);
    }

    @Override
    public int insertChildAchievement(ChildAchievement childAchievement) {
        return childAchievementMapper.insert(childAchievement);
    }

    @Override
    public int updateChildAchievement(ChildAchievement childAchievement) {
        return childAchievementMapper.updateById(childAchievement);
    }

    @Override
    public int deleteChildAchievementByAchievementId(Long achievementId) {
        return childAchievementMapper.deleteById(achievementId);
    }

    @Override
    public int deleteChildAchievementByAchievementIds(Long[] achievementIds) {
        return childAchievementMapper.deleteBatchIds(List.of(achievementIds));
    }

    @Override
    @Transactional
    public int rewardStars(Long childId, Integer stars) {
        return updateCounter(childId, "STAR", "星星", stars);
    }

    @Override
    @Transactional
    public int rewardCourageFragments(Long childId, Integer fragments) {
        return updateCounter(childId, "FRAGMENT", "勇气碎片", fragments);
    }

    @Override
    @Transactional
    public int exchangeReward(Long childId, Integer costStars, String rewardName) {
        ChildAchievement starAsset = childAchievementMapper.selectOne(new LambdaQueryWrapper<ChildAchievement>()
                .eq(ChildAchievement::getChildId, childId)
                .eq(ChildAchievement::getType, "STAR"));
        
        if (starAsset != null && starAsset.getCount() >= costStars) {
            starAsset.setCount(starAsset.getCount() - costStars);
            return childAchievementMapper.updateById(starAsset);
        }
        return 0;
    }

    @Override
    public List<ChildAchievement> selectAchievementStatsByChildId(Long childId) {
        return selectChildAchievementList(new ChildAchievement() {{ setChildId(childId); }});
    }

    @Override
    public Integer selectTotalStarsByChildId(Long childId) {
        ChildAchievement asset = childAchievementMapper.selectOne(new LambdaQueryWrapper<ChildAchievement>()
                .eq(ChildAchievement::getChildId, childId)
                .eq(ChildAchievement::getType, "STAR"));
        return asset != null ? asset.getCount() : 0;
    }

    @Override
    public Integer selectTotalCourageFragmentsByChildId(Long childId) {
        ChildAchievement asset = childAchievementMapper.selectOne(new LambdaQueryWrapper<ChildAchievement>()
                .eq(ChildAchievement::getChildId, childId)
                .eq(ChildAchievement::getType, "FRAGMENT"));
        return asset != null ? asset.getCount() : 0;
    }

    private int updateCounter(Long childId, String type, String name, Integer delta) {
        ChildAchievement asset = childAchievementMapper.selectOne(new LambdaQueryWrapper<ChildAchievement>()
                .eq(ChildAchievement::getChildId, childId)
                .eq(ChildAchievement::getType, type));
        
        if (asset == null) {
            asset = new ChildAchievement();
            asset.setChildId(childId);
            asset.setType(type);
            asset.setName(name);
            asset.setCount(delta);
            return childAchievementMapper.insert(asset);
        } else {
            asset.setCount(asset.getCount() + delta);
            return childAchievementMapper.updateById(asset);
        }
    }
}

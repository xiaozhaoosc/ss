package com.kenzhao.smallsteps.child.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.kenzhao.smallsteps.child.domain.ChildAchievement;
import com.kenzhao.smallsteps.child.domain.bo.ChildAchievementBo;
import com.kenzhao.smallsteps.child.domain.vo.ChildAchievementVo;
import com.kenzhao.smallsteps.child.mapper.ChildAchievementMapper;
import com.kenzhao.smallsteps.child.service.IChildAchievementService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.List;
import java.util.stream.Collectors;

/**
 * 儿童成就系统服务实现
 */
@Service
@RequiredArgsConstructor
public class ChildAchievementServiceImpl implements IChildAchievementService {

    private final ChildAchievementMapper childAchievementMapper;

    @Override
    public ChildAchievementVo collectCourageShard(Long userId, Integer shardCount) {
        // 查找用户的成就记录
        LambdaQueryWrapper<ChildAchievement> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(ChildAchievement::getUserId, userId);
        List<ChildAchievement> achievements = childAchievementMapper.selectList(wrapper);

        ChildAchievement achievement;
        if (achievements.isEmpty()) {
            // 创建新的成就记录
            achievement = new ChildAchievement();
            achievement.setUserId(userId);
            achievement.setAchievementName("勇气小达人");
            achievement.setDescription("收集勇气碎片，成为勇敢的孩子");
            achievement.setShardCount(shardCount);
            achievement.setStarCount(0);
            achievement.setStatus("0"); // 进行中
            achievement.setCreateTime(LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss")));
            childAchievementMapper.insert(achievement);
        } else {
            // 更新现有成就记录
            achievement = achievements.get(0);
            achievement.setShardCount(achievement.getShardCount() + shardCount);
            if (achievement.getShardCount() >= 10) {
                achievement.setStatus("1"); // 已完成
                achievement.setStarCount(achievement.getStarCount() + 1);
                achievement.setObtainTime(LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss")));
            }
            achievement.setUpdateTime(LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss")));
            childAchievementMapper.updateById(achievement);
        }

        return convertToVo(achievement);
    }

    @Override
    public Integer getStarsBalance(Long userId) {
        LambdaQueryWrapper<ChildAchievement> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(ChildAchievement::getUserId, userId);
        List<ChildAchievement> achievements = childAchievementMapper.selectList(wrapper);

        if (achievements.isEmpty()) {
            return 0;
        }

        return achievements.stream()
                .mapToInt(ChildAchievement::getStarCount)
                .sum();
    }

    @Override
    public ChildAchievementVo exchangeReward(ChildAchievementBo bo) {
        // 查找用户的成就记录
        LambdaQueryWrapper<ChildAchievement> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(ChildAchievement::getUserId, bo.getUserId());
        List<ChildAchievement> achievements = childAchievementMapper.selectList(wrapper);

        if (achievements.isEmpty()) {
            throw new RuntimeException("用户没有成就记录");
        }

        ChildAchievement achievement = achievements.get(0);
        if (achievement.getStarCount() < bo.getStarCount()) {
            throw new RuntimeException("星星数量不足");
        }

        // 扣除星星并更新成就记录
        achievement.setStarCount(achievement.getStarCount() - bo.getStarCount());
        achievement.setUpdateTime(LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss")));
        childAchievementMapper.updateById(achievement);

        ChildAchievementVo vo = convertToVo(achievement);
        vo.setRewardInfo("兑换成功：" + bo.getRewardName());
        return vo;
    }

    @Override
    public List<ChildAchievementVo> queryAchievementList(Long userId) {
        LambdaQueryWrapper<ChildAchievement> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(ChildAchievement::getUserId, userId);
        List<ChildAchievement> achievements = childAchievementMapper.selectList(wrapper);
        return achievements.stream().map(this::convertToVo).collect(Collectors.toList());
    }

    @Override
    public ChildAchievementVo queryById(Long achievementId) {
        ChildAchievement achievement = childAchievementMapper.selectById(achievementId);
        return achievement != null ? convertToVo(achievement) : null;
    }

    /**
     * 转换为VO
     */
    private ChildAchievementVo convertToVo(ChildAchievement achievement) {
        ChildAchievementVo vo = new ChildAchievementVo();
        vo.setAchievementId(achievement.getAchievementId());
        vo.setAchievementName(achievement.getAchievementName());
        vo.setDescription(achievement.getDescription());
        vo.setShardCount(achievement.getShardCount());
        vo.setStarCount(achievement.getStarCount());
        vo.setStatus(achievement.getStatus());
        vo.setObtainTime(achievement.getObtainTime());
        return vo;
    }
}
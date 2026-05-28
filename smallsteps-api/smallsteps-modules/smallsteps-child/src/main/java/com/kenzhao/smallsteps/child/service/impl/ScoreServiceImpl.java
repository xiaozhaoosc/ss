package com.kenzhao.smallsteps.child.service.impl;

import com.kenzhao.smallsteps.common.mybatis.core.page.PageQuery;
import com.kenzhao.smallsteps.common.mybatis.core.page.TableDataInfo;
import com.kenzhao.smallsteps.common.ss.domain.ChildScore;
import com.kenzhao.smallsteps.common.ss.domain.ScoreHistory;
import com.kenzhao.smallsteps.child.mapper.ChildScoreMapper;
import com.kenzhao.smallsteps.child.mapper.ScoreHistoryMapper;
import com.kenzhao.smallsteps.child.service.IScoreService;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 积分服务实现
 */
@Service
@RequiredArgsConstructor
public class ScoreServiceImpl implements IScoreService {

    private final ChildScoreMapper childScoreMapper;
    private final ScoreHistoryMapper scoreHistoryMapper;
    private final com.kenzhao.smallsteps.child.service.IChildAchievementService childAchievementService;
    private final com.kenzhao.smallsteps.child.mapper.ChildAchievementMapper childAchievementMapper;

    @Override
    public ChildScore getChildScore(Long userId) {
        ChildScore childScore = childScoreMapper.selectOne(new LambdaQueryWrapper<ChildScore>()
            .eq(ChildScore::getUserId, userId));
        if (childScore == null) {
            // 如果用户积分记录不存在，创建一个新的
            childScore = new ChildScore();
            childScore.setUserId(userId);
            childScore.setBalance(0);
            childScore.setTotalEarned(0);
            childScoreMapper.insert(childScore);
        }
        return childScore;
    }

    @Override
    public boolean addPoints(Long userId, int points, Long taskId, String reason) {
        // 获取当前积分
        ChildScore childScore = getChildScore(userId);

        // 更新积分
        childScore.setBalance(childScore.getBalance() + points);
        childScore.setTotalEarned(childScore.getTotalEarned() + points);
        childScoreMapper.updateById(childScore);

        // 记录积分历史
        ScoreHistory scoreHistory = new ScoreHistory();
        scoreHistory.setUserId(userId);
        scoreHistory.setAmount(points);
        scoreHistory.setType("1"); // 1-增加
        scoreHistory.setSourceId(taskId);
        scoreHistory.setReason(reason);
        scoreHistoryMapper.insert(scoreHistory);

        // 同步更新成就表中的星星数量
        syncStarsToAchievement(userId, points);

        // 异步或直接触发勋章检查
        childAchievementService.checkAndUnlockBadges(userId);

        return true;
    }

    /**
     * 同步星星到成就表
     */
    private void syncStarsToAchievement(Long childId, int points) {
        com.kenzhao.smallsteps.common.ss.domain.ChildAchievement stars = childAchievementMapper.selectOne(
            new com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper<com.kenzhao.smallsteps.common.ss.domain.ChildAchievement>()
                .eq(com.kenzhao.smallsteps.common.ss.domain.ChildAchievement::getChildId, childId)
                .eq(com.kenzhao.smallsteps.common.ss.domain.ChildAchievement::getType, "STAR"));

        if (stars == null) {
            stars = new com.kenzhao.smallsteps.common.ss.domain.ChildAchievement();
            stars.setChildId(childId);
            stars.setType("STAR");
            stars.setName("我的星星");
            stars.setCount(points);
            childAchievementMapper.insert(stars);
        } else {
            stars.setCount(stars.getCount() + points);
            childAchievementMapper.updateById(stars);
        }
    }

    @Override
    public boolean deductPoints(Long userId, int points, Long rewardId, String reason) {
        // 获取当前积分
        ChildScore childScore = getChildScore(userId);
        
        // 检查积分是否足够
        if (childScore.getBalance() < points) {
            return false;
        }
        
        // 更新积分
        childScore.setBalance(childScore.getBalance() - points);
        childScoreMapper.updateById(childScore);
        
        // 记录积分历史
        ScoreHistory scoreHistory = new ScoreHistory();
        scoreHistory.setUserId(userId);
        scoreHistory.setAmount(points);
        scoreHistory.setType("2"); // 2-扣除
        scoreHistory.setSourceId(rewardId);
        scoreHistory.setReason(reason);
        scoreHistoryMapper.insert(scoreHistory);
        
        return true;
    }

    @Override
    public TableDataInfo<Map<String, Object>> getScoreHistory(Long userId, PageQuery pageQuery) {
        LambdaQueryWrapper<ScoreHistory> lqw = new LambdaQueryWrapper<>();
        lqw.eq(ScoreHistory::getUserId, userId)
           .orderByDesc(ScoreHistory::getCreateTime);
        
        List<ScoreHistory> list = scoreHistoryMapper.selectList(lqw);
        List<Map<String, Object>> result = new ArrayList<>();
        
        for (ScoreHistory history : list) {
            Map<String, Object> map = new HashMap<>();
            map.put("id", history.getId());
            map.put("points", history.getAmount());
            map.put("type", "1".equals(history.getType()) ? "增加" : "扣除");
            map.put("reason", history.getReason());
            map.put("createTime", history.getCreateTime());
            result.add(map);
        }
        
        return TableDataInfo.build(result);
    }
}

package com.kenzhao.smallsteps.parent.service.impl;

import com.kenzhao.smallsteps.common.mybatis.core.page.PageQuery;
import com.kenzhao.smallsteps.common.mybatis.core.page.TableDataInfo;
import com.kenzhao.smallsteps.parent.domain.ChildScore;
import com.kenzhao.smallsteps.parent.domain.ScoreHistory;
import com.kenzhao.smallsteps.parent.mapper.ChildScoreMapper;
import com.kenzhao.smallsteps.parent.mapper.ScoreHistoryMapper;
import com.kenzhao.smallsteps.parent.service.IScoreService;
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

    @Override
    public ChildScore getChildScore(Long userId) {
        ChildScore childScore = childScoreMapper.selectChildScoreByUserId(userId);
        if (childScore == null) {
            // 如果用户积分记录不存在，创建一个新的
            childScore = new ChildScore();
            childScore.setUserId(userId);
            childScore.setScore(0);
            childScoreMapper.insertChildScore(childScore);
        }
        return childScore;
    }

    @Override
    public boolean addPoints(Long userId, int points, Long taskId, String reason) {
        // 获取当前积分
        ChildScore childScore = getChildScore(userId);
        
        // 更新积分
        childScore.setScore(childScore.getScore() + points);
        childScoreMapper.updateChildScore(childScore);
        
        // 记录积分历史
        ScoreHistory scoreHistory = new ScoreHistory();
        scoreHistory.setUserId(userId);
        scoreHistory.setPoints(points);
        scoreHistory.setType(1); // 1-增加
        scoreHistory.setTaskId(taskId);
        scoreHistory.setReason(reason);
        scoreHistoryMapper.insertScoreHistory(scoreHistory);
        
        return true;
    }

    @Override
    public boolean deductPoints(Long userId, int points, Long rewardId, String reason) {
        // 获取当前积分
        ChildScore childScore = getChildScore(userId);
        
        // 检查积分是否足够
        if (childScore.getScore() < points) {
            return false;
        }
        
        // 更新积分
        childScore.setScore(childScore.getScore() - points);
        childScoreMapper.updateChildScore(childScore);
        
        // 记录积分历史
        ScoreHistory scoreHistory = new ScoreHistory();
        scoreHistory.setUserId(userId);
        scoreHistory.setPoints(points);
        scoreHistory.setType(2); // 2-扣除
        scoreHistory.setRewardId(rewardId);
        scoreHistory.setReason(reason);
        scoreHistoryMapper.insertScoreHistory(scoreHistory);
        
        return true;
    }

    @Override
    public TableDataInfo<Map<String, Object>> getScoreHistory(Long userId, PageQuery pageQuery) {
        // 模拟积分历史数据
        List<Map<String, Object>> history = new ArrayList<>();
        
        // 模拟数据
        Map<String, Object> item1 = new HashMap<>();
        item1.put("id", 1);
        item1.put("points", 10);
        item1.put("type", "增加");
        item1.put("reason", "完成任务: 完成作业");
        item1.put("createTime", "2026-03-31 10:00:00");
        history.add(item1);
        
        Map<String, Object> item2 = new HashMap<>();
        item2.put("id", 2);
        item2.put("points", 5);
        item2.put("type", "增加");
        item2.put("reason", "完成任务: 整理房间");
        item2.put("createTime", "2026-03-30 15:30:00");
        history.add(item2);
        
        Map<String, Object> item3 = new HashMap<>();
        item3.put("id", 3);
        item3.put("points", 20);
        item3.put("type", "扣除");
        item3.put("reason", "兑换: 玩具车");
        item3.put("createTime", "2026-03-29 14:00:00");
        history.add(item3);
        
        return TableDataInfo.build(history);
    }
}

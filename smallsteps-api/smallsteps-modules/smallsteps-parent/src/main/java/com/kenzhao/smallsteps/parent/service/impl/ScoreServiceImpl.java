package com.kenzhao.smallsteps.parent.service.impl;

import com.kenzhao.smallsteps.parent.domain.ChildScore;
import com.kenzhao.smallsteps.parent.domain.ScoreHistory;
import com.kenzhao.smallsteps.parent.mapper.ChildScoreMapper;
import com.kenzhao.smallsteps.parent.mapper.ScoreHistoryMapper;
import com.kenzhao.smallsteps.parent.service.IScoreService;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

/**
 * 积分服务实现类
 * 
 * @author kenzhao
 * @date 2026-02-03
 */
@Service
public class ScoreServiceImpl extends ServiceImpl<ChildScoreMapper, ChildScore> implements IScoreService {
    @Autowired
    private ChildScoreMapper childScoreMapper;

    @Autowired
    private ScoreHistoryMapper scoreHistoryMapper;

    @Override
    public ChildScore getChildScore(Long userId) {
        ChildScore score = childScoreMapper.selectById(userId);
        if (score == null) {
            score = new ChildScore();
            score.setUserId(userId);
            score.setBalance(0);
            score.setTotalEarned(0);
            childScoreMapper.insert(score);
        }
        return score;
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public void addPoints(Long userId, Integer points, Long sourceId, String reason) {
        ChildScore score = getChildScore(userId);
        score.setBalance(score.getBalance() + points);
        score.setTotalEarned(score.getTotalEarned() + points);
        childScoreMapper.updateById(score);

        ScoreHistory history = new ScoreHistory();
        history.setUserId(userId);
        history.setAmount(points);
        history.setType("1"); // Earn
        history.setSourceId(sourceId);
        history.setReason(reason);
        scoreHistoryMapper.insert(history);
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public boolean deductPoints(Long userId, Integer points, Long sourceId, String reason) {
        ChildScore score = getChildScore(userId);
        if (score.getBalance() < points) {
            return false;
        }

        score.setBalance(score.getBalance() - points);
        childScoreMapper.updateById(score);

        ScoreHistory history = new ScoreHistory();
        history.setUserId(userId);
        history.setAmount(points);
        history.setType("2"); // Spend
        history.setSourceId(sourceId);
        history.setReason(reason);
        scoreHistoryMapper.insert(history);

        return true;
    }
}

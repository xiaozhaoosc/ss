package com.kenzhao.smallsteps.child.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.kenzhao.smallsteps.common.ss.domain.ChildAI;
import com.kenzhao.smallsteps.child.service.IChildAIService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * 儿童AI交互记录服务实现
 */
@Service
@RequiredArgsConstructor
public class ChildAIServiceImpl implements IChildAIService {

    @Override
    public List<ChildAI> selectChildAIList(ChildAI childAI) {
        return List.of();
    }

    @Override
    public ChildAI selectChildAIByAiId(Long aiId) {
        return null;
    }

    @Override
    public int insertChildAI(ChildAI childAI) {
        return 0;
    }

    @Override
    public int updateChildAI(ChildAI childAI) {
        return 0;
    }

    @Override
    public int deleteChildAIByAiId(Long aiId) {
        return 0;
    }

    @Override
    public int deleteChildAIByAiIds(Long[] aiIds) {
        return 0;
    }

    @Override
    public String chatWithAI(Long childId, String userInput, Integer emotionType) {
        return "AI Response Mock";
    }

    @Override
    public List<ChildAI> selectRecentInteractionsByChildId(Long childId, Integer limit) {
        return List.of();
    }

    @Override
    public List<ChildAI> selectEmotionTrendByChildId(Long childId, Integer days) {
        return List.of();
    }
}

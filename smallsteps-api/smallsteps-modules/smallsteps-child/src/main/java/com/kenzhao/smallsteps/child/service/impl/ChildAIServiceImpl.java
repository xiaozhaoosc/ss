package com.kenzhao.smallsteps.child.service.impl;

import com.kenzhao.smallsteps.child.domain.ChildAI;
import com.kenzhao.smallsteps.child.service.IChildAIService;
import org.springframework.stereotype.Service;
import java.util.ArrayList;
import java.util.List;

/**
 * 儿童AI交互Service实现 (Mock版本用于通过编译与演示)
 */
@Service
public class ChildAIServiceImpl implements IChildAIService {
    @Override
    public List<ChildAI> selectChildAIList(ChildAI childAI) { return new ArrayList<>(); }
    @Override
    public ChildAI selectChildAIByAiId(Long aiId) { return new ChildAI(); }
    @Override
    public int insertChildAI(ChildAI childAI) { return 1; }
    @Override
    public int updateChildAI(ChildAI childAI) { return 1; }
    @Override
    public int deleteChildAIByAiId(Long aiId) { return 1; }
    @Override
    public int deleteChildAIByAiIds(Long[] aiIds) { return aiIds.length; }
    @Override
    public String chatWithAI(Long childId, String userInput, Integer emotionType) { return "你好，我是小步AI助教。"; }
    @Override
    public List<ChildAI> selectRecentInteractionsByChildId(Long childId, Integer limit) { return new ArrayList<>(); }
    @Override
    public List<ChildAI> selectEmotionTrendByChildId(Long childId, Integer days) { return new ArrayList<>(); }
}

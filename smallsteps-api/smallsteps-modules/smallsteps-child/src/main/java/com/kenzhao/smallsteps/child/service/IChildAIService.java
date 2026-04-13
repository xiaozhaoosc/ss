package com.kenzhao.smallsteps.child.service;

import com.kenzhao.smallsteps.common.ss.domain.ChildAI;
import java.util.List;

/**
 * 儿童AI交互Service接口
 */
public interface IChildAIService {
    List<ChildAI> selectChildAIList(ChildAI childAI);
    ChildAI selectChildAIByAiId(Long aiId);
    int insertChildAI(ChildAI childAI);
    int updateChildAI(ChildAI childAI);
    int deleteChildAIByAiId(Long aiId);
    int deleteChildAIByAiIds(Long[] aiIds);
    
    /** 与AI对话 */
    String chatWithAI(Long childId, String userInput, Integer emotionType);
    
    /** 查询最近交互记录 */
    List<ChildAI> selectRecentInteractionsByChildId(Long childId, Integer limit);
    
    /** 查询情绪趋势 */
    List<ChildAI> selectEmotionTrendByChildId(Long childId, Integer days);
}

package com.kenzhao.smallsteps.child.service;

import com.kenzhao.smallsteps.common.ss.domain.ChildAI;
import java.util.List;

/**
 * 儿童AI交互Service接口
 */
public interface IChildAIService {
    List<ChildAI> selectChildAIList(ChildAI childAI);
    ChildAI selectChildAIById(Long id);
    int insertChildAI(ChildAI childAI);
    int updateChildAI(ChildAI childAI);
    int deleteChildAIById(Long id);
    int deleteChildAIByIds(Long[] ids);
    
    /** 与AI对话 */
    String chatWithAI(Long childId, String userInput, Integer emotionType);
    
    /** 查询最近交互记录 */
    List<ChildAI> selectRecentInteractionsByChildId(Long childId, Integer limit);
    
    /** 查询情绪趋势 */
    List<ChildAI> selectEmotionTrendByChildId(Long childId, Integer days);
}

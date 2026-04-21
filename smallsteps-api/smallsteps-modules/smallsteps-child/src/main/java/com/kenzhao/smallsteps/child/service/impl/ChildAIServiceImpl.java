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

    private final com.kenzhao.smallsteps.child.mapper.ChildAIMapper baseMapper;
    private final com.kenzhao.smallsteps.common.ai.service.IAiService aiService;

    @Override
    public List<ChildAI> selectChildAIList(ChildAI childAI) {
        return baseMapper.selectList(new LambdaQueryWrapper<ChildAI>()
            .eq(childAI.getChildId() != null, ChildAI::getChildId, childAI.getChildId())
            .orderByDesc(ChildAI::getCreateTime));
    }

    @Override
    public ChildAI selectChildAIByAiId(Long aiId) {
        return baseMapper.selectById(aiId);
    }

    @Override
    public int insertChildAI(ChildAI childAI) {
        return baseMapper.insert(childAI);
    }

    @Override
    public int updateChildAI(ChildAI childAI) {
        return baseMapper.updateById(childAI);
    }

    @Override
    public int deleteChildAIByAiId(Long aiId) {
        return baseMapper.deleteById(aiId);
    }

    @Override
    public int deleteChildAIByAiIds(Long[] aiIds) {
        return baseMapper.deleteByIds(java.util.Arrays.asList(aiIds));
    }

    @Override
    public String chatWithAI(Long childId, String userInput, Integer emotionType) {
        // 1. 分析情感 (如果传入的 emotionType 为空，则调用 AI 服务分析)
        java.util.Map<String, Object> analysis = aiService.emotionAnalysis(childId, userInput);
        Integer detectedType = (Integer) analysis.getOrDefault("emotionType", 5);
        
        // 2. 模拟/生成回复 (后续可以接入更复杂的聊天逻辑，目前以鼓励为主)
        String aiReply = generateEncouragingReply(analysis);
        
        // 3. 保存记录
        ChildAI record = new ChildAI();
        record.setChildId(childId);
        record.setUserInput(userInput);
        record.setAiResponse(aiReply);
        record.setEmotionType(detectedType);
        baseMapper.insert(record);
        
        return aiReply;
    }

    private String generateEncouragingReply(java.util.Map<String, Object> analysis) {
        Integer type = (Integer) analysis.getOrDefault("emotionType", 5);
        String emotion = (String) analysis.getOrDefault("emotion", "平静");
        
        return switch (type) {
            case 1 -> "看到你这么开心，我也觉得超级棒！继续保持这种能量哦！🚀";
            case 2 -> "听起来你有些难过... 没关系的，我是你最好的伙伴。深呼吸一下，要不要玩点轻松的？❤️";
            case 3 -> "嘿，感觉你现在的火气有点大。这很正常，深呼吸，我们可以一起把烦恼都“吹”走。💨";
            case 4 -> "感觉你有点紧张呢。别怕，你可以小步小步慢慢来，我一直在这里陪着你。🛡️";
            default -> "谢谢你跟我分享！你做得很好，我们接下来要开始新的任务吗？🦖";
        };
    }

    @Override
    public List<ChildAI> selectRecentInteractionsByChildId(Long childId, Integer limit) {
        return baseMapper.selectList(new LambdaQueryWrapper<ChildAI>()
            .eq(ChildAI::getChildId, childId)
            .orderByDesc(ChildAI::getCreateTime)
            .last("LIMIT " + (limit != null ? limit : 5)));
    }

    @Override
    public List<ChildAI> selectEmotionTrendByChildId(Long childId, Integer days) {
        return baseMapper.selectList(new LambdaQueryWrapper<ChildAI>()
            .eq(ChildAI::getChildId, childId)
            .gt(ChildAI::getCreateTime, java.time.LocalDateTime.now().minusDays(days != null ? days : 7))
            .orderByAsc(ChildAI::getCreateTime));
    }
}

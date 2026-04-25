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
    public ChildAI selectChildAIById(Long id) {
        return baseMapper.selectById(id);
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
    public int deleteChildAIById(Long id) {
        return baseMapper.deleteById(id);
    }

    @Override
    public int deleteChildAIByIds(Long[] ids) {
        return baseMapper.deleteByIds(java.util.Arrays.asList(ids));
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
            .gt(ChildAI::getCreateTime, new java.util.Date(System.currentTimeMillis() - (days != null ? days : 7) * 24L * 3600 * 1000))
            .orderByAsc(ChildAI::getCreateTime));
    }

    @Override
    public java.util.List<java.util.Map<String, Object>> getWeeklyHeatmap(Long childId) {
        java.util.List<java.util.Map<String, Object>> heatmap = new java.util.ArrayList<>();
        java.time.LocalDate today = java.time.LocalDate.now();
        
        // 查询最近 7 天的情绪记录
        java.util.List<ChildAI> emotions = baseMapper.selectList(new LambdaQueryWrapper<ChildAI>()
            .eq(ChildAI::getChildId, childId)
            .ge(ChildAI::getCreateTime, new java.util.Date(System.currentTimeMillis() - 7 * 24L * 3600 * 1000))
            .orderByAsc(ChildAI::getCreateTime));
            
        // 按日期分组
        java.util.Map<java.time.LocalDate, java.util.List<ChildAI>> grouped = emotions.stream()
            .collect(java.util.stream.Collectors.groupingBy(e -> 
                e.getCreateTime().toInstant().atZone(java.time.ZoneId.systemDefault()).toLocalDate()));
            
        for (int i = 6; i >= 0; i--) {
            java.time.LocalDate date = today.minusDays(i);
            java.util.List<ChildAI> dayEmotions = grouped.getOrDefault(date, new java.util.ArrayList<>());
            
            double avgLevel = dayEmotions.stream()
                .mapToInt(e -> mapEmotionToLevel(e.getEmotionType()))
                .average().orElse(0.0);
                
            java.util.Map<String, Object> dayMap = new java.util.HashMap<>();
            dayMap.put("day", date.getDayOfWeek().getDisplayName(java.time.format.TextStyle.SHORT, java.util.Locale.CHINESE));
            dayMap.put("level", (int) Math.round(avgLevel));
            dayMap.put("status", getStatusText((int) Math.round(avgLevel)));
            heatmap.add(dayMap);
        }
        return heatmap;
    }

    private int mapEmotionToLevel(Integer type) {
        if (type == null) return 3;
        return switch (type) {
            case 1 -> 5; // 开心 -> 极佳
            case 5 -> 4; // 平静 -> 稳定
            case 4 -> 3; // 焦虑 -> 一般
            case 2 -> 2; // 难过 -> 低落
            case 3 -> 1; // 愤怒 -> 挫折
            default -> 3;
        };
    }

    private String getStatusText(int level) {
        return switch (level) {
            case 5 -> "极佳";
            case 4 -> "稳定";
            case 3 -> "一般";
            case 2 -> "低落";
            case 1 -> "挫折";
            default -> "无数据";
        };
    }
}

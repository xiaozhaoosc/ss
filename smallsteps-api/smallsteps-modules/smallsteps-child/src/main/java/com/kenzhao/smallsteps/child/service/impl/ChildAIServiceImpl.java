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
    public org.springframework.web.servlet.mvc.method.annotation.SseEmitter chatWithAIStream(Long childId, String userInput, Integer emotionType) {
        org.springframework.web.servlet.mvc.method.annotation.SseEmitter emitter = new org.springframework.web.servlet.mvc.method.annotation.SseEmitter(300000L); // 5分钟超时
        
        // 0. 立即下发首个字节（空格），让 HTTP 状态码 200 和头部立刻返回给前端建立连接，避免 Pending
        try {
            emitter.send(org.springframework.web.servlet.mvc.method.annotation.SseEmitter.event().data(" "));
        } catch (Exception e) {
            System.err.println(">>> [WARNING] SSE Pre-warming handshake failed: " + e.getMessage());
        }
        
        // 1. 异步执行情绪分析，不阻塞流响应
        java.util.concurrent.CompletableFuture<java.util.Map<String, Object>> emotionFuture = 
            java.util.concurrent.CompletableFuture.supplyAsync(() -> {
                return aiService.emotionAnalysis(childId, userInput);
            });

        // 2. 立即启动流式对话
        java.util.concurrent.CompletableFuture.runAsync(() -> {
            try {
                // 上下文默认给平静，避免等待情绪分析
                java.util.Map<String, Object> defaultContext = new java.util.HashMap<>();
                defaultContext.put("emotion", "平静");
                defaultContext.put("emotionType", 5);
                
                aiService.chatStream(childId, userInput, defaultContext, emitter, (fullReply) -> {
                    // 回调：流输出完成后，等待情绪分析结果并落库保存
                    emotionFuture.thenAccept(analysis -> {
                        Integer detectedType = (Integer) analysis.getOrDefault("emotionType", 5);
                        ChildAI record = new ChildAI();
                        record.setChildId(childId);
                        record.setUserInput(userInput);
                        record.setAiResponse(fullReply);
                        record.setEmotionType(detectedType);
                        baseMapper.insert(record);
                    }).exceptionally(e -> {
                        // 情绪分析如果失败，也保存记录
                        ChildAI record = new ChildAI();
                        record.setChildId(childId);
                        record.setUserInput(userInput);
                        record.setAiResponse(fullReply);
                        record.setEmotionType(5);
                        baseMapper.insert(record);
                        return null;
                    });
                });
            } catch (Exception e) {
                System.err.println(">>> [ERROR] AI Stream failed: " + e.getMessage());
                e.printStackTrace();
                emitter.completeWithError(e);
            }
        });
        
        return emitter;
    }

    @Override
    public String chatWithAI(Long childId, String userInput, Integer emotionType) {
        // 1. 异步执行情感分析
        java.util.concurrent.CompletableFuture<java.util.Map<String, Object>> emotionFuture = 
            java.util.concurrent.CompletableFuture.supplyAsync(() -> aiService.emotionAnalysis(childId, userInput));

        // 2. 默认上下文并发调用聊天服务
        java.util.Map<String, Object> defaultContext = new java.util.HashMap<>();
        defaultContext.put("emotion", "平静");
        defaultContext.put("emotionType", 5);

        String aiReply = aiService.chat(childId, userInput, defaultContext);
        
        // 3. 阻塞等待情感分析最多5秒
        try {
            java.util.Map<String, Object> analysis = emotionFuture.get(5, java.util.concurrent.TimeUnit.SECONDS);
            emotionType = (Integer) analysis.getOrDefault("emotionType", 5);
        } catch (Exception e) {
            emotionType = 5;
        }

        // 4. 保存记录
        ChildAI record = new ChildAI();
        record.setChildId(childId);
        record.setUserInput(userInput);
        record.setAiResponse(aiReply);
        record.setEmotionType(emotionType);
        baseMapper.insert(record);
        
        return aiReply;
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
            .filter(e -> e.getCreateTime() != null)
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

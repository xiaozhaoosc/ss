package com.kenzhao.smallsteps.common.ai.service;

import java.util.List;
import java.util.Map;

/**
 * AI 服务接口
 */
public interface IAiService {

    /**
     * 任务拆解
     * @param taskName 任务名称
     * @param taskDesc 任务描述
     * @param childAge 儿童年龄
     * @return 任务步骤列表
     */
    List<Map<String, String>> taskBreakdown(String taskName, String taskDesc, int childAge);

    /**
     * 情绪分析
     * @param childId 儿童ID
     * @param content 分析内容
     * @return 情绪分析结果
     */
    Map<String, Object> emotionAnalysis(Long childId, String content);

    /**
     * AI 聊天
     * @param childId 儿童ID
     * @param userInput 用户输入
     * @param context 额外上下文 (如情绪分析结果)
     * @return AI 回复
     */
    String chat(Long childId, String userInput, Map<String, Object> context);

    /**
     * AI 流式聊天（通过 SseEmitter 逐字返回）
     * @param childId 儿童ID
     * @param userInput 用户输入
     * @param context 额外上下文
     * @param emitter SSE 发射器
     */
    void chatStream(Long childId, String userInput, Map<String, Object> context, 
                    org.springframework.web.servlet.mvc.method.annotation.SseEmitter emitter,
                    java.util.function.Consumer<String> onComplete);

    /**
     * 生成习惯打卡后的鼓励反馈
     * @param childId 儿童ID
     * @param habitName 习惯名称
     * @return 鼓励语
     */
    String generateHabitFeedback(Long childId, String habitName);

    /**
     * 生成家长洞察报告
     * @param childId 儿童ID
     * @param weeklyData 一周的行为数据概报
     * @return 深度分析报告
     */
    String generateParentReport(Long childId, String weeklyData);

    /**
     * 视觉内容鼓励（如孩子上传了画作）
     * @param childId 儿童ID
     * @param imageUrl 图片URL
     * @param description 图片描述（由预处理器生成）
     * @return 赞美与鼓励语
     */
    String visionEncourage(Long childId, String imageUrl, String description);
}

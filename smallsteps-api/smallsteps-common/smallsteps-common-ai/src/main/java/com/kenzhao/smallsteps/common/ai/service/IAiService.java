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
}

package com.kenzhao.smallsteps.common.ai.service.impl;

import com.kenzhao.smallsteps.common.ai.client.OpenAIClient;
import com.kenzhao.smallsteps.common.ai.service.IAiService;
import com.kenzhao.smallsteps.common.ai.service.IAiRouterService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * AI 服务实现
 */
@Slf4j
@RequiredArgsConstructor
@Service
public class AiServiceImpl implements IAiService {

    private final OpenAIClient openAIClient;
    private final IAiRouterService aiRouterService;

    @Override
    public List<Map<String, String>> taskBreakdown(String taskName, String taskDesc, int childAge) {
        try {
            // 获取模型
            var model = aiRouterService.route("task_breakdown", null);
            if (model == null) {
                log.warn("No AI model available, using mock data");
                return getMockTaskBreakdown(taskName, taskDesc, childAge);
            }

            // 构建提示词
            String prompt = String.format("请将以下任务拆解为适合%d岁ADHD儿童的微步骤，步骤要简单、具体、可操作：\n任务名称：%s\n任务描述：%s\n\n请以JSON格式返回步骤列表，每个步骤包含stepName和stepDesc字段。",
                    childAge, taskName, taskDesc);

            // 调用大模型
            String response = openAIClient.completion(prompt, String.valueOf(model.getId()));
            if (response == null) {
                log.warn("AI API call failed, using mock data");
                return getMockTaskBreakdown(taskName, taskDesc, childAge);
            }

            // 解析响应
            // 这里简化处理，实际需要使用JSON解析库
            return parseTaskBreakdownResponse(response);
        } catch (Exception e) {
            log.error("Error in task breakdown", e);
            return getMockTaskBreakdown(taskName, taskDesc, childAge);
        }
    }

    @Override
    public Map<String, Object> emotionAnalysis(Long childId, String content) {
        try {
            // 获取模型
            var model = aiRouterService.route("emotion_analysis", null);
            if (model == null) {
                log.warn("No AI model available, using mock data");
                return getMockEmotionAnalysis(childId, content);
            }

            // 构建提示词
            String prompt = String.format("请分析以下内容中儿童的情绪状态：\n%s\n\n请以JSON格式返回分析结果，包含emotion（情绪类型）、level（情绪强度1-5）、suggestion（建议）字段。", content);

            // 调用大模型
            String response = openAIClient.completion(prompt, String.valueOf(model.getId()));
            if (response == null) {
                log.warn("AI API call failed, using mock data");
                return getMockEmotionAnalysis(childId, content);
            }

            // 解析响应
            // 这里简化处理，实际需要使用JSON解析库
            return parseEmotionAnalysisResponse(response);
        } catch (Exception e) {
            log.error("Error in emotion analysis", e);
            return getMockEmotionAnalysis(childId, content);
        }
    }

    /**
     * 解析任务拆解响应
     */
    private List<Map<String, String>> parseTaskBreakdownResponse(String response) {
        // 这里简化处理，实际需要使用JSON解析库
        // 示例响应格式：{"choices": [{"text": "{\"steps\": [{\"stepName\": \"准备课本\", \"stepDesc\": \"拿出数学课本和练习本\"}, {\"stepName\": \"完成第一题\", \"stepDesc\": \"解决课本第10页的第一题\"}]}"}]}
        List<Map<String, String>> steps = new ArrayList<>();
        
        // 模拟解析结果
        Map<String, String> step1 = new HashMap<>();
        step1.put("stepName", "准备材料");
        step1.put("stepDesc", "拿出所需的材料和工具");
        steps.add(step1);
        
        Map<String, String> step2 = new HashMap<>();
        step2.put("stepName", "开始第一步");
        step2.put("stepDesc", "按照说明开始第一个步骤");
        steps.add(step2);
        
        Map<String, String> step3 = new HashMap<>();
        step3.put("stepName", "完成任务");
        step3.put("stepDesc", "完成所有步骤并检查结果");
        steps.add(step3);
        
        return steps;
    }

    /**
     * 解析情绪分析响应
     */
    private Map<String, Object> parseEmotionAnalysisResponse(String response) {
        // 这里简化处理，实际需要使用JSON解析库
        Map<String, Object> result = new HashMap<>();
        result.put("emotion", "平静");
        result.put("level", 2);
        result.put("suggestion", "孩子情绪稳定，继续保持良好的沟通");
        return result;
    }

    /**
     * 获取模拟任务拆解数据
     */
    private List<Map<String, String>> getMockTaskBreakdown(String taskName, String taskDesc, int childAge) {
        List<Map<String, String>> steps = new ArrayList<>();
        
        Map<String, String> step1 = new HashMap<>();
        step1.put("stepName", "准备阶段");
        step1.put("stepDesc", "为" + taskName + "准备必要的材料");
        steps.add(step1);
        
        Map<String, String> step2 = new HashMap<>();
        step2.put("stepName", "开始执行");
        step2.put("stepDesc", "按照简单的步骤开始" + taskName);
        steps.add(step2);
        
        Map<String, String> step3 = new HashMap<>();
        step3.put("stepName", "完成任务");
        step3.put("stepDesc", "完成" + taskName + "并检查结果");
        steps.add(step3);
        
        return steps;
    }

    /**
     * 获取模拟情绪分析数据
     */
    private Map<String, Object> getMockEmotionAnalysis(Long childId, String content) {
        Map<String, Object> result = new HashMap<>();
        result.put("emotion", "平静");
        result.put("level", 2);
        result.put("suggestion", "孩子情绪稳定，继续保持良好的沟通");
        return result;
    }
}

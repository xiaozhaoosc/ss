package com.kenzhao.smallsteps.common.ai.service.impl;

import cn.hutool.core.util.ReUtil;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.kenzhao.smallsteps.common.ai.domain.AiPrompt;
import com.kenzhao.smallsteps.common.ai.mapper.AiPromptMapper;
import com.kenzhao.smallsteps.common.ai.domain.AiModel;
import com.kenzhao.smallsteps.common.ai.service.IAiService;
import com.kenzhao.smallsteps.common.ai.service.IAiRouterService;
import com.kenzhao.smallsteps.common.json.utils.JsonUtils;
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

    private final IAiRouterService aiRouterService;
    private final SmartAiClient smartAiClient;
    private final AiPromptMapper aiPromptMapper;

    @Override
    public List<Map<String, String>> taskBreakdown(String taskName, String taskDesc, int childAge) {
        try {
            // 1. 获取路由模型
            AiModel aiModel = aiRouterService.route("TASK_BREAKDOWN", null);

            // 2. 构建提示词 (从数据库加载)
            Map<String, Object> params = new HashMap<>();
            params.put("taskName", taskName);
            params.put("taskDesc", taskDesc);
            params.put("childAge", childAge);
            
            String prompt = getPrompt("TASK_BREAKDOWN", params);
            if (prompt == null) {
                log.warn("Prompt template TASK_BREAKDOWN not found, using fallback");
                prompt = String.format(
                    "你是一个资深的ADHD儿童教育专家。请将以下任务拆解为适合%d岁ADHD儿童的微步骤。\n" +
                    "要求：步骤要简单、极具具体性、可操作，且每一步都带有鼓励性质。\n" +
                    "任务名称：%s\n" +
                    "任务描述：%s\n\n" +
                    "请严格按照以下JSON格式返回，不要有任何其他解释文字：\n" +
                    "[\n" +
                    "  {\"stepName\": \"步骤标题\", \"stepDesc\": \"详细的操作描述\"}\n" +
                    "]",
                    childAge, taskName, taskDesc);
            }

            // 3. 调用大模型
            String response = smartAiClient.askAi(prompt, aiModel);
            if (response == null) {
                log.warn("AI API call failed, using mock data");
                return getMockTaskBreakdown(taskName, taskDesc, childAge);
            }

            // 4. 解析响应
            return parseTaskBreakdownResponse(response);
        } catch (Exception e) {
            log.error("Error in task breakdown", e);
            return getMockTaskBreakdown(taskName, taskDesc, childAge);
        }
    }

    @Override
    public Map<String, Object> emotionAnalysis(Long childId, String content) {
        try {
            // 1. 获取路由模型
            AiModel aiModel = aiRouterService.route("EMOTION_ANALYSIS", childId);

            // 2. 构建提示词 (从数据库加载)
            Map<String, Object> params = new HashMap<>();
            params.put("content", content);
            
            String prompt = getPrompt("EMOTION_ANALYSIS", params);
            if (prompt == null) {
                log.warn("Prompt template EMOTION_ANALYSIS not found, using fallback");
                prompt = String.format(
                    "你是一个儿童心理专家。请分析以下内容中儿童的情绪状态：\n%s\n\n" +
                    "请严格按照以下JSON格式返回结果，不要有任何其他解释文字：\n" +
                    "{\n" +
                    "  \"emotion\": \"情绪类型(如：开心、难过、愤怒、焦虑、平静)\",\n" +
                    "  \"level\": 情绪强度(1-5的整数),\n" +
                    "  \"suggestion\": \"给家长的针对性建议\"\n" +
                    "}", content);
            }

            // 3. 调用大模型
            String response = smartAiClient.askAi(prompt, aiModel);
            if (response == null) {
                log.warn("AI API call failed, using mock data");
                return getMockEmotionAnalysis(childId, content);
            }

            // 4. 解析响应
            return parseEmotionAnalysisResponse(response);
        } catch (Exception e) {
            log.error("Error in emotion analysis", e);
            return getMockEmotionAnalysis(childId, content);
        }
    }

    /**
     * 从数据库加载并填充提示词模板
     */
    private String getPrompt(String promptKey, Map<String, Object> params) {
        try {
            AiPrompt aiPrompt = aiPromptMapper.selectOne(new LambdaQueryWrapper<AiPrompt>()
                .eq(AiPrompt::getPromptKey, promptKey)
                .eq(AiPrompt::getStatus, "0"));

            if (aiPrompt == null) {
                return null;
            }

            String content = aiPrompt.getContent();
            if (content == null) return null;

            for (Map.Entry<String, Object> entry : params.entrySet()) {
                content = content.replace("{" + entry.getKey() + "}", String.valueOf(entry.getValue()));
            }
            return content;
        } catch (Exception e) {
            log.error("Failed to load prompt from DB: {}", promptKey, e);
            return null;
        }
    }

    /**
     * 提取并解析任务拆解响应
     */
    private List<Map<String, String>> parseTaskBreakdownResponse(String response) {
        try {
            String jsonContent = extractJson(response);
            List<Map> list = JsonUtils.parseArray(jsonContent, Map.class);
            List<Map<String, String>> result = new ArrayList<>();
            for (Map map : list) {
                Map<String, String> step = new HashMap<>();
                step.put("stepName", String.valueOf(map.getOrDefault("stepName", "")));
                step.put("stepDesc", String.valueOf(map.getOrDefault("stepDesc", "")));
                result.add(step);
            }
            return result;
        } catch (Exception e) {
            log.error("Failed to parse AI task breakdown response: {}", response, e);
            throw new RuntimeException("AI响应格式解析失败");
        }
    }

    /**
     * 提取并解析情绪分析响应
     */
    private Map<String, Object> parseEmotionAnalysisResponse(String response) {
        Map<String, Object> result = new HashMap<>();
        try {
            String jsonContent = extractJson(response);
            Map<String, Object> map = JsonUtils.parseMap(jsonContent);
            
            String emotion = String.valueOf(map.getOrDefault("emotion", ""));
            int type = mapEmotionToType(emotion);
            
            result.put("emotion", emotion);
            result.put("emotionType", type); // 额外增加数字类型，方便数据库存储
            result.put("level", map.getOrDefault("level", 3));
            result.put("suggestion", map.getOrDefault("suggestion", "继续观察并给予孩子支持。"));
            return result;
        } catch (Exception e) {
            log.error("Failed to parse AI emotion analysis response: {}", response, e);
            // 回退逻辑：尝试模糊匹配
            if (response.contains("开心") || response.contains("快乐")) result.put("emotionType", 1);
            else if (response.contains("难过") || response.contains("伤心")) result.put("emotionType", 2);
            else if (response.contains("愤怒") || response.contains("暴躁")) result.put("emotionType", 3);
            else if (response.contains("焦虑") || response.contains("害怕")) result.put("emotionType", 4);
            else result.put("emotionType", 5);
            
            result.put("emotion", "分析中");
            result.put("level", 3);
            result.put("suggestion", "AI 解析响应异常，请人工查看输入内容。");
            return result;
        }
    }

    private int mapEmotionToType(String emotion) {
        if (emotion == null) return 5;
        if (emotion.contains("开心") || emotion.contains("快乐")) return 1;
        if (emotion.contains("难过") || emotion.contains("伤心")) return 2;
        if (emotion.contains("愤怒") || emotion.contains("生气") || emotion.contains("暴躁")) return 3;
        if (emotion.contains("焦虑") || emotion.contains("焦虑") || emotion.contains("害怕")) return 4;
        if (emotion.contains("平静") || emotion.contains("安稳")) return 5;
        return 5;
    }

    /**
     * 从大模型返回的文本中提取JSON内容
     */
    private String extractJson(String text) {
        if (text == null || text.trim().isEmpty()) return "";
        // 尝试匹配 ```json ... ``` 或 [ ... ] 或 { ... }
        String json = ReUtil.getGroup1("(?s)```json\\s*(.*?)\\s*```", text);
        if (json == null) {
            json = ReUtil.getGroup1("(?s)```\\s*(.*?)\\s*```", text);
        }
        if (json == null) {
            // 如果没有代码块，尝试直接寻找第一个 [ 或 { 到最后一个 ] 或 }
            int startArray = text.indexOf("[");
            int startObject = text.indexOf("{");
            int start = -1;
            if (startArray != -1 && (startObject == -1 || startArray < startObject)) {
                start = startArray;
                int end = text.lastIndexOf("]");
                if (end > start) return text.substring(start, end + 1);
            } else if (startObject != -1) {
                start = startObject;
                int end = text.lastIndexOf("}");
                if (end > start) return text.substring(start, end + 1);
            }
            return text.trim();
        }
        return json.trim();
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

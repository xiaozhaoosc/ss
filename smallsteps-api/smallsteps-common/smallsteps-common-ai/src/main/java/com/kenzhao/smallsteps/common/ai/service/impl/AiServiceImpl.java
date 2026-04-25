package com.kenzhao.smallsteps.common.ai.service.impl;

import cn.hutool.core.util.ReUtil;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.kenzhao.smallsteps.common.ai.domain.AiModel;
import com.kenzhao.smallsteps.common.ai.domain.AiPrompt;
import com.kenzhao.smallsteps.common.ai.mapper.AiPromptMapper;
import com.kenzhao.smallsteps.common.ai.service.IAiRouterService;
import com.kenzhao.smallsteps.common.ai.service.IAiService;
import com.kenzhao.smallsteps.common.core.exception.ServiceException;
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
        System.out.println(">>> [DEBUG] AiServiceImpl.taskBreakdown called: " + taskName);
        try {
            // 1. 获取路由模型
            AiModel aiModel = aiRouterService.route("TASK_BREAKDOWN", null);
            if (aiModel == null) {
                System.out.println(">>> [WARN] No AI model found for TASK_BREAKDOWN, using mock data");
                return getMockTaskBreakdown(taskName, taskDesc, childAge);
            }

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
            System.out.println(">>> [INFO] Calling AI for task breakdown: " + taskName + " using model: " + aiModel.getModelCode());
            log.info("Calling AI for task breakdown: {}, model: {}", taskName, aiModel.getModelCode());
            String response = smartAiClient.askAi(prompt, aiModel);
            if (response == null || response.trim().isEmpty()) {
                System.out.println(">>> [WARN] AI returned empty response, using mock data");
                log.warn("AI returned empty response for task breakdown, using mock data");
                return getMockTaskBreakdown(taskName, taskDesc, childAge);
            }
            log.debug("AI Response for task breakdown: {}", response);

            // 4. 解析响应
            return parseTaskBreakdownResponse(response);
        } catch (Exception e) {
            System.err.println(">>> [ERROR] Exception in AiServiceImpl.taskBreakdown: " + e.getMessage());
            e.printStackTrace();
            log.error("Error in task breakdown for task: {}", taskName, e);
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

    @Override
    public String chat(Long childId, String userInput, Map<String, Object> context) {
        try {
            // 1. 获取路由模型
            AiModel aiModel = aiRouterService.route("AI_CHAT", childId);

            // 2. 构建提示词
            Map<String, Object> params = new HashMap<>();
            params.put("userInput", userInput);
            if (context != null) {
                params.put("emotion", context.getOrDefault("emotion", "平静"));
                params.put("suggestion", context.getOrDefault("suggestion", ""));
            } else {
                params.put("emotion", "平静");
                params.put("suggestion", "");
            }

            String prompt = getPrompt("AI_CHAT", params);
            
            // 3. 调用大模型
            String response = smartAiClient.askAi(prompt, aiModel);
            return response != null ? response : "我现在有点累了，稍后再陪你聊天好吗？✨";
        } catch (Exception e) {
            log.error("Error in AI chat", e);
            return "我现在有点小情绪，等下再来找我玩吧！🌈";
        }
    }

    /**
     * 从数据库加载并填充提示词模板
     */
    private String getPrompt(String promptKey, Map<String, Object> params) {
        AiPrompt prompt = aiPromptMapper.selectOne(new LambdaQueryWrapper<AiPrompt>()
                .eq(AiPrompt::getPromptKey, promptKey)
                .eq(AiPrompt::getStatus, "0")
                .last("LIMIT 1"));

        String template = (prompt != null) ? prompt.getContent() : getFallbackPrompt(promptKey);

        if (template == null) {
            log.error("AI Prompt template not found for key: {}", promptKey);
            throw new ServiceException("AI 模板未配置: " + promptKey);
        }

        // 简单的变量替换
        String result = template;
        for (Map.Entry<String, Object> entry : params.entrySet()) {
            String placeholder = "{" + entry.getKey() + "}";
            result = result.replace(placeholder, String.valueOf(entry.getValue()));
        }
        return result;
    }

    /**
     * 兜底 Prompt 模板
     */
    private String getFallbackPrompt(String promptKey) {
        log.warn("Using fallback hardcoded prompt for key: {}", promptKey);
        if ("TASK_BREAKDOWN".equalsIgnoreCase(promptKey)) {
            return "你是一位 ADHD 儿童辅助专家。请将任务 \"{taskName}\" ({taskDesc}) 拆解为适合 {childAge} 岁孩子执行的、颗粒度极小的步骤。请以 JSON 格式返回：[{\"stepName\": \"步骤标题\", \"stepDesc\": \"详细的操作描述\"}]";
        } else if ("EMOTION_ANALYSIS".equalsIgnoreCase(promptKey)) {
            return "你是一位资深的儿童心理学专家，专注于 ADHD （多动症）儿童的行为干预。请分析以下孩子的表现，并给家长提供建议。\n" +
                   "孩子表现：{content}\n" +
                   "请严格按照以下 JSON 格式返回，不要有任何其他解释文字：\n" +
                   "{\n" +
                   "  \"emotion\": \"情绪类型(开心/难过/愤怒/焦虑/平静)\",\n" +
                   "  \"level\": 强度(1-5),\n" +
                   "  \"suggestion\": \"给家长的 3 条具体建议(100字以内)\"\n" +
                   "}";
        } else if ("AI_CHAT".equalsIgnoreCase(promptKey)) {
            return "你是一个名为“小步”的AI伙伴，专门陪伴ADHD儿童。你说话语气活泼、温柔、富有鼓励性，多使用表情符号。\n" +
                   "当前孩子的情绪：{emotion}\n" +
                   "给家长的建议(仅供参考其状态)：{suggestion}\n" +
                   "孩子说：{userInput}\n" +
                   "请作为“小步”给孩子一个简短、积极的回应：";
        } else if ("DAILY_EMOTION_ANALYSIS".equalsIgnoreCase(promptKey)) {
            return "你是一位资深的 ADHD 儿童教育顾问。今天孩子 {childName} 有如下表现：\n失败任务：{failedTasks}\n负面情绪：{negativeEmotions}\n请写一份给家长的温馨分析。";
        }
        return null;
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
                // 兼容性处理：尝试多种可能的字段名
                String name = String.valueOf(map.getOrDefault("stepName", 
                              map.getOrDefault("step", 
                              map.getOrDefault("title", ""))));
                String desc = String.valueOf(map.getOrDefault("stepDesc", 
                              map.getOrDefault("desc", 
                              map.getOrDefault("description", ""))));
                
                step.put("stepName", name);
                step.put("stepDesc", desc);
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
        
        // 1. 过滤 <think> 标签及其内容 (适配 Qwen 等思考模型)
        String cleanText = text.replaceAll("(?s)<think>.*?</think>", "").trim();
        
        // 2. 尝试匹配 ```json ... ``` 或 ``` ... ```
        String json = ReUtil.getGroup1("(?s)```json\\s*(.*?)\\s*```", cleanText);
        if (json == null) {
            json = ReUtil.getGroup1("(?s)```\\s*(.*?)\\s*```", cleanText);
        }
        
        if (json == null) {
            // 3. 如果没有代码块，尝试直接寻找第一个 [ 或 { 到最后一个 ] 或 }
            int startArray = cleanText.indexOf("[");
            int startObject = cleanText.indexOf("{");
            int start = -1;
            if (startArray != -1 && (startObject == -1 || startArray < startObject)) {
                start = startArray;
                int end = cleanText.lastIndexOf("]");
                if (end > start) return cleanText.substring(start, end + 1);
            } else if (startObject != -1) {
                start = startObject;
                int end = cleanText.lastIndexOf("}");
                if (end > start) return cleanText.substring(start, end + 1);
            }
            return cleanText;
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

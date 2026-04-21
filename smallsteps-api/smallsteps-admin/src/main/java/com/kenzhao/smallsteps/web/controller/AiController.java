package com.kenzhao.smallsteps.web.controller;

import com.kenzhao.smallsteps.common.ai.domain.AiModel;
import com.kenzhao.smallsteps.common.ai.service.IAiRouterService;
import com.kenzhao.smallsteps.common.core.domain.R;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.*;

import java.util.Map;

/**
 * AI 服务控制器
 */
@RequiredArgsConstructor
@RestController
@RequestMapping("/ai")
public class AiController {

    private final IAiRouterService aiRouterService;
    private final com.kenzhao.smallsteps.common.ai.service.IAiService aiService;

    /**
     * 路由 AI 模型
     */
    @GetMapping("/route")
    public R<AiModel> route(@RequestParam String sceneKey, @RequestParam(required = false) Long userId) {
        AiModel model = aiRouterService.route(sceneKey, userId);
        return R.ok(model);
    }

    /**
     * AI 任务拆解接口 (对齐前端)
     * @param params 请求参数
     * @return 拆解结果
     */
    @PostMapping("/taskBreakdown")
    public R<java.util.List<java.util.Map<String, String>>> taskBreakdown(@RequestBody java.util.Map<String, Object> params) {
        String taskName = (String) params.get("taskName");
        String taskDesc = (String) params.get("taskDesc");
        Object ageObj = params.get("childAge");
        int childAge = 8; // 默认 8 岁
        if (ageObj instanceof Number) {
            childAge = ((Number) ageObj).intValue();
        } else if (ageObj instanceof String) {
            childAge = Integer.parseInt((String) ageObj);
        }

        java.util.List<java.util.Map<String, String>> steps = aiService.taskBreakdown(taskName, taskDesc, childAge);
        return R.ok(steps);
    }

    /**
     * AI 任务拆解接口 (保留兼容)
     */
    @PostMapping("/task/decompose")
    public R<java.util.Map<String, Object>> decomposeTask(@RequestBody java.util.Map<String, Object> request) {
        String taskName = (String) request.get("taskName");
        if (taskName == null) taskName = (String) request.get("taskDescription");
        
        java.util.List<java.util.Map<String, String>> steps = aiService.taskBreakdown(taskName, "", 8);
        
        java.util.Map<String, Object> result = new java.util.HashMap<>();
        result.put("taskDescription", taskName);
        result.put("subTasks", steps);
        result.put("estimatedTime", "30分钟");
        return R.ok(result);
    }

    /**
     * AI 情绪分析接口
     * @param request 请求参数
     * @return 分析结果
     */
    @PostMapping("/emotion/analyze")
    public R<Map<String, Object>> analyzeEmotion(@RequestBody Map<String, Object> request) {
        // TODO: 实现情绪分析功能
        // 1. 获取用户输入或行为数据
        // 2. 调用 AI 模型分析情绪
        // 3. 返回分析结果
        String userInput = (String) request.get("userInput");
        Map<String, Object> result = Map.of(
            "userInput", userInput,
            "emotion", "积极",
            "confidence", 0.85,
            "suggestion", "继续保持积极的心态！"
        );
        return R.ok(result);
    }
}

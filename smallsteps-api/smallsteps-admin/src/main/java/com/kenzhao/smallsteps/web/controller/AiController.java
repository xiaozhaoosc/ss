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

    /**
     * 路由 AI 模型
     * @param sceneKey 业务场景
     * @param userId 用户ID
     * @return 选中的模型配置
     */
    @GetMapping("/route")
    public R<AiModel> route(@RequestParam String sceneKey, @RequestParam(required = false) Long userId) {
        AiModel model = aiRouterService.route(sceneKey, userId);
        return R.ok(model);
    }

    /**
     * AI 聊天接口
     * @param request 请求参数
     * @return 聊天响应
     */
    @PostMapping("/chat")
    public R<String> chat(@RequestBody Map<String, Object> request) {
        // TODO: 实现 AI 聊天功能
        // 1. 获取用户输入
        // 2. 路由到合适的 AI 模型
        // 3. 调用 AI 模型生成响应
        // 4. 返回响应结果
        String message = (String) request.get("message");
        String response = "AI 回复: " + message;
        return R.ok(response);
    }

    /**
     * AI 任务拆解接口
     * @param request 请求参数
     * @return 拆解结果
     */
    @PostMapping("/task/decompose")
    public R<Map<String, Object>> decomposeTask(@RequestBody Map<String, Object> request) {
        // TODO: 实现任务拆解功能
        // 1. 获取任务描述
        // 2. 调用 AI 模型拆解任务
        // 3. 返回拆解结果
        String taskDescription = (String) request.get("taskDescription");
        Map<String, Object> result = Map.of(
            "taskDescription", taskDescription,
            "subTasks", java.util.List.of(
                "子任务1: 准备材料",
                "子任务2: 开始执行",
                "子任务3: 完成检查"
            ),
            "estimatedTime", "30分钟"
        );
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

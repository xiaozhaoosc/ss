package com.kenzhao.smallsteps.web.controller;

import com.kenzhao.smallsteps.common.ai.service.IAiService;
import com.kenzhao.smallsteps.common.core.domain.AjaxResult;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.Map;

/**
 * AI 服务控制器
 */
@RequiredArgsConstructor
@RestController
@RequestMapping("/ai")
public class AiController {

    private final IAiService aiService;

    /**
     * 任务拆解
     */
    @PostMapping("/taskBreakdown")
    public AjaxResult taskBreakdown(@RequestBody Map<String, Object> request) {
        String taskName = (String) request.get("taskName");
        String taskDesc = (String) request.get("taskDesc");
        Integer childAge = (Integer) request.get("childAge");

        if (taskName == null || taskDesc == null || childAge == null) {
            return AjaxResult.error("参数不能为空");
        }

        var steps = aiService.taskBreakdown(taskName, taskDesc, childAge);
        return AjaxResult.success().put("steps", steps);
    }

    /**
     * 情绪分析
     */
    @PostMapping("/emotionAnalysis")
    public AjaxResult emotionAnalysis(@RequestBody Map<String, Object> request) {
        Long childId = ((Number) request.get("childId")).longValue();
        String content = (String) request.get("content");

        if (childId == null || content == null) {
            return AjaxResult.error("参数不能为空");
        }

        var result = aiService.emotionAnalysis(childId, content);
        return AjaxResult.success().put("data", result);
    }
}

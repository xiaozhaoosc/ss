package com.kenzhao.smallsteps.system.controller.system;

import com.kenzhao.smallsteps.common.core.domain.R;
import com.kenzhao.smallsteps.common.ai.service.IAiUsageService;
import com.kenzhao.smallsteps.common.web.core.BaseController;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.Map;

/**
 * AI使用统计Controller
 */
@RequiredArgsConstructor
@RestController
@RequestMapping("/system/ai/usage")
public class AiUsageController extends BaseController {

    private final IAiUsageService aiUsageService;

    /**
     * 获取AI使用统计概报
     */
    @GetMapping("/stats")
    public R<Map<String, Object>> getUsageStats() {
        return R.ok(aiUsageService.getUsageStats());
    }
}

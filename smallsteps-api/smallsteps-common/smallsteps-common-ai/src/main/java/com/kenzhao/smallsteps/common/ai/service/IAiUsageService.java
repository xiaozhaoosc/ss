package com.kenzhao.smallsteps.common.ai.service;

import com.kenzhao.smallsteps.common.ai.domain.AiModel;
import java.util.Map;

/**
 * AI使用记录Service接口
 */
public interface IAiUsageService {
    /**
     * 记录使用情况
     */
    void recordUsage(Long modelId, Long childId, String sceneKey, Long promptTokens, Long completionTokens, AiModel model);

    /**
     * 获取使用统计
     */
    Map<String, Object> getUsageStats();
}

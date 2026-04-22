package com.kenzhao.smallsteps.common.ai.client;

import org.springframework.stereotype.Component;

/**
 * OpenAI 客户端存根实现
 */
@Component
public class OpenAIClient {

    /**
     * 模拟大模型补全方法
     * @param prompt 提示词
     * @param modelId 模型ID
     * @return 模拟响应
     */
    public String completion(String prompt, String modelId) {
        // 这是一个存根实现，实际应调用 OpenAI 或其他大模型 API
        return null;
    }
}

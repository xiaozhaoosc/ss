package com.kenzhao.smallsteps.common.ai.service.impl;

import com.kenzhao.smallsteps.common.ai.config.AiModelProperties;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;

import java.util.List;

@Slf4j
@RequiredArgsConstructor
@Service
public class SmartAiClient {
    private final AiModelProperties aiModelProperties;
    private final RestTemplate restTemplate = new RestTemplate();

    public String askAi(String prompt) {
        List<AiModelProperties.ModelConfig> configs = aiModelProperties.getConfigs();
        for (AiModelProperties.ModelConfig config : configs) {
            try {
                log.info("Attempting AI call with model: {}", config.getName());
                // Simple POST call, adjust based on actual API contract
                return restTemplate.postForObject(config.getApiUrl(), prompt, String.class);
            } catch (Exception e) {
                log.error("Failed to call AI model: {}, trying next...", config.getName());
            }
        }
        throw new RuntimeException("All AI models failed.");
    }
}

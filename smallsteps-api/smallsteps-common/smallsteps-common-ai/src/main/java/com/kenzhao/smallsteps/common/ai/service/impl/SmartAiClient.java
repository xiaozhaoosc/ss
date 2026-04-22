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
        String baseUrl = aiModelProperties.getBaseUrl();
        String apiKey = aiModelProperties.getApiKey();
        List<AiModelProperties.ModelConfig> models = aiModelProperties.getModels();
        
        if (models == null || models.isEmpty()) {
            throw new RuntimeException("No AI models configured.");
        }

        // 默认使用第一个模型
        String modelId = models.get(0).getId();
        String url = baseUrl.endsWith("/") ? baseUrl + "chat/completions" : baseUrl + "/chat/completions";

        try {
            log.info("Attempting AI call to {} with model: {}", url, modelId);
            
            org.springframework.http.HttpHeaders headers = new org.springframework.http.HttpHeaders();
            headers.setContentType(org.springframework.http.MediaType.APPLICATION_JSON);
            if (apiKey != null && !apiKey.isEmpty()) {
                headers.setBearerAuth(apiKey);
            }

            java.util.Map<String, Object> body = new java.util.HashMap<>();
            body.put("model", modelId);
            body.put("messages", java.util.List.of(
                java.util.Map.of("role", "user", "content", prompt)
            ));
            body.put("temperature", 0.7);

            org.springframework.http.HttpEntity<java.util.Map<String, Object>> entity = new org.springframework.http.HttpEntity<>(body, headers);
            
            String responseStr = restTemplate.postForObject(url, entity, String.class);
            log.debug("AI Raw Response: {}", responseStr);
            
            // 解析 OpenAI 响应格式
            java.util.Map<String, Object> responseMap = com.kenzhao.smallsteps.common.json.utils.JsonUtils.parseMap(responseStr);
            java.util.List<java.util.Map<String, Object>> choices = (java.util.List<java.util.Map<String, Object>>) responseMap.get("choices");
            if (choices != null && !choices.isEmpty()) {
                java.util.Map<String, Object> message = (java.util.Map<String, Object>) choices.get(0).get("message");
                if (message != null) {
                    return (String) message.get("content");
                }
            }
            
            throw new RuntimeException("AI响应格式不正确: " + responseStr);
        } catch (Exception e) {
            log.error("Failed to call AI model: {}", modelId, e);
            throw new RuntimeException("AI调用失败: " + e.getMessage());
        }
    }
}

package com.kenzhao.smallsteps.common.ai.service.impl;

import com.kenzhao.smallsteps.common.ai.domain.AiModel;
import com.kenzhao.smallsteps.common.ai.domain.AiProvider;
import com.kenzhao.smallsteps.common.ai.mapper.AiProviderMapper;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;

@Slf4j
@Service
public class SmartAiClient {
    private final AiProviderMapper aiProviderMapper;
    private final RestTemplate restTemplate;

    public SmartAiClient(AiProviderMapper aiProviderMapper) {
        this.aiProviderMapper = aiProviderMapper;
        org.springframework.http.client.SimpleClientHttpRequestFactory factory = new org.springframework.http.client.SimpleClientHttpRequestFactory();
        factory.setConnectTimeout(60000); // 60s
        factory.setReadTimeout(300000);   // 300s (5 min)
        this.restTemplate = new RestTemplate(factory);
    }

    public String askAi(String prompt, AiModel model) {
        AiProvider provider = aiProviderMapper.selectById(model.getProviderId());
        if (provider == null) {
            throw new RuntimeException("Provider not found for model: " + model.getName());
        }

        String baseUrl = provider.getBaseUrl();
        String apiKey = provider.getApiKey();
        String modelCode = model.getModelCode();

        String url = baseUrl.endsWith("/") ? baseUrl + "chat/completions" : baseUrl + "/chat/completions";

        try {
            log.info("Attempting AI call to {} with model: {}", url, modelCode);
            
            org.springframework.http.HttpHeaders headers = new org.springframework.http.HttpHeaders();
            headers.setContentType(org.springframework.http.MediaType.APPLICATION_JSON);
            if (apiKey != null && !apiKey.isEmpty() && !"no-key".equals(apiKey)) {
                headers.setBearerAuth(apiKey);
            }

            java.util.Map<String, Object> body = new java.util.HashMap<>();
            body.put("model", modelCode);
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
            log.error("Failed to call AI model: {}", modelCode, e);
            throw new RuntimeException("AI调用失败: " + e.getMessage());
        }
    }
}

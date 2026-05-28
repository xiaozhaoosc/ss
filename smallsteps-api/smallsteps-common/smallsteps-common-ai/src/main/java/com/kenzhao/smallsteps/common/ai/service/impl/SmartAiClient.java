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
    private final com.kenzhao.smallsteps.common.ai.service.IAiUsageService aiUsageService;

    public SmartAiClient(AiProviderMapper aiProviderMapper, com.kenzhao.smallsteps.common.ai.service.IAiUsageService aiUsageService) {
        this.aiProviderMapper = aiProviderMapper;
        this.aiUsageService = aiUsageService;
        org.springframework.http.client.SimpleClientHttpRequestFactory factory = new org.springframework.http.client.SimpleClientHttpRequestFactory();
        factory.setConnectTimeout(60000); // 60s
        factory.setReadTimeout(300000);   // 300s (5 min)
        this.restTemplate = new RestTemplate(factory);
    }

    public String askAi(String prompt, AiModel model, String sceneKey, Long childId) {
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
                
                // 记录使用情况
                try {
                    java.util.Map<String, Object> usage = (java.util.Map<String, Object>) responseMap.get("usage");
                    if (usage != null) {
                        Long promptTokens = ((Number) usage.get("prompt_tokens")).longValue();
                        Long completionTokens = ((Number) usage.get("completion_tokens")).longValue();
                        aiUsageService.recordUsage(model.getId(), childId, sceneKey, promptTokens, completionTokens, model);
                    }
                } catch (Exception ex) {
                    log.warn("Failed to parse or record AI usage: {}", ex.getMessage());
                }

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

    /**
     * 流式调用 AI，通过回调逐块返回内容
     * @param prompt 提示词
     * @param model AI 模型
     * @param sceneKey 场景标识
     * @param childId 儿童ID
     * @param callback 流式回调，每收到一块数据就调用一次
     */
    public void askAiStream(String prompt, AiModel model, String sceneKey, Long childId, StreamCallback callback) {
        AiProvider provider = aiProviderMapper.selectById(model.getProviderId());
        if (provider == null) {
            throw new RuntimeException("Provider not found for model: " + model.getName());
        }

        String baseUrl = provider.getBaseUrl();
        String apiKey = provider.getApiKey();
        String modelCode = model.getModelCode();

        String url = baseUrl.endsWith("/") ? baseUrl + "chat/completions" : baseUrl + "/chat/completions";

        try {
            log.info("Attempting STREAM AI call to {} with model: {}", url, modelCode);
            
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
            body.put("stream", true);  // 关键：启用流式响应

            org.springframework.http.HttpEntity<java.util.Map<String, Object>> entity = new org.springframework.http.HttpEntity<>(body, headers);
            
            // 使用 OkHttp 或手动读取流式响应
            // 这里使用 Java 原生 HttpURLConnection 读取流
            java.net.HttpURLConnection conn = (java.net.HttpURLConnection) new java.net.URL(url).openConnection();
            conn.setRequestMethod("POST");
            conn.setDoOutput(true);
            conn.setConnectTimeout(60000);
            conn.setReadTimeout(300000);
            conn.setRequestProperty("Content-Type", "application/json");
            if (apiKey != null && !apiKey.isEmpty() && !"no-key".equals(apiKey)) {
                conn.setRequestProperty("Authorization", "Bearer " + apiKey);
            }
            
            // 写入请求体
            String requestBody = com.kenzhao.smallsteps.common.json.utils.JsonUtils.toJsonString(body);
            try (java.io.OutputStream os = conn.getOutputStream()) {
                os.write(requestBody.getBytes(java.nio.charset.StandardCharsets.UTF_8));
            }
            
            // 读取流式响应
            int responseCode = conn.getResponseCode();
            if (responseCode != 200) {
                throw new RuntimeException("AI API 返回错误: " + responseCode);
            }
            
            StringBuilder fullResponse = new StringBuilder();
            try (java.io.BufferedReader reader = new java.io.BufferedReader(
                    new java.io.InputStreamReader(conn.getInputStream(), java.nio.charset.StandardCharsets.UTF_8))) {
                String line;
                while ((line = reader.readLine()) != null) {
                    if (line.startsWith("data: ")) {
                        String data = line.substring(6).trim();
                        if ("[DONE]".equals(data)) {
                            break;
                        }
                        try {
                            java.util.Map<String, Object> chunk = com.kenzhao.smallsteps.common.json.utils.JsonUtils.parseMap(data);
                            java.util.List<java.util.Map<String, Object>> choices = (java.util.List<java.util.Map<String, Object>>) chunk.get("choices");
                            if (choices != null && !choices.isEmpty()) {
                                java.util.Map<String, Object> delta = (java.util.Map<String, Object>) choices.get(0).get("delta");
                                if (delta != null) {
                                    // 处理思考/推理内容 (reasoning_content)
                                    if (delta.containsKey("reasoning_content")) {
                                        String reasoning = (String) delta.get("reasoning_content");
                                        if (reasoning != null && !reasoning.isEmpty()) {
                                            // 将思考内容包装为 <think> 标签发送给前端
                                            callback.onChunk("<think>" + reasoning + "</think>");
                                        }
                                    }
                                    // 处理正式回复内容
                                    if (delta.containsKey("content")) {
                                        String content = (String) delta.get("content");
                                        if (content != null && !content.isEmpty()) {
                                            fullResponse.append(content);
                                            callback.onChunk(content);
                                        }
                                    }
                                }
                            }
                        } catch (Exception e) {
                            log.warn("Failed to parse stream chunk: {}", data, e);
                        }
                    }
                }
            }
            
            callback.onComplete();  // 通知完成
            
            // 记录使用情况 (流式模式下无法获取精确 token 数，估算)
            try {
                long estimatedTokens = fullResponse.length() / 2;  // 粗略估算
                aiUsageService.recordUsage(model.getId(), childId, sceneKey, estimatedTokens, estimatedTokens, model);
            } catch (Exception ex) {
                log.warn("Failed to record AI usage for stream: {}", ex.getMessage());
            }
            
        } catch (Exception e) {
            log.error("Failed to call AI model (stream): {}", modelCode, e);
            callback.onError(e);
        }
    }

    /**
     * 流式回调接口
     */
    public interface StreamCallback {
        void onChunk(String chunk);
        void onComplete();
        void onError(Throwable error);
    }
}

package com.kenzhao.smallsteps.common.ai.config;

import lombok.Data;
import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.context.annotation.Configuration;

import java.util.List;

@Data
@Configuration
@ConfigurationProperties(prefix = "ai.vllm")
public class AiModelProperties {
    private String baseUrl;
    private String apiKey;
    private String api;
    private List<ModelConfig> models;

    @Data
    public static class ModelConfig {
        private String id;
        private String name;
        private boolean reasoning;
        private List<String> input;
    }
}

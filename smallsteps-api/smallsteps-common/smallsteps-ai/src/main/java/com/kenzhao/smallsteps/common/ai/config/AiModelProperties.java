package com.kenzhao.smallsteps.common.ai.config;

import lombok.Data;
import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.context.annotation.Configuration;

import java.util.List;

@Data
@Configuration
@ConfigurationProperties(prefix = "ai.models")
public class AiModelProperties {
    private List<ModelConfig> configs;

    @Data
    public static class ModelConfig {
        private String name;
        private String apiKey;
        private String apiUrl;
        private String modelType;
    }
}

package com.kenzhao.smallsteps.common.social.config.properties;

import lombok.Data;
import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.stereotype.Component;

import java.util.Map;

/**
 * Social 配置属性
 *
 * @author 赵轩
 */
@Data
@Component
@ConfigurationProperties(prefix = "justauth")
public class SocialProperties {

    /**
     * 授权类型
     */
    private Map<String, SocialLoginConfigProperties> type;

}

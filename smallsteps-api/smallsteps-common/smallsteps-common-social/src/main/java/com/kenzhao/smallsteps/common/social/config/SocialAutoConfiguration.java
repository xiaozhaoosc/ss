package com.kenzhao.smallsteps.common.social.config;

import me.zhyd.oauth.cache.AuthStateCache;
import com.kenzhao.smallsteps.common.social.config.properties.SocialProperties;
import com.kenzhao.smallsteps.common.social.utils.AuthRedisStateCache;
import org.springframework.boot.autoconfigure.AutoConfiguration;
import org.springframework.boot.context.properties.EnableConfigurationProperties;
import org.springframework.context.annotation.Bean;

/**
 * Social 配置属性
 * @author 赵轩
 */
@AutoConfiguration
@EnableConfigurationProperties(SocialProperties.class)
public class SocialAutoConfiguration {

    @Bean
    public AuthStateCache authStateCache() {
        return new AuthRedisStateCache();
    }

}

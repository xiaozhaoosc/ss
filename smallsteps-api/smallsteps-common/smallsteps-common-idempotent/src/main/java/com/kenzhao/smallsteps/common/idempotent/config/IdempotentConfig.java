package com.kenzhao.smallsteps.common.idempotent.config;

import com.kenzhao.smallsteps.common.idempotent.aspectj.RepeatSubmitAspect;
import org.springframework.boot.autoconfigure.AutoConfiguration;
import org.springframework.context.annotation.Bean;
import org.springframework.data.redis.connection.RedisConfiguration;

/**
 * 幂等功能配置
 *
 * @author 赵轩
 */
@AutoConfiguration(after = RedisConfiguration.class)
public class IdempotentConfig {

    @Bean
    public RepeatSubmitAspect repeatSubmitAspect() {
        return new RepeatSubmitAspect();
    }

}

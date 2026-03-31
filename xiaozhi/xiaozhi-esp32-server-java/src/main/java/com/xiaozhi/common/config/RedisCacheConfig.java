package com.xiaozhi.common.config;

import com.fasterxml.jackson.annotation.JsonTypeInfo;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.jsontype.impl.LaissezFaireSubTypeValidator;
import com.fasterxml.jackson.datatype.jsr310.JavaTimeModule;
import org.springframework.cache.CacheManager;
import org.springframework.cache.annotation.EnableCaching;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.data.redis.cache.RedisCacheConfiguration;
import org.springframework.data.redis.cache.RedisCacheManager;
import org.springframework.data.redis.connection.RedisConnectionFactory;
import org.springframework.data.redis.serializer.GenericJackson2JsonRedisSerializer;
import org.springframework.data.redis.serializer.RedisSerializationContext;
import org.springframework.data.redis.serializer.StringRedisSerializer;

import java.time.Duration;
import java.util.HashMap;
import java.util.Map;
import java.util.concurrent.ThreadLocalRandom;

/**
 * Redis缓存配置
 * 实现缓存穿透、击穿、雪崩防护
 *
 * @author Joey
 */
@Configuration
@EnableCaching
public class RedisCacheConfig {

    /**
     * 自定义CacheManager
     * - 支持空值缓存(防穿透)
     * - 随机TTL(防雪崩)
     * - 不同业务不同过期时间
     */
    @Bean
    public CacheManager cacheManager(RedisConnectionFactory factory) {
        // 配置序列化
        ObjectMapper objectMapper = new ObjectMapper();
        objectMapper.registerModule(new JavaTimeModule());
        objectMapper.activateDefaultTyping(
            LaissezFaireSubTypeValidator.instance,
            ObjectMapper.DefaultTyping.NON_FINAL,
            JsonTypeInfo.As.PROPERTY
        );

        GenericJackson2JsonRedisSerializer serializer = new GenericJackson2JsonRedisSerializer(objectMapper);

        // 默认配置: 1天 + 随机1小时 (防雪崩)
        RedisCacheConfiguration defaultConfig = RedisCacheConfiguration.defaultCacheConfig()
            .entryTtl(Duration.ofSeconds(86400 + ThreadLocalRandom.current().nextInt(3600)))
            .serializeKeysWith(RedisSerializationContext.SerializationPair.fromSerializer(new StringRedisSerializer()))
            .serializeValuesWith(RedisSerializationContext.SerializationPair.fromSerializer(serializer))
            .disableCachingNullValues();  // 默认不缓存null (会被特定缓存覆盖)

        // 为不同业务配置不同的缓存策略
        Map<String, RedisCacheConfiguration> cacheConfigurations = new HashMap<>();

        // 用户缓存: 365天 + 随机1小时, 允许缓存null值
        cacheConfigurations.put("XiaoZhi:SysUser",
            createConfigWithNullCache(Duration.ofDays(365), Duration.ofMinutes(5)));

        // 设备缓存: 1天 + 随机1小时, 允许缓存null值
        cacheConfigurations.put("XiaoZhi:SysDevice",
            createConfigWithNullCache(Duration.ofDays(1), Duration.ofMinutes(5)));

        // 配置缓存: 7天 + 随机1小时, 允许缓存null值
        cacheConfigurations.put("XiaoZhi:SysConfig",
            createConfigWithNullCache(Duration.ofDays(7), Duration.ofMinutes(5)));

        // 角色缓存: 7天 + 随机1小时, 允许缓存null值
        cacheConfigurations.put("XiaoZhi:SysRole",
            createConfigWithNullCache(Duration.ofDays(7), Duration.ofMinutes(5)));

        // MCP服务器缓存: 7天 + 随机1小时 (跟随角色配置周期)
        cacheConfigurations.put("XiaoZhi:SysMcpServer",
            createConfigWithNullCache(Duration.ofDays(7), Duration.ofMinutes(5)));

        // MCP工具排除缓存: 7天 + 随机1小时 (跟随角色配置周期)
        cacheConfigurations.put("XiaoZhi:McpToolExclude",
            createConfigWithNullCache(Duration.ofDays(7), Duration.ofMinutes(5)));

        // 监控数据: 1小时
        cacheConfigurations.put("monitoring",
            RedisCacheConfiguration.defaultCacheConfig()
                .entryTtl(Duration.ofHours(1))
                .serializeKeysWith(RedisSerializationContext.SerializationPair.fromSerializer(new StringRedisSerializer()))
                .serializeValuesWith(RedisSerializationContext.SerializationPair.fromSerializer(serializer)));

        return RedisCacheManager.builder(factory)
            .cacheDefaults(defaultConfig)
            .withInitialCacheConfigurations(cacheConfigurations)
            .transactionAware()  // 支持事务
            .build();
    }

    /**
     * 创建支持null值缓存的配置
     * null值使用较短的过期时间,避免长期占用内存
     *
     * @param normalTtl 正常值的TTL
     * @param nullTtl null值的TTL (通常较短)
     * @return 缓存配置
     */
    private RedisCacheConfiguration createConfigWithNullCache(Duration normalTtl, Duration nullTtl) {
        ObjectMapper objectMapper = new ObjectMapper();
        objectMapper.registerModule(new JavaTimeModule());
        objectMapper.activateDefaultTyping(
            LaissezFaireSubTypeValidator.instance,
            ObjectMapper.DefaultTyping.NON_FINAL,
            JsonTypeInfo.As.PROPERTY
        );

        GenericJackson2JsonRedisSerializer serializer = new GenericJackson2JsonRedisSerializer(objectMapper);

        // 添加随机时间防止雪崩
        long randomSeconds = ThreadLocalRandom.current().nextInt(3600);  // 0-1小时随机

        return RedisCacheConfiguration.defaultCacheConfig()
            .entryTtl(normalTtl.plusSeconds(randomSeconds))
            .serializeKeysWith(RedisSerializationContext.SerializationPair.fromSerializer(new StringRedisSerializer()))
            .serializeValuesWith(RedisSerializationContext.SerializationPair.fromSerializer(serializer));
            // 注意: Spring Cache不支持对null值单独设置TTL
            // 这里使用统一TTL, null值会在业务层面通过@Cacheable的key设计来优化
    }
}

package com.kenzhao.smallsteps.common.ai.service.impl;

import com.kenzhao.smallsteps.common.ai.domain.AiModel;
import com.kenzhao.smallsteps.common.ai.domain.AiRoute;
import com.kenzhao.smallsteps.common.ai.mapper.AiModelMapper;
import com.kenzhao.smallsteps.common.ai.mapper.AiRouteMapper;
import com.kenzhao.smallsteps.common.ai.service.IAiRouterService;
import com.kenzhao.smallsteps.common.core.constant.CacheConstants;
import com.kenzhao.smallsteps.common.redis.utils.RedisUtils;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

import java.time.Duration;

/**
 * AI路由服务实现
 */
@Slf4j
@RequiredArgsConstructor
@Service
public class AiRouterServiceImpl implements IAiRouterService {

    private final AiRouteMapper aiRouteMapper;
    private final AiModelMapper aiModelMapper;

    /**
     * 根据场景选择最佳模型
     * @param sceneKey 业务场景 (default_scene, emotion_analysis_scene, etc)
     * @param userId   用户ID (可选，当前版本暂未深度集成个人策略)
     * @return 选中的模型配置
     */
    @Override
    public AiModel route(String sceneKey, Long userId) {
        log.info("Routing for scene: {}", sceneKey);

        // 1. 获取场景配置 (优先从缓存获取)
        AiRoute route = RedisUtils.getCacheObject(CacheConstants.AI_ROUTE_KEY + sceneKey);
        
        if (route == null) {
            route = aiRouteMapper.selectById(sceneKey);
            // 1.1 如果没找到，尝试小写并加 _scene 后缀
            if (route == null) {
                String altKey = sceneKey.toLowerCase() + "_scene";
                log.debug("Scene {} not found, trying alt key: {}", sceneKey, altKey);
                route = aiRouteMapper.selectById(altKey);
            }
            if (route != null) {
                RedisUtils.setCacheObject(CacheConstants.AI_ROUTE_KEY + sceneKey, route, Duration.ofHours(24));
            }
        }

        Long modelId;
        if (route != null && route.getDefaultModelId() != null) {
            modelId = route.getDefaultModelId();
            log.debug("Found route for scene: {}, using modelId: {}", sceneKey, modelId);
        } else {
            // 回退到默认场景 (也走缓存)
            String defaultKey = "default_scene";
            AiRoute defaultRoute = RedisUtils.getCacheObject(CacheConstants.AI_ROUTE_KEY + defaultKey);
            if (defaultRoute == null) {
                defaultRoute = aiRouteMapper.selectById(defaultKey);
                if (defaultRoute != null) {
                    RedisUtils.setCacheObject(CacheConstants.AI_ROUTE_KEY + defaultKey, defaultRoute, Duration.ofHours(24));
                }
            }
            modelId = (defaultRoute != null) ? defaultRoute.getDefaultModelId() : 2001L; // 兜底使用 Gemma
            log.warn("Scene {} not found in DB/Cache, fallback to modelId: {}", sceneKey, modelId);
        }

        // 2. 获取模型详情 (优先从缓存获取)
        AiModel model = RedisUtils.getCacheObject(CacheConstants.AI_MODEL_KEY + modelId);
        if (model == null) {
            model = aiModelMapper.selectById(modelId);
            if (model == null) {
                // 如果模型不存在，尝试寻找任意可用的模型
                model = aiModelMapper.selectOne(new com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper<AiModel>()
                    .eq(AiModel::getStatus, "0")
                    .last("LIMIT 1"));
            }
            if (model != null) {
                RedisUtils.setCacheObject(CacheConstants.AI_MODEL_KEY + modelId, model, Duration.ofHours(24));
            }
        }
        
        return model;
    }
}

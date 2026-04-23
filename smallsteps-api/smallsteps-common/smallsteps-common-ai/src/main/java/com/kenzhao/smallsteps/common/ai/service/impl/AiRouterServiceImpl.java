package com.kenzhao.smallsteps.common.ai.service.impl;

import com.kenzhao.smallsteps.common.ai.domain.AiModel;
import com.kenzhao.smallsteps.common.ai.domain.AiRoute;
import com.kenzhao.smallsteps.common.ai.mapper.AiModelMapper;
import com.kenzhao.smallsteps.common.ai.mapper.AiRouteMapper;
import com.kenzhao.smallsteps.common.ai.service.IAiRouterService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

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
        
        // 1. 获取场景配置
        AiRoute route = aiRouteMapper.selectById(sceneKey);
        
        // 1.1 如果没找到，尝试小写并加 _scene 后缀 (兼容旧版或不同命名习惯)
        if (route == null) {
            String altKey = sceneKey.toLowerCase() + "_scene";
            log.debug("Scene {} not found, trying alt key: {}", sceneKey, altKey);
            route = aiRouteMapper.selectById(altKey);
        }

        Long modelId;
        if (route != null && route.getDefaultModelId() != null) {
            modelId = route.getDefaultModelId();
            log.debug("Found route for scene: {}, using modelId: {}", sceneKey, modelId);
        } else {
            // 回退到默认场景
            AiRoute defaultRoute = aiRouteMapper.selectById("default_scene");
            modelId = (defaultRoute != null) ? defaultRoute.getDefaultModelId() : 2001L; // 兜底使用 Gemma
            log.warn("Scene {} not found in DB, fallback to modelId: {}", sceneKey, modelId);
        }

        // 2. 获取模型详情
        AiModel model = aiModelMapper.selectById(modelId);
        if (model == null) {
            // 如果模型不存在，尝试寻找任意可用的模型
            model = aiModelMapper.selectOne(new com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper<AiModel>()
                .eq(AiModel::getStatus, "0")
                .last("LIMIT 1"));
        }
        
        return model;
    }
}

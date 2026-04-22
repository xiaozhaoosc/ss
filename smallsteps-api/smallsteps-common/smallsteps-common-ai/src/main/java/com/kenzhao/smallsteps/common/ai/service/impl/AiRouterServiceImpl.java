package com.kenzhao.smallsteps.common.ai.service.impl;

import com.kenzhao.smallsteps.common.ai.domain.AiModel;
import com.kenzhao.smallsteps.common.ai.domain.AiRoute;
import com.kenzhao.smallsteps.common.ai.mapper.AiModelMapper;
import com.kenzhao.smallsteps.common.ai.mapper.AiRouteMapper;
import com.kenzhao.smallsteps.common.ai.service.IAiRouterService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

/**
 * AI路由服务实现
 */
@RequiredArgsConstructor
@Service
public class AiRouterServiceImpl implements IAiRouterService {

    private final AiRouteMapper aiRouteMapper;
    private final AiModelMapper aiModelMapper;

    /**
     * 根据场景和用户上下文选择最佳模型
     * @param sceneKey 业务场景 (chat/image/etc)
     * @param userId   用户ID (可选)
     * @return 选中的模型配置
     */
    @Override
    public AiModel route(String sceneKey, Long userId) {
        AiRoute route = aiRouteMapper.selectById(sceneKey);
        if (route == null || route.getDefaultModelId() == null) {
            throw new RuntimeException("No route found for scene: " + sceneKey);
        }
        
        AiModel model = aiModelMapper.selectById(route.getDefaultModelId());
        if (model == null) {
            throw new RuntimeException("No model found for ID: " + route.getDefaultModelId());
        }
        
        return model;
    }
}

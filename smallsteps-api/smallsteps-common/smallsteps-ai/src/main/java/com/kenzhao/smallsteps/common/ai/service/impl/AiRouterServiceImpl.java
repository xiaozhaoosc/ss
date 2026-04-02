package com.kenzhao.smallsteps.common.ai.service.impl;

import com.kenzhao.smallsteps.common.ai.domain.AiModel;
import com.kenzhao.smallsteps.common.ai.mapper.AiModelMapper;
import com.kenzhao.smallsteps.common.ai.service.IAiRouterService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

/**
 * AI路由服务实现
 */
@RequiredArgsConstructor
@Service
public class AiRouterServiceImpl implements IAiRouterService {

    private final AiModelMapper aiModelMapper;

    /**
     * 根据场景和用户上下文选择最佳模型
     * @param sceneKey 业务场景 (chat/image/etc)
     * @param userId   用户ID (可选)
     * @return 选中的模型配置
     */
    @Override
    public AiModel route(String sceneKey, Long userId) {
        // TODO: 实现模型路由逻辑
        // 1. 根据场景和用户ID查询合适的模型
        // 2. 考虑模型的可用性、性能、成本等因素
        // 3. 返回最佳模型配置
        
        // 这里返回一个默认模型作为示例
        AiModel model = new AiModel();
        model.setModelId(1L);
        model.setModelName("default-model");
        model.setProvider("openai");
        model.setSceneKey(sceneKey);
        model.setStatus(1);
        return model;
    }
}

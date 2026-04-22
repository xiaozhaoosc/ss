package com.kenzhao.smallsteps.common.ai.service;

import com.kenzhao.smallsteps.common.ai.domain.AiModel;

/**
 * AI路由服务接口
 * 
 * @author kenzhao
 * @date 2026-02-01
 */
public interface IAiRouterService {

    /**
     * 根据场景和用户上下文选择最佳模型
     * 
     * @param sceneKey 业务场景 (chat/image/etc)
     * @param userId   用户ID (可选)
     * @return 选中的模型配置
     */
    AiModel route(String sceneKey, Long userId);
}

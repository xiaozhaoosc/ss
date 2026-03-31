package com.kenzhao.smallsteps.common.ai.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.kenzhao.smallsteps.common.ai.domain.AiModel;
import com.kenzhao.smallsteps.common.ai.domain.AiProvider;
import com.kenzhao.smallsteps.common.ai.domain.AiRoute;
import com.kenzhao.smallsteps.common.ai.mapper.AiModelMapper;
import com.kenzhao.smallsteps.common.ai.mapper.AiProviderMapper;
import com.kenzhao.smallsteps.common.ai.mapper.AiRouteMapper;
import com.kenzhao.smallsteps.common.ai.service.IAiRouterService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

import java.util.Comparator;
import java.util.List;
import java.util.stream.Collectors;

/**
 * AI路由服务实现
 * 
 * @author kenzhao
 * @date 2026-02-01
 */
@Slf4j
@RequiredArgsConstructor
@Service
public class AiRouterServiceImpl implements IAiRouterService {

    private final AiRouteMapper routeMapper;
    private final AiModelMapper modelMapper;
    private final AiProviderMapper providerMapper;

    @Override
    public AiModel route(String sceneKey, Long userId) {
        // 1. 获取路由策略
        AiRoute route = routeMapper.selectById(sceneKey);
        if (route == null) {
            // 默认策略: 查找默认场景或直接返回系统默认模型
            log.warn("Scene definition not found for key: {}. Using default.", sceneKey);
            // 简化处理：如果没有配置路由，尝试找一个免费的
            return findBestFreeModel();
        }

        // 2. 根据策略选择
        // 注意：此处是简化逻辑，完整实现需要结合 用户权益(UserQuota) 模块
        // 假设策略是 "PRIORITY_LEVEL" (免费 -> 低价)

        // 2.1 查找所有可用模型
        List<AiModel> allModels = modelMapper.selectList(new LambdaQueryWrapper<AiModel>()
                .eq(AiModel::getStatus, "0")
                .eq(AiModel::getDelFlag, "0"));

        // 过滤掉停用供应商的模型
        // (实际生产中应该用缓存优化，不要每次查库)

        // 3. 执行核心优先级逻辑
        // P0: 免费模型 (若用户有免费额度 - 需调用外部服务判断，此处略)
        List<AiModel> freeModels = allModels.stream()
                .filter(m -> "1".equals(m.getIsFreeTier()))
                .collect(Collectors.toList());

        if (!freeModels.isEmpty()) {
            return freeModels.get(0); // 返回第一个免费模型
        }

        // P1: 按价格排序 (低 -> 高)
        allModels.sort(Comparator.comparing(AiModel::getCostInput)
                .thenComparing(AiModel::getCostOutput));

        if (!allModels.isEmpty()) {
            return allModels.get(0);
        }

        throw new RuntimeException("No available AI models found for scene: " + sceneKey);
    }

    private AiModel findBestFreeModel() {
        return modelMapper.selectOne(new LambdaQueryWrapper<AiModel>()
                .eq(AiModel::getIsFreeTier, "1")
                .eq(AiModel::getStatus, "0")
                .last("LIMIT 1"));
    }
}

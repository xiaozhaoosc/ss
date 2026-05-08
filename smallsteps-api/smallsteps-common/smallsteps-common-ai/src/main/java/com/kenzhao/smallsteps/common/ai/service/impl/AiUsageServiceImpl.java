package com.kenzhao.smallsteps.common.ai.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.kenzhao.smallsteps.common.ai.domain.AiModel;
import com.kenzhao.smallsteps.common.ai.domain.AiUsage;
import com.kenzhao.smallsteps.common.ai.mapper.AiUsageMapper;
import com.kenzhao.smallsteps.common.ai.service.IAiUsageService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

import java.math.BigDecimal;
import java.math.RoundingMode;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.LocalTime;
import java.time.ZoneId;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

/**
 * AI使用记录Service实现
 */
@Slf4j
@Service
@RequiredArgsConstructor
public class AiUsageServiceImpl implements IAiUsageService {

    private final AiUsageMapper baseMapper;

    @Override
    public void recordUsage(Long modelId, Long childId, String sceneKey, Long promptTokens, Long completionTokens, AiModel model) {
        try {
            AiUsage usage = new AiUsage();
            usage.setModelId(modelId);
            usage.setChildId(childId);
            usage.setSceneKey(sceneKey);
            usage.setInputTokens(promptTokens);
            usage.setOutputTokens(completionTokens);
            usage.setTotalTokens(promptTokens + completionTokens);
            usage.setStatus("0");

            if (model != null) {
                // 计算成本: (inputTokens * costInput + outputTokens * costOutput) / 1,000,000
                BigDecimal inputCost = BigDecimal.valueOf(promptTokens)
                    .multiply(model.getCostInput())
                    .divide(BigDecimal.valueOf(1000000), 10, RoundingMode.HALF_UP);
                BigDecimal outputCost = BigDecimal.valueOf(completionTokens)
                    .multiply(model.getCostOutput())
                    .divide(BigDecimal.valueOf(1000000), 10, RoundingMode.HALF_UP);
                usage.setCost(inputCost.add(outputCost));
            } else {
                usage.setCost(BigDecimal.ZERO);
            }

            baseMapper.insert(usage);
        } catch (Exception e) {
            log.error("Failed to record AI usage", e);
        }
    }

    @Override
    public Map<String, Object> getUsageStats() {
        Map<String, Object> stats = new HashMap<>();
        
        // 获取今日 00:00:00
        LocalDateTime startOfDay = LocalDateTime.of(LocalDate.now(), LocalTime.MIN);
        Date startDate = Date.from(startOfDay.atZone(ZoneId.systemDefault()).toInstant());

        // 今日总 Token
        Long todayTokens = baseMapper.selectList(new LambdaQueryWrapper<AiUsage>()
            .ge(AiUsage::getCreateTime, startDate))
            .stream()
            .mapToLong(AiUsage::getTotalTokens)
            .sum();

        // 今日总成本
        BigDecimal todayCost = baseMapper.selectList(new LambdaQueryWrapper<AiUsage>()
            .ge(AiUsage::getCreateTime, startDate))
            .stream()
            .map(AiUsage::getCost)
            .reduce(BigDecimal.ZERO, BigDecimal::add);

        // 设定一个每日额度 (如 100,000 tokens)
        long dailyQuota = 100000L;
        double usageRate = (double) todayTokens / dailyQuota * 100;

        stats.put("todayTokens", todayTokens);
        stats.put("todayCost", todayCost.setScale(4, RoundingMode.HALF_UP));
        stats.put("dailyQuota", dailyQuota);
        stats.put("remainingQuota", Math.max(0, dailyQuota - todayTokens));
        stats.put("usageRate", Math.min(100, (int) usageRate));
        stats.put("status", usageRate > 90 ? "warning" : "normal");

        return stats;
    }
}

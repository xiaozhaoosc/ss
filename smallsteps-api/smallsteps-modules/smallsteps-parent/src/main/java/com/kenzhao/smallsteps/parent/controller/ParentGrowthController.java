package com.kenzhao.smallsteps.parent.controller;

import com.kenzhao.smallsteps.common.core.domain.R;
import com.kenzhao.smallsteps.parent.domain.bo.ParentGrowthBo;
import com.kenzhao.smallsteps.parent.domain.vo.ParentGrowthVo;
import com.kenzhao.smallsteps.parent.service.IParentGrowthService;
import jakarta.validation.constraints.NotNull;
import lombok.RequiredArgsConstructor;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

import java.util.List;

/**
 * 家长成长观察
 */
@Validated
@RequiredArgsConstructor
@RestController
@RequestMapping("/parent/growth")
public class ParentGrowthController {

    private final IParentGrowthService parentGrowthService;

    /**
     * 获取情绪日报
     */
    @GetMapping("/emotion/daily")
    public R<ParentGrowthVo> getEmotionDaily(@RequestParam Long userId, @RequestParam String date) {
        return R.ok(parentGrowthService.getEmotionDaily(userId, date));
    }

    /**
     * 获取能力雷达图
     */
    @GetMapping("/ability/radar")
    public R<ParentGrowthVo> getAbilityRadar(@RequestParam Long userId, @RequestParam String period) {
        return R.ok(parentGrowthService.getAbilityRadar(userId, period));
    }

    /**
     * 获取成长轨迹
     */
    @GetMapping("/track")
    public R<List<ParentGrowthVo>> getGrowthTrack(@RequestParam Long userId, @RequestParam String startDate, @RequestParam String endDate) {
        return R.ok(parentGrowthService.getGrowthTrack(userId, startDate, endDate));
    }

    /**
     * 记录情绪状态
     */
    @PostMapping("/emotion/record")
    public R<Void> recordEmotion(@RequestBody ParentGrowthBo bo) {
        return toAjax(parentGrowthService.recordEmotion(bo));
    }

    /**
     * 辅助方法：转换为 Ajax 响应
     */
    private R<Void> toAjax(boolean success) {
        return success ? R.ok() : R.fail();
    }
}
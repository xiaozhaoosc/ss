package com.kenzhao.smallsteps.parent.controller;

import com.kenzhao.smallsteps.common.core.domain.R;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.*;

/**
 * 家长端洞察报表控制器
 */
@RequiredArgsConstructor
@RestController
@RequestMapping("/parent/insights")
public class ParentInsightsController {

    /**
     * 获取专注力趋势图
     */
    @GetMapping("/focus")
    public R<?> getFocusTrend() {
        // TODO: 实现获取专注力趋势图的逻辑
        return R.ok("获取专注力趋势图成功");
    }

    /**
     * 获取情绪日历
     */
    @GetMapping("/emotion")
    public R<?> getEmotionCalendar() {
        // TODO: 实现获取情绪日历的逻辑
        return R.ok("获取情绪日历成功");
    }

    /**
     * 获取成就回顾
     */
    @GetMapping("/achievements")
    public R<?> getAchievementReview() {
        // TODO: 实现获取成就回顾的逻辑
        return R.ok("获取成就回顾成功");
    }
}

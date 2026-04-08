package com.kenzhao.smallsteps.child.controller;

import com.kenzhao.smallsteps.common.core.domain.R;
import org.springframework.web.bind.annotation.*;

/**
 * 儿童端成就控制器
 */
@RestController
@RequestMapping("/child/achievement")
public class ChildAchievementController {

    /**
     * 获取星星余额
     */
    @GetMapping("/stars")
    public R<?> getStars() {
        // TODO: 实现获取星星余额的逻辑
        return R.ok("获取星星余额成功");
    }

    /**
     * 获取成就列表
     */
    @GetMapping("/list")
    public R<?> getAchievements() {
        // TODO: 实现获取成就列表的逻辑
        return R.ok("获取成就列表成功");
    }

    /**
     * 兑换奖励
     */
    @PostMapping("/redeem")
    public R<?> redeem(@RequestBody RedeemRequest request) {
        // TODO: 实现兑换奖励的逻辑
        return R.ok("兑换奖励成功");
    }

    // 请求参数类
    public static class RedeemRequest {
        private String rewardId;

        public String getRewardId() {
            return rewardId;
        }

        public void setRewardId(String rewardId) {
            this.rewardId = rewardId;
        }
    }
}

package com.kenzhao.smallsteps.child.controller;

import com.kenzhao.smallsteps.common.core.domain.R;
import com.kenzhao.smallsteps.child.domain.bo.ChildAchievementBo;
import com.kenzhao.smallsteps.child.domain.vo.ChildAchievementVo;
import com.kenzhao.smallsteps.child.service.IChildAchievementService;
import jakarta.validation.constraints.NotNull;
import lombok.RequiredArgsConstructor;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

/**
 * 儿童成就系统
 */
@Validated
@RequiredArgsConstructor
@RestController
@RequestMapping("/child/achievement")
public class ChildAchievementController {

    private final IChildAchievementService childAchievementService;

    /**
     * 收集勇气碎片
     */
    @PostMapping("/collect")
    public R<ChildAchievementVo> collectCourageShard(@RequestParam Long userId, @RequestParam Integer shardCount) {
        return R.ok(childAchievementService.collectCourageShard(userId, shardCount));
    }

    /**
     * 查询星星余额
     */
    @GetMapping("/stars")
    public R<Integer> getStarsBalance(@RequestParam Long userId) {
        return R.ok(childAchievementService.getStarsBalance(userId));
    }

    /**
     * 兑换奖励
     */
    @PostMapping("/exchange")
    public R<ChildAchievementVo> exchangeReward(@RequestBody ChildAchievementBo bo) {
        return R.ok(childAchievementService.exchangeReward(bo));
    }

    /**
     * 查询成就列表
     */
    @GetMapping("/list")
    public R<?> list(@RequestParam Long userId) {
        return R.ok(childAchievementService.queryAchievementList(userId));
    }

    /**
     * 获取成就详情
     */
    @GetMapping("/{achievementId}")
    public R<ChildAchievementVo> getInfo(@NotNull(message = "成就ID不能为空") @PathVariable Long achievementId) {
        return R.ok(childAchievementService.queryById(achievementId));
    }
}
package com.kenzhao.smallsteps.child.controller;

import com.kenzhao.smallsteps.common.ss.domain.ChildAchievement;
import com.kenzhao.smallsteps.child.service.IChildAchievementService;
import com.kenzhao.smallsteps.common.core.domain.R;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

/**
 * 儿童成就Controller
 */
@cn.dev33.satoken.annotation.SaCheckLogin
@RestController
@RequestMapping("/child/achievement")
public class ChildAchievementController {

    @Autowired
    private IChildAchievementService childAchievementService;

    @Autowired
    private com.kenzhao.smallsteps.child.service.IChildService childService;

    /**
     * 查询儿童成就列表
     */
    @GetMapping("/list")
    public R<List<ChildAchievement>> list(ChildAchievement childAchievement) {
        validateChildAccess(childAchievement.getChildId());
        List<ChildAchievement> list = childAchievementService.selectChildAchievementList(childAchievement);
        return R.ok(list);
    }

    /**
     * 根据成就ID查询儿童成就
     */
    @GetMapping("/info/{id}")
    public R<ChildAchievement> info(@PathVariable("id") Long id) {
        ChildAchievement childAchievement = childAchievementService.selectChildAchievementById(id);
        if (childAchievement != null) {
            validateChildAccess(childAchievement.getChildId());
        }
        return R.ok(childAchievement);
    }

    /**
     * 新增儿童成就
     */
    @PostMapping("/add")
    public R<String> add(@RequestBody ChildAchievement childAchievement) {
        validateChildAccess(childAchievement.getChildId());
        int result = childAchievementService.insertChildAchievement(childAchievement);
        return result > 0 ? R.ok("新增成功") : R.fail("新增失败");
    }

    /**
     * 修改儿童成就
     */
    @PutMapping("/edit")
    public R<String> edit(@RequestBody ChildAchievement childAchievement) {
        validateChildAccess(childAchievement.getChildId());
        int result = childAchievementService.updateChildAchievement(childAchievement);
        return result > 0 ? R.ok("修改成功") : R.fail("修改失败");
    }

    /**
     * 删除儿童成就
     */
    @DeleteMapping("/remove/{id}")
    public R<String> remove(@PathVariable("id") Long id) {
        ChildAchievement childAchievement = childAchievementService.selectChildAchievementById(id);
        if (childAchievement != null) {
            validateChildAccess(childAchievement.getChildId());
        }
        int result = childAchievementService.deleteChildAchievementById(id);
        return result > 0 ? R.ok("删除成功") : R.fail("删除失败");
    }

    /**
     * 批量删除儿童成就
     */
    @DeleteMapping("/remove/batch")
    public R<String> removeBatch(@RequestBody Long[] ids) {
        for (Long id : ids) {
            ChildAchievement childAchievement = childAchievementService.selectChildAchievementById(id);
            if (childAchievement != null) validateChildAccess(childAchievement.getChildId());
        }
        int result = childAchievementService.deleteChildAchievementByIds(ids);
        return result > 0 ? R.ok("删除成功") : R.fail("删除失败");
    }

    /**
     * 奖励星星
     */
    @PostMapping("/reward/stars")
    public R<String> rewardStars(@RequestParam("childId") Long childId, @RequestParam("stars") Integer stars) {
        validateChildAccess(childId);
        int result = childAchievementService.rewardStars(childId, stars);
        return result > 0 ? R.ok("奖励成功") : R.fail("奖励失败");
    }

    /**
     * 奖励勇气碎片
     */
    @PostMapping("/reward/fragments")
    public R<String> rewardCourageFragments(@RequestParam("childId") Long childId, @RequestParam("fragments") Integer fragments) {
        validateChildAccess(childId);
        int result = childAchievementService.rewardCourageFragments(childId, fragments);
        return result > 0 ? R.ok("奖励成功") : R.fail("奖励失败");
    }

    /**
     * 兑换奖励
     */
    @PostMapping("/exchange")
    public R<String> exchangeReward(@RequestParam("childId") Long childId, @RequestParam("stars") Integer stars, @RequestParam("rewardName") String rewardName) {
        validateChildAccess(childId);
        int result = childAchievementService.exchangeReward(childId, stars, rewardName);
        return result > 0 ? R.ok("兑换成功") : R.fail("兑换失败，星星不足");
    }

    /**
     * 查询儿童成就统计
     */
    @GetMapping("/stats/{childId}")
    public R<List<ChildAchievement>> achievementStats(@PathVariable("childId") Long childId) {
        validateChildAccess(childId);
        List<ChildAchievement> list = childAchievementService.selectAchievementStatsByChildId(childId);
        return R.ok(list);
    }

    /**
     * 查询儿童星星总数
     */
    @GetMapping("/stars/{childId}")
    public R<Integer> totalStars(@PathVariable("childId") Long childId) {
        validateChildAccess(childId);
        Integer totalStars = childAchievementService.selectTotalStarsByChildId(childId);
        return R.ok(totalStars);
    }

    /**
     * 查询儿童勇气碎片总数
     */
    @GetMapping("/fragments/{childId}")
    public R<Integer> totalCourageFragments(@PathVariable("childId") Long childId) {
        validateChildAccess(childId);
        Integer totalFragments = childAchievementService.selectTotalCourageFragmentsByChildId(childId);
        return R.ok(totalFragments);
    }

    /**
     * 查询儿童连击天数 (Streak)
     */
    @GetMapping("/streak/{childId}")
    public R<Integer> streak(@PathVariable("childId") Long childId) {
        validateChildAccess(childId);
        return R.ok(childAchievementService.selectStreakByChildId(childId));
    }

    /**
     * 校验当前登录用户是否有权访问该儿童数据
     */
    private void validateChildAccess(Long childId) {
        if (childId == null) return;
        com.kenzhao.smallsteps.common.ss.domain.Child child = childService.selectChildById(childId);
        Long currentUserId = com.kenzhao.smallsteps.common.satoken.utils.LoginHelper.getUserId();
        
        // 允许访问的条件：
        // 1. 当前登录者就是该儿童本人 (child.id == currentUserId)
        // 2. 当前登录者是该儿童绑定的家长 (child.parentId == currentUserId)
        if (child == null || (!child.getId().equals(currentUserId) && !child.getParentId().equals(currentUserId))) {
            throw new com.kenzhao.smallsteps.common.core.exception.ServiceException("无权访问该儿童数据");
        }
    }
}

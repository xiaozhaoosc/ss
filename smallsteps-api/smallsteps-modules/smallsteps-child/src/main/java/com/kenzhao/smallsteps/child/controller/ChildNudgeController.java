package com.kenzhao.smallsteps.child.controller;

import com.kenzhao.smallsteps.common.core.domain.R;
import com.kenzhao.smallsteps.common.web.core.BaseController;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.web.bind.annotation.*;

import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;

/**
 * 儿童硬件远程提醒 (Nudge) 控制层
 * 用于家长端主动向儿童终端发送实时震动、语音或灯光指令
 *
 * @author 赵轩
 * @date 2026-04-08
 */
@Slf4j
@cn.dev33.satoken.annotation.SaCheckLogin
@RestController
@RequiredArgsConstructor
@RequestMapping("/child/nudge")
public class ChildNudgeController extends BaseController {

    private final com.kenzhao.smallsteps.child.service.IChildService childService;

    // 内存中保存最新的提醒指令 (实际项目建议使用 Redis)
    private static final Map<Long, Map<String, Object>> NUDGE_CACHE = new ConcurrentHashMap<>();

    /**
     * [Parent 调用] 向指定儿童发送一个提醒 (Nudge)
     */
    @PostMapping("/send")
    public R<Void> sendNudge(@RequestParam("childId") Long childId, 
                            @RequestParam(value = "type", defaultValue = "vibrate") String type,
                            @RequestParam(value = "message", required = false) String message) {
        validateChildAccess(childId);
        log.info("Parent nudge sent to child {}: type={}, message={}", childId, type, message);
        
        Map<String, Object> nudgeData = new ConcurrentHashMap<>();
        nudgeData.put("type", type);
        nudgeData.put("message", message != null ? message : "亲爱的，该加把劲啦！");
        nudgeData.put("timestamp", System.currentTimeMillis());
        nudgeData.put("consumed", false);
        
        NUDGE_CACHE.put(childId, nudgeData);
        return R.ok();
    }

    /**
     * [Child Terminal 调用] 轮询或长连接获取最新的提醒请求
     */
    @cn.dev33.satoken.annotation.SaIgnore
    @GetMapping("/poll/{childId}")
    public R<Map<String, Object>> pollNudge(@PathVariable("childId") Long childId) {
        // Hardware terminal might not have a login session, so we SaIgnore but keep childId specific.
        Map<String, Object> nudge = NUDGE_CACHE.get(childId);
        if (nudge != null && !(Boolean) nudge.get("consumed")) {
            // 标记已消费 (避免硬件重复触发)
            nudge.put("consumed", true);
            return R.ok(nudge);
        }
        return R.ok(null);
    }

    /**
     * 清除特定儿童的提醒记录
     */
    @DeleteMapping("/clear/{childId}")
    public R<Void> clearNudge(@PathVariable("childId") Long childId) {
        validateChildAccess(childId);
        NUDGE_CACHE.remove(childId);
        return R.ok();
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

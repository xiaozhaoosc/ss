package com.kenzhao.smallsteps.child.controller;

import com.kenzhao.smallsteps.common.core.domain.R;
import com.kenzhao.smallsteps.child.domain.bo.ChildTaskBo;
import com.kenzhao.smallsteps.child.domain.vo.ChildTaskVo;
import com.kenzhao.smallsteps.child.service.IChildTaskService;
import jakarta.validation.constraints.NotEmpty;
import jakarta.validation.constraints.NotNull;
import lombok.RequiredArgsConstructor;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

/**
 * 儿童任务执行
 */
@Validated
@RequiredArgsConstructor
@RestController
@RequestMapping("/child/task")
public class ChildTaskController {

    private final IChildTaskService childTaskService;

    /**
     * NFC 刷卡签到
     */
    @PostMapping("/nfc/signin")
    public R<ChildTaskVo> nfcSignin(@RequestParam String nfcId, @RequestParam Long taskId) {
        return R.ok(childTaskService.nfcSignin(nfcId, taskId));
    }

    /**
     * 更新任务状态
     */
    @PutMapping("/status")
    public R<Void> updateStatus(@RequestBody ChildTaskBo bo) {
        return toAjax(childTaskService.updateStatus(bo));
    }

    /**
     * 获取任务列表
     */
    @GetMapping("/list")
    public R<?> list(@RequestParam Long userId) {
        return R.ok(childTaskService.queryListByUserId(userId));
    }

    /**
     * 获取任务详情
     */
    @GetMapping("/{taskId}")
    public R<ChildTaskVo> getInfo(@NotNull(message = "任务ID不能为空") @PathVariable Long taskId) {
        return R.ok(childTaskService.queryById(taskId));
    }

    /**
     * 辅助方法：转换为 Ajax 响应
     */
    private R<Void> toAjax(boolean success) {
        return success ? R.ok() : R.fail();
    }
}
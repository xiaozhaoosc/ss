package com.kenzhao.smallsteps.task.controller;

import com.kenzhao.smallsteps.common.core.domain.R;
import com.kenzhao.smallsteps.common.web.core.BaseController;
import com.kenzhao.smallsteps.task.domain.vo.SsTaskVO;
import com.kenzhao.smallsteps.task.service.ISsTaskLogService;
import com.kenzhao.smallsteps.task.service.ISsTaskService;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.*;

import java.util.List;

/**
 * 儿童端任务控制器 (小步协作版)
 */
@RequiredArgsConstructor
@RestController
@RequestMapping("/task/child")
public class ChildTaskController extends BaseController {

    private final ISsTaskService taskService;
    private final ISsTaskLogService taskLogService;

    /**
     * 获取我的任务列表
     */
    @GetMapping("/list/{childId}")
    public R<List<SsTaskVO>> list(@PathVariable Long childId) {
        return R.ok(taskService.listByChildId(childId));
    }

    /**
     * 儿童提交任务 (进入[待点亮]存钱罐状态)
     */
    @PostMapping("/submit/{logId}")
    public R<Void> submit(@PathVariable Long logId) {
        return toAjax(taskLogService.submitTask(logId));
    }
}

package com.kenzhao.smallsteps.task.controller;

import com.kenzhao.smallsteps.common.core.domain.R;
import com.kenzhao.smallsteps.common.web.core.BaseController;
import com.kenzhao.smallsteps.task.domain.vo.SsParentTaskVO;
import com.kenzhao.smallsteps.task.service.ISsParentTaskService;
import com.kenzhao.smallsteps.task.service.ISsTaskLogService;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.*;

/**
 * 家长端任务管理 (协作模式)
 */
@RequiredArgsConstructor
@RestController
@RequestMapping("/task/parent")
public class ParentTaskController extends BaseController {

    private final ISsParentTaskService parentTaskService;
    private final ISsTaskLogService taskLogService;

    /**
     * 家长发布新任务
     */
    @PostMapping("/add")
    public R<Void> add(@RequestBody SsParentTaskVO taskVO) {
        return toAjax(parentTaskService.publishTask(taskVO));
    }

    /**
     * 家长点亮星星 (合作确认)
     * @param logId 任务记录ID
     */
    @PutMapping("/lightUp/{logId}")
    public R<Void> lightUp(@PathVariable Long logId) {
        return toAjax(taskLogService.lightUp(logId));
    }
}

package com.kenzhao.smallsteps.child.controller;

import com.kenzhao.smallsteps.common.ss.domain.ChildTask;
import com.kenzhao.smallsteps.common.ss.domain.vo.ChildTaskVo;
import com.kenzhao.smallsteps.child.service.IChildTaskService;
import com.kenzhao.smallsteps.task.service.ISsTaskLogService;
import com.kenzhao.smallsteps.common.core.domain.R;
import com.kenzhao.smallsteps.common.web.core.BaseController;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.*;

import java.util.List;

/**
 * 儿童任务执行控制层
 */
@cn.dev33.satoken.annotation.SaCheckLogin
@RestController
@RequiredArgsConstructor
@RequestMapping("/child/task")
public class ChildTaskController extends BaseController {

    private final IChildTaskService childTaskService;
    private final ISsTaskLogService taskLogService;
    private final com.kenzhao.smallsteps.child.service.IChildService childService;
    private final com.kenzhao.smallsteps.child.service.IScoreService scoreService;

    /**
     * 查询儿童任务执行列表
     */
    @GetMapping("/list")
    public R<List<ChildTaskVo>> list(ChildTask childTask) {
        validateChildAccess(childTask.getChildId());
        List<ChildTaskVo> list = childTaskService.selectChildTaskList(childTask);
        return R.ok(list);
    }

    /**
     * 根据执行记录ID查询任务详情
     */
    @GetMapping("/info/{id}")
    public R<ChildTaskVo> info(@PathVariable("id") Long id) {
        ChildTaskVo childTask = childTaskService.selectChildTaskById(id);
        if (childTask != null) {
            validateChildAccess(childTask.getChildId());
        }
        return R.ok(childTask);
    }

    /**
     * [ADHD] 开始执行任务
     */
    @PostMapping("/start")
    public R<Void> startTask(@RequestParam("taskId") Long taskId, @RequestParam("childId") Long childId) {
        validateChildAccess(childId);
        return toAjax(childTaskService.startTask(taskId, childId));
    }

    /**
     * [ADHD] 完成任务 (直接完成)
     */
    @PostMapping("/complete")
    public R<Void> completeTask(@RequestBody ChildTask childTask) {
        validateChildAccess(childTask.getChildId());
        return toAjax(childTaskService.completeTask(childTask.getTaskId(), childTask.getChildId(), childTask.getProof()));
    }

    /**
     * [ADHD] 提交任务 (进入待审核状态)
     */
    @PostMapping("/submit/{logId}")
    public R<Void> submitTask(@PathVariable("logId") Long logId) {
        ChildTaskVo childTask = childTaskService.selectChildTaskById(logId);
        if (childTask != null) {
            validateChildAccess(childTask.getChildId());
        }
        return toAjax(taskLogService.submitTask(logId));
    }

    /**
     * 查询儿童待执行任务
     */
    @GetMapping({"/pending/{childId}", "/pending"})
    public R<List<ChildTaskVo>> pendingTasks(@PathVariable(required = false) Long childId, @RequestParam(value = "childId", required = false) Long qid, @RequestParam(required = false) Long cid) {
        Long finalChildId = childId != null ? childId : (qid != null ? qid : cid);
        if (finalChildId == null) {
            return R.fail("未选择儿童");
        }
        validateChildAccess(finalChildId);
        List<ChildTaskVo> list = childTaskService.selectPendingTasksByChildId(finalChildId);
        return R.ok(list);
    }

    /**
     * 查询儿童正在执行的任务
     */
    @GetMapping({"/current/{childId}", "/current"})
    public R<ChildTaskVo> currentTask(@PathVariable(required = false) Long childId, @RequestParam(value = "childId", required = false) Long qid, @RequestParam(required = false) Long cid) {
        Long finalChildId = childId != null ? childId : (qid != null ? qid : cid);
        if (finalChildId == null) {
            return R.fail("未选择儿童");
        }
        validateChildAccess(finalChildId);
        ChildTaskVo childTask = childTaskService.selectCurrentTaskByChildId(finalChildId);
        return R.ok(childTask);
    }

    /**
     * 新增任务指派
     */
    @PostMapping("/add")
    public R<Void> add(@RequestBody ChildTask childTask) {
        validateChildAccess(childTask.getChildId());
        return toAjax(childTaskService.insertChildTask(childTask));
    }

    /**
     * 获取儿童积分
     */
    @GetMapping("/score/{childId}")
    public R<com.kenzhao.smallsteps.common.ss.domain.ChildScore> getScore(@PathVariable Long childId) {
        validateChildAccess(childId);
        return R.ok(scoreService.getChildScore(childId));
    }

    /**
     * 删除任务记录
     */
    @DeleteMapping("/remove/{id}")
    public R<Void> remove(@PathVariable("id") Long id) {
        ChildTaskVo childTask = childTaskService.selectChildTaskById(id);
        if (childTask != null) {
            validateChildAccess(childTask.getChildId());
        }
        return toAjax(childTaskService.deleteChildTaskById(id));
    }

    /**
     * 校验当前登录用户是否有权访问该儿童数据
     */
    private void validateChildAccess(Long childId) {
        if (childId == null) return;
        
        // 超级管理员拥有所有权限
        if (com.kenzhao.smallsteps.common.satoken.utils.LoginHelper.isSuperAdmin()) {
            return;
        }

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

package com.kenzhao.smallsteps.child.controller;

import com.kenzhao.smallsteps.common.ss.domain.ChildTask;
import com.kenzhao.smallsteps.common.ss.domain.vo.ChildTaskVo;
import com.kenzhao.smallsteps.child.service.IChildTaskService;
import com.kenzhao.smallsteps.common.core.domain.R;
import com.kenzhao.smallsteps.common.web.core.BaseController;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.*;

import java.util.List;

/**
 * 儿童任务执行控制层 (现代化重构 + 支持 VO)
 *
 * @author 赵轩
 * @date 2026-04-08
 */
@RestController
@RequiredArgsConstructor
@RequestMapping("/child/task")
public class ChildTaskController extends BaseController {

    private final IChildTaskService childTaskService;

    /**
     * 查询儿童任务执行列表 (带硬件反馈信息)
     */
    @GetMapping("/list")
    public R<List<ChildTaskVo>> list(ChildTask childTask) {
        List<ChildTaskVo> list = childTaskService.selectChildTaskList(childTask);
        return R.ok(list);
    }

    /**
     * 根据执行记录ID查询任务详情
     */
    @GetMapping("/info/{id}")
    public R<ChildTaskVo> info(@PathVariable("id") Long id) {
        ChildTaskVo childTask = childTaskService.selectChildTaskById(id);
        return R.ok(childTask);
    }

    /**
     * [ADHD] 开始执行任务 - 触发硬件灯光/音效预警
     */
    @PostMapping("/start")
    public R<Void> startTask(@RequestParam("taskId") Long taskId, @RequestParam("childId") Long childId) {
        return toAjax(childTaskService.startTask(taskId, childId));
    }

    /**
     * [ADHD] 完成任务 - 触发奖励
     */
    @PostMapping("/complete")
    public R<Void> completeTask(@RequestParam("taskId") Long taskId, @RequestParam("childId") Long childId) {
        return toAjax(childTaskService.completeTask(taskId, childId));
    }

    /**
     * 查询儿童待执行任务
     */
    @GetMapping({"/pending/{childId}", "/pending"})
    public R<List<ChildTaskVo>> pendingTasks(@PathVariable(required = false) Long childId, @RequestParam(required = false) Long cid) {
        Long finalChildId = childId != null ? childId : cid;
        if (finalChildId == null) {
            return R.fail("未选择儿童");
        }
        List<ChildTaskVo> list = childTaskService.selectPendingTasksByChildId(finalChildId);
        return R.ok(list);
    }

    /**
     * 查询儿童正在执行的任务
     */
    @GetMapping({"/current/{childId}", "/current"})
    public R<ChildTaskVo> currentTask(@PathVariable(required = false) Long childId, @RequestParam(required = false) Long cid) {
        Long finalChildId = childId != null ? childId : cid;
        if (finalChildId == null) {
            return R.fail("未选择儿童");
        }
        ChildTaskVo childTask = childTaskService.selectCurrentTaskByChildId(finalChildId);
        return R.ok(childTask);
    }

    // CRUD 基础操作保留 (省略或根据需要完善)
    @PostMapping("/add")
    public R<Void> add(@RequestBody ChildTask childTask) {
        return toAjax(childTaskService.insertChildTask(childTask));
    }

    @DeleteMapping("/remove/{id}")
    public R<Void> remove(@PathVariable("id") Long id) {
        return toAjax(childTaskService.deleteChildTaskById(id));
    }
}

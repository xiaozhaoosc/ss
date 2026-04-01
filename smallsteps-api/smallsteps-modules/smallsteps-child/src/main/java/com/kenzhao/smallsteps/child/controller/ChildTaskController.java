package com.kenzhao.smallsteps.child.controller;

import com.kenzhao.smallsteps.child.domain.ChildTask;
import com.kenzhao.smallsteps.child.service.IChildTaskService;
import com.kenzhao.smallsteps.common.core.domain.R;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

/**
 * 儿童任务Controller
 */
@RestController
@RequestMapping("/child/task")
public class ChildTaskController {

    @Autowired
    private IChildTaskService childTaskService;

    /**
     * 查询儿童任务列表
     */
    @GetMapping("/list")
    public R<List<ChildTask>> list(ChildTask childTask) {
        List<ChildTask> list = childTaskService.selectChildTaskList(childTask);
        return R.ok(list);
    }

    /**
     * 根据任务ID查询儿童任务
     */
    @GetMapping("/info/{taskId}")
    public R<ChildTask> info(@PathVariable("taskId") Long taskId) {
        ChildTask childTask = childTaskService.selectChildTaskByTaskId(taskId);
        return R.ok(childTask);
    }

    /**
     * 新增儿童任务
     */
    @PostMapping("/add")
    public R<String> add(@RequestBody ChildTask childTask) {
        int result = childTaskService.insertChildTask(childTask);
        return result > 0 ? R.ok("新增成功") : R.fail("新增失败");
    }

    /**
     * 修改儿童任务
     */
    @PutMapping("/edit")
    public R<String> edit(@RequestBody ChildTask childTask) {
        int result = childTaskService.updateChildTask(childTask);
        return result > 0 ? R.ok("修改成功") : R.fail("修改失败");
    }

    /**
     * 删除儿童任务
     */
    @DeleteMapping("/remove/{taskId}")
    public R<String> remove(@PathVariable("taskId") Long taskId) {
        int result = childTaskService.deleteChildTaskByTaskId(taskId);
        return result > 0 ? R.ok("删除成功") : R.fail("删除失败");
    }

    /**
     * 批量删除儿童任务
     */
    @DeleteMapping("/remove/batch")
    public R<String> removeBatch(@RequestBody Long[] taskIds) {
        int result = childTaskService.deleteChildTaskByTaskIds(taskIds);
        return result > 0 ? R.ok("删除成功") : R.fail("删除失败");
    }

    /**
     * 开始执行任务
     */
    @PostMapping("/start")
    public R<String> startTask(@RequestParam("taskId") Long taskId, @RequestParam("childId") Long childId) {
        int result = childTaskService.startTask(taskId, childId);
        return result > 0 ? R.ok("任务开始成功") : R.fail("任务开始失败");
    }

    /**
     * 完成任务
     */
    @PostMapping("/complete")
    public R<String> completeTask(@RequestParam("taskId") Long taskId, @RequestParam("childId") Long childId) {
        int result = childTaskService.completeTask(taskId, childId);
        return result > 0 ? R.ok("任务完成成功") : R.fail("任务完成失败");
    }

    /**
     * 失败任务
     */
    @PostMapping("/fail")
    public R<String> failTask(@RequestParam("taskId") Long taskId, @RequestParam("childId") Long childId) {
        int result = childTaskService.failTask(taskId, childId);
        return result > 0 ? R.ok("任务失败成功") : R.fail("任务失败失败");
    }

    /**
     * 查询儿童待执行任务
     */
    @GetMapping("/pending/{childId}")
    public R<List<ChildTask>> pendingTasks(@PathVariable("childId") Long childId) {
        List<ChildTask> list = childTaskService.selectPendingTasksByChildId(childId);
        return R.ok(list);
    }

    /**
     * 查询儿童正在执行的任务
     */
    @GetMapping("/current/{childId}")
    public R<ChildTask> currentTask(@PathVariable("childId") Long childId) {
        ChildTask childTask = childTaskService.selectCurrentTaskByChildId(childId);
        return R.ok(childTask);
    }

    /**
     * NFC刷卡签到
     */
    @PostMapping("/nfc/checkin")
    public R<String> nfcCheckIn(@RequestParam("nfcId") String nfcId, @RequestParam("childId") Long childId) {
        int result = childTaskService.nfcCheckIn(nfcId, childId);
        return result > 0 ? R.ok("签到成功") : R.fail("签到失败");
    }
}

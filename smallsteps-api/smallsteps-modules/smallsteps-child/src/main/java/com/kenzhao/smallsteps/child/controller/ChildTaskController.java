package com.kenzhao.smallsteps.child.controller;

import com.kenzhao.smallsteps.common.core.domain.R;
import org.springframework.web.bind.annotation.*;

/**
 * 儿童端任务控制器
 */
@RestController
@RequestMapping("/child/task")
public class ChildTaskController {

    /**
     * 获取当前任务
     */
    @GetMapping("/current")
    public R<?> getCurrentTask() {
        // TODO: 实现获取当前任务的逻辑
        return R.ok("获取当前任务成功");
    }

    /**
     * 任务签到
     */
    @PostMapping("/checkin")
    public R<?> checkin(@RequestBody CheckinRequest request) {
        // TODO: 实现任务签到的逻辑
        return R.ok("任务签到成功");
    }

    /**
     * 任务完成
     */
    @PostMapping("/complete")
    public R<?> complete(@RequestBody CompleteRequest request) {
        // TODO: 实现任务完成的逻辑
        return R.ok("任务完成成功");
    }

    // 请求参数类
    public static class CheckinRequest {
        private String taskId;
        private String nfcId;

        public String getTaskId() {
            return taskId;
        }

        public void setTaskId(String taskId) {
            this.taskId = taskId;
        }

        public String getNfcId() {
            return nfcId;
        }

        public void setNfcId(String nfcId) {
            this.nfcId = nfcId;
        }
    }

    public static class CompleteRequest {
        private String taskId;

        public String getTaskId() {
            return taskId;
        }

        public void setTaskId(String taskId) {
            this.taskId = taskId;
        }
    }
}

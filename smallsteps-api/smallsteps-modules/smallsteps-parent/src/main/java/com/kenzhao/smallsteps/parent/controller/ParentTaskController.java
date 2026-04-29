package com.kenzhao.smallsteps.parent.controller;

import cn.dev33.satoken.annotation.SaCheckPermission;
import com.kenzhao.smallsteps.common.core.domain.R;
import com.kenzhao.smallsteps.common.core.validate.AddGroup;
import com.kenzhao.smallsteps.common.core.validate.EditGroup;
import com.kenzhao.smallsteps.common.excel.utils.ExcelUtil;
import com.kenzhao.smallsteps.common.idempotent.annotation.RepeatSubmit;
import com.kenzhao.smallsteps.common.log.annotation.Log;
import com.kenzhao.smallsteps.common.log.enums.BusinessType;
import com.kenzhao.smallsteps.common.mybatis.core.page.PageQuery;
import com.kenzhao.smallsteps.common.mybatis.core.page.TableDataInfo;
import com.kenzhao.smallsteps.common.web.core.BaseController;
import com.kenzhao.smallsteps.common.ss.domain.bo.ParentTaskBo;
import com.kenzhao.smallsteps.common.ss.domain.vo.ParentTaskVo;
import com.kenzhao.smallsteps.common.ss.domain.ParentTask;
import com.kenzhao.smallsteps.task.service.IParentTaskService;
import com.kenzhao.smallsteps.task.service.ISsTaskLogService;
import com.kenzhao.smallsteps.child.service.IScoreService;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.validation.constraints.NotEmpty;
import jakarta.validation.constraints.NotNull;
import lombok.RequiredArgsConstructor;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

import java.util.List;

/**
 * 家长任务发布
 */
@Validated
@RequiredArgsConstructor
@RestController
@RequestMapping("/parent/task")
public class ParentTaskController extends BaseController {

    private final IParentTaskService parentTaskService;
    private final IScoreService scoreService;
    private final ISsTaskLogService taskLogService;
    private static final org.slf4j.Logger log = org.slf4j.LoggerFactory.getLogger(ParentTaskController.class);

    /**
     * 查询家长任务发布列表
     */
    @SaCheckPermission("parent:task:list")
    @GetMapping("/list")
    public TableDataInfo<ParentTaskVo> list(ParentTaskBo bo, PageQuery pageQuery) {
        bo.setUserId(com.kenzhao.smallsteps.common.satoken.utils.LoginHelper.getUserId());
        return parentTaskService.queryPageList(bo, pageQuery);
    }

    /**
     * 导出家长任务发布列表
     */
    @SaCheckPermission("parent:task:export")
    @Log(title = "家长任务发布", businessType = BusinessType.EXPORT)
    @PostMapping("/export")
    public void export(ParentTaskBo bo, HttpServletResponse response) {
        bo.setUserId(com.kenzhao.smallsteps.common.satoken.utils.LoginHelper.getUserId());
        List<ParentTaskVo> list = parentTaskService.queryList(bo);
        ExcelUtil.exportExcel(list, "家长任务发布", ParentTaskVo.class, response);
    }

    /**
     * 获取家长任务发布详细信息
     */
    @SaCheckPermission("parent:task:query")
    @GetMapping("/{taskId}")
    public R<ParentTaskVo> getInfo(@NotNull(message = "主键不能为空") @PathVariable Long taskId) {
        return R.ok(parentTaskService.queryById(taskId));
    }

    /**
     * 新增家长任务发布
     */
    @SaCheckPermission("parent:task:add")
    @Log(title = "家长任务发布", businessType = BusinessType.INSERT)
    @RepeatSubmit()
    @PostMapping()
    public R<Void> add(@Validated(AddGroup.class) @RequestBody ParentTaskBo bo) {
        if (bo.getUserId() == null) {
            bo.setUserId(com.kenzhao.smallsteps.common.satoken.utils.LoginHelper.getUserId());
        }
        boolean success = parentTaskService.insertByBo(bo);
        
        // 使用 error 级别确保在 sys-error.log 中可见，简化 ID 匹配
        log.error("[Shadow-Debug] ParentTaskController.add called. userId: {}, success: {}", bo.getUserId(), success);

        return toAjax(success);
    }

    /**
     * 修改家长任务发布
     */
    @SaCheckPermission("parent:task:edit")
    @Log(title = "家长任务发布", businessType = BusinessType.UPDATE)
    @RepeatSubmit()
    @PutMapping()
    public R<Void> edit(@Validated(EditGroup.class) @RequestBody ParentTaskBo bo) {
        ParentTaskVo oldTask = parentTaskService.queryById(bo.getTaskId());
        boolean success = parentTaskService.updateByBo(bo);
        if (success && oldTask != null && !ParentTask.STATUS_COMPLETED.equals(oldTask.getStatus()) 
            && ParentTask.STATUS_COMPLETED.equals(bo.getStatus())) {
            // Task Completed
            int points = bo.getRewardPoints() != null ? bo.getRewardPoints()
                    : (oldTask.getRewardPoints() != null ? oldTask.getRewardPoints() : 0);
            if (points > 0) {
                scoreService.addPoints(bo.getUserId(), points, bo.getTaskId(), "完成任务: " + bo.getTitle());
            }
        }
        return toAjax(success);
    }

    /**
     * 家长点亮星星 (合作确认)
     * @param logId 任务记录ID
     */
    @SaCheckPermission("parent:task:edit")
    @Log(title = "家长任务点亮", businessType = BusinessType.UPDATE)
    @PutMapping("/lightUp/{logId}")
    public R<Void> lightUp(@PathVariable Long logId) {
        return toAjax(taskLogService.lightUp(logId));
    }

    /**
     * 删除家长任务发布
     */
    @SaCheckPermission("parent:task:remove")
    @Log(title = "家长任务发布", businessType = BusinessType.DELETE)
    @DeleteMapping("/{taskIds}")
    public R<Void> remove(@NotEmpty(message = "主键不能为空") @PathVariable Long[] taskIds) {
        return toAjax(parentTaskService.deleteWithValidByIds(List.of(taskIds), true));
    }
}

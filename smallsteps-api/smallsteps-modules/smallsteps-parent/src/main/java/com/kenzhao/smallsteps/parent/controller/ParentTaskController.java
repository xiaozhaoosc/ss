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
import com.kenzhao.smallsteps.parent.domain.bo.ParentTaskBo;
import com.kenzhao.smallsteps.parent.domain.vo.ParentTaskVo;
import com.kenzhao.smallsteps.parent.service.IParentTaskService;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.validation.constraints.NotEmpty;
import jakarta.validation.constraints.NotNull;
import lombok.RequiredArgsConstructor;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

import java.util.List;

/**
 * 家长任务发布
 *
 * @author 赵轩
 * @date 2026-02-01
 */
@Validated
@RequiredArgsConstructor
@RestController
@RequestMapping("/parent/task")
public class ParentTaskController extends BaseController {

    private final IParentTaskService parentTaskService;
    private final com.kenzhao.smallsteps.parent.service.IScoreService scoreService;

    /**
     * 查询家长任务发布列表
     */
    @SaCheckPermission("parent:task:list")
    @GetMapping("/list")
    public TableDataInfo<ParentTaskVo> list(ParentTaskBo bo, PageQuery pageQuery) {
        return parentTaskService.queryPageList(bo, pageQuery);
    }

    /**
     * 导出家长任务发布列表
     */
    @SaCheckPermission("parent:task:export")
    @Log(title = "家长任务发布", businessType = BusinessType.EXPORT)
    @PostMapping("/export")
    public void export(ParentTaskBo bo, HttpServletResponse response) {
        List<ParentTaskVo> list = parentTaskService.queryList(bo);
        ExcelUtil.exportExcel(list, "家长任务发布", ParentTaskVo.class, response);
    }

    /**
     * 获取家长任务发布详细信息
     *
     * @param taskId 主键
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
        return toAjax(parentTaskService.insertByBo(bo));
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
        if (success && oldTask != null && !"1".equals(oldTask.getStatus()) && "1".equals(bo.getStatus())) {
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
     * 删除家长任务发布
     *
     * @param taskIds 主键串
     */
    @SaCheckPermission("parent:task:remove")
    @Log(title = "家长任务发布", businessType = BusinessType.DELETE)
    @DeleteMapping("/{taskIds}")
    public R<Void> remove(@NotEmpty(message = "主键不能为空") @PathVariable Long[] taskIds) {
        return toAjax(parentTaskService.deleteWithValidByIds(List.of(taskIds), true));
    }
}

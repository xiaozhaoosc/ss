package com.kenzhao.smallsteps.parent.controller;

import com.kenzhao.smallsteps.common.core.domain.R;
import com.kenzhao.smallsteps.common.mybatis.core.page.PageQuery;
import com.kenzhao.smallsteps.common.mybatis.core.page.TableDataInfo;
import com.kenzhao.smallsteps.common.web.core.BaseController;
import com.kenzhao.smallsteps.common.ss.domain.bo.TaskTemplateBo;
import com.kenzhao.smallsteps.common.ss.domain.vo.TaskTemplateVo;
import com.kenzhao.smallsteps.parent.service.ITaskTemplateService;
import com.kenzhao.smallsteps.common.satoken.utils.LoginHelper;
import lombok.RequiredArgsConstructor;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

/**
 * ADHD 标准任务模板接口
 */
@Validated
@RequiredArgsConstructor
@RestController
@RequestMapping("/parent/template")
public class TaskTemplateController extends BaseController {

    private final ITaskTemplateService taskTemplateService;

    /**
     * 获取模板列表
     */
    @GetMapping("/list")
    public TableDataInfo<TaskTemplateVo> list(TaskTemplateBo bo, PageQuery pageQuery) {
        return taskTemplateService.queryPageList(bo, pageQuery);
    }

    /**
     * 获取模板详情
     */
    @GetMapping("/{templateId}")
    public R<TaskTemplateVo> getInfo(@PathVariable Long templateId) {
        return R.ok(taskTemplateService.queryById(templateId));
    }

    /**
     * 从模板导入任务
     * @param templateId 模板ID
     * @param childId 目标儿童ID
     */
    @PostMapping("/import/{templateId}")
    public R<Long> importTemplate(@PathVariable Long templateId, @RequestParam Long childId) {
        Long userId = LoginHelper.getUserId();
        Long deptId = LoginHelper.getDeptId();
        return R.ok(taskTemplateService.importTemplate(templateId, childId, userId, deptId));
    }
}

package com.kenzhao.smallsteps.system.controller;

import com.kenzhao.smallsteps.common.core.domain.R;
import com.kenzhao.smallsteps.common.mybatis.core.page.TableDataInfo;
import com.kenzhao.smallsteps.common.mybatis.core.page.PageQuery;
import com.kenzhao.smallsteps.system.domain.bo.SysAiPromptBo;
import com.kenzhao.smallsteps.system.domain.vo.SysAiPromptVo;
import com.kenzhao.smallsteps.system.service.ISysAiPromptService;
import com.kenzhao.smallsteps.common.web.core.BaseController;
import com.kenzhao.smallsteps.common.log.annotation.Log;
import com.kenzhao.smallsteps.common.log.enums.BusinessType;
import cn.dev33.satoken.annotation.SaCheckPermission;
import lombok.RequiredArgsConstructor;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

import java.util.Arrays;
import java.util.List;

/**
 * AI提示词模板Controller
 *
 * @author kenzhao
 */
@Validated
@RequiredArgsConstructor
@RestController
@RequestMapping("/system/ai/prompt")
public class SysAiPromptController extends BaseController {

    private final ISysAiPromptService aiPromptService;

    /**
     * 查询AI提示词模板列表
     */
    @SaCheckPermission("system:ai:list")
    @GetMapping("/list")
    public TableDataInfo<SysAiPromptVo> list(SysAiPromptBo bo, PageQuery pageQuery) {
        return aiPromptService.queryPageList(bo, pageQuery);
    }

    /**
     * 获取AI提示词模板详细信息
     */
    @SaCheckPermission("system:ai:query")
    @GetMapping("/{id}")
    public R<SysAiPromptVo> getInfo(@PathVariable("id") Long id) {
        return R.ok(aiPromptService.queryById(id));
    }

    /**
     * 新增AI提示词模板
     */
    @SaCheckPermission("system:ai:add")
    @Log(title = "AI提示词模板", businessType = BusinessType.INSERT)
    @PostMapping
    public R<Void> add(@RequestBody SysAiPromptBo bo) {
        return toAjax(aiPromptService.insertByBo(bo));
    }

    /**
     * 修改AI提示词模板
     */
    @SaCheckPermission("system:ai:edit")
    @Log(title = "AI提示词模板", businessType = BusinessType.UPDATE)
    @PutMapping
    public R<Void> edit(@RequestBody SysAiPromptBo bo) {
        return toAjax(aiPromptService.updateByBo(bo));
    }

    /**
     * 删除AI提示词模板
     */
    @SaCheckPermission("system:ai:remove")
    @Log(title = "AI提示词模板", businessType = BusinessType.DELETE)
    @DeleteMapping("/{ids}")
    public R<Void> remove(@PathVariable Long[] ids) {
        return toAjax(aiPromptService.deleteWithValidByIds(Arrays.asList(ids), true));
    }
}

package com.kenzhao.smallsteps.system.controller;

import com.kenzhao.smallsteps.common.ai.domain.AiPrompt;
import com.kenzhao.smallsteps.system.service.ISysAiPromptService;
import com.kenzhao.smallsteps.common.core.domain.R;
import com.kenzhao.smallsteps.common.mybatis.core.page.TableDataInfo;
import com.kenzhao.smallsteps.common.mybatis.core.page.PageQuery;
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
    public TableDataInfo<AiPrompt> list(AiPrompt aiPrompt, PageQuery pageQuery) {
        return aiPromptService.queryPageList(aiPrompt, pageQuery);
    }

    /**
     * 获取AI提示词模板详细信息
     */
    @SaCheckPermission("system:ai:query")
    @GetMapping("/{id}")
    public R<AiPrompt> getInfo(@PathVariable("id") Long id) {
        return R.ok(aiPromptService.queryById(id));
    }

    /**
     * 新增AI提示词模板
     */
    @SaCheckPermission("system:ai:add")
    @Log(title = "AI提示词模板", businessType = BusinessType.INSERT)
    @PostMapping
    public R<Void> add(@RequestBody AiPrompt aiPrompt) {
        return toAjax(aiPromptService.insert(aiPrompt));
    }

    /**
     * 修改AI提示词模板
     */
    @SaCheckPermission("system:ai:edit")
    @Log(title = "AI提示词模板", businessType = BusinessType.UPDATE)
    @PutMapping
    public R<Void> edit(@RequestBody AiPrompt aiPrompt) {
        return toAjax(aiPromptService.update(aiPrompt));
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

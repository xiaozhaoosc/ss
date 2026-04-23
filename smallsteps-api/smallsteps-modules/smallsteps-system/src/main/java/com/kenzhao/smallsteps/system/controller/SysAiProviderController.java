package com.kenzhao.smallsteps.system.controller;

import com.kenzhao.smallsteps.common.ai.domain.AiProvider;
import com.kenzhao.smallsteps.system.service.ISysAiProviderService;
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
 * AI供应商配置Controller
 *
 * @author kenzhao
 */
@Validated
@RequiredArgsConstructor
@RestController
@RequestMapping("/system/ai/provider")
public class SysAiProviderController extends BaseController {

    private final ISysAiProviderService aiProviderService;

    /**
     * 查询AI供应商配置列表
     */
    @SaCheckPermission("system:ai:list")
    @GetMapping("/list")
    public TableDataInfo<AiProvider> list(AiProvider aiProvider, PageQuery pageQuery) {
        return aiProviderService.queryPageList(aiProvider, pageQuery);
    }

    /**
     * 获取AI供应商配置详细信息
     */
    @SaCheckPermission("system:ai:query")
    @GetMapping("/{id}")
    public R<AiProvider> getInfo(@PathVariable("id") Long id) {
        return R.ok(aiProviderService.queryById(id));
    }

    /**
     * 新增AI供应商配置
     */
    @SaCheckPermission("system:ai:add")
    @Log(title = "AI供应商配置", businessType = BusinessType.INSERT)
    @PostMapping
    public R<Void> add(@RequestBody AiProvider aiProvider) {
        return toAjax(aiProviderService.insert(aiProvider));
    }

    /**
     * 修改AI供应商配置
     */
    @SaCheckPermission("system:ai:edit")
    @Log(title = "AI供应商配置", businessType = BusinessType.UPDATE)
    @PutMapping
    public R<Void> edit(@RequestBody AiProvider aiProvider) {
        return toAjax(aiProviderService.update(aiProvider));
    }

    /**
     * 删除AI供应商配置
     */
    @SaCheckPermission("system:ai:remove")
    @Log(title = "AI供应商配置", businessType = BusinessType.DELETE)
    @DeleteMapping("/{ids}")
    public R<Void> remove(@PathVariable Long[] ids) {
        return toAjax(aiProviderService.deleteWithValidByIds(Arrays.asList(ids), true));
    }
}

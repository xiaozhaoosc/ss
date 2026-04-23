package com.kenzhao.smallsteps.system.controller;

import com.kenzhao.smallsteps.common.ai.domain.AiModel;
import com.kenzhao.smallsteps.system.service.ISysAiModelService;
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
 * AI模型配置Controller
 *
 * @author kenzhao
 */
@Validated
@RequiredArgsConstructor
@RestController
@RequestMapping("/system/ai/model")
public class SysAiModelController extends BaseController {

    private final ISysAiModelService aiModelService;

    /**
     * 查询AI模型配置列表
     */
    @SaCheckPermission("system:ai:list")
    @GetMapping("/list")
    public TableDataInfo<AiModel> list(AiModel aiModel, PageQuery pageQuery) {
        return aiModelService.queryPageList(aiModel, pageQuery);
    }

    /**
     * 获取AI模型配置详细信息
     */
    @SaCheckPermission("system:ai:query")
    @GetMapping("/{id}")
    public R<AiModel> getInfo(@PathVariable("id") Long id) {
        return R.ok(aiModelService.queryById(id));
    }

    /**
     * 新增AI模型配置
     */
    @SaCheckPermission("system:ai:add")
    @Log(title = "AI模型配置", businessType = BusinessType.INSERT)
    @PostMapping
    public R<Void> add(@RequestBody AiModel aiModel) {
        return toAjax(aiModelService.insert(aiModel));
    }

    /**
     * 修改AI模型配置
     */
    @SaCheckPermission("system:ai:edit")
    @Log(title = "AI模型配置", businessType = BusinessType.UPDATE)
    @PutMapping
    public R<Void> edit(@RequestBody AiModel aiModel) {
        return toAjax(aiModelService.update(aiModel));
    }

    /**
     * 删除AI模型配置
     */
    @SaCheckPermission("system:ai:remove")
    @Log(title = "AI模型配置", businessType = BusinessType.DELETE)
    @DeleteMapping("/{ids}")
    public R<Void> remove(@PathVariable Long[] ids) {
        return toAjax(aiModelService.deleteWithValidByIds(Arrays.asList(ids), true));
    }
}

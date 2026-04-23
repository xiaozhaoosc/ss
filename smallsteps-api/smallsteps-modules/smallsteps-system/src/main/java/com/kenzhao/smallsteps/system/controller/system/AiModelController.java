package com.kenzhao.smallsteps.system.controller.system;

import cn.dev33.satoken.annotation.SaCheckPermission;
import com.kenzhao.smallsteps.common.core.domain.R;
import com.kenzhao.smallsteps.common.mybatis.core.page.PageQuery;
import com.kenzhao.smallsteps.common.mybatis.core.page.TableDataInfo;
import com.kenzhao.smallsteps.common.web.core.BaseController;
import com.kenzhao.smallsteps.system.domain.bo.SysAiModelBo;
import com.kenzhao.smallsteps.system.domain.vo.SysAiModelVo;
import com.kenzhao.smallsteps.system.service.ISysAiModelService;
import lombok.RequiredArgsConstructor;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

import java.util.Arrays;

/**
 * AI模型配置Controller (管理端)
 *
 * @author kenzhao
 */
@Validated
@RequiredArgsConstructor
@RestController
@RequestMapping("/system/ai/model")
public class AiModelController extends BaseController {

    private final ISysAiModelService aiModelService;

    /**
     * 查询AI模型配置列表
     */
    @SaCheckPermission("ai:model:list")
    @GetMapping("/list")
    public TableDataInfo<SysAiModelVo> list(SysAiModelBo bo, PageQuery pageQuery) {
        return aiModelService.queryPageList(bo, pageQuery);
    }

    /**
     * 获取AI模型配置详细信息
     */
    @SaCheckPermission("ai:model:query")
    @GetMapping(value = {"/", "/{id}"})
    public R<SysAiModelVo> getInfo(@PathVariable(value = "id", required = false) Long id) {
        return R.ok(aiModelService.queryById(id));
    }

    /**
     * 新增AI模型配置
     */
    @SaCheckPermission("ai:model:add")
    @PostMapping
    public R<Void> add(@RequestBody SysAiModelBo bo) {
        return toAjax(aiModelService.insertByBo(bo));
    }

    /**
     * 修改AI模型配置
     */
    @SaCheckPermission("ai:model:edit")
    @PutMapping
    public R<Void> edit(@RequestBody SysAiModelBo bo) {
        return toAjax(aiModelService.updateByBo(bo));
    }

    /**
     * 删除AI模型配置
     */
    @SaCheckPermission("ai:model:remove")
    @DeleteMapping("/{ids}")
    public R<Void> remove(@PathVariable Long[] ids) {
        return toAjax(aiModelService.deleteWithValidByIds(Arrays.asList(ids), true));
    }
}

package com.kenzhao.smallsteps.system.controller.system;

import cn.dev33.satoken.annotation.SaCheckPermission;
import com.kenzhao.smallsteps.common.core.domain.R;
import com.kenzhao.smallsteps.common.mybatis.core.page.PageQuery;
import com.kenzhao.smallsteps.common.mybatis.core.page.TableDataInfo;
import com.kenzhao.smallsteps.common.web.core.BaseController;
import com.kenzhao.smallsteps.system.domain.bo.SysAiPromptBo;
import com.kenzhao.smallsteps.system.domain.vo.SysAiPromptVo;
import com.kenzhao.smallsteps.system.service.ISysAiPromptService;
import lombok.RequiredArgsConstructor;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

import java.util.Arrays;

/**
 * AI提示词模板Controller (管理端)
 *
 * @author kenzhao
 */
@Validated
@RequiredArgsConstructor
@RestController
@RequestMapping("/system/ai/prompt")
public class AiPromptController extends BaseController {

    private final ISysAiPromptService aiPromptService;

    /**
     * 查询AI提示词模板列表
     */
    @SaCheckPermission("ai:prompt:list")
    @GetMapping("/list")
    public TableDataInfo<SysAiPromptVo> list(SysAiPromptBo bo, PageQuery pageQuery) {
        return aiPromptService.queryPageList(bo, pageQuery);
    }

    /**
     * 获取AI提示词模板详细信息
     */
    @SaCheckPermission("ai:prompt:query")
    @GetMapping(value = {"/", "/{id}"})
    public R<SysAiPromptVo> getInfo(@PathVariable(value = "id", required = false) Long id) {
        return R.ok(aiPromptService.queryById(id));
    }

    /**
     * 新增AI提示词模板
     */
    @SaCheckPermission("ai:prompt:add")
    @PostMapping
    public R<Void> add(@RequestBody SysAiPromptBo bo) {
        return toAjax(aiPromptService.insertByBo(bo));
    }

    /**
     * 修改AI提示词模板
     */
    @SaCheckPermission("ai:prompt:edit")
    @PutMapping
    public R<Void> edit(@RequestBody SysAiPromptBo bo) {
        return toAjax(aiPromptService.updateByBo(bo));
    }

    /**
     * 删除AI提示词模板
     */
    @SaCheckPermission("ai:prompt:remove")
    @DeleteMapping("/{ids}")
    public R<Void> remove(@PathVariable Long[] ids) {
        return toAjax(aiPromptService.deleteWithValidByIds(Arrays.asList(ids), true));
    }
}

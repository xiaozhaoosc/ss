package com.kenzhao.smallsteps.system.controller.system;

import cn.dev33.satoken.annotation.SaCheckPermission;
import com.kenzhao.smallsteps.common.core.domain.R;
import com.kenzhao.smallsteps.common.mybatis.core.page.PageQuery;
import com.kenzhao.smallsteps.common.mybatis.core.page.TableDataInfo;
import com.kenzhao.smallsteps.common.web.core.BaseController;
import com.kenzhao.smallsteps.common.log.annotation.Log;
import com.kenzhao.smallsteps.common.log.enums.BusinessType;
import com.kenzhao.smallsteps.system.domain.bo.SysAiRouteBo;
import com.kenzhao.smallsteps.system.domain.vo.SysAiRouteVo;
import com.kenzhao.smallsteps.system.service.ISysAiRouteService;
import lombok.RequiredArgsConstructor;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

import java.util.Arrays;

/**
 * AI路由策略Controller (管理端)
 *
 * @author kenzhao
 */
@Validated
@RequiredArgsConstructor
@RestController
@RequestMapping("/system/ai/route")
public class AiRouteController extends BaseController {

    private final ISysAiRouteService aiRouteService;

    /**
     * 查询AI路由策略列表
     */
    @SaCheckPermission("ai:route:list")
    @GetMapping("/list")
    public TableDataInfo<SysAiRouteVo> list(SysAiRouteBo bo, PageQuery pageQuery) {
        return aiRouteService.queryPageList(bo, pageQuery);
    }

    /**
     * 获取AI路由策略详细信息
     */
    @SaCheckPermission("ai:route:query")
    @GetMapping(value = {"/", "/{sceneKey}"})
    public R<SysAiRouteVo> getInfo(@PathVariable(value = "sceneKey", required = false) String sceneKey) {
        return R.ok(aiRouteService.queryById(sceneKey));
    }

    /**
     * 新增AI路由策略
     */
    @SaCheckPermission("ai:route:add")
    @Log(title = "AI路由策略", businessType = BusinessType.INSERT)
    @PostMapping
    public R<Void> add(@RequestBody SysAiRouteBo bo) {
        return toAjax(aiRouteService.insertByBo(bo));
    }

    /**
     * 修改AI路由策略
     */
    @SaCheckPermission("ai:route:edit")
    @Log(title = "AI路由策略", businessType = BusinessType.UPDATE)
    @PutMapping
    public R<Void> edit(@RequestBody SysAiRouteBo bo) {
        return toAjax(aiRouteService.updateByBo(bo));
    }

    /**
     * 删除AI路由策略
     */
    @SaCheckPermission("ai:route:remove")
    @Log(title = "AI路由策略", businessType = BusinessType.DELETE)
    @DeleteMapping("/{ids}")
    public R<Void> remove(@PathVariable String[] ids) {
        return toAjax(aiRouteService.deleteWithValidByIds(Arrays.asList(ids), true));
    }
}

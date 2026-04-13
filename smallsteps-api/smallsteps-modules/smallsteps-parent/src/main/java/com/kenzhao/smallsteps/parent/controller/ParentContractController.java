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
import com.kenzhao.smallsteps.common.ss.domain.bo.ParentContractBo;
import com.kenzhao.smallsteps.common.ss.domain.vo.ParentContractVo;
import com.kenzhao.smallsteps.parent.service.IParentContractService;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.validation.constraints.NotEmpty;
import jakarta.validation.constraints.NotNull;
import lombok.RequiredArgsConstructor;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

import java.util.List;

/**
 * 亲子契约
 *
 * @author 赵轩
 * @date 2026-02-01
 */
@Validated
@RequiredArgsConstructor
@RestController
@RequestMapping("/parent/contract")
public class ParentContractController extends BaseController {

    private final IParentContractService parentContractService;

    /**
     * 查询亲子契约列表
     */
    @SaCheckPermission("parent:contract:list")
    @GetMapping("/list")
    public TableDataInfo<ParentContractVo> list(ParentContractBo bo, PageQuery pageQuery) {
        return parentContractService.queryPageList(bo, pageQuery);
    }

    /**
     * 导出亲子契约列表
     */
    @SaCheckPermission("parent:contract:export")
    @Log(title = "亲子契约", businessType = BusinessType.EXPORT)
    @PostMapping("/export")
    public void export(ParentContractBo bo, HttpServletResponse response) {
        List<ParentContractVo> list = parentContractService.queryList(bo);
        ExcelUtil.exportExcel(list, "亲子契约", ParentContractVo.class, response);
    }

    /**
     * 获取亲子契约详细信息
     *
     * @param contractId 主键
     */
    @SaCheckPermission("parent:contract:query")
    @GetMapping("/{contractId}")
    public R<ParentContractVo> getInfo(@NotNull(message = "主键不能为空") @PathVariable Long contractId) {
        return R.ok(parentContractService.queryById(contractId));
    }

    /**
     * 新增亲子契约
     */
    @SaCheckPermission("parent:contract:add")
    @Log(title = "亲子契约", businessType = BusinessType.INSERT)
    @RepeatSubmit()
    @PostMapping()
    public R<Void> add(@Validated(AddGroup.class) @RequestBody ParentContractBo bo) {
        return toAjax(parentContractService.insertByBo(bo));
    }

    /**
     * 修改亲子契约
     */
    @SaCheckPermission("parent:contract:edit")
    @Log(title = "亲子契约", businessType = BusinessType.UPDATE)
    @RepeatSubmit()
    @PutMapping()
    public R<Void> edit(@Validated(EditGroup.class) @RequestBody ParentContractBo bo) {
        return toAjax(parentContractService.updateByBo(bo));
    }

    /**
     * 删除亲子契约
     *
     * @param contractIds 主键串
     */
    @SaCheckPermission("parent:contract:remove")
    @Log(title = "亲子契约", businessType = BusinessType.DELETE)
    @DeleteMapping("/{contractIds}")
    public R<Void> remove(@NotEmpty(message = "主键不能为空") @PathVariable Long[] contractIds) {
        return toAjax(parentContractService.deleteWithValidByIds(List.of(contractIds), true));
    }
}

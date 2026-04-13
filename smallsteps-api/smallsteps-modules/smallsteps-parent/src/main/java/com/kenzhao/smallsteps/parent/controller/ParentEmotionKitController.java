package com.kenzhao.smallsteps.parent.controller;

import com.kenzhao.smallsteps.common.core.domain.R;
import com.kenzhao.smallsteps.common.core.validate.AddGroup;
import com.kenzhao.smallsteps.common.core.validate.EditGroup;
import com.kenzhao.smallsteps.common.idempotent.annotation.RepeatSubmit;
import com.kenzhao.smallsteps.common.log.annotation.Log;
import com.kenzhao.smallsteps.common.log.enums.BusinessType;
import com.kenzhao.smallsteps.common.mybatis.core.page.PageQuery;
import com.kenzhao.smallsteps.common.mybatis.core.page.TableDataInfo;
import com.kenzhao.smallsteps.common.web.core.BaseController;
import com.kenzhao.smallsteps.common.ss.domain.bo.ParentEmotionKitBo;
import com.kenzhao.smallsteps.common.ss.domain.vo.ParentEmotionKitVo;
import com.kenzhao.smallsteps.parent.service.IParentEmotionKitService;
import jakarta.validation.constraints.NotEmpty;
import jakarta.validation.constraints.NotNull;
import lombok.RequiredArgsConstructor;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

import java.util.List;

/**
 * 情绪急救包配置
 */
@Validated
@RequiredArgsConstructor
@RestController
@RequestMapping("/parent/emotion-kit")
public class ParentEmotionKitController extends BaseController {

    private final IParentEmotionKitService parentEmotionKitService;

    /**
     * 查询情绪急救包配置列表
     */
    @GetMapping("/list")
    public TableDataInfo<ParentEmotionKitVo> list(ParentEmotionKitBo bo, PageQuery pageQuery) {
        return parentEmotionKitService.queryPageList(bo, pageQuery);
    }

    /**
     * 获取情绪急救包配置详细信息
     *
     * @param kitId 主键
     */
    @GetMapping("/{kitId}")
    public R<ParentEmotionKitVo> getInfo(@NotNull(message = "主键不能为空") @PathVariable Long kitId) {
        return R.ok(parentEmotionKitService.queryById(kitId));
    }

    /**
     * 新增情绪急救包配置
     */
    @Log(title = "情绪急救包配置", businessType = BusinessType.INSERT)
    @RepeatSubmit()
    @PostMapping()
    public R<Void> add(@Validated(AddGroup.class) @RequestBody ParentEmotionKitBo bo) {
        return toAjax(parentEmotionKitService.insertByBo(bo));
    }

    /**
     * 修改情绪急救包配置
     */
    @Log(title = "情绪急救包配置", businessType = BusinessType.UPDATE)
    @RepeatSubmit()
    @PutMapping()
    public R<Void> edit(@Validated(EditGroup.class) @RequestBody ParentEmotionKitBo bo) {
        return toAjax(parentEmotionKitService.updateByBo(bo));
    }

    /**
     * 删除情绪急救包配置
     *
     * @param kitIds 主键串
     */
    @Log(title = "情绪急救包配置", businessType = BusinessType.DELETE)
    @DeleteMapping("/{kitIds}")
    public R<Void> remove(@NotEmpty(message = "主键不能为空") @PathVariable Long[] kitIds) {
        return toAjax(parentEmotionKitService.deleteWithValidByIds(List.of(kitIds), true));
    }

    /**
     * 获取孩子的情绪急救包配置
     */
    @GetMapping("/child/{childId}")
    public R<List<ParentEmotionKitVo>> getChildEmotionKits(@PathVariable Long childId) {
        List<ParentEmotionKitVo> kits = parentEmotionKitService.getChildEmotionKits(childId);
        return R.ok(kits);
    }
}

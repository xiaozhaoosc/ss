package com.kenzhao.smallsteps.parent.controller;

import com.kenzhao.smallsteps.common.core.domain.R;
import com.kenzhao.smallsteps.parent.domain.bo.ParentToolBo;
import com.kenzhao.smallsteps.parent.domain.vo.ParentToolVo;
import com.kenzhao.smallsteps.parent.service.IParentToolService;
import jakarta.validation.constraints.NotNull;
import lombok.RequiredArgsConstructor;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

import java.util.List;

/**
 * 家长辅助工具
 */
@Validated
@RequiredArgsConstructor
@RestController
@RequestMapping("/parent/tool")
public class ParentToolController {

    private final IParentToolService parentToolService;

    /**
     * 获取情绪急救包配置
     */
    @GetMapping("/emotion/first-aid")
    public R<ParentToolVo> getEmotionFirstAid(@RequestParam Long userId) {
        return R.ok(parentToolService.getEmotionFirstAid(userId));
    }

    /**
     * 更新情绪急救包配置
     */
    @PutMapping("/emotion/first-aid")
    public R<Void> updateEmotionFirstAid(@RequestBody ParentToolBo bo) {
        return toAjax(parentToolService.updateEmotionFirstAid(bo));
    }

    /**
     * 获取家长指南
     */
    @GetMapping("/guide")
    public R<List<ParentToolVo>> getParentGuide(@RequestParam String type) {
        return R.ok(parentToolService.getParentGuide(type));
    }

    /**
     * 获取亲子契约模板
     */
    @GetMapping("/contract/template")
    public R<List<ParentToolVo>> getContractTemplate() {
        return R.ok(parentToolService.getContractTemplate());
    }

    /**
     * 辅助方法：转换为 Ajax 响应
     */
    private R<Void> toAjax(boolean success) {
        return success ? R.ok() : R.fail();
    }
}
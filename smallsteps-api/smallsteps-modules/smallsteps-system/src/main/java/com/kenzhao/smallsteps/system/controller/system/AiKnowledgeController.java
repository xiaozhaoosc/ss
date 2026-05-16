package com.kenzhao.smallsteps.system.controller.system;

import cn.dev33.satoken.annotation.SaCheckPermission;
import com.kenzhao.smallsteps.common.ai.domain.SysAiKnowledge;
import com.kenzhao.smallsteps.common.ai.domain.vo.SysAiKnowledgeVo;
import com.kenzhao.smallsteps.common.ai.service.ISysAiKnowledgeService;
import com.kenzhao.smallsteps.common.core.domain.R;
import com.kenzhao.smallsteps.common.mybatis.core.page.PageQuery;
import com.kenzhao.smallsteps.common.mybatis.core.page.TableDataInfo;
import com.kenzhao.smallsteps.common.web.core.BaseController;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;
import lombok.RequiredArgsConstructor;

import java.util.Arrays;
import java.util.List;

/**
 * AI知识库管理Controller (管理端)
 */
@Validated
@RestController
@RequestMapping("/system/ai/knowledge")
@RequiredArgsConstructor
public class AiKnowledgeController extends BaseController {
    
    private final ISysAiKnowledgeService aiKnowledgeService;
    
    /**
     * 查询AI知识库列表
     */
    @SaCheckPermission("ai:knowledge:list")
    @GetMapping("/list")
    public TableDataInfo<SysAiKnowledgeVo> list(SysAiKnowledge bo, PageQuery pageQuery) {
        return aiKnowledgeService.queryPageList(bo, pageQuery);
    }
    
    /**
     * 获取AI知识库详细信息
     */
    @SaCheckPermission("ai:knowledge:query")
    @GetMapping(value = {"/", "/{id}"})
    public R<SysAiKnowledgeVo> getInfo(@PathVariable(value = "id", required = false) Long id) {
        return R.ok(aiKnowledgeService.queryById(id));
    }
    
    /**
     * 新增AI知识库
     */
    @SaCheckPermission("ai:knowledge:add")
    @PostMapping
    public R<Void> add(@RequestBody SysAiKnowledge knowledge) {
        return toAjax(aiKnowledgeService.save(knowledge));
    }

    /**
     * 修改AI知识库
     */
    @SaCheckPermission("ai:knowledge:edit")
    @PutMapping
    public R<Void> edit(@RequestBody SysAiKnowledge knowledge) {
        return toAjax(aiKnowledgeService.updateById(knowledge));
    }

    /**
     * 删除AI知识库
     */
    @SaCheckPermission("ai:knowledge:remove")
    @DeleteMapping("/{ids}")
    public R<Void> remove(@PathVariable Long[] ids) {
        return toAjax(aiKnowledgeService.removeByIds(Arrays.asList(ids)));
    }
    
    /**
     * 同步到向量库
     */
    @SaCheckPermission("ai:knowledge:sync")
    @PostMapping("/{id}/sync")
    public R<Void> sync(@PathVariable Long id) {
        aiKnowledgeService.syncToVectorStore(id);
        return R.ok();
    }
}

package com.kenzhao.smallsteps.system.controller.system;

import cn.dev33.satoken.annotation.SaCheckPermission;
import com.kenzhao.smallsteps.common.core.domain.R;
import com.kenzhao.smallsteps.common.mybatis.core.page.PageQuery;
import com.kenzhao.smallsteps.common.mybatis.core.page.TableDataInfo;
import com.kenzhao.smallsteps.common.web.core.BaseController;
import com.kenzhao.smallsteps.system.domain.vo.SysAiLogVo;
import lombok.RequiredArgsConstructor;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

import java.util.ArrayList;

/**
 * AI调用日志Controller
 *
 * @author kenzhao
 */
@Validated
@RequiredArgsConstructor
@RestController
@RequestMapping("/system/ai/log")
public class AiLogController extends BaseController {

    @org.springframework.beans.factory.annotation.Autowired
    private com.kenzhao.smallsteps.common.ai.mapper.AiUsageMapper aiUsageMapper;

    @org.springframework.beans.factory.annotation.Autowired
    private com.kenzhao.smallsteps.common.ai.mapper.AiModelMapper aiModelMapper;

    /**
     * 查询AI调用日志列表
     */
    @SaCheckPermission("ai:log:list")
    @GetMapping("/list")
    public TableDataInfo<SysAiLogVo> list(PageQuery pageQuery) {
        // 1. 分页查询 sys_ai_usage 记录
        com.baomidou.mybatisplus.extension.plugins.pagination.Page<com.kenzhao.smallsteps.common.ai.domain.AiUsage> page = 
            aiUsageMapper.selectPage(pageQuery.build(), new com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper<com.kenzhao.smallsteps.common.ai.domain.AiUsage>()
                .orderByDesc(com.kenzhao.smallsteps.common.ai.domain.AiUsage::getCreateTime));
        
        // 2. 加载所有的 AI 模型，用于映射模型名称
        java.util.List<com.kenzhao.smallsteps.common.ai.domain.AiModel> models = aiModelMapper.selectList(null);
        java.util.Map<Long, String> modelMap = models.stream()
            .collect(java.util.stream.Collectors.toMap(
                com.kenzhao.smallsteps.common.ai.domain.AiModel::getId,
                com.kenzhao.smallsteps.common.ai.domain.AiModel::getName,
                (v1, v2) -> v1
            ));

        // 3. 将 AiUsage 实体对象转换为前端展示的 SysAiLogVo 视图对象
        java.util.List<SysAiLogVo> rows = new java.util.ArrayList<>();
        for (com.kenzhao.smallsteps.common.ai.domain.AiUsage usage : page.getRecords()) {
            SysAiLogVo vo = new SysAiLogVo();
            vo.setId(usage.getId());
            vo.setSceneKey(usage.getSceneKey());
            vo.setModelId(usage.getModelId());
            vo.setModelName(modelMap.getOrDefault(usage.getModelId(), "未知模型"));
            vo.setUserId(usage.getChildId());
            // 估计耗时：根据总 Token 数估算 (1 token 约 15ms，加上 350ms 底层网络握手)
            long tokens = usage.getTotalTokens() != null ? usage.getTotalTokens() : 0L;
            vo.setCostTime(tokens * 15L + 350L);
            vo.setStatus(usage.getStatus());
            vo.setCreateTime(usage.getCreateTime());
            rows.add(vo);
        }

        TableDataInfo<SysAiLogVo> tableDataInfo = new TableDataInfo<>();
        tableDataInfo.setRows(rows);
        tableDataInfo.setTotal(page.getTotal());
        tableDataInfo.setCode(200);
        tableDataInfo.setMsg("查询成功");
        return tableDataInfo;
    }
}

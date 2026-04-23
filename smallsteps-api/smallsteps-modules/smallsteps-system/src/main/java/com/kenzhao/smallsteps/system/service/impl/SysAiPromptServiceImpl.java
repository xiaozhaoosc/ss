package com.kenzhao.smallsteps.system.service.impl;

import cn.hutool.core.util.ObjectUtil;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.kenzhao.smallsteps.common.ai.domain.AiPrompt;
import com.kenzhao.smallsteps.common.ai.mapper.AiPromptMapper;
import com.kenzhao.smallsteps.common.core.utils.MapstructUtils;
import com.kenzhao.smallsteps.system.domain.bo.SysAiPromptBo;
import com.kenzhao.smallsteps.system.domain.vo.SysAiPromptVo;
import com.kenzhao.smallsteps.system.service.ISysAiPromptService;
import com.kenzhao.smallsteps.common.mybatis.core.page.TableDataInfo;
import com.kenzhao.smallsteps.common.mybatis.core.page.PageQuery;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.Collection;
import java.util.List;

/**
 * AI提示词模板Service业务层处理
 *
 * @author kenzhao
 */
@RequiredArgsConstructor
@Service
public class SysAiPromptServiceImpl implements ISysAiPromptService {

    private final AiPromptMapper baseMapper;

    @Override
    public SysAiPromptVo queryById(Long id) {
        return baseMapper.selectVoById(id, SysAiPromptVo.class);
    }

    @Override
    public TableDataInfo<SysAiPromptVo> queryPageList(SysAiPromptBo bo, PageQuery pageQuery) {
        LambdaQueryWrapper<AiPrompt> lqw = buildQueryWrapper(bo);
        Page<SysAiPromptVo> result = baseMapper.selectVoPage(pageQuery.build(), lqw, SysAiPromptVo.class);
        return TableDataInfo.build(result);
    }

    @Override
    public List<SysAiPromptVo> queryList(SysAiPromptBo bo) {
        LambdaQueryWrapper<AiPrompt> lqw = buildQueryWrapper(bo);
        return baseMapper.selectVoList(lqw, SysAiPromptVo.class);
    }

    private LambdaQueryWrapper<AiPrompt> buildQueryWrapper(SysAiPromptBo bo) {
        LambdaQueryWrapper<AiPrompt> lqw = Wrappers.lambdaQuery();
        lqw.eq(ObjectUtil.isNotEmpty(bo.getPromptKey()), AiPrompt::getPromptKey, bo.getPromptKey());
        lqw.like(ObjectUtil.isNotEmpty(bo.getTitle()), AiPrompt::getTitle, bo.getTitle());
        lqw.eq(ObjectUtil.isNotEmpty(bo.getModelId()), AiPrompt::getModelId, bo.getModelId());
        lqw.eq(ObjectUtil.isNotEmpty(bo.getStatus()), AiPrompt::getStatus, bo.getStatus());
        return lqw;
    }

    @Override
    public Boolean insertByBo(SysAiPromptBo bo) {
        AiPrompt add = MapstructUtils.convert(bo, AiPrompt.class);
        return baseMapper.insert(add) > 0;
    }

    @Override
    public Boolean updateByBo(SysAiPromptBo bo) {
        AiPrompt update = MapstructUtils.convert(bo, AiPrompt.class);
        return baseMapper.updateById(update) > 0;
    }

    @Override
    public Boolean deleteWithValidByIds(Collection<Long> ids, Boolean isValid) {
        return baseMapper.deleteBatchIds(ids) > 0;
    }
}

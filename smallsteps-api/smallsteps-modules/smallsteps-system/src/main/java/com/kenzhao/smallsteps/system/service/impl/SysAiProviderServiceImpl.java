package com.kenzhao.smallsteps.system.service.impl;

import cn.hutool.core.util.ObjectUtil;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.kenzhao.smallsteps.common.ai.domain.AiProvider;
import com.kenzhao.smallsteps.common.ai.mapper.AiProviderMapper;
import com.kenzhao.smallsteps.system.service.ISysAiProviderService;
import com.kenzhao.smallsteps.common.mybatis.core.page.TableDataInfo;
import com.kenzhao.smallsteps.common.mybatis.core.page.PageQuery;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.Collection;
import java.util.List;

/**
 * AI供应商配置Service业务层处理
 *
 * @author kenzhao
 */
@RequiredArgsConstructor
@Service
public class SysAiProviderServiceImpl implements ISysAiProviderService {

    private final AiProviderMapper baseMapper;

    @Override
    public AiProvider queryById(Long id) {
        return baseMapper.selectById(id);
    }

    @Override
    public TableDataInfo<AiProvider> queryPageList(AiProvider aiProvider, PageQuery pageQuery) {
        LambdaQueryWrapper<AiProvider> lqw = buildQueryWrapper(aiProvider);
        Page<AiProvider> result = baseMapper.selectPage(pageQuery.build(), lqw);
        return TableDataInfo.build(result);
    }

    @Override
    public List<AiProvider> queryList(AiProvider aiProvider) {
        LambdaQueryWrapper<AiProvider> lqw = buildQueryWrapper(aiProvider);
        return baseMapper.selectList(lqw);
    }

    private LambdaQueryWrapper<AiProvider> buildQueryWrapper(AiProvider aiProvider) {
        LambdaQueryWrapper<AiProvider> lqw = Wrappers.lambdaQuery();
        lqw.like(ObjectUtil.isNotEmpty(aiProvider.getName()), AiProvider::getName, aiProvider.getName());
        lqw.eq(ObjectUtil.isNotEmpty(aiProvider.getType()), AiProvider::getType, aiProvider.getType());
        lqw.eq(ObjectUtil.isNotEmpty(aiProvider.getStatus()), AiProvider::getStatus, aiProvider.getStatus());
        return lqw;
    }

    @Override
    public Boolean insert(AiProvider aiProvider) {
        return baseMapper.insert(aiProvider) > 0;
    }

    @Override
    public Boolean update(AiProvider aiProvider) {
        return baseMapper.updateById(aiProvider) > 0;
    }

    @Override
    public Boolean deleteWithValidByIds(Collection<Long> ids, Boolean isValid) {
        return baseMapper.deleteBatchIds(ids) > 0;
    }
}

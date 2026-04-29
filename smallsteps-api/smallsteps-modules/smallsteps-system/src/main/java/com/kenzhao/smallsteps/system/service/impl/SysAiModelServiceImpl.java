package com.kenzhao.smallsteps.system.service.impl;

import cn.hutool.core.util.ObjectUtil;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.kenzhao.smallsteps.common.ai.domain.AiModel;
import com.kenzhao.smallsteps.common.ai.mapper.AiModelMapper;
import com.kenzhao.smallsteps.common.core.constant.CacheConstants;
import com.kenzhao.smallsteps.common.core.utils.MapstructUtils;
import com.kenzhao.smallsteps.common.redis.utils.RedisUtils;
import com.kenzhao.smallsteps.system.domain.bo.SysAiModelBo;
import com.kenzhao.smallsteps.system.domain.vo.SysAiModelVo;
import com.kenzhao.smallsteps.system.service.ISysAiModelService;
import com.kenzhao.smallsteps.common.mybatis.core.page.TableDataInfo;
import com.kenzhao.smallsteps.common.mybatis.core.page.PageQuery;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.Collection;
import java.util.List;

/**
 * AI模型配置Service业务层处理
 *
 * @author kenzhao
 */
@RequiredArgsConstructor
@Service
public class SysAiModelServiceImpl implements ISysAiModelService {

    private final AiModelMapper baseMapper;
    private final com.kenzhao.smallsteps.common.ai.mapper.AiProviderMapper providerMapper;

    @Override
    public SysAiModelVo queryById(Long id) {
        SysAiModelVo vo = baseMapper.selectVoById(id, SysAiModelVo.class);
        populateProviderInfo(vo);
        return vo;
    }

    @Override
    public TableDataInfo<SysAiModelVo> queryPageList(SysAiModelBo bo, PageQuery pageQuery) {
        LambdaQueryWrapper<AiModel> lqw = buildQueryWrapper(bo);
        Page<SysAiModelVo> result = baseMapper.selectVoPage(pageQuery.build(), lqw, SysAiModelVo.class);
        result.getRecords().forEach(this::populateProviderInfo);
        return TableDataInfo.build(result);
    }

    @Override
    public List<SysAiModelVo> queryList(SysAiModelBo bo) {
        LambdaQueryWrapper<AiModel> lqw = buildQueryWrapper(bo);
        List<SysAiModelVo> list = baseMapper.selectVoList(lqw, SysAiModelVo.class);
        list.forEach(this::populateProviderInfo);
        return list;
    }

    private void populateProviderInfo(SysAiModelVo vo) {
        if (vo != null && vo.getProviderId() != null) {
            com.kenzhao.smallsteps.common.ai.domain.AiProvider provider = providerMapper.selectById(vo.getProviderId());
            if (provider != null) {
                vo.setProviderName(provider.getName());
                vo.setProviderCode(provider.getProviderCode());
            }
        }
    }

    private LambdaQueryWrapper<AiModel> buildQueryWrapper(SysAiModelBo bo) {
        LambdaQueryWrapper<AiModel> lqw = Wrappers.lambdaQuery();
        lqw.eq(ObjectUtil.isNotEmpty(bo.getProviderId()), AiModel::getProviderId, bo.getProviderId());
        lqw.like(ObjectUtil.isNotEmpty(bo.getName()), AiModel::getName, bo.getName());
        lqw.eq(ObjectUtil.isNotEmpty(bo.getModelCode()), AiModel::getModelCode, bo.getModelCode());
        lqw.eq(ObjectUtil.isNotEmpty(bo.getStatus()), AiModel::getStatus, bo.getStatus());
        return lqw;
    }

    @Override
    public Boolean insertByBo(SysAiModelBo bo) {
        AiModel add = MapstructUtils.convert(bo, AiModel.class);
        boolean flag = baseMapper.insert(add) > 0;
        if (flag && add.getId() != null) {
            RedisUtils.deleteObject(CacheConstants.AI_MODEL_KEY + add.getId());
        }
        return flag;
    }

    @Override
    public Boolean updateByBo(SysAiModelBo bo) {
        AiModel update = MapstructUtils.convert(bo, AiModel.class);
        boolean flag = baseMapper.updateById(update) > 0;
        if (flag) {
            RedisUtils.deleteObject(CacheConstants.AI_MODEL_KEY + bo.getId());
        }
        return flag;
    }

    @Override
    public Boolean deleteWithValidByIds(Collection<Long> ids, Boolean isValid) {
        boolean flag = baseMapper.deleteBatchIds(ids) > 0;
        if (flag) {
            for (Long id : ids) {
                RedisUtils.deleteObject(CacheConstants.AI_MODEL_KEY + id);
            }
        }
        return flag;
    }
}

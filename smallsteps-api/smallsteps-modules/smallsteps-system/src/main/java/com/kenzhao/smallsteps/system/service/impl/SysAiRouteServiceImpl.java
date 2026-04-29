package com.kenzhao.smallsteps.system.service.impl;

import cn.hutool.core.util.ObjectUtil;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.kenzhao.smallsteps.common.ai.domain.AiRoute;
import com.kenzhao.smallsteps.common.ai.mapper.AiRouteMapper;
import com.kenzhao.smallsteps.common.core.constant.CacheConstants;
import com.kenzhao.smallsteps.common.core.utils.MapstructUtils;
import com.kenzhao.smallsteps.common.redis.utils.RedisUtils;
import com.kenzhao.smallsteps.system.domain.bo.SysAiRouteBo;
import com.kenzhao.smallsteps.system.domain.vo.SysAiRouteVo;
import com.kenzhao.smallsteps.system.service.ISysAiRouteService;
import com.kenzhao.smallsteps.common.mybatis.core.page.TableDataInfo;
import com.kenzhao.smallsteps.common.mybatis.core.page.PageQuery;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.Collection;
import java.util.List;

/**
 * AI路由策略Service业务层处理
 *
 * @author kenzhao
 */
@RequiredArgsConstructor
@Service
public class SysAiRouteServiceImpl implements ISysAiRouteService {

    private final AiRouteMapper baseMapper;

    @Override
    public SysAiRouteVo queryById(String sceneKey) {
        return baseMapper.selectVoById(sceneKey, SysAiRouteVo.class);
    }

    @Override
    public TableDataInfo<SysAiRouteVo> queryPageList(SysAiRouteBo bo, PageQuery pageQuery) {
        LambdaQueryWrapper<AiRoute> lqw = buildQueryWrapper(bo);
        Page<SysAiRouteVo> result = baseMapper.selectVoPage(pageQuery.build(), lqw, SysAiRouteVo.class);
        return TableDataInfo.build(result);
    }

    @Override
    public List<SysAiRouteVo> queryList(SysAiRouteBo bo) {
        LambdaQueryWrapper<AiRoute> lqw = buildQueryWrapper(bo);
        return baseMapper.selectVoList(lqw, SysAiRouteVo.class);
    }

    private LambdaQueryWrapper<AiRoute> buildQueryWrapper(SysAiRouteBo bo) {
        LambdaQueryWrapper<AiRoute> lqw = Wrappers.lambdaQuery();
        lqw.eq(ObjectUtil.isNotEmpty(bo.getSceneKey()), AiRoute::getSceneKey, bo.getSceneKey());
        lqw.eq(ObjectUtil.isNotEmpty(bo.getStrategy()), AiRoute::getStrategy, bo.getStrategy());
        lqw.eq(ObjectUtil.isNotEmpty(bo.getDefaultModelId()), AiRoute::getDefaultModelId, bo.getDefaultModelId());
        return lqw;
    }

    @Override
    public Boolean insertByBo(SysAiRouteBo bo) {
        AiRoute add = MapstructUtils.convert(bo, AiRoute.class);
        boolean flag = baseMapper.insert(add) > 0;
        if (flag) {
            RedisUtils.deleteObject(CacheConstants.AI_ROUTE_KEY + bo.getSceneKey());
        }
        return flag;
    }

    @Override
    public Boolean updateByBo(SysAiRouteBo bo) {
        AiRoute update = MapstructUtils.convert(bo, AiRoute.class);
        boolean flag = baseMapper.updateById(update) > 0;
        if (flag) {
            RedisUtils.deleteObject(CacheConstants.AI_ROUTE_KEY + bo.getSceneKey());
        }
        return flag;
    }

    @Override
    public Boolean deleteWithValidByIds(Collection<String> ids, Boolean isValid) {
        boolean flag = baseMapper.deleteBatchIds(ids) > 0;
        if (flag) {
            for (String id : ids) {
                RedisUtils.deleteObject(CacheConstants.AI_ROUTE_KEY + id);
            }
        }
        return flag;
    }
}

package com.kenzhao.smallsteps.system.service;

import com.kenzhao.smallsteps.common.mybatis.core.page.TableDataInfo;
import com.kenzhao.smallsteps.common.mybatis.core.page.PageQuery;
import com.kenzhao.smallsteps.system.domain.bo.SysAiRouteBo;
import com.kenzhao.smallsteps.system.domain.vo.SysAiRouteVo;

import java.util.Collection;
import java.util.List;

/**
 * AI路由策略Service接口
 *
 * @author kenzhao
 */
public interface ISysAiRouteService {

    /**
     * 查询AI路由策略
     */
    SysAiRouteVo queryById(String sceneKey);

    /**
     * 查询AI路由策略列表
     */
    TableDataInfo<SysAiRouteVo> queryPageList(SysAiRouteBo bo, PageQuery pageQuery);

    /**
     * 查询AI路由策略列表
     */
    List<SysAiRouteVo> queryList(SysAiRouteBo bo);

    /**
     * 新增AI路由策略
     */
    Boolean insertByBo(SysAiRouteBo bo);

    /**
     * 修改AI路由策略
     */
    Boolean updateByBo(SysAiRouteBo bo);

    /**
     * 校验并批量删除AI路由策略信息
     */
    Boolean deleteWithValidByIds(Collection<String> ids, Boolean isValid);
}

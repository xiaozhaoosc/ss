package com.kenzhao.smallsteps.system.service;

import com.kenzhao.smallsteps.common.ai.domain.AiProvider;
import com.kenzhao.smallsteps.common.mybatis.core.page.TableDataInfo;
import com.kenzhao.smallsteps.common.mybatis.core.page.PageQuery;
import java.util.Collection;
import java.util.List;

/**
 * AI供应商配置Service接口
 *
 * @author kenzhao
 */
public interface ISysAiProviderService {

    /**
     * 查询AI供应商配置
     */
    AiProvider queryById(Long id);

    /**
     * 查询AI供应商配置列表
     */
    TableDataInfo<AiProvider> queryPageList(AiProvider aiProvider, PageQuery pageQuery);

    /**
     * 查询AI供应商配置列表
     */
    List<AiProvider> queryList(AiProvider aiProvider);

    /**
     * 新增AI供应商配置
     */
    Boolean insert(AiProvider aiProvider);

    /**
     * 修改AI供应商配置
     */
    Boolean update(AiProvider aiProvider);

    /**
     * 校验并批量删除AI供应商配置信息
     */
    Boolean deleteWithValidByIds(Collection<Long> ids, Boolean isValid);
}

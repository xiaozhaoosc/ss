package com.kenzhao.smallsteps.system.service;

import com.kenzhao.smallsteps.common.mybatis.core.page.TableDataInfo;
import com.kenzhao.smallsteps.common.mybatis.core.page.PageQuery;
import com.kenzhao.smallsteps.system.domain.bo.SysAiModelBo;
import com.kenzhao.smallsteps.system.domain.vo.SysAiModelVo;

import java.util.Collection;
import java.util.List;

/**
 * AI模型配置Service接口
 *
 * @author kenzhao
 */
public interface ISysAiModelService {

    /**
     * 查询AI模型配置
     */
    SysAiModelVo queryById(Long id);

    /**
     * 查询AI模型配置列表
     */
    TableDataInfo<SysAiModelVo> queryPageList(SysAiModelBo bo, PageQuery pageQuery);

    /**
     * 查询AI模型配置列表
     */
    List<SysAiModelVo> queryList(SysAiModelBo bo);

    /**
     * 新增AI模型配置
     */
    Boolean insertByBo(SysAiModelBo bo);

    /**
     * 修改AI模型配置
     */
    Boolean updateByBo(SysAiModelBo bo);

    /**
     * 校验并批量删除AI模型配置信息
     */
    Boolean deleteWithValidByIds(Collection<Long> ids, Boolean isValid);
}

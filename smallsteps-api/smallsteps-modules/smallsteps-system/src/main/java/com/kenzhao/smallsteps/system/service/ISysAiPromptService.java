package com.kenzhao.smallsteps.system.service;

import com.kenzhao.smallsteps.common.mybatis.core.page.TableDataInfo;
import com.kenzhao.smallsteps.common.mybatis.core.page.PageQuery;
import com.kenzhao.smallsteps.system.domain.bo.SysAiPromptBo;
import com.kenzhao.smallsteps.system.domain.vo.SysAiPromptVo;

import java.util.Collection;
import java.util.List;

/**
 * AI提示词模板Service接口
 *
 * @author kenzhao
 */
public interface ISysAiPromptService {

    /**
     * 查询AI提示词模板
     */
    SysAiPromptVo queryById(Long id);

    /**
     * 查询AI提示词模板列表
     */
    TableDataInfo<SysAiPromptVo> queryPageList(SysAiPromptBo bo, PageQuery pageQuery);

    /**
     * 查询AI提示词模板列表
     */
    List<SysAiPromptVo> queryList(SysAiPromptBo bo);

    /**
     * 新增AI提示词模板
     */
    Boolean insertByBo(SysAiPromptBo bo);

    /**
     * 修改AI提示词模板
     */
    Boolean updateByBo(SysAiPromptBo bo);

    /**
     * 校验并批量删除AI提示词模板信息
     */
    Boolean deleteWithValidByIds(Collection<Long> ids, Boolean isValid);
}

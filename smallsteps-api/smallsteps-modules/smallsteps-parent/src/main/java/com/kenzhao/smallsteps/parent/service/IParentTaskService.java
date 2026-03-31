package com.kenzhao.smallsteps.parent.service;

import com.kenzhao.smallsteps.parent.domain.vo.ParentTaskVo;
import com.kenzhao.smallsteps.parent.domain.bo.ParentTaskBo;
import com.kenzhao.smallsteps.common.mybatis.core.page.TableDataInfo;
import com.kenzhao.smallsteps.common.mybatis.core.page.PageQuery;

import java.util.Collection;
import java.util.List;

/**
 * 家长任务发布Service接口
 *
 * @author 赵轩
 * @date 2026-02-01
 */
public interface IParentTaskService {

    /**
     * 查询家长任务发布
     */
    ParentTaskVo queryById(Long taskId);

    /**
     * 查询家长任务发布列表
     */
    TableDataInfo<ParentTaskVo> queryPageList(ParentTaskBo bo, PageQuery pageQuery);

    /**
     * 查询家长任务发布列表
     */
    List<ParentTaskVo> queryList(ParentTaskBo bo);

    /**
     * 新增家长任务发布
     */
    Boolean insertByBo(ParentTaskBo bo);

    /**
     * 修改家长任务发布
     */
    Boolean updateByBo(ParentTaskBo bo);

    /**
     * 校验并批量删除家长任务发布信息
     */
    Boolean deleteWithValidByIds(Collection<Long> ids, Boolean isValid);
}

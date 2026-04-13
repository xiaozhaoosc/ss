package com.kenzhao.smallsteps.parent.service;

import com.kenzhao.smallsteps.common.mybatis.core.page.PageQuery;
import com.kenzhao.smallsteps.common.mybatis.core.page.TableDataInfo;
import com.kenzhao.smallsteps.common.ss.domain.bo.TaskTemplateBo;
import com.kenzhao.smallsteps.common.ss.domain.vo.TaskTemplateVo;

import java.util.List;

/**
 * ADHD 标准任务模板服务接口
 */
public interface ITaskTemplateService {

    /**
     * 分页查询模板列表
     */
    TableDataInfo<TaskTemplateVo> queryPageList(TaskTemplateBo bo, PageQuery pageQuery);

    /**
     * 根据ID查询模板详情（含步骤）
     */
    TaskTemplateVo queryById(Long templateId);

    /**
     * 一键导入模板到儿童任务
     * @param templateId 模板ID
     * @param childId 目标儿童ID
     * @param userId 操作家长ID
     * @param deptId 家庭ID
     * @return 成功生成的父任务ID
     */
    Long importTemplate(Long templateId, Long childId, Long userId, Long deptId);
}

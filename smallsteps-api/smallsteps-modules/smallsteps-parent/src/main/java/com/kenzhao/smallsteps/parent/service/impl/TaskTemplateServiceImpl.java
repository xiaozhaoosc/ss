package com.kenzhao.smallsteps.parent.service.impl;

import cn.hutool.core.bean.BeanUtil;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.kenzhao.smallsteps.task.mapper.ParentTaskMapper;
import com.kenzhao.smallsteps.task.mapper.ChildTaskMapper;
import com.kenzhao.smallsteps.common.mybatis.core.page.PageQuery;
import com.kenzhao.smallsteps.common.mybatis.core.page.TableDataInfo;
import com.kenzhao.smallsteps.common.ss.domain.ParentTask;
import com.kenzhao.smallsteps.common.ss.domain.ChildTask;
import com.kenzhao.smallsteps.common.ss.domain.TaskStepTemplate;
import com.kenzhao.smallsteps.common.ss.domain.TaskTemplate;
import com.kenzhao.smallsteps.common.ss.domain.bo.TaskTemplateBo;
import com.kenzhao.smallsteps.common.ss.domain.vo.TaskStepTemplateVo;
import com.kenzhao.smallsteps.common.ss.domain.vo.TaskTemplateVo;
import com.kenzhao.smallsteps.parent.mapper.TaskStepTemplateMapper;
import com.kenzhao.smallsteps.parent.mapper.TaskTemplateMapper;
import com.kenzhao.smallsteps.parent.service.ITaskTemplateService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

/**
 * ADHD 标准任务模板服务实现
 */
@Service
@RequiredArgsConstructor
public class TaskTemplateServiceImpl implements ITaskTemplateService {

    private final TaskTemplateMapper baseMapper;
    private final TaskStepTemplateMapper stepTemplateMapper;
    private final ParentTaskMapper parentTaskMapper;
    private final ChildTaskMapper childTaskMapper;

    @Override
    public TableDataInfo<TaskTemplateVo> queryPageList(TaskTemplateBo bo, PageQuery pageQuery) {
        LambdaQueryWrapper<TaskTemplate> lqw = buildQueryWrapper(bo);
        Page<TaskTemplateVo> result = baseMapper.selectVoPage(pageQuery.build(), lqw);
        return TableDataInfo.build(result);
    }

    private LambdaQueryWrapper<TaskTemplate> buildQueryWrapper(TaskTemplateBo bo) {
        LambdaQueryWrapper<TaskTemplate> lqw = Wrappers.lambdaQuery();
        lqw.like(bo.getTitle() != null, TaskTemplate::getTitle, bo.getTitle());
        lqw.eq(bo.getCategory() != null, TaskTemplate::getCategory, bo.getCategory());
        lqw.eq(TaskTemplate::getStatus, "0");
        return lqw;
    }

    @Override
    public TaskTemplateVo queryById(Long templateId) {
        TaskTemplateVo vo = baseMapper.selectVoById(templateId);
        if (vo != null) {
            List<TaskStepTemplate> steps = stepTemplateMapper.selectList(new LambdaQueryWrapper<TaskStepTemplate>()
                .eq(TaskStepTemplate::getTemplateId, templateId)
                .orderByAsc(TaskStepTemplate::getStepOrder));
            vo.setSteps(BeanUtil.copyToList(steps, TaskStepTemplateVo.class));
        }
        return vo;
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public Long importTemplate(Long templateId, Long childId, Long userId, Long deptId) {
        TaskTemplate template = baseMapper.selectById(templateId);
        if (template == null) return null;

        // 1. 创建父任务
        ParentTask parentTask = new ParentTask();
        parentTask.setTitle(template.getTitle());
        parentTask.setDescription(template.getDescription());
        parentTask.setIcon(template.getIcon());
        parentTask.setDifficulty(template.getDefaultDifficulty());
        parentTask.setPromptLevel(template.getDefaultPromptLevel());
        parentTask.setLightEffect(template.getLightEffect());
        parentTask.setAudioEffect(template.getAudioEffect());
        parentTask.setDeptId(deptId);
        parentTask.setUserId(userId);
        parentTask.setStatus("0"); // 进行中

        parentTaskMapper.insert(parentTask);
        Long mainTaskId = parentTask.getTaskId();

        // 1.5. 自动创建给儿童的指派执行任务 (ChildTask)
        if (childId != null) {
            ChildTask childTask = new ChildTask();
            childTask.setTaskId(mainTaskId);
            childTask.setChildId(childId);
            childTask.setDeptId(deptId);
            childTask.setStatus("0"); // Ongoing / 进行中
            childTask.setDelFlag("0");
            childTask.setTargetDate(new java.util.Date());
            childTaskMapper.insert(childTask);
            org.slf4j.LoggerFactory.getLogger(TaskTemplateServiceImpl.class)
                .info("[Task] Assigned imported template task {} to child {}", mainTaskId, childId);
        }

        // 2. 创建子任务（拆解步骤）
        List<TaskStepTemplate> steps = stepTemplateMapper.selectList(new LambdaQueryWrapper<TaskStepTemplate>()
            .eq(TaskStepTemplate::getTemplateId, templateId)
            .orderByAsc(TaskStepTemplate::getStepOrder));

        for (TaskStepTemplate step : steps) {
            ParentTask subTask = new ParentTask();
            subTask.setParentId(mainTaskId);
            subTask.setTitle(step.getContent());
            subTask.setDeptId(deptId);
            subTask.setUserId(userId);
            subTask.setStatus("0");
            // 子任务继承父任务的基础属性
            subTask.setDifficulty(parentTask.getDifficulty());
            subTask.setPromptLevel(parentTask.getPromptLevel());

            parentTaskMapper.insert(subTask);
        }

        return mainTaskId;
    }
}

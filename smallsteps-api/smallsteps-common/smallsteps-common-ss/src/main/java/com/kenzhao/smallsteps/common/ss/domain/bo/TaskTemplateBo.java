package com.kenzhao.smallsteps.common.ss.domain.bo;

import com.kenzhao.smallsteps.common.mybatis.core.domain.BaseEntity;
import com.kenzhao.smallsteps.common.ss.domain.TaskTemplate;
import io.github.linpeilie.annotations.AutoMapper;
import lombok.Data;
import lombok.EqualsAndHashCode;

/**
## [2026-04-14] ADHD Scaffolding Dictionary 与核心依赖解耦
- **背景**: 1. 后端 `common-core` 等模块存在循环依赖，导致无法正常编译。 2. 任务创建对家长认知负荷过高。
- **决策**: 
  1. 物理移除冗余引用，通过 VO 迁移实现各模块底层的单向依赖。
  2. 建立 `ss_task_template` 系统，支持原子动作级别的干预模板一键导入。
- **影响**: 系统架构恢复整洁，项目具备了初步的“专业干预”知识库特征。
 */
@Data
@EqualsAndHashCode(callSuper = true)
@AutoMapper(target = TaskTemplate.class)
public class TaskTemplateBo extends BaseEntity {

    private Long templateId;
    private String title;
    private String description;
    private String icon;
    private String category;
    private Integer defaultDifficulty;
    private Integer defaultPromptLevel;
    private String lightEffect;
    private String audioEffect;
    private String interventionTheory;
    private String status;
}

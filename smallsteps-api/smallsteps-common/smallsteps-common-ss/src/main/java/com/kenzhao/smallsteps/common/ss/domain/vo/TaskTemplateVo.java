package com.kenzhao.smallsteps.common.ss.domain.vo;

import lombok.Data;
import java.io.Serializable;
import java.util.List;

/**
 * ADHD 标准任务模板视图对象
 *
 * @author 赵轩
 * @date 2026-04-14
 */
@Data
public class TaskTemplateVo implements Serializable {

    private static final long serialVersionUID = 1L;

    /**
     * 模板ID
     */
    private Long templateId;

    /**
     * 任务标题
     */
    private String title;

    /**
     * 任务描述
     */
    private String description;

    /**
     * 模板图标
     */
    private String icon;

    /**
     * 分类
     */
    private String category;

    /**
     * 默认难度
     */
    private Integer defaultDifficulty;

    /**
     * 默认支架强度
     */
    private Integer defaultPromptLevel;

    /**
     * 心理学依据
     */
    private String interventionTheory;

    /**
     * 步骤列表
     */
    private List<TaskStepTemplateVo> steps;
}

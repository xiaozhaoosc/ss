package com.kenzhao.smallsteps.common.ss.domain;

import com.baomidou.mybatisplus.annotation.*;
import com.kenzhao.smallsteps.common.mybatis.core.domain.BaseEntity;
import lombok.Data;
import lombok.EqualsAndHashCode;

import java.io.Serial;

/**
 * ADHD 标准任务模板对象 ss_task_template
 *
 * @author 赵轩
 * @date 2026-04-14
 */
@Data
@EqualsAndHashCode(callSuper = true)
@TableName("ss_task_template")
public class TaskTemplate extends BaseEntity {

    @Serial
    private static final long serialVersionUID = 1L;

    /**
     * 模板ID
     */
    @TableId(value = "template_id")
    private Long template_id;

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
     * 分类 (Life, Study, Social)
     */
    private String category;

    /**
     * 目标最小年龄
     */
    private Integer targetAgeMin;

    /**
     * 目标最大年龄
     */
    private Integer targetAgeMax;

    /**
     * 默认难度 (1-5)
     */
    private Integer defaultDifficulty;

    /**
     * 默认支架强度 (1-5)
     */
    private Integer defaultPromptLevel;

    /**
     * 预设灯光效果
     */
    private String lightEffect;

    /**
     * 预设音频建议
     */
    private String audioEffect;

    /**
     * 心理学/干预理论依据
     */
    private String interventionTheory;

    /**
     * 状态 (0 正常 1 停用)
     */
    private String status;

    /**
     * 删除标志 (0代表存在 2代表删除)
     */
    @TableLogic
    private String delFlag;

}

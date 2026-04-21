package com.kenzhao.smallsteps.task.domain;

import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import com.kenzhao.smallsteps.common.tenant.core.TenantEntity;
import lombok.Data;
import lombok.EqualsAndHashCode;

/**
 * 任务预设库实体类 ss_task_preset
 *
 * @author 赵轩
 */
@Data
@EqualsAndHashCode(callSuper = true)
@TableName("ss_task_preset")
public class SsTaskPreset extends TenantEntity {

    /**
     * 预设ID
     */
    @TableId(value = "id")
    private Long id;

    /**
     * 分类 (日常, 学习, 运动等)
     */
    private String category;

    /**
     * 任务标题
     */
    private String title;

    /**
     * 任务描述
     */
    @TableField("`desc`")
    private String desc;

    /**
     * 基础奖励星星
     */
    private Integer starBase;

    /**
     * 图标
     */
    private String icon;

    /**
     * 难度
     */
    private Integer difficulty;

    /**
     * 步骤拆解 (JSONB)
     */
    private String subTasks;

    /**
     * 引导录音URL
     */
    private String voiceUrl;

    /**
     * 标签库 (用逗号分隔)
     */
    private String tags;

    /**
     * 删除标志
     */
    private String delFlag;
}

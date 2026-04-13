package com.kenzhao.smallsteps.common.ss.domain;

import com.baomidou.mybatisplus.annotation.*;
import lombok.Data;

import java.io.Serial;
import java.io.Serializable;
import java.util.Date;

/**
 * ADHD 任务步骤拆解模板对象 ss_task_step_template
 *
 * @author 赵轩
 * @date 2026-04-14
 */
@Data
@TableName("ss_task_step_template")
public class TaskStepTemplate implements Serializable {

    @Serial
    private static final long serialVersionUID = 1L;

    /**
     * 步骤ID
     */
    @TableId(value = "step_id")
    private Long stepId;

    /**
     * 关联模板ID
     */
    private Long templateId;

    /**
     * 步骤顺序
     */
    private Integer stepOrder;

    /**
     * 步骤内容
     */
    private String content;

    /**
     * 视觉提示代码
     */
    private String visualHint;

    /**
     * 语音脚本/代码
     */
    private String audioHint;

    /**
     * 建议用时 (秒)
     */
    private Integer expectedDuration;

    /**
     * 创建者
     */
    private String createBy;

    /**
     * 创建时间
     */
    private Date createTime;

    /**
     * 更新者
     */
    private String updateBy;

    /**
     * 更新时间
     */
    private Date updateTime;

}

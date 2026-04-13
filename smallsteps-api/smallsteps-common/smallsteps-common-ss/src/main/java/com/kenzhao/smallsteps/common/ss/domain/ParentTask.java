package com.kenzhao.smallsteps.common.ss.domain;

import com.baomidou.mybatisplus.annotation.*;
import com.fasterxml.jackson.annotation.JsonFormat;
import com.kenzhao.smallsteps.common.mybatis.core.domain.BaseEntity;
import lombok.Data;
import lombok.EqualsAndHashCode;

import java.io.Serial;
import java.util.Date;

/**
 * 家长任务发布对象 parent_task
 *
 * @author 赵轩
 * @date 2026-02-01
 */
@Data
@EqualsAndHashCode(callSuper = true)
@TableName("ss_parent_task")
public class ParentTask extends BaseEntity {

    @Serial
    private static final long serialVersionUID = 1L;

    /**
     * 任务ID
     */
    @TableId(value = "task_id")
    private Long taskId;

    /**
     * 家庭ID (对应 sys_dept.dept_id)
     */
    private Long deptId;

    /**
     * 父任务ID (用于任务拆解)
     */
    private Long parentId;

    /**
     * 用户ID
     */
    private Long userId;

    /**
     * 任务标题
     */
    private String title;

    /**
     * 任务描述
     */
    private String description;

    /**
     * 任务图标
     */
    private String icon;

    /**
     * 难度等级(1-5)
     */
    private Integer difficulty;

    /**
     * 支架强度/辅助强度(1-5)
     */
    private Integer promptLevel;

    /**
     * 循环类型(0单次 1每日 2每周)
     */
    private Integer cycleType;

    /**
     * 奖励积分
     */
    private Integer rewardPoints;

    /**
     * 灯光效果代码
     */
    private String lightEffect;

    /**
     * 音频索引代码
     */
    private String audioEffect;

    /**
     * 截止时间
     */
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private Date deadline;

    /**
     * 状态(0进行中 1已完成 2已过期)
     */
    private String status;

    /**
     * 删除标志(0代表存在 2代表删除)
     */
    @TableLogic
    private String delFlag;

}

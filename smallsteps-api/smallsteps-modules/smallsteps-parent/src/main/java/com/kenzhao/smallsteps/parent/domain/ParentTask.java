package com.kenzhao.smallsteps.parent.domain;

import com.baomidou.mybatisplus.annotation.*;
import com.kenzhao.smallsteps.common.mybatis.core.domain.BaseEntity;
import lombok.Data;
import lombok.EqualsAndHashCode;

import java.io.Serial;

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
     * 奖励积分
     */
    private Integer rewardPoints;

    /**
     * 状态(0正常 1停用)
     */
    private String status;

    /**
     * 删除标志(0代表存在 2代表删除)
     */
    @TableLogic
    private String delFlag;

}

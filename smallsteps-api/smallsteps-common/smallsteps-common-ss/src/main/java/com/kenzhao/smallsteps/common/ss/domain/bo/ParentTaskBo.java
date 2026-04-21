package com.kenzhao.smallsteps.common.ss.domain.bo;

import com.kenzhao.smallsteps.common.mybatis.core.domain.BaseEntity;
import com.kenzhao.smallsteps.common.core.validate.AddGroup;
import com.kenzhao.smallsteps.common.core.validate.EditGroup;
import jakarta.validation.constraints.*;
import lombok.Data;
import lombok.EqualsAndHashCode;

import java.util.Date;

/**
 * 家长任务发布业务对象 parent_task
 *
 * @author 赵轩
 * @date 2026-02-01
 */
@Data
@EqualsAndHashCode(callSuper = true)
public class ParentTaskBo extends BaseEntity {

    /**
     * 任务ID
     */
    @NotNull(message = "任务ID不能为空", groups = { EditGroup.class })
    private Long taskId;

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
    @NotBlank(message = "任务标题不能为空", groups = { AddGroup.class, EditGroup.class })
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
    @Max(value = 5, message = "难度不能超过5")
    @Min(value = 1, message = "难度不能低于1")
    private Integer difficulty;

    /**
     * 支架强度/辅助强度(1-5)
     */
    @Max(value = 5, message = "支架强度不能超过5")
    @Min(value = 1, message = "支架强度不能低于1")
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
    private Date deadline;

    /**
     * 状态(0进行中 1已完成 2已过期)
     */
    private String status;

}

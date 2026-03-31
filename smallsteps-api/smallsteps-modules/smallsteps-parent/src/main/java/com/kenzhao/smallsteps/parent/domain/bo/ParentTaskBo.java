package com.kenzhao.smallsteps.parent.domain.bo;

import com.kenzhao.smallsteps.common.mybatis.core.domain.BaseEntity;
import com.kenzhao.smallsteps.common.core.validate.AddGroup;
import com.kenzhao.smallsteps.common.core.validate.EditGroup;
import jakarta.validation.constraints.*;
import lombok.Data;
import lombok.EqualsAndHashCode;

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
     * 用户ID
     */
    @NotNull(message = "用户ID不能为空", groups = { AddGroup.class, EditGroup.class })
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
    private Integer difficulty;

    /**
     * 奖励积分
     */
    private Integer rewardPoints;

    /**
     * 状态(0正常 1停用)
     */
    private String status;

}

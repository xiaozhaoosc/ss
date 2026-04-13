package com.kenzhao.smallsteps.common.ss.domain.bo;

import com.kenzhao.smallsteps.common.mybatis.core.domain.BaseEntity;
import com.kenzhao.smallsteps.common.core.validate.AddGroup;
import com.kenzhao.smallsteps.common.core.validate.EditGroup;
import jakarta.validation.constraints.*;
import lombok.Data;
import lombok.EqualsAndHashCode;

/**
 * 家长奖励配置业务对象 parent_reward
 *
 * @author 赵轩
 * @date 2026-02-01
 */
@Data
@EqualsAndHashCode(callSuper = true)
public class ParentRewardBo extends BaseEntity {

    /**
     * 奖励ID
     */
    @NotNull(message = "奖励ID不能为空", groups = { EditGroup.class })
    private Long rewardId;

    /**
     * 用户ID
     */
    @NotNull(message = "用户ID不能为空", groups = { AddGroup.class, EditGroup.class })
    private Long userId;

    /**
     * 奖励名称
     */
    @NotBlank(message = "奖励名称不能为空", groups = { AddGroup.class, EditGroup.class })
    private String name;

    /**
     * 所需积分
     */
    private Integer pointsRequired;

    /**
     * 库存(-1表示无限)
     */
    private Integer stock;

    /**
     * 奖励图标
     */
    private String icon;

    /**
     * 状态(0正常 1停用)
     */
    private String status;

}

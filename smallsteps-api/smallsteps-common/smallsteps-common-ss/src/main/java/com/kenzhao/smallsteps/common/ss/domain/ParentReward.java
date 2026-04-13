package com.kenzhao.smallsteps.common.ss.domain;

import com.baomidou.mybatisplus.annotation.*;
import com.kenzhao.smallsteps.common.mybatis.core.domain.BaseEntity;
import lombok.Data;
import lombok.EqualsAndHashCode;

import java.io.Serial;

/**
 * 家长奖励配置对象 parent_reward
 *
 * @author 赵轩
 * @date 2026-02-01
 */
@Data
@EqualsAndHashCode(callSuper = true)
@TableName("ss_parent_reward")
public class ParentReward extends BaseEntity {

    @Serial
    private static final long serialVersionUID = 1L;

    @TableId(value = "reward_id")
    private Long rewardId;

    private Long userId;
    private String name;
    private Integer pointsRequired;
    private Integer stock;
    private String icon;
    private String status;

    @TableLogic
    private String delFlag;
}

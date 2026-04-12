package com.kenzhao.smallsteps.parent.domain;

import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import com.kenzhao.smallsteps.common.mybatis.core.domain.BaseEntity;
import lombok.Data;
import lombok.EqualsAndHashCode;

/**
 * 奖励兑换记录对象 ss_parent_reward_redemption
 *
 * @author kenzhao
 */
@Data
@EqualsAndHashCode(callSuper = true)
@TableName("ss_parent_reward_redemption")
public class ParentRewardRedemption extends BaseEntity {

    private static final long serialVersionUID = 1L;

    /** 兑换ID */
    @TableId
    private Long redemptionId;

    /** 奖励ID */
    private Long rewardId;

    /** 用户ID (儿童ID) */
    private Long userId;

    /** 消耗积分 */
    private Integer pointsCost;

    /** 状态 (0:待审批 1:已批准 2:已拒绝) */
    private String status;

}

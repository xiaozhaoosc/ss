package com.kenzhao.smallsteps.parent.domain.bo;

import com.kenzhao.smallsteps.common.mybatis.core.domain.BaseEntity;
import com.kenzhao.smallsteps.parent.domain.ParentRewardRedemption;
import io.github.linpeilie.annotations.AutoMapper;
import lombok.Data;
import lombok.EqualsAndHashCode;

/**
 * 奖励兑换记录业务对象
 */
@Data
@EqualsAndHashCode(callSuper = true)
@AutoMapper(target = ParentRewardRedemption.class, reverseConvertTarget = true)
public class ParentRewardRedemptionBo extends BaseEntity {

    /** 兑换ID */
    private Long redemptionId;

    /** 奖励ID */
    private Long rewardId;

    /** 用户ID */
    private Long userId;

    /** 消耗积分 */
    private Integer pointsCost;

    /** 状态 (0:待审批 1:已批准 2:已拒绝) */
    private String status;

}

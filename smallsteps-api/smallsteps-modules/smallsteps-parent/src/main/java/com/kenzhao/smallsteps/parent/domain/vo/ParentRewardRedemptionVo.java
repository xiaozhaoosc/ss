package com.kenzhao.smallsteps.parent.domain.vo;

import com.kenzhao.smallsteps.parent.domain.ParentRewardRedemption;
import io.github.linpeilie.annotations.AutoMapper;
import lombok.Data;

import java.io.Serial;
import java.io.Serializable;
import java.util.Date;

/**
 * 奖励兑换记录视图对象
 */
@Data
@AutoMapper(target = ParentRewardRedemption.class)
public class ParentRewardRedemptionVo implements Serializable {

    @Serial
    private static final long serialVersionUID = 1L;

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

    /** 奖励名称 (冗余或通过关联查询) */
    private String rewardName;

    /** 创建时间 */
    private Date createTime;

}

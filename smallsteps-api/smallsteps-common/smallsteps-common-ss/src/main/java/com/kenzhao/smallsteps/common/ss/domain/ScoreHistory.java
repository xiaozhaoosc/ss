package com.kenzhao.smallsteps.common.ss.domain;

import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import com.kenzhao.smallsteps.common.mybatis.core.domain.BaseEntity;
import lombok.Data;
import lombok.EqualsAndHashCode;

/**
 * 积分流水对象 ss_score_history
 *
 * @author kenzhao
 * @date 2026-02-03
 */
@Data
@EqualsAndHashCode(callSuper = true)
@TableName("ss_score_history")
public class ScoreHistory extends BaseEntity
{
    private static final long serialVersionUID = 1L;

    /** ID */
    @TableId
    private Long id;

    /** 用户ID */
    private Long userId;

    /** 变动金额 */
    private Integer amount;

    /** 类型(1:获取 2:消费) */
    private String type;

    /** 来源ID (TaskId or RewardId) */
    private Long sourceId;

    /** 变动原因 */
    private String reason;

}

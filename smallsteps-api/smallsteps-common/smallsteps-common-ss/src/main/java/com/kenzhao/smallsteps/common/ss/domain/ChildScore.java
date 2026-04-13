package com.kenzhao.smallsteps.common.ss.domain;

import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import com.kenzhao.smallsteps.common.mybatis.core.domain.BaseEntity;
import lombok.Data;
import lombok.EqualsAndHashCode;

/**
 * 儿童积分余额对象 ss_child_score
 *
 * @author kenzhao
 * @date 2026-02-03
 */
@Data
@EqualsAndHashCode(callSuper = true)
@TableName("ss_child_score")
public class ChildScore extends BaseEntity
{
    private static final long serialVersionUID = 1L;

    /** 用户ID */
    @TableId
    private Long userId;

    /** 当前余额 */
    private Integer balance;

    /** 累计获得 */
    private Integer totalEarned;

}

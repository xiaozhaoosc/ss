package com.kenzhao.smallsteps.common.ss.domain;

import com.baomidou.mybatisplus.annotation.*;
import com.kenzhao.smallsteps.common.mybatis.core.domain.BaseEntity;
import lombok.Data;
import lombok.EqualsAndHashCode;

import java.io.Serial;

/**
 * 儿童成就/资产对象 (对应 ss_child_achievement 或 ss_score_history 聚合)
 *
 * @author 赵轩
 * @date 2026-04-08
 */
@Data
@EqualsAndHashCode(callSuper = true)
@TableName("ss_child_achievement")
public class ChildAchievement extends BaseEntity {

    @Serial
    private static final long serialVersionUID = 1L;

    /**
     * ID
     */
    @TableId(value = "id")
    private Long id;

    /**
     * 成就业务ID
     */
    private Long achievementId;

    /**
     * 儿童ID
     */
    private Long childId;

    /**
     * 成就类型 (STAR-星星, FRAGMENT-勇气碎片, BADGE-勋章)
     */
    private String type;

    /**
     * 名称
     */
    private String name;

    /**
     * 数量/进度
     */
    private Integer count;

    /**
     * 图标
     */
    private String icon;

    /**
     * 备注/描述
     */
    private String remark;

    /**
     * 删除标志 (0代表存在 2代表删除)
     */
    @TableLogic
    private String delFlag;

}

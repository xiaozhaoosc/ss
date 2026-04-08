package com.kenzhao.smallsteps.child.domain;

import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;

/**
 * 儿童成就系统实体
 */
@Data
@TableName("child_achievement")
public class ChildAchievement {

    /**
     * 成就ID
     */
    @TableId
    private Long achievementId;

    /**
     * 用户ID
     */
    private Long userId;

    /**
     * 成就名称
     */
    private String achievementName;

    /**
     * 成就描述
     */
    private String description;

    /**
     * 勇气碎片数量
     */
    private Integer shardCount;

    /**
     * 星星数量
     */
    private Integer starCount;

    /**
     * 成就状态
     */
    private String status;

    /**
     * 获得时间
     */
    private String obtainTime;

    /**
     * 创建时间
     */
    private String createTime;

    /**
     * 更新时间
     */
    private String updateTime;
}
package com.kenzhao.smallsteps.parent.domain;

import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;

/**
 * 家长成长观察实体
 */
@Data
@TableName("parent_growth")
public class ParentGrowth {

    /**
     * 记录ID
     */
    @TableId
    private Long recordId;

    /**
     * 用户ID
     */
    private Long userId;

    /**
     * 日期
     */
    private String date;

    /**
     * 情绪状态
     */
    private String emotionState;

    /**
     * 情绪评分
     */
    private Integer emotionScore;

    /**
     * 能力类型
     */
    private String abilityType;

    /**
     * 能力评分
     */
    private Integer abilityScore;

    /**
     * 观察记录
     */
    private String observation;

    /**
     * 创建时间
     */
    private String createTime;

    /**
     * 更新时间
     */
    private String updateTime;
}
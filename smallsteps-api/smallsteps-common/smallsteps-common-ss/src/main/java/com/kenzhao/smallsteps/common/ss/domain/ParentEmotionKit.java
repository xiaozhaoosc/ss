package com.kenzhao.smallsteps.common.ss.domain;

import com.kenzhao.smallsteps.common.mybatis.core.domain.BaseEntity;
import com.baomidou.mybatisplus.annotation.TableName;
import com.baomidou.mybatisplus.annotation.TableId;
import lombok.Data;
import lombok.EqualsAndHashCode;

/**
 * 情绪急救包配置
 */
@Data
@EqualsAndHashCode(callSuper = true)
@TableName("ss_parent_emotion_kit")
public class ParentEmotionKit extends BaseEntity {
    private static final long serialVersionUID = 1L;

    /** 急救包ID */
    @TableId
    private Long kitId;

    /** 孩子ID */
    private Long childId;

    /** 急救包名称 */
    private String kitName;

    /** 情绪类型 (1-开心, 2-难过, 3-愤怒, 4-焦虑, 5-平静) */
    private Integer emotionType;

    /** 急救包内容 */
    private String content;

    /** 启用状态 (0-禁用, 1-启用) */
    private Integer status;
}

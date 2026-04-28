package com.kenzhao.smallsteps.common.ss.domain;

import com.baomidou.mybatisplus.annotation.*;
import lombok.Data;
import java.io.Serial;
import java.io.Serializable;
import java.util.Date;

/**
 * 儿童情绪记录对象 ss_emotion_record
 */
@Data
@TableName("ss_emotion_record")
public class EmotionRecord implements Serializable {

    @Serial
    private static final long serialVersionUID = 1L;

    /**
     * ID
     */
    @TableId(value = "id")
    private Long id;

    /**
     * 租户ID
     */
    private String tenantId;

    /**
     * 孩子ID
     */
    private Long childId;

    /**
     * 情绪等级 (1-5)
     */
    private Integer moodLevel;

    /**
     * 情绪类型
     */
    private String moodType;

    /**
     * 详细描述
     */
    private String description;

    /**
     * 语音URL (如果是语音树洞提交)
     */
    private String voiceUrl;

    /**
     * 家长反馈
     */
    private String parentFeedback;

    /**
     * 是否已读 (0 未读 1 已读)
     */
    private String isRead;

    /**
     * 记录时间
     */
    private Date recordTime;

    /**
     * 创建时间
     */
    @TableField(fill = FieldFill.INSERT)
    private Date createTime;

}

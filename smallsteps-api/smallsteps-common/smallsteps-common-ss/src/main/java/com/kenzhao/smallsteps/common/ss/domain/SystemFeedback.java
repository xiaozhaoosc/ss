package com.kenzhao.smallsteps.common.ss.domain;

import com.kenzhao.smallsteps.common.mybatis.core.domain.BaseEntity;
import com.baomidou.mybatisplus.annotation.TableName;
import com.baomidou.mybatisplus.annotation.TableId;
import lombok.Data;
import lombok.EqualsAndHashCode;

/**
 * 系统意见反馈实体类 ss_system_feedback
 */
@Data
@EqualsAndHashCode(callSuper = true)
@TableName("ss_system_feedback")
public class SystemFeedback extends BaseEntity {
    private static final long serialVersionUID = 1L;

    /** 反馈主键ID */
    @TableId
    private Long feedbackId;

    /** 提交反馈的用户ID */
    private Long userId;

    /** 反馈详细文本内容 */
    private String content;

    /** 反馈附加图片链接 (多图逗号分隔) */
    private String imgUrls;

    /** 反馈状态 (0-未处理, 1-已处理) */
    private String status;

    /** 处理备注 */
    private String remark;
}

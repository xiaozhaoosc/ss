package com.kenzhao.smallsteps.common.ai.domain;

import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import com.kenzhao.smallsteps.common.mybatis.core.domain.BaseEntity;
import lombok.Data;
import lombok.EqualsAndHashCode;

/**
 * AI提示词模板对象 sys_ai_prompt
 * 
 * @author kenzhao
 * @date 2026-04-23
 */
@Data
@EqualsAndHashCode(callSuper = true)
@TableName("sys_ai_prompt")
public class AiPrompt extends BaseEntity {
    private static final long serialVersionUID = 1L;

    /** 主键 */
    @TableId
    private Long id;

    /** 业务标识 (如 TASK_BREAKDOWN) */
    private String promptKey;

    /** 模板标题 */
    private String title;

    /** 提示词内容 */
    private String content;

    /** 关联模型ID */
    private Long modelId;

    /** 状态(0正常 1停用) */
    private String status;

    /** 删除标志(0代表存在 2代表删除) */
    private String delFlag;
}

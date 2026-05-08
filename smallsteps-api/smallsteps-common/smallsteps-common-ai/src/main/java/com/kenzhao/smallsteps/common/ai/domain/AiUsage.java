package com.kenzhao.smallsteps.common.ai.domain;

import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import com.kenzhao.smallsteps.common.mybatis.core.domain.BaseEntity;
import lombok.Data;
import lombok.EqualsAndHashCode;

import java.math.BigDecimal;

/**
 * AI使用记录对象 sys_ai_usage
 */
@Data
@EqualsAndHashCode(callSuper = true)
@TableName("sys_ai_usage")
public class AiUsage extends BaseEntity {
    private static final long serialVersionUID = 1L;

    /** 主键 */
    @TableId
    private Long id;

    /** 模型ID */
    private Long modelId;

    /** 儿童ID (可选) */
    private Long childId;

    /** 业务场景 (scene_key) */
    private String sceneKey;

    /** 输入Token数 */
    private Long inputTokens;

    /** 输出Token数 */
    private Long outputTokens;

    /** 总Token数 */
    private Long totalTokens;

    /** 消耗金额 (元) */
    private BigDecimal cost;

    /** 状态 (0成功 1失败) */
    private String status;
}

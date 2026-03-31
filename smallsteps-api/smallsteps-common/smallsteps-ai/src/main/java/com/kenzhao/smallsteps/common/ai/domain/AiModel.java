package com.kenzhao.smallsteps.common.ai.domain;

import java.math.BigDecimal;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import com.kenzhao.smallsteps.common.mybatis.core.domain.BaseEntity;
import lombok.Data;
import lombok.EqualsAndHashCode;

/**
 * AI模型对象 sys_ai_model
 * 
 * @author kenzhao
 * @date 2026-02-01
 */
@Data
@EqualsAndHashCode(callSuper = true)
@TableName("sys_ai_model")
public class AiModel extends BaseEntity {
    private static final long serialVersionUID = 1L;

    /** 主键 */
    @TableId
    private Long id;

    /** 供应商ID */
    private Long providerId;

    /** API调用代码 */
    private String modelCode;

    /** 显示名称 */
    private String name;

    /** 输入价格(元/1M) */
    private BigDecimal costInput;

    /** 输出价格(元/1M) */
    private BigDecimal costOutput;

    /** 上下文窗口 */
    private Integer contextWindow;

    /** 是否免费模型(0否 1是) */
    private String isFreeTier;

    /** 状态(0正常 1停用) */
    private String status;

    /** 删除标志(0代表存在 2代表删除) */
    private String delFlag;
}

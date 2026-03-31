package com.kenzhao.smallsteps.common.ai.domain;

import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import com.kenzhao.smallsteps.common.mybatis.core.domain.BaseEntity;
import lombok.Data;
import lombok.EqualsAndHashCode;

/**
 * AI供应商对象 sys_ai_provider
 * 
 * @author kenzhao
 * @date 2026-02-01
 */
@Data
@EqualsAndHashCode(callSuper = true)
@TableName("sys_ai_provider")
public class AiProvider extends BaseEntity {
    private static final long serialVersionUID = 1L;

    /** 主键 */
    @TableId
    private Long id;

    /** 供应商名称 */
    private String name;

    /** 类型(openai/azure/sdk) */
    private String type;

    /** API地址 */
    private String baseUrl;

    /** API密钥(加密存储) */
    private String apiKey;

    /** 权重 */
    private Integer weight;

    /** 状态(0正常 1停用) */
    private String status;

    /** 删除标志(0代表存在 2代表删除) */
    private String delFlag;
}

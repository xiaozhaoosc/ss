package com.kenzhao.smallsteps.common.ai.domain;

import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import com.kenzhao.smallsteps.common.mybatis.core.domain.BaseEntity;
import com.kenzhao.smallsteps.common.mybatis.handler.PgJsonTypeHandler;
import lombok.Data;
import lombok.EqualsAndHashCode;

/**
 * AI路由策略对象 sys_ai_route
 *
 * @author kenzhao
 * @date 2026-02-01
 */
@Data
@EqualsAndHashCode(callSuper = true)
@TableName(value = "sys_ai_route", autoResultMap = true)
public class AiRoute extends BaseEntity {
    private static final long serialVersionUID = 1L;

    /** 业务场景Key */
    @TableId
    private String sceneKey;

    /** 路由策略(PRIORITY_LEVEL, LOWEST_PRICE) */
    private String strategy;

    /** 默认模型ID */
    private Long defaultModelId;

    /** 扩展配置(JSON) */
    @TableField(typeHandler = PgJsonTypeHandler.class)
    private String configJson;
}

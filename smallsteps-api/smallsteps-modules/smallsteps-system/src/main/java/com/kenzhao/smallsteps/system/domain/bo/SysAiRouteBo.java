package com.kenzhao.smallsteps.system.domain.bo;

import com.kenzhao.smallsteps.common.ai.domain.AiRoute;
import com.kenzhao.smallsteps.common.mybatis.core.domain.BaseEntity;
import io.github.linpeilie.annotations.AutoMapper;
import jakarta.validation.constraints.NotBlank;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.NoArgsConstructor;

/**
 * AI路由策略业务对象 sys_ai_route
 *
 * @author kenzhao
 */
@Data
@NoArgsConstructor
@EqualsAndHashCode(callSuper = true)
@AutoMapper(target = AiRoute.class, reverseConvertGenerate = false)
public class SysAiRouteBo extends BaseEntity {

    /** 业务场景Key */
    @NotBlank(message = "场景Key不能为空")
    private String sceneKey;

    /** 路由策略(PRIORITY_LEVEL, LOWEST_PRICE) */
    @NotBlank(message = "路由策略不能为空")
    private String strategy;

    /** 默认模型ID */
    private Long defaultModelId;

    /** 扩展配置(JSON) */
    private String configJson;

}

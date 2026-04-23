package com.kenzhao.smallsteps.system.domain.bo;

import com.kenzhao.smallsteps.common.ai.domain.AiModel;
import com.kenzhao.smallsteps.common.mybatis.core.domain.BaseEntity;
import io.github.linpeilie.annotations.AutoMapper;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.NoArgsConstructor;

import java.math.BigDecimal;

/**
 * AI模型业务对象 sys_ai_model
 *
 * @author kenzhao
 */
@Data
@NoArgsConstructor
@EqualsAndHashCode(callSuper = true)
@AutoMapper(target = AiModel.class, reverseConvertGenerate = false)
public class SysAiModelBo extends BaseEntity {

    /** 主键 */
    private Long id;

    /** 供应商ID */
    @NotNull(message = "供应商ID不能为空")
    private Long providerId;

    /** API调用代码 */
    @NotBlank(message = "API调用代码不能为空")
    private String modelCode;

    /** 显示名称 */
    @NotBlank(message = "显示名称不能为空")
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

}

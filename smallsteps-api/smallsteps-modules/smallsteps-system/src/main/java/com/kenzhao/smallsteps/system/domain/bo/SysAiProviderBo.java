package com.kenzhao.smallsteps.system.domain.bo;

import com.kenzhao.smallsteps.common.ai.domain.AiProvider;
import com.kenzhao.smallsteps.common.mybatis.core.domain.BaseEntity;
import io.github.linpeilie.annotations.AutoMapper;
import jakarta.validation.constraints.NotBlank;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.NoArgsConstructor;

/**
 * AI供应商业务对象 sys_ai_provider
 *
 * @author kenzhao
 */
@Data
@NoArgsConstructor
@EqualsAndHashCode(callSuper = true)
@AutoMapper(target = AiProvider.class, reverseConvertGenerate = false)
public class SysAiProviderBo extends BaseEntity {

    /** 主键 */
    private Long id;

    /** 供应商名称 */
    @NotBlank(message = "供应商名称不能为空")
    private String name;

    /** 类型(openai/azure/sdk) */
    @NotBlank(message = "供应商类型不能为空")
    private String type;

    /** API地址 */
    private String baseUrl;

    /** API密钥 */
    private String apiKey;

    /** 权重 */
    private Integer weight;

    /** 状态(0正常 1停用) */
    private String status;

}

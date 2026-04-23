package com.kenzhao.smallsteps.system.domain.bo;

import com.kenzhao.smallsteps.common.ai.domain.AiPrompt;
import com.kenzhao.smallsteps.common.mybatis.core.domain.BaseEntity;
import io.github.linpeilie.annotations.AutoMapper;
import jakarta.validation.constraints.NotBlank;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.NoArgsConstructor;

/**
 * AI提示词模板业务对象 sys_ai_prompt
 *
 * @author kenzhao
 */
@Data
@NoArgsConstructor
@EqualsAndHashCode(callSuper = true)
@AutoMapper(target = AiPrompt.class, reverseConvertGenerate = false)
public class SysAiPromptBo extends BaseEntity {

    /** 主键 */
    private Long id;

    /** 业务标识 (如 TASK_BREAKDOWN) */
    @NotBlank(message = "业务标识不能为空")
    private String promptKey;

    /** 模板标题 */
    @NotBlank(message = "模板标题不能为空")
    private String title;

    /** 提示词内容 */
    @NotBlank(message = "提示词内容不能为空")
    private String content;

    /** 关联模型ID */
    private Long modelId;

    /** 状态(0正常 1停用) */
    private String status;

}

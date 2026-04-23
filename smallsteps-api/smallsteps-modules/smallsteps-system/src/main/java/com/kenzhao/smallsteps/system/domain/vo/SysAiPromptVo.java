package com.kenzhao.smallsteps.system.domain.vo;

import cn.idev.excel.annotation.ExcelIgnoreUnannotated;
import cn.idev.excel.annotation.ExcelProperty;
import com.kenzhao.smallsteps.common.ai.domain.AiPrompt;
import io.github.linpeilie.annotations.AutoMapper;
import lombok.Data;

import java.io.Serial;
import java.io.Serializable;
import java.util.Date;

/**
 * AI提示词模板视图对象 sys_ai_prompt
 *
 * @author kenzhao
 */
@Data
@ExcelIgnoreUnannotated
@AutoMapper(target = AiPrompt.class)
public class SysAiPromptVo implements Serializable {

    @Serial
    private static final long serialVersionUID = 1L;

    /** 主键 */
    @ExcelProperty(value = "序号")
    private Long id;

    /** 业务标识 (如 TASK_BREAKDOWN) */
    @ExcelProperty(value = "业务标识")
    private String promptKey;

    /** 模板标题 */
    @ExcelProperty(value = "模板标题")
    private String title;

    /** 提示词内容 */
    @ExcelProperty(value = "提示词内容")
    private String content;

    /** 关联模型ID */
    @ExcelProperty(value = "模型ID")
    private Long modelId;

    /** 状态(0正常 1停用) */
    @ExcelProperty(value = "状态")
    private String status;

    /** 创建时间 */
    @ExcelProperty(value = "创建时间")
    private Date createTime;

}

package com.kenzhao.smallsteps.system.domain.vo;

import cn.idev.excel.annotation.ExcelIgnoreUnannotated;
import cn.idev.excel.annotation.ExcelProperty;
import com.kenzhao.smallsteps.common.ai.domain.AiModel;
import io.github.linpeilie.annotations.AutoMapper;
import lombok.Data;

import java.io.Serial;
import java.io.Serializable;
import java.math.BigDecimal;
import java.util.Date;

/**
 * AI模型视图对象 sys_ai_model
 *
 * @author kenzhao
 */
@Data
@ExcelIgnoreUnannotated
@AutoMapper(target = AiModel.class)
public class SysAiModelVo implements Serializable {

    @Serial
    private static final long serialVersionUID = 1L;

    /** 主键 */
    @ExcelProperty(value = "序号")
    private Long id;

    /** 供应商ID */
    @ExcelProperty(value = "供应商ID")
    private Long providerId;

    /** API调用代码 */
    @ExcelProperty(value = "模型代码")
    private String modelCode;

    /** 显示名称 */
    @ExcelProperty(value = "模型名称")
    private String name;

    /** 输入价格(元/1M) */
    @ExcelProperty(value = "输入价格")
    private BigDecimal costInput;

    /** 输出价格(元/1M) */
    @ExcelProperty(value = "输出价格")
    private BigDecimal costOutput;

    /** 上下文窗口 */
    @ExcelProperty(value = "上下文窗口")
    private Integer contextWindow;

    /** 是否免费模型(0否 1是) */
    @ExcelProperty(value = "是否免费")
    private String isFreeTier;

    /** 状态(0正常 1停用) */
    @ExcelProperty(value = "状态")
    private String status;

    /** 创建时间 */
    @ExcelProperty(value = "创建时间")
    private Date createTime;

}

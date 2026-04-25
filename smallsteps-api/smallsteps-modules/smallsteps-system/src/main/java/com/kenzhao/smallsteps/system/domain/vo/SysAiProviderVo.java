package com.kenzhao.smallsteps.system.domain.vo;

import cn.idev.excel.annotation.ExcelIgnoreUnannotated;
import cn.idev.excel.annotation.ExcelProperty;
import com.kenzhao.smallsteps.common.ai.domain.AiProvider;
import io.github.linpeilie.annotations.AutoMapper;
import lombok.Data;

import java.io.Serial;
import java.io.Serializable;
import java.util.Date;

/**
 * AI供应商视图对象 sys_ai_provider
 *
 * @author kenzhao
 */
@Data
@ExcelIgnoreUnannotated
@AutoMapper(target = AiProvider.class)
public class SysAiProviderVo implements Serializable {

    @Serial
    private static final long serialVersionUID = 1L;

    /** 主键 */
    @ExcelProperty(value = "序号")
    private Long id;

    /** 供应商名称 */
    @ExcelProperty(value = "供应商名称")
    private String name;

    /** 供应商代码 */
    @ExcelProperty(value = "供应商代码")
    private String providerCode;

    /** 类型(openai/azure/sdk) */
    @ExcelProperty(value = "供应商类型")
    private String type;

    /** API地址 */
    @ExcelProperty(value = "API地址")
    private String baseUrl;

    /** 权重 */
    @ExcelProperty(value = "权重")
    private Integer weight;

    /** 状态(0正常 1停用) */
    @ExcelProperty(value = "状态")
    private String status;

    /** 创建时间 */
    @ExcelProperty(value = "创建时间")
    private Date createTime;

}

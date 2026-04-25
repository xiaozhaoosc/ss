package com.kenzhao.smallsteps.system.domain.vo;

import cn.idev.excel.annotation.ExcelIgnoreUnannotated;
import cn.idev.excel.annotation.ExcelProperty;
import com.kenzhao.smallsteps.common.ai.domain.AiRoute;
import io.github.linpeilie.annotations.AutoMapper;
import lombok.Data;

import java.io.Serial;
import java.io.Serializable;
import java.util.Date;

/**
 * AI路由策略视图对象 sys_ai_route
 *
 * @author kenzhao
 */
@Data
@ExcelIgnoreUnannotated
@AutoMapper(target = AiRoute.class)
public class SysAiRouteVo implements Serializable {

    @Serial
    private static final long serialVersionUID = 1L;

    /** 业务场景Key */
    @ExcelProperty(value = "场景Key")
    private String sceneKey;

    /** 路由策略 */
    @ExcelProperty(value = "路由策略")
    private String strategy;

    /** 默认模型ID */
    @ExcelProperty(value = "默认模型ID")
    private Long defaultModelId;

    /** 扩展配置(JSON) */
    @ExcelProperty(value = "扩展配置")
    private String configJson;

    /** 创建时间 */
    @ExcelProperty(value = "创建时间")
    private Date createTime;

}

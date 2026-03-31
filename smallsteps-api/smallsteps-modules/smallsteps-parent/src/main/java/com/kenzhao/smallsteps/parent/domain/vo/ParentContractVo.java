package com.kenzhao.smallsteps.parent.domain.vo;

import cn.idev.excel.annotation.ExcelProperty;
import lombok.Data;

import java.io.Serial;
import java.io.Serializable;

/**
 * 亲子契约视图对象 parent_contract
 *
 * @author 赵轩
 * @date 2026-02-01
 */
@Data
public class ParentContractVo implements Serializable {

    @Serial
    private static final long serialVersionUID = 1L;

    /**
     * 契约ID
     */
    @ExcelProperty(value = "契约ID")
    private Long contractId;

    /**
     * 家长ID
     */
    @ExcelProperty(value = "家长ID")
    private Long parentId;

    /**
     * 儿童ID
     */
    @ExcelProperty(value = "儿童ID")
    private Long childId;

    /**
     * 契约内容
     */
    @ExcelProperty(value = "契约内容")
    private String content;

    /**
     * 签名图片
     */
    @ExcelProperty(value = "签名图片")
    private String signatureImg;

    /**
     * 状态(0草稿 1生效 2终止)
     */
    @ExcelProperty(value = "状态")
    private String status;

}

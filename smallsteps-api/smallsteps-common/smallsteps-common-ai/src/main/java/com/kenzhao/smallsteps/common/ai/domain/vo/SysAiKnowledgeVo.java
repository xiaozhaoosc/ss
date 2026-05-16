package com.kenzhao.smallsteps.common.ai.domain.vo;

import cn.idev.excel.annotation.ExcelIgnoreUnannotated;
import cn.idev.excel.annotation.ExcelProperty;
import com.kenzhao.smallsteps.common.ai.domain.SysAiKnowledge;
import io.github.linpeilie.annotations.AutoMapper;
import lombok.Data;

import java.io.Serial;
import java.io.Serializable;
import java.util.Date;

/**
 * AI知识库视图对象 sys_ai_knowledge
 */
@Data
@ExcelIgnoreUnannotated
@AutoMapper(target = SysAiKnowledge.class)
public class SysAiKnowledgeVo implements Serializable {

    @Serial
    private static final long serialVersionUID = 1L;

    @ExcelProperty(value = "编号")
    private Long id;

    @ExcelProperty(value = "知识标题")
    private String title;

    @ExcelProperty(value = "内容类型")
    private String contentType;

    @ExcelProperty(value = "知识内容")
    private String content;

    @ExcelProperty(value = "关键词")
    private String keywords;

    @ExcelProperty(value = "状态")
    private String status;

    @ExcelProperty(value = "创建者")
    private String createBy;

    @ExcelProperty(value = "创建时间")
    private Date createTime;

    @ExcelProperty(value = "更新者")
    private String updateBy;

    @ExcelProperty(value = "更新时间")
    private Date updateTime;

    @ExcelProperty(value = "备注")
    private String remark;
}

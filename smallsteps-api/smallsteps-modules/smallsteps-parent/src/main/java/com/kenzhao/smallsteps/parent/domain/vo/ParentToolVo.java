package com.kenzhao.smallsteps.parent.domain.vo;

import lombok.Data;

/**
 * 家长辅助工具视图对象
 */
@Data
public class ParentToolVo {

    /**
     * 工具ID
     */
    private Long toolId;

    /**
     * 工具类型
     */
    private String toolType;

    /**
     * 工具名称
     */
    private String toolName;

    /**
     * 工具配置
     */
    private String toolConfig;

    /**
     * 情绪急救包配置
     */
    private String firstAidConfig;

    /**
     * 指南类型
     */
    private String guideType;

    /**
     * 指南标题
     */
    private String guideTitle;

    /**
     * 指南内容
     */
    private String guideContent;

    /**
     * 契约模板ID
     */
    private Long templateId;

    /**
     * 契约模板名称
     */
    private String templateName;

    /**
     * 契约模板内容
     */
    private String templateContent;
}
package com.kenzhao.smallsteps.parent.domain;

import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;

/**
 * 家长辅助工具实体
 */
@Data
@TableName("parent_tool")
public class ParentTool {

    /**
     * 工具ID
     */
    @TableId
    private Long toolId;

    /**
     * 用户ID
     */
    private Long userId;

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

    /**
     * 创建时间
     */
    private String createTime;

    /**
     * 更新时间
     */
    private String updateTime;
}
package com.kenzhao.smallsteps.parent.domain;

import com.kenzhao.smallsteps.common.mybatis.core.domain.BaseEntity;

/**
 * 情绪急救包配置
 */
public class ParentEmotionKit extends BaseEntity {
    private static final long serialVersionUID = 1L;

    /** 急救包ID */
    private Long kitId;

    /** 孩子ID */
    private Long childId;

    /** 急救包名称 */
    private String kitName;

    /** 情绪类型 (1-开心, 2-难过, 3-愤怒, 4-焦虑, 5-平静) */
    private Integer emotionType;

    /** 急救包内容 */
    private String content;

    /** 启用状态 (0-禁用, 1-启用) */
    private Integer status;

    // getter and setter methods
    public Long getKitId() {
        return kitId;
    }

    public void setKitId(Long kitId) {
        this.kitId = kitId;
    }

    public Long getChildId() {
        return childId;
    }

    public void setChildId(Long childId) {
        this.childId = childId;
    }

    public String getKitName() {
        return kitName;
    }

    public void setKitName(String kitName) {
        this.kitName = kitName;
    }

    public Integer getEmotionType() {
        return emotionType;
    }

    public void setEmotionType(Integer emotionType) {
        this.emotionType = emotionType;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public Integer getStatus() {
        return status;
    }

    public void setStatus(Integer status) {
        this.status = status;
    }
}

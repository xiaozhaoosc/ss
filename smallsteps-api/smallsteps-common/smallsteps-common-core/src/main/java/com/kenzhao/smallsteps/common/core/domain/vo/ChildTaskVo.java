package com.kenzhao.smallsteps.common.core.domain.vo;

import lombok.Data;
import lombok.EqualsAndHashCode;

/**
 * 儿童任务视图对象 (包含硬件反馈信息)
 */
@Data
public class ChildTaskVo {

    private Long childTaskId;
    private Long taskId;
    private Long childId;
    private String status;

    /**
     * 绑定的母版任务信息
     */
    private ParentTaskVo taskDefinition;

    /**
     * 快捷访问：灯光效果
     */
    public String getLightEffect() {
        return taskDefinition != null ? taskDefinition.getLightEffect() : null;
    }

    /**
     * 快捷访问：音频索引
     */
    public String getAudioEffect() {
        return taskDefinition != null ? taskDefinition.getAudioIndex() : null;
    }
}

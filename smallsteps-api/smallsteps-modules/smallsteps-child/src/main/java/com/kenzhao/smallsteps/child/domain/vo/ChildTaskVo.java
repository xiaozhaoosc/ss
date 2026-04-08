package com.kenzhao.smallsteps.child.domain.vo;

import com.kenzhao.smallsteps.child.domain.ChildTask;
import com.kenzhao.smallsteps.parent.domain.vo.ParentTaskVo;
import lombok.Data;
import lombok.EqualsAndHashCode;

/**
 * 儿童任务视图对象 (包含硬件反馈信息)
 */
@Data
@EqualsAndHashCode(callSuper = true)
public class ChildTaskVo extends ChildTask {

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
        return taskDefinition != null ? taskDefinition.getAudioEffect() : null;
    }
}

package com.kenzhao.smallsteps.child.domain.bo;

import lombok.Data;

/**
 * 儿童 AI 伴侣业务对象
 */
@Data
public class ChildAIBo {

    /**
     * 用户ID
     */
    private Long userId;

    /**
     * 语音输入
     */
    private String voiceInput;

    /**
     * 文本输入
     */
    private String textInput;

    /**
     * 情绪状态
     */
    private String emotionState;

    /**
     * 场景类型
     */
    private String sceneType;
}
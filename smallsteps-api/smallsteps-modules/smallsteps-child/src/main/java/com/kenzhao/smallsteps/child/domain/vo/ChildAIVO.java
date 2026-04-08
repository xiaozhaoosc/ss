package com.kenzhao.smallsteps.child.domain.vo;

import lombok.Data;

/**
 * 儿童 AI 伴侣视图对象
 */
@Data
public class ChildAIVO {

    /**
     * 响应文本
     */
    private String responseText;

    /**
     * 语音响应
     */
    private String voiceResponse;

    /**
     * 情绪识别结果
     */
    private String emotionResult;

    /**
     * 个性化建议
     */
    private String suggestion;

    /**
     * 场景类型
     */
    private String sceneType;

    /**
     * 时间戳
     */
    private String timestamp;
}
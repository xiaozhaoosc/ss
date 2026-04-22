package com.kenzhao.smallsteps.child.service;

/**
 * 情绪追踪Service接口
 */
public interface IChildEmotionService {

    /**
     * 保存儿童情绪切片
     */
    void saveEmotion(Long childId, Integer moodLevel, String moodType, String description);
}

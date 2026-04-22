package com.kenzhao.smallsteps.child.service.impl;

import com.kenzhao.smallsteps.child.service.IChildEmotionService;
import org.springframework.stereotype.Service;

@Service
public class ChildEmotionServiceImpl implements IChildEmotionService {

    @Override
    public void saveEmotion(Long childId, Integer moodLevel, String moodType, String description) {
        // 1. Convert DTO/params to entity EmotionRecord
        // 2. Set recordTime = now(), isRead = "0"
        // 3. Save to ss_emotion_record table via mapper
    }
}

package com.kenzhao.smallsteps.child.service.impl;

import com.kenzhao.smallsteps.child.service.IChildEmotionService;
import com.kenzhao.smallsteps.child.mapper.EmotionRecordMapper;
import com.kenzhao.smallsteps.common.ss.domain.EmotionRecord;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.Date;

@RequiredArgsConstructor
@Service
public class ChildEmotionServiceImpl implements IChildEmotionService {

    private final EmotionRecordMapper emotionRecordMapper;

    @Override
    public void saveEmotion(Long childId, Integer moodLevel, String moodType, String description) {
        EmotionRecord record = new EmotionRecord();
        record.setChildId(childId);
        record.setMoodLevel(moodLevel);
        record.setMoodType(moodType);
        record.setDescription(description);
        record.setIsRead("0");
        record.setRecordTime(new Date());
        emotionRecordMapper.insert(record);
    }
}

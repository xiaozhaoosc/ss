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

    @Override
    public java.util.List<java.util.Map<String, Object>> getShadowEmotionStats(Long childId, Integer days) {
        if (days == null) days = 7;
        java.util.Date startTime = new java.util.Date(System.currentTimeMillis() - days * 24L * 3600 * 1000);
        
        java.util.List<EmotionRecord> records = emotionRecordMapper.selectList(
            new com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper<EmotionRecord>()
                .eq(EmotionRecord::getChildId, childId)
                .ge(EmotionRecord::getRecordTime, startTime)
                .orderByAsc(EmotionRecord::getRecordTime)
        );

        // 按日期分组统计
        java.util.Map<java.time.LocalDate, java.util.List<EmotionRecord>> grouped = records.stream()
            .filter(r -> r.getRecordTime() != null)
            .collect(java.util.stream.Collectors.groupingBy(r -> 
                r.getRecordTime().toInstant().atZone(java.time.ZoneId.systemDefault()).toLocalDate()));

        java.util.List<java.util.Map<String, Object>> result = new java.util.ArrayList<>();
        java.time.LocalDate today = java.time.LocalDate.now();

        for (int i = days - 1; i >= 0; i--) {
            java.time.LocalDate date = today.minusDays(i);
            java.util.List<EmotionRecord> dayRecords = grouped.getOrDefault(date, new java.util.ArrayList<>());

            double avgMood = dayRecords.stream()
                .mapToInt(r -> r.getMoodLevel() != null ? r.getMoodLevel() : 3)
                .average().orElse(0.0);
            
            long frustrationCount = dayRecords.stream()
                .filter(r -> "frustrated".equalsIgnoreCase(r.getMoodType()))
                .count();

            java.util.Map<String, Object> dayMap = new java.util.HashMap<>();
            dayMap.put("date", date.toString());
            dayMap.put("dayLabel", date.getDayOfWeek().getDisplayName(java.time.format.TextStyle.SHORT, java.util.Locale.CHINESE));
            dayMap.put("avgMood", Math.round(avgMood * 10) / 10.0);
            dayMap.put("frustrationCount", frustrationCount);
            result.add(dayMap);
        }

        return result;
    }
}

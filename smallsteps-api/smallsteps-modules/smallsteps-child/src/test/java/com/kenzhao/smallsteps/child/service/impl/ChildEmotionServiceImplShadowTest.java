//package com.kenzhao.smallsteps.child.service.impl;
//
//import com.kenzhao.smallsteps.child.mapper.EmotionRecordMapper;
//import com.kenzhao.smallsteps.common.ss.domain.EmotionRecord;
//import org.junit.jupiter.api.BeforeEach;
//import org.junit.jupiter.api.Test;
//import org.junit.jupiter.api.extension.ExtendWith;
//import org.mockito.InjectMocks;
//import org.mockito.Mock;
//import org.mockito.junit.jupiter.MockitoExtension;
//
//import java.util.*;
//
//import static org.junit.jupiter.api.Assertions.*;
//import static org.mockito.ArgumentMatchers.*;
//import static org.mockito.Mockito.*;
//
///**
// * 影子观察者情绪统计服务测试
// */
//@ExtendWith(MockitoExtension.class)
//public class ChildEmotionServiceImplShadowTest {
//
//    @InjectMocks
//    private ChildEmotionServiceImpl service;
//
//    @Mock
//    private EmotionRecordMapper emotionRecordMapper;
//
//    /**
//     * TC-B01: 跨天数据聚合测试
//     * 验证 getShadowEmotionStats 返回正确的聚合数据
//     */
//    @Test
//    public void testGetShadowEmotionStats_AggregatesDataByDay() {
//        // 准备测试数据 - 创建3天的记录
//        List<EmotionRecord> mockRecords = new ArrayList<>();
//        Date today = new Date();
//        long dayMs = 24L * 3600 * 1000;
//
//        // 第一天（2天前）
//        mockRecords.add(createEmotionRecord(1L, 2, "frustrated", today.getTime() - 2 * dayMs));
//        mockRecords.add(createEmotionRecord(1L, 3, "normal", today.getTime() - 2 * dayMs));
//
//        // 第二天（1天前）
//        mockRecords.add(createEmotionRecord(1L, 1, "happy", today.getTime() - 1 * dayMs));
//        mockRecords.add(createEmotionRecord(1L, 2, "frustrated", today.getTime() - 1 * dayMs));
//        mockRecords.add(createEmotionRecord(1L, 2, "frustrated", today.getTime() - 1 * dayMs));
//
//        // 今天
//        mockRecords.add(createEmotionRecord(1L, 4, "calm", today.getTime()));
//
//        // Mock 查询
//        when(emotionRecordMapper.selectList(any())).thenReturn(mockRecords);
//
//        // 执行测试 - 获取7天数据
//        List<Map<String, Object>> result = service.getShadowEmotionStats(1L, 7);
//
//        // 验证结果
//        assertNotNull(result);
//        assertEquals(7, result.size()); // 应该返回7天
//
//        // 验证聚合逻辑
//        Map<String, Object> twoDaysAgo = result.get(5); // 倒数第2天
//        Map<String, Object> oneDayAgo = result.get(6);  // 倒数第1天（昨天）
//
//        // 验证前两天前的数据
//        assertEquals(2, twoDaysAgo.get("frustrationCount")); // 1条 frustrated
//        double avgMoodTwoDays = ((Number) twoDaysAgo.get("avgMood")).doubleValue();
//        assertEquals(2.5, avgMoodTwoDays, 0.1); // (2+3)/2 = 2.5
//
//        // 验证昨天的数据
//        assertEquals(2, oneDayAgo.get("frustrationCount")); // 2条 frustrated
//        double avgMoodOneDay = ((Number) oneDayAgo.get("avgMood")).doubleValue();
//        assertEquals(1.67, avgMoodOneDay, 0.01); // (1+2+2)/3 ≈ 1.67
//    }
//
//    /**
//     * 测试空数据情况
//     */
//    @Test
//    public void testGetShadowEmotionStats_NoData() {
//        when(emotionRecordMapper.selectList(any())).thenReturn(new ArrayList<>());
//
//        List<Map<String, Object>> result = service.getShadowEmotionStats(1L, 3);
//
//        assertNotNull(result);
//        assertEquals(3, result.size());
//
//        // 验证空数据的默认值
//        for (Map<String, Object> dayData : result) {
//            assertEquals(0.0, dayData.get("avgMood"));
//            assertEquals(0L, dayData.get("frustrationCount"));
//        }
//    }
//
//    /**
//     * 测试 days 参数为空时使用默认值
//     */
//    @Test
//    public void testGetShadowEmotionStats_DefaultDays() {
//        when(emotionRecordMapper.selectList(any())).thenReturn(new ArrayList<>());
//
//        List<Map<String, Object>> result = service.getShadowEmotionStats(1L, null);
//
//        assertNotNull(result);
//        assertEquals(7, result.size()); // 默认7天
//    }
//
//    /**
//     * 测试情绪记录保存
//     */
//    @Test
//    public void testSaveEmotion_SavesRecord() {
//        EmotionRecord savedRecord = null;
//
//        doAnswer(invocation -> {
//            EmotionRecord record = invocation.getArgument(0);
//            savedRecord = record;
//            return 1;
//        }).when(emotionRecordMapper).insert(any(EmotionRecord.class));
//
//        // 执行保存
//        service.saveEmotion(1L, 2, "frustrated", "测试描述");
//
//        // 验证保存的数据
//        assertNotNull(savedRecord);
//        assertEquals(1L, savedRecord.getChildId());
//        assertEquals(2, savedRecord.getMoodLevel());
//        assertEquals("frustrated", savedRecord.getMoodType());
//        assertEquals("测试描述", savedRecord.getDescription());
//        assertEquals("0", savedRecord.getIsRead());
//        assertNotNull(savedRecord.getRecordTime());
//    }
//
//    /**
//     * 创建测试用的情绪记录
//     */
//    private EmotionRecord createEmotionRecord(Long childId, Integer moodLevel, String moodType, long timestamp) {
//        EmotionRecord record = new EmotionRecord();
//        record.setChildId(childId);
//        record.setMoodLevel(moodLevel);
//        record.setMoodType(moodType);
//        record.setRecordTime(new Date(timestamp));
//        return record;
//    }
//}

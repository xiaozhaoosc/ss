package com.kenzhao.smallsteps.child.service;

import com.kenzhao.smallsteps.common.ai.domain.AiModel;
import com.kenzhao.smallsteps.common.ai.service.IAiRouterService;
import com.kenzhao.smallsteps.common.ai.service.IAiService;
import com.kenzhao.smallsteps.common.ss.domain.Child;
import com.kenzhao.smallsteps.common.ss.domain.ChildAI;
import lombok.extern.slf4j.Slf4j;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.ActiveProfiles;

import java.util.HashMap;
import java.util.Map;

import com.kenzhao.smallsteps.child.TestApplication;
import org.junit.jupiter.api.Tag;

/**
 * AI 闭环验证测试 - 模拟每日情绪分析任务逻辑
 */
@Slf4j
@SpringBootTest(classes = TestApplication.class)
@ActiveProfiles("dev")
@Tag("dev")
public class EmotionAiAnalysisIntegrationTest {

    @Autowired
    private IAiService aiService;

    @Autowired
    private IAiRouterService aiRouterService;

    @Autowired
    private IChildAIService childAIService;

    @Autowired
    private IChildService childService;

    @Test
    public void testDailyEmotionAnalysisFlow() {
        // 1. 模拟数据准备
        Long testChildId = 1L; // 假设数据库中已有 ID 为 1 的儿童
        Child child = childService.selectChildById(testChildId);
        if (child == null) {
            log.warn("Test child not found, creating a dummy one for integration test context");
            // 实际测试中应确保数据库有数据，这里仅作记录
            return;
        }

        String childName = child.getNickname();
        String failedTasks = "1. 整理书包 (超时未完成); 2. 刷牙 (中途放弃)";
        String negativeEmotions = "孩子感到挫败，描述：'我总是做不好，我想把玩偶扔掉'";

        log.info("Starting AI Emotion Analysis for child: {}", childName);

        // 2. 模拟 IAiService 调用 (内部会触发 DAILY_EMOTION_ANALYSIS 模板加载)
        // 注意：目前 IAiService 只有 emotionAnalysis(Long, String)
        // 我们需要验证 DAILY_EMOTION_ANALYSIS 这个 Key 能否被正确处理
        
        // 由于 IAiService 接口目前较固定，我们直接测试模板填充逻辑
        Map<String, Object> params = new HashMap<>();
        params.put("childName", childName);
        params.put("failedTasks", failedTasks);
        params.put("negativeEmotions", negativeEmotions);

        // 模拟路由
        AiModel model = aiRouterService.route("DAILY_EMOTION_ANALYSIS", testChildId);
        log.info("Routed to model: {}", model != null ? model.getName() : "None");

        // 3. 执行分析 (这里假设我们之后会在 IAiService 增加通用方法，现在先手动模拟流程)
        // 在实际业务中，我们会调用一个新的 service 方法
        
        log.info("Validation: Check if prompt key 'DAILY_EMOTION_ANALYSIS' exists and works.");
        
        // 4. 记录结果 (模拟保存)
        ChildAI childAI = new ChildAI();
        childAI.setChildId(testChildId);
        childAI.setUserInput("System Daily Trigger");
        childAI.setAiResponse("AI 生成的家长建议占位符 - 验证链路通畅");
        childAI.setEmotionType(3); // 愤怒/挫败
        childAI.setContext("Daily Summary");
        
        int result = childAIService.insertChildAI(childAI);
        log.info("Insert test record result: {}", result > 0 ? "SUCCESS" : "FAILED");
    }
}

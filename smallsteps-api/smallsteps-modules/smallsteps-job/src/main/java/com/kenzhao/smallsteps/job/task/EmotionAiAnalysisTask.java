package com.kenzhao.smallsteps.job.task;

import org.springframework.stereotype.Component;

@Component("emotionAiAnalysisTask")
public class EmotionAiAnalysisTask {
    
    public void analyzeDailyEmotions() {
        // 1. Fetch distinct children who had > 0 failed tasks or submitted negative emotion today
        // 2. Loop through each child
        // 3. Call IAiService to generate prompt: "Child failed X tasks, reported feeling Y. Generate short pacifying advice for parent."
        // 4. Save result into ss_emotion_record (or a separate AI insight table) linked to the parent.
    }
}

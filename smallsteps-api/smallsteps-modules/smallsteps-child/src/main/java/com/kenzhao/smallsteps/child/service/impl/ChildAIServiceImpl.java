package com.kenzhao.smallsteps.child.service.impl;

import com.kenzhao.smallsteps.child.domain.bo.ChildAIBo;
import com.kenzhao.smallsteps.child.domain.vo.ChildAIVO;
import com.kenzhao.smallsteps.child.service.IChildAIService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

/**
 * 儿童 AI 伴侣服务实现
 */
@Service
@RequiredArgsConstructor
public class ChildAIServiceImpl implements IChildAIService {

    @Override
    public ChildAIVO chat(ChildAIBo bo) {
        ChildAIVO vo = new ChildAIVO();
        vo.setResponseText(getChatResponse(bo.getTextInput()));
        vo.setVoiceResponse("voice_response_url");
        vo.setSceneType(bo.getSceneType());
        vo.setTimestamp(LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss")));
        return vo;
    }

    @Override
    public ChildAIVO recognizeEmotion(ChildAIBo bo) {
        ChildAIVO vo = new ChildAIVO();
        vo.setEmotionResult(getEmotionResult(bo.getEmotionState()));
        vo.setSuggestion(getEmotionSuggestion(bo.getEmotionState()));
        vo.setSceneType(bo.getSceneType());
        vo.setTimestamp(LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss")));
        return vo;
    }

    @Override
    public ChildAIVO getSuggestion(Long userId) {
        ChildAIVO vo = new ChildAIVO();
        vo.setSuggestion("每天坚持完成一个小任务，你会变得越来越棒！");
        vo.setResponseText("小步相信你可以做到的！");
        vo.setSceneType("daily");
        vo.setTimestamp(LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss")));
        return vo;
    }

    /**
     * 获取聊天响应
     */
    private String getChatResponse(String input) {
        if (input == null || input.isEmpty()) {
            return "你好！有什么可以帮助你的吗？";
        }

        input = input.toLowerCase();
        if (input.contains("你好") || input.contains("hi") || input.contains("hello")) {
            return "你好！很高兴见到你！";
        } else if (input.contains("任务") || input.contains("作业")) {
            return "让我们一起完成任务吧！你可以的！";
        } else if (input.contains("困难") || input.contains("难")) {
            return "别担心，我们可以把它分解成小步骤，一步一步来！";
        } else if (input.contains("开心") || input.contains("高兴")) {
            return "看到你开心，我也很开心！";
        } else if (input.contains("伤心") || input.contains("难过")) {
            return "别难过，我在这里陪着你。";
        } else {
            return "很有趣的想法！让我们一起探索吧！";
        }
    }

    /**
     * 获取情绪识别结果
     */
    private String getEmotionResult(String emotionState) {
        if (emotionState == null || emotionState.isEmpty()) {
            return "中性";
        }

        emotionState = emotionState.toLowerCase();
        if (emotionState.contains("开心") || emotionState.contains("高兴") || emotionState.contains("快乐")) {
            return "开心";
        } else if (emotionState.contains("伤心") || emotionState.contains("难过") || emotionState.contains("悲伤")) {
            return "伤心";
        } else if (emotionState.contains("生气") || emotionState.contains("愤怒")) {
            return "生气";
        } else if (emotionState.contains("焦虑") || emotionState.contains("担心")) {
            return "焦虑";
        } else {
            return "中性";
        }
    }

    /**
     * 获取情绪建议
     */
    private String getEmotionSuggestion(String emotionState) {
        if (emotionState == null || emotionState.isEmpty()) {
            return "保持好心情！";
        }

        emotionState = emotionState.toLowerCase();
        if (emotionState.contains("开心") || emotionState.contains("高兴") || emotionState.contains("快乐")) {
            return "继续保持这份好心情！";
        } else if (emotionState.contains("伤心") || emotionState.contains("难过") || emotionState.contains("悲伤")) {
            return "试试深呼吸，或者做一些你喜欢的事情。";
        } else if (emotionState.contains("生气") || emotionState.contains("愤怒")) {
            return "先深呼吸，数到十，然后我们再一起解决问题。";
        } else if (emotionState.contains("焦虑") || emotionState.contains("担心")) {
            return "把问题分解成小步骤，一步一步来，你可以的！";
        } else {
            return "保持好心情！";
        }
    }
}
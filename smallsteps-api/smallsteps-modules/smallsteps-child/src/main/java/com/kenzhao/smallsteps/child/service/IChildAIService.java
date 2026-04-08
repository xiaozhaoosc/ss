package com.kenzhao.smallsteps.child.service;

import com.kenzhao.smallsteps.child.domain.bo.ChildAIBo;
import com.kenzhao.smallsteps.child.domain.vo.ChildAIVO;

/**
 * 儿童 AI 伴侣服务接口
 */
public interface IChildAIService {

    /**
     * 语音互动
     */
    ChildAIVO chat(ChildAIBo bo);

    /**
     * 情绪识别
     */
    ChildAIVO recognizeEmotion(ChildAIBo bo);

    /**
     * 个性化建议
     */
    ChildAIVO getSuggestion(Long userId);
}
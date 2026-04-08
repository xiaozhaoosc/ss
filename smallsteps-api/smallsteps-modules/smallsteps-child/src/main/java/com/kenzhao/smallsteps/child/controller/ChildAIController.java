package com.kenzhao.smallsteps.child.controller;

import com.kenzhao.smallsteps.common.core.domain.R;
import com.kenzhao.smallsteps.child.domain.bo.ChildAIBo;
import com.kenzhao.smallsteps.child.domain.vo.ChildAIVO;
import com.kenzhao.smallsteps.child.service.IChildAIService;
import jakarta.validation.constraints.NotNull;
import lombok.RequiredArgsConstructor;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

/**
 * 儿童 AI 伴侣
 */
@Validated
@RequiredArgsConstructor
@RestController
@RequestMapping("/child/ai")
public class ChildAIController {

    private final IChildAIService childAIService;

    /**
     * 语音互动
     */
    @PostMapping("/chat")
    public R<ChildAIVO> chat(@RequestBody ChildAIBo bo) {
        return R.ok(childAIService.chat(bo));
    }

    /**
     * 情绪识别
     */
    @PostMapping("/emotion")
    public R<ChildAIVO> recognizeEmotion(@RequestBody ChildAIBo bo) {
        return R.ok(childAIService.recognizeEmotion(bo));
    }

    /**
     * 个性化建议
     */
    @GetMapping("/suggestion")
    public R<ChildAIVO> getSuggestion(@RequestParam Long userId) {
        return R.ok(childAIService.getSuggestion(userId));
    }
}
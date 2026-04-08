package com.kenzhao.smallsteps.child.controller;

import com.kenzhao.smallsteps.common.core.domain.R;
import org.springframework.web.bind.annotation.*;

/**
 * 儿童端AI伴侣控制器
 */
@RestController
@RequestMapping("/child/ai")
public class ChildAIController {

    /**
     * 与AI对话
     */
    @PostMapping("/chat")
    public R<?> chat(@RequestBody ChatRequest request) {
        // TODO: 实现与AI对话的逻辑
        return R.ok("与AI对话成功");
    }

    /**
     * 获取AI建议
     */
    @GetMapping("/suggestion")
    public R<?> getSuggestion() {
        // TODO: 实现获取AI建议的逻辑
        return R.ok("获取AI建议成功");
    }

    // 请求参数类
    public static class ChatRequest {
        private String message;

        public String getMessage() {
            return message;
        }

        public void setMessage(String message) {
            this.message = message;
        }
    }
}

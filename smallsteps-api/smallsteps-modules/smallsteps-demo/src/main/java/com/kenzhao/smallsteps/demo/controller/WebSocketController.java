package com.kenzhao.smallsteps.demo.controller;

import com.kenzhao.smallsteps.common.core.domain.R;
import com.kenzhao.smallsteps.common.websocket.dto.WebSocketMessageDto;
import com.kenzhao.smallsteps.common.websocket.utils.WebSocketUtils;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

/**
 * WebSocket 演示案例
 *
 * @author 赵轩
 */
@RequiredArgsConstructor
@RestController
@RequestMapping("/demo/websocket")
@Slf4j
public class WebSocketController {

    /**
     * 发布消息
     *
     * @param dto 发送内容
     */
    @GetMapping("/send")
    public R<Void> send(WebSocketMessageDto dto) throws InterruptedException {
        WebSocketUtils.publishMessage(dto);
        return R.ok("操作成功");
    }
}

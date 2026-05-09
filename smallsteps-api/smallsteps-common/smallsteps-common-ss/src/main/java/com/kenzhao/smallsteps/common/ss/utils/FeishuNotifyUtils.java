package com.kenzhao.smallsteps.common.ss.utils;

import cn.hutool.http.HttpUtil;
import cn.hutool.json.JSONUtil;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;

import java.util.HashMap;
import java.util.Map;

/**
 * 飞书通知工具类
 */
@Slf4j
@Component
public class FeishuNotifyUtils {

    @Value("${feishu.webhook.url:https://open.feishu.cn/open-apis/bot/v2/hook/placeholder}")
    private String webhookUrl;

    /**
     * 发送文本消息
     */
    public void sendTextMessage(String title, String content) {
        try {
            Map<String, Object> msg = new HashMap<>();
            msg.put("msg_type", "post");
            
            Map<String, Object> contentMap = new HashMap<>();
            Map<String, Object> postMap = new HashMap<>();
            Map<String, Object> zhCnMap = new HashMap<>();
            
            zhCnMap.put("title", title);
            
            Object[][] contentArr = new Object[1][1];
            Map<String, String> textMap = new HashMap<>();
            textMap.put("tag", "text");
            textMap.put("text", content);
            contentArr[0][0] = textMap;
            
            zhCnMap.put("content", contentArr);
            postMap.put("zh_cn", zhCnMap);
            contentMap.put("post", postMap);
            msg.put("content", contentMap);

            String body = JSONUtil.toJsonStr(msg);
            log.info("Sending Feishu notification: {}", body);
            
            if (webhookUrl.contains("placeholder")) {
                log.warn("Feishu Webhook URL is not configured, skipping send.");
                return;
            }
            
            String result = HttpUtil.post(webhookUrl, body);
            log.info("Feishu notification result: {}", result);
        } catch (Exception e) {
            log.error("Failed to send Feishu notification", e);
        }
    }
}

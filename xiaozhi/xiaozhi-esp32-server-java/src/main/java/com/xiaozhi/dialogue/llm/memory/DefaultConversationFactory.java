package com.xiaozhi.dialogue.llm.memory;

import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Primary;
import org.springframework.stereotype.Service;
import com.xiaozhi.entity.SysDevice;
import com.xiaozhi.entity.SysRole;

@Primary
@Service
@Slf4j
public class DefaultConversationFactory implements ConversationFactory{

    @Value("${conversation.max-messages:16}")
    private int maxMessages;

    @Autowired
    private ChatMemory chatMemory;

    @Override
    public Conversation initConversation(SysDevice device, SysRole role, String sessionId) {
        Conversation conversation = switch (role.getMemoryType()) {
            case "window"-> MessageWindowConversation.builder().chatMemory(chatMemory)
                    .maxMessages(maxMessages)
                    .role(role)
                    .device(device)
                    .sessionId(sessionId)
                    .build();
            default ->{
                log.warn("系统目前不支持这类未知的记忆类型：{} ， 将启用默认的MessageWindowConversation", role.getMemoryType());
                yield MessageWindowConversation.builder().chatMemory(chatMemory)
                        .maxMessages(maxMessages)
                        .role(role)
                        .device(device)
                        .sessionId(sessionId)
                        .build();
            }
        };
        
        return conversation;

    }
}

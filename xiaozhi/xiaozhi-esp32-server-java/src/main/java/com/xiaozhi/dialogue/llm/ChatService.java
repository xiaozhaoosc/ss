package com.xiaozhi.dialogue.llm;

import com.xiaozhi.communication.common.ChatSession;
import com.xiaozhi.dialogue.llm.factory.ChatModelFactory;
import com.xiaozhi.dialogue.llm.memory.ChatMemory;
import com.xiaozhi.mcp.McpSessionManager;
import com.xiaozhi.dialogue.llm.memory.Conversation;
import jakarta.annotation.Resource;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.ai.chat.messages.AssistantMessage;
import org.springframework.ai.chat.messages.Message;
import org.springframework.ai.chat.messages.UserMessage;
import org.springframework.ai.chat.model.ChatModel;
import org.springframework.ai.chat.model.ChatResponse;
import org.springframework.ai.chat.prompt.ChatOptions;
import org.springframework.ai.chat.prompt.Prompt;
import org.springframework.ai.model.tool.ToolCallingChatOptions;
import org.springframework.ai.model.tool.ToolCallingManager;
import org.springframework.ai.model.tool.ToolExecutionResult;
import org.springframework.util.CollectionUtils;
import org.springframework.stereotype.Service;
import reactor.core.publisher.Flux;

import java.util.ArrayList;
import java.util.List;
import java.util.concurrent.atomic.AtomicBoolean;

/**
 *
 * 负责管理和协调LLM相关功能
 * 未来考虑：改成Domain Entity: ChatRole(聊天角色)，管理对话历史记录，管理对话工具调用等。
 * 未来考虑：在连接通过认证，可正常对话时，创建实例，构建好一个完整的Role。
 */
@Service
public class ChatService {
    private static final Logger logger = LoggerFactory.getLogger(ChatService.class);

    public static final String TOOL_CONTEXT_SESSION_KEY = "session";




    @Resource
    private ChatModelFactory chatModelFactory;

    @Resource
    private McpSessionManager mcpSessionManager;

    @Resource
    private ToolCallingManager toolCallingManager;

    /**
     * 处理用户查询（同步方式）
     * 
     * @param session         会话信息
     * @param message         用户消息
     * @param useFunctionCall 是否使用函数调用
     * @return 模型回复
     */
    public String chat(ChatSession session, String message, boolean useFunctionCall) {
        try {
            if(useFunctionCall){
                //处理mcp自定义
                mcpSessionManager.customMcpHandler(session);
            }

            // 获取ChatModel
            ChatModel chatModel = chatModelFactory.takeChatModel(session);

            // 获取对话时间戳
            Long conversationTimestamp = session.getAssistantTimeMillis();
            if (conversationTimestamp == null) {
                conversationTimestamp = System.currentTimeMillis();
            }

            ChatOptions chatOptions = ToolCallingChatOptions.builder()
                    .toolCallbacks(useFunctionCall && session.isSupportFunctionCall() ? session.getToolCallbacks() : new ArrayList<>())
                    .toolContext(TOOL_CONTEXT_SESSION_KEY, session)
                    .toolContext("conversationTimestamp", conversationTimestamp)
                    .build();

            UserMessage userMessage = new UserMessage(message);
            Long userTimeMillis = System.currentTimeMillis();
            Conversation conversation = session.getConversation();
            conversation.add(userMessage, userTimeMillis);
            List<Message> messages = conversation.messages();
            Prompt prompt = new Prompt(messages,chatOptions);

            ChatResponse chatResponse = chatModel.call(prompt);
            if (chatResponse == null || chatResponse.getResult().getOutput().getText() == null) {
                logger.warn("模型响应为空或无生成内容");
                return "抱歉，我在处理您的请求时遇到了问题。请稍后再试。";
            }
            AssistantMessage assistantMessage = chatResponse.getResult().getOutput();

            // 检查是否有工具调用，如果有则处理工具调用
            if (useFunctionCall && !CollectionUtils.isEmpty(assistantMessage.getToolCalls())) {
                // 使用工具调用管理器处理工具调用
                ToolExecutionResult toolExecutionResult = toolCallingManager.executeToolCalls(prompt, chatResponse);
                
                // 获取工具调用后的最终响应
                List<Message> conversationHistory = toolExecutionResult.conversationHistory();
                if (!conversationHistory.isEmpty()) {
                    Message lastMessage = conversationHistory.get(conversationHistory.size() - 1);
                    if (lastMessage instanceof AssistantMessage) {
                        assistantMessage = (AssistantMessage) lastMessage;
                    }
                }
                
                // 如果工具调用返回直接结果，则直接返回
                if (toolExecutionResult.returnDirect()) {
                    return assistantMessage.getText();
                }
            }

            final AssistantMessage finalAssistantMessage = assistantMessage;
            Thread.startVirtualThread(() -> {// 异步持久化
                // 保存AI消息，会被持久化至数据库。
                session.getConversation().add(finalAssistantMessage,session.getAssistantTimeMillis());
            });
            return assistantMessage.getText();

        } catch (Exception e) {
            logger.error("处理查询时出错: {}", e.getMessage(), e);
            return "抱歉，我在处理您的请求时遇到了问题。请稍后再试。";
        }
    }

    /**
     * 处理用户查询（流式方式）
     *
     * @param userMessage         用户消息
     * @param useFunctionCall 是否使用函数调用
     */
    public Flux<ChatResponse> chatStream(ChatSession session, UserMessage userMessage, boolean useFunctionCall) {
        if(useFunctionCall){
            //处理mcp自定义
            mcpSessionManager.customMcpHandler(session);
        }

        // 获取ChatModel
        ChatModel chatModel = chatModelFactory.takeChatModel(session);

        // 获取对话时间戳
        Long conversationTimestamp = session.getAssistantTimeMillis();
        if (conversationTimestamp == null) {
            conversationTimestamp = System.currentTimeMillis();
        }

        ChatOptions chatOptions = ToolCallingChatOptions.builder()
                .toolCallbacks(useFunctionCall && session.isSupportFunctionCall() ? session.getToolCallbacks() : new ArrayList<>())
                .toolContext(TOOL_CONTEXT_SESSION_KEY, session)
                .toolContext("conversationTimestamp", conversationTimestamp)
                .build();

        Conversation conversation = session.getConversation();
        conversation.add(userMessage, ChatMemory.getTimeMillis(userMessage));
        List<Message> messages = conversation.messages();
        Prompt prompt = new Prompt(messages, chatOptions);

        // 调用实际的流式聊天方法
        return chatModel.stream(prompt);
    }

}
package com.xiaozhi.dialogue.llm.tool.observation;

import com.xiaozhi.communication.common.ChatSession;
import com.xiaozhi.dao.MessageMapper;
import com.xiaozhi.dialogue.llm.memory.ChatMemory;
import com.xiaozhi.dialogue.llm.memory.Conversation;
import com.xiaozhi.dialogue.llm.tool.XiaozhiToolMetadata;
import com.xiaozhi.dialogue.service.Synthesizer;
import com.xiaozhi.entity.SysMessage;
import com.xiaozhi.service.SysMessageService;
import com.xiaozhi.utils.AudioUtils;
import io.micrometer.observation.Observation;
import io.micrometer.observation.ObservationHandler;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.ai.chat.messages.AssistantMessage;
import org.springframework.ai.chat.messages.MessageType;
import org.springframework.ai.chat.messages.UserMessage;
import org.springframework.ai.chat.metadata.ChatGenerationMetadata;
import org.springframework.ai.chat.metadata.Usage;
import org.springframework.ai.chat.model.ChatResponse;
import org.springframework.ai.chat.model.Generation;
import org.springframework.ai.chat.observation.ChatModelObservationContext;
import org.springframework.ai.chat.prompt.Prompt;
import org.springframework.ai.model.tool.ToolCallingChatOptions;
import org.springframework.ai.model.tool.ToolExecutionResult;
import org.springframework.ai.tool.ToolCallback;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.util.Assert;
import org.springframework.util.StringUtils;

import java.nio.file.Path;
import java.time.Instant;
import java.time.temporal.ChronoUnit;
import java.util.Date;
import java.util.List;
import java.util.Map;

/**
 * 在这里进行AssistantMessage消息的处理。
 * 这里所获得的ChatResponse对象实例实际是来自于 MessageAggregator 所聚合的，即使在stream调用里也是生效的。
 * @see new MessageAggregator().aggregate(chatResponseFlux, observationContext::setResponse);
 *
 * 在 观察者 onStop时，可从Context里获得Request与Response。当前只是在这里保存Assistant消息,具体的细节逻辑，由Conversation处理。
 * TODO 将入库持久化的职能移至此处，可统一在此class保存用户输入与Ai输出。避免逻辑过于分散。
 * 注意：Message在没有持久化前，是不会有messageId的。需要依靠createTime标识消息唯一性。
 * 问：是否需要把content为空和角色为tool的入库?
 * 答：目前不入库（这类主要是function_call的二次调用llm进行总结时的过程消息）。TODO 未来可考虑将工具结果也一起入库。
 *
 * TODO 考虑将 时间戳 移至此处，避免散落在其它地方。
 * 需要时间戳的场景：
 * 1. 数据库表的createTime字段。
 * 2. 音频文件存储。（当前是在Player保存为本地文件）如何确保Player能拿到 时间戳？ 办法一：setter 至Synthesizer and Player。
 *
 * 此类仅记录相关信息，但不能反向影响业务逻辑。也就是必须假设拆除此class，不影响对话。
 * 这个假设不成立，因为AssistantMessage 将会由此Handler 添加回到 Conversation 进而影响下一轮对话
 * 参考PromptChatMemoryAdvisor，它在LLM流式输出时是如何添加消息至 Conversation的？
 *
 */
@Component
public class ChatModelObservationHandler  implements ObservationHandler<ChatModelObservationContext> {
    private static final Logger logger = LoggerFactory.getLogger(ChatModelObservationHandler.class);

    @Autowired
    private SysMessageService sysMessageService;

    @Autowired
    private MessageMapper messageMapper;

    @Override
    public boolean supportsContext(Observation.Context context) {
        return context instanceof ChatModelObservationContext;
    }

    @Override
    public void onStop(ChatModelObservationContext context) {

        ChatSession session = checkoutChatSession(context);
        if(session==null){
            logger.info("此次大模型调用时，没有找到ChatSession信息,不属于正常对话聊天，不持久化消息");
            return;
        }

        // 获取UserMessage
        UserMessage userMessage = context.getRequest().getUserMessage();

        ChatResponse chatResponse = context.getResponse();
        Assert.notNull(chatResponse, "ChatResponse is null from ChatModelObservationContext");
        logger.info("Chat Model Completion:\n{}", chatResponse);
        Generation generation = chatResponse.getResult();
        Assert.notNull(generation, "Generation is null from ChatResponse");

        // 获取最后的完整的AssistantMessage
        AssistantMessage assistantMessage = generation.getOutput();

        // 判断用户消息是否属于可能影响后续对话效果的指令
        ChatGenerationMetadata generationMetadata = generation.getMetadata();
        List<ToolCallback> toolCallbacks = session.getToolCallbacks();
        boolean isFunctionCalling = isFunctionCalling(generationMetadata, toolCallbacks);

        // 获取Token Usage （算力消耗）
        Usage llmUsage = chatResponse.getMetadata().getUsage();
        Assert.notNull(llmUsage, "Usage is null from ChatResponse.Metadata");
        logger.debug("Usage: {}", llmUsage);


        Long assistantTimeMillis = session.getAssistantTimeMillis();
        Conversation conversation = session.getConversation();
        if(isFunctionCalling){
            conversation.add(Conversation.ROLLBACK_MESSAGE, assistantTimeMillis);
        }else{
            conversation.add(assistantMessage, assistantTimeMillis);
        }


        String sysMessageType = isFunctionCalling? SysMessage.MESSAGE_TYPE_FUNCTION_CALL: SysMessage.MESSAGE_TYPE_NORMAL;

        // 首次模型响应时间、首次TTS响应时间都是AssistantMessage才具备的metadata，UserMessage没有实际也不应该有。
        Synthesizer synthesizer = session.getSynthesizer();
        int firstChatDurationMillis = synthesizer!=null? synthesizer.getFirstChatDurationMillis():0;

        List<SysMessage> messageList = List.of(userMessage, assistantMessage).stream()
                .map(msg -> {
                    SysMessage message = new SysMessage();
                    message.setDeviceId(conversation.device().getDeviceId());
                    message.setSessionId(conversation.sessionId());
                    message.setSender(msg.getMessageType().getValue());
                    message.setMessage(msg.getText());
                    message.setRoleId(conversation.role().getRoleId());
                    message.setMessageType(sysMessageType);
                    Long timeMillis = ChatMemory.getTimeMillis(msg);
                    // TODO 这个时间戳 转换后丢失精度容易出现错误。
                    Instant instant = Instant.ofEpochMilli(timeMillis).truncatedTo(ChronoUnit.SECONDS);
                    message.setCreateTime(Date.from(instant));

                    //设置 message的tokens用量，用于统计成本（计费）。
                    switch (msg.getMessageType()) {
                        case USER:
                            message.setTokens(llmUsage.getPromptTokens());
                            break;
                        case ASSISTANT:
                            message.setTokens(llmUsage.getCompletionTokens());
                            break;
                        default:
                            message.setTokens(0);
                    }

                    // TTFStime: 模型回复的时间（模型响应时间）
                    message.setTtfsTime(firstChatDurationMillis);
                    // responseTime: 音频出声的时间（流式TTS首帧延迟时间）。这个时刻很可能还没有完成TTS,后续更新
                    message.setResponseTime(0);

                    return message;
                }).toList();
        saveMessage(messageList);
        updateMessage(session, userMessage);
    }

    /**
     * 检查元数据中是否包含工具调用标识。这里的“工具调用”指的是那些会影响对话效果的工具消息，例如“退出”、“切换角色”。
     * 这些的特殊用户指令会污染后续对话效果。
     * 有些工具调用的结果直接作为AssistantMessage加入对话历史并不会影响对话效果。它的AssistantMessage为正常消息。
     * @param generationMetadata
     * @param toolCallbacks
     * @return
     */
    private boolean isFunctionCalling(ChatGenerationMetadata generationMetadata, List<ToolCallback> toolCallbacks){
        if(ToolExecutionResult.FINISH_REASON.equals(generationMetadata.getFinishReason())){
            String toolId = generationMetadata.get(ToolExecutionResult.METADATA_TOOL_ID);
            String toolName = generationMetadata.get(ToolExecutionResult.METADATA_TOOL_NAME);
            logger.info("工具调用id: {} , name: {}", toolId,toolName);

            if (StringUtils.hasText(toolName) &&
                    toolCallbacks.stream()
                            .filter(toolCallback -> toolCallback.getToolDefinition().name().equals(toolName))
                            .map(toolCallback -> toolCallback.getToolMetadata())
                            .filter(toolMetadata -> toolMetadata instanceof XiaozhiToolMetadata)
                            .map(toolMetadata -> (XiaozhiToolMetadata) toolMetadata)
                            .anyMatch(xiaozhiToolMetadata -> xiaozhiToolMetadata.rollback())) {
                logger.info("当前用户消息属于可能影响后续对话效果的指令`{}`，准备执行回滚。", toolName);
                return true;
            }
        }
        return false;
    }

    /**
     * 获取ChatSession
     */
    private ChatSession checkoutChatSession(ChatModelObservationContext context) {
        Prompt prompt = context.getRequest();
        if (prompt.getOptions() instanceof ToolCallingChatOptions toolCallingChatOptions) {
            Map<String, Object> toolContext = toolCallingChatOptions.getToolContext();
            if (toolContext != null && toolContext.containsKey("session")) {
                Object sessionObj = toolContext.get("session");
                if (sessionObj instanceof com.xiaozhi.communication.common.ChatSession chatSession) {
                    return chatSession;
                }
            }
        }
        return null;
    }

    /**
     * 更新消息表 用户消息的路径、时长信息
     * TODO  等消息持久化 迁移至此处时，再执行此方法。在onStop方法里。
     * @param session
     * @param userMessage
     */
    private void updateMessage(ChatSession session, UserMessage userMessage) {
        Path path = session.getAudioPath(MessageType.USER.getValue(), ChatMemory.getTimeMillis(userMessage));
        //更新消息表路径、时长信息
        String deviceId = session.getSysDevice().getDeviceId().replace("-", ":");
        Integer roleId = session.getSysDevice().getRoleId();
        String fileName = path.getFileName().toString();
        String createTime = fileName.substring(0, fileName.indexOf("-" + Conversation.MESSAGE_TYPE_USER));
        sysMessageService.updateMessageByAudioFile(deviceId, roleId,
                Conversation.MESSAGE_TYPE_USER, createTime, path.toString());
    }

    /**
     * 添加消息。
     * 支持批量，对于注重性能的实现是很有必要的。
     */
    private void saveMessage(List<SysMessage> messageList) {

        // 异步虚拟线程处理持久化。
        Thread.startVirtualThread(() -> {
            try {
                messageMapper.saveAll(messageList);
            } catch (Exception e) {
                logger.error("保存消息时出错: {}", e.getMessage(), e);
            }
        });
    }
    // Message里塞的内容已经较多，后续再考虑优化。可能设计一个新的类，融合 SysMessage and Message是值得考虑的。
}

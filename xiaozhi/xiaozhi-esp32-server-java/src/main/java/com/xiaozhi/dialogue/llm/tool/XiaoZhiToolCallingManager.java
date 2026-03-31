package com.xiaozhi.dialogue.llm.tool;

import io.micrometer.observation.ObservationRegistry;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.ai.chat.messages.AssistantMessage;
import org.springframework.ai.chat.messages.Message;
import org.springframework.ai.chat.messages.ToolResponseMessage;
import org.springframework.ai.chat.model.ChatResponse;
import org.springframework.ai.chat.model.Generation;
import org.springframework.ai.chat.model.ToolContext;
import org.springframework.ai.chat.prompt.Prompt;
import org.springframework.ai.model.tool.ToolCallingChatOptions;
import org.springframework.ai.model.tool.ToolCallingManager;
import org.springframework.ai.model.tool.ToolExecutionResult;
import org.springframework.ai.tool.ToolCallback;
import org.springframework.ai.tool.definition.ToolDefinition;
import org.springframework.ai.tool.execution.DefaultToolExecutionExceptionProcessor;
import org.springframework.ai.tool.execution.ToolExecutionException;
import org.springframework.ai.tool.execution.ToolExecutionExceptionProcessor;
import org.springframework.ai.tool.observation.DefaultToolCallingObservationConvention;
import org.springframework.ai.tool.observation.ToolCallingObservationContext;
import org.springframework.ai.tool.observation.ToolCallingObservationConvention;
import org.springframework.ai.tool.observation.ToolCallingObservationDocumentation;
import org.springframework.ai.tool.resolution.DelegatingToolCallbackResolver;
import org.springframework.ai.tool.resolution.ToolCallbackResolver;
import org.springframework.beans.BeansException;
import org.springframework.context.ApplicationContext;
import org.springframework.context.ApplicationContextAware;
import org.springframework.util.Assert;
import org.springframework.util.CollectionUtils;

import java.util.*;
import java.util.HashMap;

/**
 * 自定义的工具调用管理器，用于处理工具调用和执行。
 * 基于Spring AI的DefaultToolCallingManager
 * TODO 需要注意，有些AI返回多tool call时，会返回多条，其中有的包含名称，有的包含参数。待观察
 */
public class XiaoZhiToolCallingManager implements ToolCallingManager, ApplicationContextAware {

    private static final Logger logger = LoggerFactory.getLogger(XiaoZhiToolCallingManager.class);

    // @formatter:off

    private static final ObservationRegistry DEFAULT_OBSERVATION_REGISTRY
            = ObservationRegistry.NOOP;

    private static final ToolCallingObservationConvention DEFAULT_OBSERVATION_CONVENTION
            = new DefaultToolCallingObservationConvention();

    private static final ToolCallbackResolver DEFAULT_TOOL_CALLBACK_RESOLVER
            = new DelegatingToolCallbackResolver(List.of());

    private static final ToolExecutionExceptionProcessor DEFAULT_TOOL_EXECUTION_EXCEPTION_PROCESSOR
            = DefaultToolExecutionExceptionProcessor.builder().build();

    // @formatter:on
    private final ObservationRegistry observationRegistry;

    private final ToolCallbackResolver toolCallbackResolver;

    private final ToolExecutionExceptionProcessor toolExecutionExceptionProcessor;

    private ToolCallingObservationConvention observationConvention = DEFAULT_OBSERVATION_CONVENTION;

    public XiaoZhiToolCallingManager(ObservationRegistry observationRegistry, ToolCallbackResolver toolCallbackResolver,
                                     ToolExecutionExceptionProcessor toolExecutionExceptionProcessor) {
        Assert.notNull(observationRegistry, "observationRegistry cannot be null");
        Assert.notNull(toolCallbackResolver, "toolCallbackResolver cannot be null");
        Assert.notNull(toolExecutionExceptionProcessor, "toolCallExceptionConverter cannot be null");

        this.observationRegistry = observationRegistry;
        this.toolCallbackResolver = toolCallbackResolver;
        this.toolExecutionExceptionProcessor = toolExecutionExceptionProcessor;
    }
    
    @Override
    public void setApplicationContext(ApplicationContext applicationContext) throws BeansException {
    }

    @Override
    public List<ToolDefinition> resolveToolDefinitions(ToolCallingChatOptions chatOptions) {
        Assert.notNull(chatOptions, "chatOptions cannot be null");

        List<ToolCallback> toolCallbacks = new ArrayList<>(chatOptions.getToolCallbacks());
        for (String toolName : chatOptions.getToolNames()) {
            // Skip the tool if it is already present in the request toolCallbacks.
            // That might happen if a tool is defined in the options
            // both as a ToolCallback and as a tool name.
            if (chatOptions.getToolCallbacks()
                    .stream()
                    .anyMatch(tool -> tool.getToolDefinition().name().equals(toolName))) {
                continue;
            }
            ToolCallback toolCallback = this.toolCallbackResolver.resolve(toolName);
            if (toolCallback == null) {
                throw new IllegalStateException("No ToolCallback found for tool name: " + toolName);
            }
            toolCallbacks.add(toolCallback);
        }

        return toolCallbacks.stream().map(ToolCallback::getToolDefinition).toList();
    }

    @Override
    public ToolExecutionResult executeToolCalls(Prompt prompt, ChatResponse chatResponse) {
        Assert.notNull(prompt, "prompt cannot be null");
        Assert.notNull(chatResponse, "chatResponse cannot be null");

        Optional<Generation> toolCallGeneration = chatResponse.getResults()
                .stream()
                .filter(g -> !CollectionUtils.isEmpty(g.getOutput().getToolCalls()))
                .findFirst();

        if (toolCallGeneration.isEmpty()) {
            throw new IllegalStateException("No tool call requested by the chat model");
        }

        // 使用Spring AI原始实现：直接传递AssistantMessage，不合并ToolCall
        AssistantMessage assistantMessage = toolCallGeneration.get().getOutput();

        ToolContext toolContext = buildToolContext(prompt, assistantMessage);

        XiaoZhiToolCallingManager.InternalToolExecutionResult internalToolExecutionResult = executeToolCall(prompt, assistantMessage,
                toolContext);

        List<Message> conversationHistory = buildConversationHistoryAfterToolExecution(prompt.getInstructions(),
                assistantMessage, internalToolExecutionResult.toolResponseMessage());

        return ToolExecutionResult.builder()
                .conversationHistory(conversationHistory)
                .returnDirect(internalToolExecutionResult.returnDirect())
                .build();
    }

    private static ToolContext buildToolContext(Prompt prompt, AssistantMessage assistantMessage) {
        Map<String, Object> toolContextMap = Map.of();

        if (prompt.getOptions() instanceof ToolCallingChatOptions toolCallingChatOptions
                && !CollectionUtils.isEmpty(toolCallingChatOptions.getToolContext())) {
            toolContextMap = new HashMap<>(toolCallingChatOptions.getToolContext());

            List<Message> messageHistory = new ArrayList<>(prompt.copy().getInstructions());
            
            // 确保工具调用消息包含正确的元数据
            if (!CollectionUtils.isEmpty(assistantMessage.getToolCalls())) {
                Map<String, Object> metadata = new HashMap<>(assistantMessage.getMetadata());
                String toolName = assistantMessage.getToolCalls().get(0).name();
                metadata.put("toolName", toolName);
                AssistantMessage updatedAssistantMessage = AssistantMessage.builder()
                        .content(assistantMessage.getText())
                        .properties(metadata)
                        .toolCalls(assistantMessage.getToolCalls())
                        .build();
                messageHistory.add(updatedAssistantMessage);
            } else {
                messageHistory.add(AssistantMessage.builder()
                        .content(assistantMessage.getText())
                        .properties(assistantMessage.getMetadata())
                        .toolCalls(assistantMessage.getToolCalls())
                        .build());
            }

            toolContextMap.put(ToolContext.TOOL_CALL_HISTORY,
                    buildConversationHistoryBeforeToolExecution(prompt, assistantMessage));
        }

        return new ToolContext(toolContextMap);
    }

    private static List<Message> buildConversationHistoryBeforeToolExecution(Prompt prompt,
                                                                             AssistantMessage assistantMessage) {
        List<Message> messageHistory = new ArrayList<>(prompt.copy().getInstructions());
        
        // 确保工具调用消息包含正确的元数据
        if (!CollectionUtils.isEmpty(assistantMessage.getToolCalls())) {
            Map<String, Object> metadata = new HashMap<>(assistantMessage.getMetadata());
            String toolName = assistantMessage.getToolCalls().get(0).name();
            metadata.put("toolName", toolName);
            AssistantMessage updatedAssistantMessage = AssistantMessage.builder()
                    .content(assistantMessage.getText())
                    .properties(metadata)
                    .toolCalls(assistantMessage.getToolCalls())
                    .build();
            messageHistory.add(updatedAssistantMessage);
        } else {
            messageHistory.add(AssistantMessage.builder()
                    .content(assistantMessage.getText())
                    .properties(assistantMessage.getMetadata())
                    .toolCalls(assistantMessage.getToolCalls())
                    .build());
        }
        
        return messageHistory;
    }

    /**
     * Execute the tool call and return the response message.
     */
    private XiaoZhiToolCallingManager.InternalToolExecutionResult executeToolCall(Prompt prompt, AssistantMessage assistantMessage,
                                                                                  ToolContext toolContext) {
        List<ToolCallback> toolCallbacks = List.of();
        if (prompt.getOptions() instanceof ToolCallingChatOptions toolCallingChatOptions) {
            toolCallbacks = toolCallingChatOptions.getToolCallbacks();
        }

        List<ToolResponseMessage.ToolResponse> toolResponses = new ArrayList<>();

        Boolean returnDirect = null;

        for (AssistantMessage.ToolCall toolCall : assistantMessage.getToolCalls()) {

            String toolName = toolCall.name();
            String toolInputArguments = toolCall.arguments();

            ToolCallback toolCallback = toolCallbacks.stream()
                    .filter(tool -> toolName.equals(tool.getToolDefinition().name()))
                    .findFirst()
                    .orElseGet(() -> this.toolCallbackResolver.resolve(toolName));

            if (toolCallback == null) {
                throw new IllegalStateException("No ToolCallback found for tool name: " + toolName);
            }

            if (returnDirect == null) {
                returnDirect = toolCallback.getToolMetadata().returnDirect();
            }
            else {
                returnDirect = returnDirect && toolCallback.getToolMetadata().returnDirect();
            }

            ToolCallingObservationContext observationContext = ToolCallingObservationContext.builder()
                    .toolDefinition(toolCallback.getToolDefinition())
                    .toolMetadata(toolCallback.getToolMetadata())
                    .toolCallArguments(toolInputArguments)
                    .build();
            observationContext.put("session", toolContext.getContext().get("session"));


            String toolCallResult = ToolCallingObservationDocumentation.TOOL_CALL
                    .observation(this.observationConvention, DEFAULT_OBSERVATION_CONVENTION, () -> observationContext,
                            this.observationRegistry)
                    .observe(() -> {
                        String toolResult;
                        try {
                            toolResult = toolCallback.call(toolInputArguments, toolContext);
                        }
                        catch (ToolExecutionException ex) {
                            logger.error("Tool execution exception: ", ex);
                            toolResult = this.toolExecutionExceptionProcessor.process(ex);
                            logger.debug("Processed tool execution exception result: {}", toolResult);
                        }
                        catch (Exception ex) {
                            logger.error("Unexpected exception during tool execution: ", ex);
                            toolResult = "Error executing tool: " + ex.getMessage();
                        }
                        observationContext.setToolCallResult(toolResult);
                        
                        return toolResult;
                    });

            toolResponses.add(new ToolResponseMessage.ToolResponse(toolCall.id(), toolName,
                    toolCallResult != null ? toolCallResult : ""));
        }

        return new XiaoZhiToolCallingManager.InternalToolExecutionResult(ToolResponseMessage.builder().responses(toolResponses).build(), returnDirect);
    }

    private List<Message> buildConversationHistoryAfterToolExecution(List<Message> previousMessages,
                                                                     AssistantMessage assistantMessage, ToolResponseMessage toolResponseMessage) {
        List<Message> messages = new ArrayList<>(previousMessages);
        
        // 确保工具调用消息包含正确的元数据
        if (!CollectionUtils.isEmpty(assistantMessage.getToolCalls())) {
            Map<String, Object> metadata = new HashMap<>(assistantMessage.getMetadata());
            String toolName = assistantMessage.getToolCalls().get(0).name();
            metadata.put("toolName", toolName);
            AssistantMessage updatedAssistantMessage = AssistantMessage.builder()
                    .content(assistantMessage.getText())
                    .properties(metadata)
                    .toolCalls(assistantMessage.getToolCalls())
                    .build();
            messages.add(updatedAssistantMessage);
        } else {
            messages.add(assistantMessage);
        }
        
        messages.add(toolResponseMessage);
        return messages;
    }

    public void setObservationConvention(ToolCallingObservationConvention observationConvention) {
        this.observationConvention = observationConvention;
    }

    public static XiaoZhiToolCallingManager.Builder builder() {
        return new XiaoZhiToolCallingManager.Builder();
    }

    private record InternalToolExecutionResult(ToolResponseMessage toolResponseMessage, boolean returnDirect) {
    }

    public final static class Builder {

        private ObservationRegistry observationRegistry = DEFAULT_OBSERVATION_REGISTRY;

        private ToolCallbackResolver toolCallbackResolver = DEFAULT_TOOL_CALLBACK_RESOLVER;

        private ToolExecutionExceptionProcessor toolExecutionExceptionProcessor = DEFAULT_TOOL_EXECUTION_EXCEPTION_PROCESSOR;

        private Builder() {
        }

        public XiaoZhiToolCallingManager.Builder observationRegistry(ObservationRegistry observationRegistry) {
            this.observationRegistry = observationRegistry;
            return this;
        }

        public XiaoZhiToolCallingManager.Builder toolCallbackResolver(ToolCallbackResolver toolCallbackResolver) {
            this.toolCallbackResolver = toolCallbackResolver;
            return this;
        }

        public XiaoZhiToolCallingManager.Builder toolExecutionExceptionProcessor(
                ToolExecutionExceptionProcessor toolExecutionExceptionProcessor) {
            this.toolExecutionExceptionProcessor = toolExecutionExceptionProcessor;
            return this;
        }

        public XiaoZhiToolCallingManager build() {
            return new XiaoZhiToolCallingManager(this.observationRegistry, this.toolCallbackResolver,
                    this.toolExecutionExceptionProcessor);
        }

    }
}

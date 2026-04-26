# ADR-009: AI Chat Timeout & JSON Parse Exception Resolution

## 背景 (Context)
系统引入支持复杂思维链 (Chain of Thought) 的 AI 模型后，发生两个连锁性严重问题：
1. **JsonParseException**: 模型的流式输出包含了 `<think>...</think>` 等非标准 JSON 内容，破坏了后端既有的结构化提取逻辑。
2. **超时截断 (Timeout)**: 深度思考模型耗时较长，经常突破前端（或 Nginx/网关）配置的 75 秒请求超时阈值。

## 决策 (Decision)
1. **双通道解析架构**: 
   - 在后端响应解析器中，增加对 `<think>` 标签块的正则过滤或分离提取逻辑。将“思维过程”和“最终结果”通过 SSE 事件结构化地下发给前端，而不是直接 parse 整个字符串为单一 JSON。
2. **超时机制重构**: 
   - 弃用传统的单一长连接 Request-Response 模式，全面强化 SSE (Server-Sent Events) 的长连接心跳保持。只要模型在思考（流式输出 content 或 thinking），连接就会保持活跃。
   - 适当提升 HTTP 客户端底层的 Timeout 设置（如 120s+），以应对首字延迟 (TTFT) 较高的模型。

## 后果 (Consequences)
- **收益**: 完美兼容带有深度思考功能的大模型（如 DeepSeek-R1 类别），提升系统健壮性。
- **风险/成本**: 需要对现有的 `IChildAIService` 或对应的 AI 请求层进行正则处理的性能评估，避免长文本阻塞解析线程。

## 状态 (Status)
- [ ] 待执行 (Pending)

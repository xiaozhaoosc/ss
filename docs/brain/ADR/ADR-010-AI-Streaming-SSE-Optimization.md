# ADR-010: AI 聊天流式 SSE 响应优化与 Vite 代理绕过机制

## 上下文 (Context)
在 H5 开发环境下（Vite + Uni-app），AI 聊天的流式响应（Server-Sent Events, SSE）遭遇了两个关键阻塞：
1. **Vite 代理缓冲/404**: Vite 的反向代理在处理 `GET /ssapi/child/ai/chat/stream` 时，偶尔会因为其特殊的 `Accept` 头（`text/event-stream`）或其响应格式未被正确识别为流，而触发 SPA 回退逻辑返回 `index.html`，或者导致响应被完全缓冲直到结束才一次性返回。
2. **后端冷启动/处理延迟**: 后端在返回 `SseEmitter` 之前执行了耗时的 AI 情感分析（20-30s）和聊天请求（20-30s），导致 HTTP 连接在 60s 内没有任何字节下发，被浏览器/代理判定为挂起并可能触发超时。

## 决定 (Decision)
1. **前端绝对路径跳转 (Dev Mode Only)**: 
   在 `treehole-chat/index.vue` 中，当检测到处于 H5 开发模式且 `baseUrl` 为 `/ssapi` 时，强制将流请求 URL 切换为后端的绝对路径 `http://localhost:8081/ssapi/...`。这绕过了 Vite Proxy 的处理逻辑，直接建立 SSE 长连接，并依赖后端的 CORS 配置（已开启）进行通信。
2. **后端 SSE 预热 (Pre-warming)**:
   修改 `ChildAIServiceImpl.chatWithAIStream`，在开启异步线程前，立即向 `SseEmitter` 发送一个包含空格（`" "`）的初始数据块。这会立即使 HTTP 响应头和首个字节下发至客户端，从而“握手”成功，防止任何中间代理（Nginx/Vite）因长时间无数据传输而断开连接。
3. **后端异步编排**:
   保持异步执行耗时任务，但在 UI 层面确保即使 AI 正在生成，连接也是活跃的。

## 后果 (Consequences)
- **正面**:
    - AI 聊天界面现在能立即展示“对话气泡”（即使内容尚未生成），显著提升了用户交互的安全感。
    - 彻底解决了 Vite 代理导致的 SSE 无法流式展示的问题。
- **负面**:
    - 生产环境部署时必须确保后端支持 CORS 或 Nginx 代理配置为 `proxy_buffering off`。
    - 前端代码中包含硬编码的 `localhost:8081` 逻辑，需在打包生产环境时通过环境变量隔离。

## 关联项
- [[ADR-009-AI-Chat-Timeout-JSON-Exception]]
- [[SmallSteps-AI-Architecture]]

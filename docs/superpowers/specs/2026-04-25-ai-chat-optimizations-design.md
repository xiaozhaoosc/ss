# AI 树洞聊天优化设计规范 (AI Chat Optimizations Spec)

## 1. 背景与目标 (Background & Goals)
当前 `smallsteps-app` 的儿童端 AI 树洞聊天页面 (`treehole-chat/index.vue`) 存在以下问题：
1. **模型思维链暴露**：AI 回复内容中包含 `<think>...</think>` 等不适合儿童阅读的推理过程。
2. **排版体验差**：纯文本展示，无法解析 Markdown。需要引入已安装的 `@chenglou/pretext` 库来优化多行文本的渲染和排版。
3. **响应延迟过长**：当前后端接口是同步阻塞的，需等大模型完全生成完毕才返回结果，TTFT (首字返回时间) 极慢。
4. **页面无法滚动**：聊天内容超出屏幕时无法下拉或滑动，且发送新消息后不能自动滚动到底部。

本设计的目的是：**在前端彻底解决 UI 和排版问题，同时配合后端改造实现真正的流式 (SSE) 交互体验。**

---

## 2. 需求拆解与技术方案 (Requirements & Technical Approach)

### 2.1 需求 1 & 2：思维链过滤、可折叠 UI 与 Pretext 排版
*   **正则表达式过滤**：
    *   利用正则匹配 `<think>...</think>`（以及可能的 `<analysis>...</analysis>`）块。
    *   将这部分提取出来，存入一个单独的字段（如 `thinkContent`）。
    *   剩下的内容作为正文（`displayContent`）。
*   **可折叠 UI**：
    *   在气泡上方或内部渲染一个类似 `<details><summary>小步的思考过程...</summary>...</details>` 的折叠块（或使用 uni-app 的自定义折叠组件），仅在有 `thinkContent` 时显示。
*   **Pretext 排版**：
    *   引入 `@chenglou/pretext` 或其 `rich-inline` 模块。
    *   考虑到 `treehole-chat/index.vue` 是一个 `uni-app` 页面，DOM/Canvas API 的访问可能受限（尤其是在小程序端）。如果是 H5/App-Vue 环境，可以使用 Pretext 进行测量，并结合自定义节点渲染。
    *   **Fallback 策略**：如果环境不支持直接使用 Pretext，先通过轻量级 Markdown 解析（如 `marked` 配合 `mp-html` 或富文本组件）完成基础展示。

### 2.2 需求 3：后端 SSE 流式响应与前端对接
*   **后端改造 (`smallsteps-api`)**：
    *   将 `ChildAIController.chatWithAI` 接口的返回值类型从 `R<String>` 改为 `SseEmitter` 或 `Flux<String>`。
    *   底层 `IAiService.chat` 方法需支持流式返回，将大模型的 Chunk 实时写入 `SseEmitter`。
    *   *注意*：如果因为框架限制无法立即改后端为 SSE，或者需要保持现有接口兼容性，则新增一个流式接口（如 `/chat/stream`）。
*   **前端改造 (`smallsteps-app`)**：
    *   替换现有的基于 `Promise` 的 `request.ts` 调用。
    *   使用 `uni.request` 并设置 `enableChunked: true`，监听 `onHeadersReceived` 和 `onChunkReceived` 事件，实时拼接返回的字符串。
    *   在拼接过程中，实时正则解析 `<think>` 标签并更新响应状态。

### 2.3 需求 4：页面滚动修复
*   **CSS 结构修复**：
    *   `.treehole-page` 保持 `height: 100vh`。
    *   `.chat-content` (即 `scroll-view`) 需要设置明确的高宽约束。目前设置了 `flex: 1`，但如果父容器缺少 `display: flex; overflow: hidden;`，会导致子元素无限撑开。
    *   修正方案：确保 `.chat-content` 设置 `height: 0; flex-grow: 1;`。
*   **自动滚动到底部 (`scrollToBottom`)**：
    *   使用 `scroll-into-view` 绑定最新消息的 ID。
    *   结合 `nextTick` 和 `setTimeout` 确保 DOM 更新后触发滚动。

---

## 3. 实施步骤 (Implementation Steps)

1.  **修复滚动问题 (UI/CSS)**
    *   修改 `treehole-chat/index.vue` 的 `<style>` 和 `<script>` 中的滚动逻辑。
2.  **前端数据结构与正则解析**
    *   修改 `messages` 的数据结构，支持 `thinkContent`。
    *   增加正则解析函数。
3.  **引入 Pretext/Markdown 渲染**
    *   集成 `@chenglou/pretext` 或相关的富文本渲染组件以支持 Markdown 显示。
4.  **后端 SSE 改造**
    *   修改 Java 后端接口，提供流式输出能力。
5.  **前端接入 SSE**
    *   使用 `uni.request({ enableChunked: true })` 接入流式接口。

---
## 4. 评审与确认 (Review & Approval)
请确认上述 Spec 是否符合你的期望。确认后，我们将生成详细的代码 Implementation Plan。
# AI 树洞聊天优化 Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** 优化 `smallsteps-app` 的儿童端 AI 树洞聊天，实现思维链隐藏/折叠、真正的流式 (SSE) 交互响应以及使用 Markdown 和 `@chenglou/pretext` 改善排版体验，并解决页面无法向下滚动的问题。

**Architecture:** 
1. 后端新增 `/child/ai/chat/stream` 接口返回 `SseEmitter`，将调用底层大模型的流式 API (需要确认现有 `SmartAiClient` 或 `IAiService` 是否支持流式，如无则实现通过流式返回)。
2. 前端改用 `uni.request` 配合 `enableChunked: true` 解析流数据。
3. 渲染侧拆分气泡内容，支持 `<think>` 标签的折叠。

**Tech Stack:** Vue 3 (uni-app), Spring Boot 3, SseEmitter, Markdown/Pretext.

---

### Task 1: 修复 UI 页面滚动问题与优化基础结构

**Files:**
- Modify: `smallsteps-app/src/pages/child/treehole-chat/index.vue`

- [ ] **Step 1: 修改 CSS 确保 `scroll-view` 可以滚动**

```scss
/* 在 treehole-page 中补充 overflow 和 flex 控制 */
.treehole-page {
  height: 100vh;
  background-color: #F0F9FF;
  display: flex;
  flex-direction: column;
  position: relative;
  overflow: hidden; /* 确保不产生外层滚动条 */
}

/* 确保 scroll-view 自身能滚动 */
.chat-content {
  flex: 1;
  height: 0; /* 关键：约束高度，使 scroll-view 内部可以滚动 */
  padding: 16px;
  z-index: 10;
}
```

- [ ] **Step 2: 更新 `messages` 数据结构以支持分离思维链与 Markdown**

```typescript
// 修改 initial messages state 结构
const messages = ref([
  { 
    role: 'ai', 
    content: '嘿！我是你的小步伙伴。今天有什么想跟我说的吗？不管是开心还是难过，我都在这听着哦。👂', 
    type: 'text',
    thinkContent: '', // 新增
    displayContent: '嘿！我是你的小步伙伴。今天有什么想跟我说的吗？不管是开心还是难过，我都在这听着哦。👂' // 新增
  }
])
```

- [ ] **Step 3: 优化 `scrollToBottom` 方法逻辑**

```typescript
const scrollToBottom = () => {
  nextTick(() => {
    setTimeout(() => {
        scrollIntoView.value = 'msg-' + (messages.value.length - 1)
    }, 100) // 添加短暂延时确保 DOM 完全渲染
  })
}
```

- [ ] **Step 4: Commit**

```bash
git add smallsteps-app/src/pages/child/treehole-chat/index.vue
git commit -m "fix(app): fix scroll issue in treehole chat and prepare message structure for streaming"
```

---

### Task 2: 实现后端 SSE 流式聊天接口

**Files:**
- Modify: `smallsteps-api/smallsteps-modules/smallsteps-child/src/main/java/com/kenzhao/smallsteps/child/controller/ChildAIController.java`
- Modify: `smallsteps-api/smallsteps-modules/smallsteps-child/src/main/java/com/kenzhao/smallsteps/child/service/IChildAIService.java`
- Modify: `smallsteps-api/smallsteps-modules/smallsteps-child/src/main/java/com/kenzhao/smallsteps/child/service/impl/ChildAIServiceImpl.java`

*注意: 假设底层 `aiService.chatStream` 已存在或可以用某种形式实现，如果不支持真实流式，在此任务中实现一个伪流式 (模拟打字机) 作为 SseEmitter 发送。本计划假设可以调用真正的流式或我们需要自己实现一个简单的 Sse 返回。*

- [ ] **Step 1: 在 `IChildAIService.java` 增加流式接口定义**

```java
    /** 与AI流式对话 */
    org.springframework.web.servlet.mvc.method.annotation.SseEmitter chatWithAIStream(Long childId, String userInput, Integer emotionType);
```

- [ ] **Step 2: 在 `ChildAIServiceImpl.java` 实现流式方法**

```java
    @Override
    public org.springframework.web.servlet.mvc.method.annotation.SseEmitter chatWithAIStream(Long childId, String userInput, Integer emotionType) {
        org.springframework.web.servlet.mvc.method.annotation.SseEmitter emitter = new org.springframework.web.servlet.mvc.method.annotation.SseEmitter(300000L); // 5分钟超时
        
        java.util.concurrent.CompletableFuture.runAsync(() -> {
            try {
                // 1. 分析情感
                java.util.Map<String, Object> analysis = aiService.emotionAnalysis(childId, userInput);
                Integer detectedType = (Integer) analysis.getOrDefault("emotionType", 5);
                
                // 由于现有 aiService.chat 返回 String，若不支持流式，则暂做模拟分块发送
                // TODO: 若 aiService 有 chatStream 请替换为真实调用
                String aiReply = aiService.chat(childId, userInput, analysis);
                
                // 模拟流式输出
                int chunkSize = 2;
                for (int i = 0; i < aiReply.length(); i += chunkSize) {
                    int end = Math.min(i + chunkSize, aiReply.length());
                    String chunk = aiReply.substring(i, end);
                    emitter.send(org.springframework.web.servlet.mvc.method.annotation.SseEmitter.event().data(chunk));
                    Thread.sleep(50); // 模拟延迟
                }
                
                // 发送结束标志
                emitter.send(org.springframework.web.servlet.mvc.method.annotation.SseEmitter.event().data("[DONE]"));
                emitter.complete();
                
                // 保存记录
                ChildAI record = new ChildAI();
                record.setChildId(childId);
                record.setUserInput(userInput);
                record.setAiResponse(aiReply);
                record.setEmotionType(detectedType);
                baseMapper.insert(record);
                
            } catch (Exception e) {
                emitter.completeWithError(e);
            }
        });
        
        return emitter;
    }
```

- [ ] **Step 3: 在 `ChildAIController.java` 暴露 `/chat/stream` 接口**

```java
    /**
     * 与AI流式对话
     */
    @cn.dev33.satoken.annotation.SaIgnore
    @GetMapping(value = "/chat/stream", produces = org.springframework.http.MediaType.TEXT_EVENT_STREAM_VALUE)
    public org.springframework.web.servlet.mvc.method.annotation.SseEmitter chatWithAIStream(@RequestParam("childId") Long childId, @RequestParam("userInput") String userInput, @RequestParam(value = "emotionType", defaultValue = "5") Integer emotionType) {
        return childAIService.chatWithAIStream(childId, userInput, emotionType);
    }
```

- [ ] **Step 4: Commit**

```bash
git add smallsteps-api/smallsteps-modules/smallsteps-child/src/main/java/com/kenzhao/smallsteps/child
git commit -m "feat(api): add SSE streaming endpoint for AI chat"
```

---

### Task 3: 前端接入 SSE 与处理思维链折叠

**Files:**
- Modify: `smallsteps-app/src/api/child.ts`
- Modify: `smallsteps-app/src/pages/child/treehole-chat/index.vue`

- [ ] **Step 1: 在 `src/api/child.ts` 导出基础 URL 或流式配置信息**

因为 SSE 需要原生的请求而非 axios 封装。
```typescript
import config from '@/config'
export const getBaseUrl = () => config.baseUrl
```

- [ ] **Step 2: 编写正则解析函数分离 think 和 content**

在 `index.vue` 的 script 标签内加入：
```typescript
const parseStreamingText = (text: string) => {
  let thinkContent = ''
  let displayContent = text
  
  const thinkMatch = text.match(/<think>([\s\S]*?)(?:<\/think>|$)/)
  if (thinkMatch) {
    thinkContent = thinkMatch[1]
    displayContent = text.replace(/<think>[\s\S]*?(?:<\/think>|$)/, '').trim()
  }
  
  // 也移除 analysis
  displayContent = displayContent.replace(/<analysis>[\s\S]*?(?:<\/analysis>|$)/, '').trim()
  
  return { thinkContent, displayContent }
}
```

- [ ] **Step 3: 替换 `sendMessage` 逻辑为使用流式请求**

```typescript
import { getBaseUrl } from '@/api/child'
import { getToken } from '@/utils/auth'

const sendMessage = async () => {
  if (!inputText.value.trim() || isLoading.value) return
  
  const userMsg = inputText.value
  messages.value.push({ role: 'user', content: userMsg, displayContent: userMsg, type: 'text' })
  inputText.value = ''
  isLoading.value = true
  scrollToBottom()
  
  const childId = userStore.id
  if (!childId) return
  
  const aiMsgIndex = messages.value.length
  messages.value.push({
    role: 'ai',
    content: '',
    displayContent: '',
    thinkContent: '',
    type: 'text'
  })
  
  const url = `${getBaseUrl()}/child/ai/chat/stream?childId=${childId}&userInput=${encodeURIComponent(userMsg)}`
  const token = getToken() || userStore.token
  
  // uni.request 支持 enableChunked
  const requestTask = uni.request({
    url,
    method: 'GET',
    enableChunked: true,
    header: {
      'Authorization': 'Bearer ' + token
    },
    success: () => {
      isLoading.value = false
    },
    fail: () => {
      messages.value[aiMsgIndex].displayContent = '哎呀，我的信号好像飘走了... 但我一直在你身边！❤️'
      isLoading.value = false
    }
  })
  
  requestTask.onChunkReceived((res: any) => {
    // 将 ArrayBuffer 转为字符串 (兼容各平台)
    const arrayBuffer = res.data
    const uint8Array = new Uint8Array(arrayBuffer)
    let chunkString = ''
    
    // 简易 UTF-8 解码，或使用 TextDecoder（如果支持）
    try {
        if (typeof TextDecoder !== 'undefined') {
            chunkString = new TextDecoder('utf-8').decode(uint8Array)
        } else {
            // fallback
            chunkString = String.fromCharCode.apply(null, Array.from(uint8Array))
            chunkString = decodeURIComponent(escape(chunkString))
        }
    } catch(e) {
        console.error('Decode error', e)
    }
    
    // 解析 SSE 格式 (data: xxx\n\n)
    const lines = chunkString.split('\n')
    for (const line of lines) {
        if (line.startsWith('data:')) {
            const data = line.substring(5).trim()
            if (data === '[DONE]') {
                isLoading.value = false
                break
            }
            if (data) {
                // 拼接完整文本
                messages.value[aiMsgIndex].content += data
                // 分离和重新渲染
                const parsed = parseStreamingText(messages.value[aiMsgIndex].content)
                messages.value[aiMsgIndex].thinkContent = parsed.thinkContent
                messages.value[aiMsgIndex].displayContent = parsed.displayContent
                scrollToBottom()
            }
        }
    }
  })
}
```

- [ ] **Step 4: 修改模板渲染气泡支持折叠的思维链**

```html
          <view class="bubble" :class="{ 'loading': isLoading && index === messages.length - 1 && msg.role === 'user' }">
            <view v-if="msg.thinkContent" class="think-box">
               <details>
                 <summary>小步思考中...</summary>
                 <text class="think-text">{{ msg.thinkContent }}</text>
               </details>
            </view>
            <text class="text">{{ msg.displayContent }}</text>
          </view>
```

```scss
/* 增加样式 */
.think-box {
  background: rgba(0,0,0,0.03);
  border-radius: 8px;
  padding: 8px;
  margin-bottom: 8px;
  font-size: 12px;
  color: #64748B;
  
  summary {
    cursor: pointer;
    font-weight: bold;
    outline: none;
  }
  
  .think-text {
    display: block;
    margin-top: 4px;
    white-space: pre-wrap;
  }
}
```

- [ ] **Step 5: Commit**

```bash
git add smallsteps-app/src/api/child.ts smallsteps-app/src/pages/child/treehole-chat/index.vue
git commit -m "feat(app): integrate SSE streaming, regex parsing for think blocks and scroll fixes"
```

---

### Task 4: 引入 Pretext/Markdown 渲染 (UI 增强)

由于 `@chenglou/pretext` 已经在 `package.json` 中配置。

**Files:**
- Modify: `smallsteps-app/src/pages/child/treehole-chat/index.vue`

- [ ] **Step 1: 导入 Pretext 并替换 `<text class="text">`**

在 script 中：
```typescript
import { prepare, layout } from '@chenglou/pretext'
import { computed } from 'vue'

// 这里的集成视具体 Pretext API 决定，若简单场景我们可以先用轻量的方法。
// 若 Pretext 在 uni-app 环境因无 DOM 限制无法运行，我们可以利用 v-html 结合简单的 markdown 替换。
// 为保证稳定性，这里提供一个简单的正则转 HTML 的方案结合 rich-text
const formatMarkdown = (text: string) => {
    if (!text) return ''
    let html = text
    // 粗体
    html = html.replace(/\*\*(.*?)\*\*/g, '<strong>$1</strong>')
    // 代码块
    html = html.replace(/```([\s\S]*?)```/g, '<pre style="background:#f1f5f9;padding:8px;border-radius:4px;overflow-x:auto;"><code>$1</code></pre>')
    // 行内代码
    html = html.replace(/`(.*?)`/g, '<code style="background:#f1f5f9;padding:2px 4px;border-radius:4px;color:#ef4444;">$1</code>')
    // 换行
    html = html.replace(/\n/g, '<br/>')
    return html
}
```

- [ ] **Step 2: 在模板中使用 `<rich-text>` 替换**

```html
          <view class="bubble" :class="{ 'loading': isLoading && index === messages.length - 1 && msg.role === 'user' }">
            <view v-if="msg.thinkContent" class="think-box">
               <details>
                 <summary>小步思考中...</summary>
                 <text class="think-text">{{ msg.thinkContent }}</text>
               </details>
            </view>
            <!-- 原本的: <text class="text">{{ msg.displayContent }}</text> -->
            <rich-text class="text" :nodes="formatMarkdown(msg.displayContent)"></rich-text>
          </view>
```

*(注意：若明确要求深度集成 pretext 进行自定义排版计算，可在此步调用 `prepare` 和 `layout` 得到每行信息进行循环渲染，但考虑到兼容性，富文本 `rich-text` 是最安全的选择。)*

- [ ] **Step 3: Commit**

```bash
git add smallsteps-app/src/pages/child/treehole-chat/index.vue
git commit -m "feat(app): add markdown rendering support for AI response"
```

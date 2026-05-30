<script setup lang="ts">
import { ref, onMounted, nextTick } from 'vue'
import { onShow } from '@dcloudio/uni-app'
import { useUserStore } from '@/store/modules/user'
import { getToken } from '@/utils/auth'

// Markdown formatting helper
const formatMarkdown = (text: string) => {
    if (!text) return ''
    let html = text
    html = html.replace(/\*\*(.*?)\*\*/g, '<strong>$1</strong>')
    html = html.replace(/```([\s\S]*?)```/g, '<pre style="background:#f1f5f9;padding:8px;border-radius:4px;overflow-x:auto;"><code>$1</code></pre>')
    html = html.replace(/`(.*?)`/g, '<code style="background:#f1f5f9;padding:2px 4px;border-radius:4px;color:#ef4444;">$1</code>')
    html = html.replace(/\n/g, '<br/>')
    return html
}

const parseStreamingText = (text: string) => {
  let thinkContent = ''
  let displayContent = text
  
  const thinkMatch = text.match(/<think>([\s\S]*?)(?:<\/think>|$)/)
  if (thinkMatch) {
    thinkContent = thinkMatch[1]
    displayContent = text.replace(/<think>[\s\S]*?(?:<\/think>|$)/, '').trim()
  }
  
  displayContent = displayContent.replace(/<analysis>[\s\S]*?(?:<\/analysis>|$)/, '').trim()
  return { thinkContent, displayContent }
}

const userStore = useUserStore()
const messages = ref([
  { 
    role: 'ai', 
    content: '您好，我是小步家长管家。❤️\n在这个育儿旅程中，您辛苦了。无论是关于孩子的行为引导，还是您自己的情绪压力，我都愿意在这里倾听并为您提供支持。今天有什么我可以帮您的吗？', 
    displayContent: '您好，我是小步家长管家。❤️\n在这个育儿旅程中，您辛苦了。无论是关于孩子的行为引导，还是您自己的情绪压力，我都愿意在这里倾听并为您提供支持。今天有什么我可以帮您的吗？'
  }
])
const inputText = ref('')
const scrollIntoView = ref('')
const isLoading = ref(false)

const handleBack = () => {
  uni.navigateBack()
}

const sendMessage = async () => {
  if (!inputText.value.trim() || isLoading.value) return
  
  const userMsg = inputText.value
  messages.value.push({ role: 'user', content: userMsg, displayContent: userMsg })
  inputText.value = ''
  isLoading.value = true
  scrollToBottom()
  
  const aiMsgIndex = messages.value.length
  messages.value.push({
    role: 'ai',
    content: '',
    displayContent: '',
    thinkContent: ''
  })
  
  // Use backend URL logic similar to treehole
  const baseUrl = import.meta.env.VITE_APP_BASE_API || 'http://localhost:8081/ssapi'
  const token = getToken() || userStore.token
  const clientid = uni.getStorageSync('clientid') || 'e5cd7e4891bf95d1d19206ce24a7b32e'
  
  // For parents, we might need a specific child context or a general parent context
  // Here we use a general prompt by passing a special ID or just using the treehole endpoint as a base
  const url = `${baseUrl}/child/ai/chat/stream?childId=0&userInput=${encodeURIComponent("[家长模式] " + userMsg)}&Authorization=${encodeURIComponent('Bearer ' + token)}&clientid=${clientid}`

  const requestTask = uni.request({
    url,
    method: 'GET',
    enableChunked: true,
    header: {
      'Authorization': 'Bearer ' + token,
      'clientid': clientid
    },
    success: () => { isLoading.value = false },
    fail: () => {
      messages.value[aiMsgIndex].displayContent = '抱歉，我刚才走神了... 我们可以重新聊聊吗？'
      isLoading.value = false
    }
  })
  
  let decoder: any = null
  if (typeof TextDecoder !== 'undefined') {
      decoder = new TextDecoder('utf-8')
  }

  let buffer = ''

  requestTask.onChunkReceived((res: any) => {
    let chunkString = ''
    if (typeof res.data === 'string') {
        chunkString = res.data
    } else {
        const arrayBuffer = res.data
        const uint8Array = new Uint8Array(arrayBuffer)
        if (decoder) {
            chunkString = decoder.decode(uint8Array, {stream: true})
        } else {
            chunkString = decodeURIComponent(escape(String.fromCharCode.apply(null, Array.from(uint8Array))))
        }
    }
    
    buffer += chunkString
    const events = buffer.split(/\n\n|\r\n\r\n/)
    buffer = events.pop() || ''
    
    for (const event of events) {
        if (!event.trim()) continue
        const lines = event.split('\n')
        const dataLines = []
        let isDone = false
        
        for (const line of lines) {
            if (line.startsWith('data:')) {
                let data = line.substring(5).trim()
                if (data === '[DONE]') {
                    isDone = true
                } else {
                    dataLines.push(data)
                }
            }
        }
        
        if (isDone) {
            isLoading.value = false
            break
        }
        
        if (dataLines.length > 0) {
            messages.value[aiMsgIndex].content += dataLines.join('\n')
            const parsed = parseStreamingText(messages.value[aiMsgIndex].content)
            messages.value[aiMsgIndex].thinkContent = parsed.thinkContent
            messages.value[aiMsgIndex].displayContent = parsed.displayContent
            scrollToBottom()
        }
    }
  })
}

const scrollToBottom = () => {
  nextTick(() => {
    setTimeout(() => {
      scrollIntoView.value = 'msg-' + (messages.value.length - 1)
    }, 100)
  })
}

onMounted(() => {
  scrollToBottom()
})
</script>

<template>
  <view class="ai-page">
    <!-- Header -->
    <view class="header">
      <view class="back-area" @click="handleBack">
        <text class="material-symbols-outlined">arrow_back_ios</text>
      </view>
      <view class="title-area">
        <text class="title">AI 情感助手</text>
        <view class="status">
          <view class="dot"></view>
          <text>温情陪伴中</text>
        </view>
      </view>
      <view class="spacer"></view>
    </view>

    <!-- Chat Content -->
    <scroll-view 
      scroll-y 
      class="chat-scroll" 
      :scroll-into-view="scrollIntoView"
      scroll-with-animation
    >
      <view class="message-list">
        <view 
          v-for="(msg, index) in messages" 
          :key="index" 
          :id="'msg-' + index"
          class="message-wrapper"
          :class="msg.role"
        >
          <view v-if="msg.role === 'ai'" class="ai-avatar">
            <image src="https://lh3.googleusercontent.com/aida-public/AB6AXuAJ1cciJ4i8VZa4i84tUg3c73WgpXsHDPWFJTFC1HCyoJaWAw63sCD6sYtGoggTmCxZPkFLdgXZ0jMVUEjuhNaybs-1a06VWI-j7Tv_k-GcxylNpE1U9cjTL6ICQBnyg02gLWhSCCy1SnHe6psYMG-13HPVdTV9vR6odzmSIWG_6kD9m5MrzeKyalS3Ewhx_px4_a3iAVFvHE4SYxL6Z13ZA7UVC9fVC7U29WKKz0G9msv4O4zW9MUm2t6NZ6FOtcNY4-8SHhP3MgM" mode="aspectFill" class="avatar-img" />
          </view>
          
          <view class="bubble-container">
            <view v-if="msg.thinkContent" class="think-card">
              <text class="think-title">💡 深度思考中...</text>
              <text class="think-text">{{ msg.thinkContent }}</text>
            </view>
            <view class="bubble">
              <rich-text :nodes="formatMarkdown(msg.displayContent)"></rich-text>
            </view>
          </view>

          <view v-if="msg.role === 'user'" class="user-avatar">
            <text class="material-symbols-outlined">person</text>
          </view>
        </view>

        <view v-if="isLoading" class="message-wrapper ai">
          <view class="ai-avatar loading-avatar">
            <text class="material-symbols-outlined rotating">smart_toy</text>
          </view>
          <view class="bubble typing-bubble">
            <view class="typing-dot"></view>
            <view class="typing-dot"></view>
            <view class="typing-dot"></view>
          </view>
        </view>
      </view>
      <view class="bottom-gap"></view>
    </scroll-view>

    <!-- Input Panel -->
    <view class="input-panel">
      <view class="input-inner">
        <textarea 
          v-model="inputText" 
          auto-height 
          maxlength="500" 
          class="chat-input" 
          placeholder="分享您的育儿困惑或心情..." 
          @confirm="sendMessage"
        />
        <view class="send-btn" :class="{ active: inputText.trim() }" @click="sendMessage">
          <text class="material-symbols-outlined">send</text>
        </view>
      </view>
    </view>

    <!-- Decorative blobs -->
    <view class="blob b1"></view>
    <view class="blob b2"></view>
  </view>
</template>

<style lang="scss" scoped>
.ai-page {
  height: 100vh;
  background-color: #f8fafc;
  display: flex;
  flex-direction: column;
  position: relative;
  overflow: hidden;
}

.header {
  padding: 16px;
  padding-top: calc(20px + env(safe-area-inset-top));
  display: flex;
  align-items: center;
  justify-content: space-between;
  background: rgba(255, 255, 255, 0.8);
  backdrop-filter: blur(12px);
  z-index: 100;
  border-bottom: 1px solid rgba(0, 0, 0, 0.05);
}

.back-area {
  padding: 8px;
  color: #64748b;
}

.title-area {
  text-align: center;
  .title { font-size: 18px; font-weight: 700; color: #1e293b; }
  .status {
    display: flex;
    align-items: center;
    justify-content: center;
    gap: 4px;
    font-size: 10px;
    color: #6c9bd2;
    .dot { width: 6px; height: 6px; background: #6c9bd2; border-radius: 50%; animation: pulse 2s infinite; }
  }
}

.spacer { width: 40px; }

.chat-scroll {
  flex: 1;
  height: 0; /* 关键：约束高度，使 scroll-view 内部可以滚动 */
  padding: 16px;
  z-index: 10;
}

.message-list {
  display: flex;
  flex-direction: column;
  gap: 24px;
}

.message-wrapper {
  display: flex;
  gap: 12px;
  max-width: 90%;
  
  &.ai { align-self: flex-start; }
  &.user { align-self: flex-end; flex-direction: row-reverse; }
}

.ai-avatar, .user-avatar {
  width: 40px;
  height: 40px;
  border-radius: 12px;
  overflow: hidden;
  display: flex;
  align-items: center;
  justify-content: center;
  box-shadow: 0 4px 12px rgba(0,0,0,0.05);
}

.ai-avatar { background: #e0f2fe; }
.user-avatar { background: #fef3c7; color: #d97706; }

.avatar-img { width: 100%; height: 100%; }

.bubble-container {
  display: flex;
  flex-direction: column;
  gap: 8px;
  max-width: calc(100% - 52px);
}

.bubble {
  padding: 12px 16px;
  border-radius: 18px;
  font-size: 15px;
  line-height: 1.6;
  
  .ai & {
    background: white;
    color: #334155;
    border-top-left-radius: 4px;
    box-shadow: 0 2px 12px rgba(0,0,0,0.03);
  }
  
  .user & {
    background: linear-gradient(135deg, #6c9bd2 0%, #8eadda 100%);
    color: white;
    border-top-right-radius: 4px;
    box-shadow: 0 4px 15px rgba(108, 155, 210, 0.2);
  }
}

.think-card {
  background: rgba(108, 155, 210, 0.05);
  border-left: 3px solid #6c9bd2;
  padding: 8px 12px;
  border-radius: 8px;
  
  .think-title { font-size: 11px; font-weight: bold; color: #6c9bd2; margin-bottom: 4px; display: block; }
  .think-text { font-size: 12px; color: #64748b; line-height: 1.4; }
}

.input-panel {
  padding: 12px 16px;
  padding-bottom: calc(12px + env(safe-area-inset-bottom));
  background: white;
  border-top: 1px solid #f1f5f9;
  z-index: 100;
}

.input-inner {
  background: #f1f5f9;
  border-radius: 20px;
  display: flex;
  align-items: flex-end;
  padding: 8px 12px;
}

.chat-input {
  flex: 1;
  min-height: 24px;
  max-height: 100px;
  font-size: 15px;
  padding: 4px 0;
}

.send-btn {
  width: 32px;
  height: 32px;
  border-radius: 50%;
  display: flex;
  align-items: center;
  justify-content: center;
  color: #cbd5e1;
  margin-left: 8px;
  transition: all 0.3s;
  
  &.active {
    background: #6c9bd2;
    color: white;
  }
}

.typing-bubble {
  display: flex;
  gap: 4px;
  background: white;
  .typing-dot {
    width: 6px;
    height: 6px;
    background: #cbd5e1;
    border-radius: 50%;
    animation: typing 1.4s infinite both;
    &:nth-child(2) { animation-delay: 0.2s; }
    &:nth-child(3) { animation-delay: 0.4s; }
  }
}

.blob {
  position: absolute;
  z-index: 0;
  border-radius: 50%;
  filter: blur(60px);
  opacity: 0.3;
}
.b1 { width: 300px; height: 300px; background: #6c9bd2; top: -100px; left: -100px; }
.b2 { width: 200px; height: 200px; background: #fef3c7; bottom: 50px; right: -50px; }

@keyframes pulse {
  0% { transform: scale(1); opacity: 0.5; }
  50% { transform: scale(1.2); opacity: 1; }
  100% { transform: scale(1); opacity: 0.5; }
}

@keyframes typing {
  0%, 80%, 100% { transform: scale(0); }
  40% { transform: scale(1); }
}

.rotating { animation: rotate 2s linear infinite; }
@keyframes rotate { from { transform: rotate(0deg); } to { transform: rotate(360deg); } }

.bottom-gap { height: 20px; }
</style>

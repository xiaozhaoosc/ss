<script setup lang="ts">
import { ref, onMounted, nextTick } from 'vue'
import { onShow } from '@dcloudio/uni-app'
import { useUserStore } from '@/store/modules/user'
import { chatWithAI } from '@/api/child'

const userStore = useUserStore()
const messages = ref([
  { role: 'ai', content: '嘿！我是你的小步伙伴。今天有什么想跟我说的吗？不管是开心还是难过，我都在这听着哦。👂', type: 'text' }
])
const inputText = ref('')
const isRecording = ref(false)
const scrollIntoView = ref('')
const isLoading = ref(false)

const handleBack = () => {
  uni.navigateBack()
}

const sendMessage = async () => {
  if (!inputText.value.trim() || isLoading.value) return
  
  const userMsg = inputText.value
  messages.value.push({ role: 'user', content: userMsg, type: 'text' })
  inputText.value = ''
  isLoading.value = true
  
  scrollToBottom()
  
  try {
    const childId = userStore.id
    if (!childId) return
    const res: any = await chatWithAI(childId, userMsg)
    messages.value.push({
      role: 'ai',
      content: res.data || '我听到了哦，你真的很棒！🌟',
      type: 'text'
    })
  } catch (e) {
    messages.value.push({
      role: 'ai',
      content: '哎呀，我的信号好像飘走了... 但我一直在你身边！❤️',
      type: 'text'
    })
  } finally {
    isLoading.value = false
    scrollToBottom()
  }
}

const toggleRecording = () => {
  isRecording.value = !isRecording.value
  if (!isRecording.value) {
    // 模拟录音结束发送
    inputText.value = "我今天在学校画了一头蓝色的狮子，老师夸我很有想象力！"
    sendMessage()
  }
}

const scrollToBottom = () => {
  nextTick(() => {
    scrollIntoView.value = 'msg-' + (messages.value.length - 1)
  })
}

onMounted(() => {
  scrollToBottom()
})
</script>

<template>
  <view class="treehole-page">
    <!-- Header -->
    <view class="header">
      <button class="back-btn" @click="handleBack">
        <text class="material-symbols-outlined icon">arrow_back</text>
      </button>
      <view class="title-area">
        <text class="title">秘密树洞</text>
        <view class="status">
          <view class="dot"></view>
          <text>AI 伙伴在线</text>
        </view>
      </view>
      <view class="spacer"></view>
    </view>

    <!-- Chat Area -->
    <scroll-view 
      scroll-y 
      class="chat-content" 
      :scroll-into-view="scrollIntoView"
      scroll-with-animation
    >
      <view class="message-list">
        <view 
          v-for="(msg, index) in messages" 
          :key="index" 
          :id="'msg-' + index"
          class="message-item"
          :class="msg.role"
        >
          <view v-if="msg.role === 'ai'" class="avatar ai-avatar">
            <text class="material-symbols-outlined">smart_toy</text>
          </view>
          <view class="bubble" :class="{ 'loading': isLoading && index === messages.length - 1 && msg.role === 'user' }">
            <text class="text">{{ msg.content }}</text>
          </view>
          <view v-if="msg.role === 'user'" class="avatar user-avatar">
            <text class="material-symbols-outlined">person</text>
          </view>
        </view>
        
        <view v-if="isLoading" class="message-item ai">
          <view class="avatar ai-avatar">
            <text class="material-symbols-outlined">smart_toy</text>
          </view>
          <view class="bubble typing">
            <view class="dot"></view>
            <view class="dot"></view>
            <view class="dot"></view>
          </view>
        </view>
      </view>
      <view class="bottom-spacer"></view>
    </scroll-view>

    <!-- Input Area -->
    <view class="input-panel">
      <view class="input-wrapper">
        <input 
          v-model="inputText" 
          class="text-input" 
          placeholder="跟小步说点什么..." 
          @confirm="sendMessage"
        />
        <view class="voice-btn" :class="{ 'active': isRecording }" @click="toggleRecording">
          <text class="material-symbols-outlined">{{ isRecording ? 'stop' : 'mic' }}</text>
        </view>
      </view>
      <button class="send-btn" @click="sendMessage" :disabled="!inputText.trim()">
        <text class="material-symbols-outlined">send</text>
      </button>
    </view>
    
    <!-- Visual background decoration -->
    <view class="decoration blob-1"></view>
    <view class="decoration blob-2"></view>
  </view>
</template>

<style lang="scss" scoped>
.treehole-page {
  height: 100vh;
  background-color: #F0F9FF;
  display: flex;
  flex-direction: column;
  position: relative;
  overflow: hidden;
}

.header {
  display: flex;
  align-items: center;
  justify-content: space-between;
  padding: 16px;
  padding-top: calc(16px + env(safe-area-inset-top));
  background: rgba(255, 255, 255, 0.8);
  backdrop-filter: blur(10px);
  z-index: 100;
  border-bottom: 1px solid rgba(0, 0, 0, 0.05);
}

.back-btn {
  width: 40px;
  height: 40px;
  border-radius: 12px;
  background: white;
  display: flex;
  align-items: center;
  justify-content: center;
  box-shadow: 0 2px 8px rgba(0,0,0,0.05);
  border: none;
  &::after { border: none; }
}

.title-area {
  display: flex;
  flex-direction: column;
  align-items: center;
  .title { font-size: 18px; font-weight: 800; color: #0C4A6E; }
  .status {
    display: flex;
    align-items: center;
    gap: 4px;
    font-size: 10px;
    color: #0EA5E9;
    .dot { width: 6px; height: 6px; background: #0EA5E9; border-radius: 50%; animation: pulse 2s infinite; }
  }
}

.spacer { width: 40px; }

.chat-content {
  flex: 1;
  padding: 16px;
  z-index: 10;
}

.message-list {
  display: flex;
  flex-direction: column;
  gap: 20px;
}

.message-item {
  display: flex;
  align-items: flex-end;
  gap: 12px;
  max-width: 85%;
  
  &.ai { align-self: flex-start; }
  &.user { align-self: flex-end; flex-direction: row-reverse; }
}

.avatar {
  width: 36px;
  height: 36px;
  border-radius: 12px;
  display: flex;
  align-items: center;
  justify-content: center;
  box-shadow: 0 4px 10px rgba(0,0,0,0.1);
  
  &.ai-avatar { background: #BAE6FD; color: #0284C7; }
  &.user-avatar { background: #FDE68A; color: #D97706; }
}

.bubble {
  padding: 12px 16px;
  border-radius: 20px;
  font-size: 15px;
  line-height: 1.5;
  box-shadow: 0 2px 12px rgba(0,0,0,0.03);
  
  .ai & {
    background: white;
    color: #1E293B;
    border-bottom-left-radius: 4px;
  }
  
  .user & {
    background: #0EA5E9;
    color: white;
    border-bottom-right-radius: 4px;
  }
}

.typing {
  display: flex;
  gap: 4px;
  padding: 12px 20px;
  .dot {
    width: 6px;
    height: 6px;
    background: #CBD5E1;
    border-radius: 50%;
    animation: typing 1.4s infinite both;
    &:nth-child(2) { animation-delay: 0.2s; }
    &:nth-child(3) { animation-delay: 0.4s; }
  }
}

.input-panel {
  padding: 16px;
  padding-bottom: calc(16px + env(safe-area-inset-bottom));
  background: white;
  display: flex;
  gap: 12px;
  z-index: 100;
  box-shadow: 0 -4px 20px rgba(0,0,0,0.05);
}

.input-wrapper {
  flex: 1;
  background: #F1F5F9;
  border-radius: 24px;
  display: flex;
  align-items: center;
  padding: 4px 4px 4px 16px;
  border: 1px solid #E2E8F0;
}

.text-input {
  flex: 1;
  height: 40px;
  font-size: 14px;
}

.voice-btn {
  width: 40px;
  height: 40px;
  border-radius: 20px;
  background: white;
  display: flex;
  align-items: center;
  justify-content: center;
  color: #64748B;
  transition: all 0.3s;
  
  &.active {
    background: #EF4444;
    color: white;
    animation: pulse-red 1.5s infinite;
  }
}

.send-btn {
  width: 48px;
  height: 48px;
  border-radius: 16px;
  background: #0EA5E9;
  color: white;
  display: flex;
  align-items: center;
  justify-content: center;
  border: none;
  &:disabled { opacity: 0.5; }
  &::after { border: none; }
}

.decoration {
  position: absolute;
  z-index: 0;
  border-radius: 50%;
  filter: blur(60px);
}
.blob-1 { width: 300px; height: 300px; background: #BAE6FD; top: -100px; right: -100px; opacity: 0.4; }
.blob-2 { width: 300px; height: 300px; background: #FDE68A; bottom: -100px; left: -100px; opacity: 0.3; }

.bottom-spacer { height: 20px; }

@keyframes pulse {
  0% { opacity: 0.4; transform: scale(1); }
  50% { opacity: 1; transform: scale(1.2); }
  100% { opacity: 0.4; transform: scale(1); }
}

@keyframes pulse-red {
  0% { box-shadow: 0 0 0 0 rgba(239, 68, 68, 0.4); }
  70% { box-shadow: 0 0 0 10px rgba(239, 68, 68, 0); }
  100% { box-shadow: 0 0 0 0 rgba(239, 68, 68, 0); }
}

@keyframes typing {
  0%, 80%, 100% { transform: scale(0); }
  40% { transform: scale(1); }
}
</style>

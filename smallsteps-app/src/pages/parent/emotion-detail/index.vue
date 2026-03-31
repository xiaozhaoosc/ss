<template>
  <view class="emotion-detail-page" :class="{ 'dark': isDarkMode }">
    <!-- Top Bar -->
    <top-bar title="情感详情" :show-back="true"></top-bar>

    <scroll-view scroll-y class="main-content no-scrollbar">
      <!-- Media Player Section -->
      <view class="section">
        <audio-player 
          :src="audioData.src"
          :title="audioData.title"
          :subtitle="audioData.subtitle"
          :cover="audioData.cover"
        />
      </view>

      <!-- AI Analysis Card -->
      <view class="section">
        <view class="analysis-card">
          <view class="card-header">
            <view class="header-icon-box">
              <text class="material-symbols-outlined icon">auto_awesome</text>
            </view>
            <text class="card-title">AI 分析报告</text>
          </view>
          
          <!-- Tags -->
          <view class="tags">
            <view v-for="tag in analysis.tags" :key="tag.text" class="tag" :class="tag.type">
              <view class="dot"></view>
              <text class="tag-text">{{ tag.text }}</text>
            </view>
          </view>
          
          <!-- Analysis Text -->
          <view class="analysis-text-box">
            <view class="decoration-line"></view>
            <text class="analysis-text">
              {{ analysis.summary }}
            </text>
          </view>
        </view>
      </view>

      <!-- Transcript Section -->
      <view class="section">
        <view class="transcript-card">
          <view class="card-header justify-between">
            <view class="flex items-center gap-2">
              <view class="header-icon-box green">
                <text class="material-symbols-outlined icon">description</text>
              </view>
              <text class="card-title">录音文稿</text>
            </view>
            <text class="format-badge">AI 整理</text>
          </view>

          <view class="transcript-content">
            <view v-for="(line, index) in transcript" :key="index" class="transcript-line">
              <text class="timestamp">({{ line.time }})</text>
              <text class="text">{{ line.content }}</text>
            </view>
          </view>
          
          <view class="divider"></view>
          <button class="view-more-btn" @click="handleViewMore">查看更多</button>
        </view>
      </view>
      
      <view class="spacer"></view>
    </scroll-view>

    <!-- Footer Action Bar -->
    <footer class="footer">
      <h3 class="footer-title">家长回复</h3>
      <view class="action-buttons">
        <button class="action-btn voice" @click="handleVoiceReply">
          <view class="btn-icon">
            <text class="material-symbols-outlined">mic</text>
          </view>
          <text class="btn-text">录制语音</text>
        </button>
        
        <button class="action-btn ai" @click="handleAiReply">
          <view class="btn-icon primary">
            <text class="material-symbols-outlined">magic_button</text>
          </view>
          <text class="btn-text primary">使用 AI 建议</text>
        </button>
      </view>
    </footer>
  </view>
</template>

<script setup>
import { ref } from 'vue'
import TopBar from '@/components/common/top-bar/top-bar.vue'
import AudioPlayer from '@/components/parent/audio-player/audio-player.vue'

const isDarkMode = ref(false)

const audioData = ref({
  src: '',
  title: '10月24日 - 树洞录音',
  subtitle: '下午 4:32 • 星期二',
  cover: 'https://lh3.googleusercontent.com/aida-public/AB6AXuDAKbTSgFUG4tO8fG6Mj7-aEQbZYBHnnnRiC3nr8hKUHntAsqfQyVMRLadvC94V-h3F9ROliE-tekIGcRZwcDC_fhfBKmRYWTDzEJfVKf027emv1NU1eEcPqJOGCLUXbzXlOuMg_EHG0uMu2NcIzP0fRWrjrGGZM9tw7ZXxaena7DIedlMstaGy-cwHLayuET22bH-Ghz_wakvHPmbxp89X5ki21Ut8Tnc-u7WYEPWJebwBLuuXqKZtzHGeMHqQqWyLJ4fE_drWK98'
})

const analysis = ref({
  tags: [
    { text: '数学焦虑', type: 'orange' },
    { text: '高强度', type: 'red' },
    { text: '寻求关注', type: 'blue' }
  ],
  summary: '检测到孩子在谈论数学考试时语速加快，声调升高，表现出明显的焦虑情绪。这通常反映了对成绩的过分担忧。建议给予鼓励而非压力。'
})

const transcript = ref([
  { time: '00:00', content: '既然说到了数学考试，我就觉得... 特别紧张。' },
  { time: '00:05', content: '每次看到那些数字，我就感觉头有点晕。我不想要不及格，那样会被同学笑话。' },
  { time: '00:12', content: '其实我也复习了，但是一进考场就忘光了。' }
])

const handleViewMore = () => {
  uni.showToast({ title: '加载更多...', icon: 'none' })
}

const handleVoiceReply = () => {
  uni.showToast({ title: '开启录音...', icon: 'none' })
}

const handleAiReply = () => {
  uni.showModal({
    title: 'AI 回复建议',
    content: '“宝贝，妈妈知道你很努力了。不管考试结果如何，我们都爱你。放轻松，我们一起面对。”',
    confirmText: '发送',
    cancelText: '换一个',
    success: (res) => {
      if (res.confirm) {
        uni.showToast({ title: '已发送至设备', icon: 'success' })
      }
    }
  })
}
</script>

<style lang="scss" scoped>
.emotion-detail-page {
  height: 100vh;
  display: flex;
  flex-direction: column;
  background-color: #f8f9fb;
  
  :deep(.dark) & {
    background-color: #14191e;
  }
}

.main-content {
  flex: 1;
  padding: 16px;
  padding-top: 60px;
}

.section {
  margin-bottom: 24px;
}

.analysis-card, .transcript-card {
  padding: 20px;
  background-color: #ffffff;
  border-radius: 16px;
  border: 1px solid #f3f4f6;
  box-shadow: 0 1px 3px rgba(0,0,0,0.02);
  
  :deep(.dark) & {
    background-color: #1e242b;
    border-color: #1f2937;
  }
}

.card-header {
  display: flex;
  align-items: center;
  gap: 12px;
  margin-bottom: 16px;
  
  &.justify-between { justify-content: space-between; }
}

.header-icon-box {
  padding: 6px;
  background-color: rgba(147, 51, 234, 0.1);
  border-radius: 8px;
  display: flex;
  
  &.green { background-color: rgba(16, 185, 129, 0.1); .icon { color: #10b981; } }
  
  .icon {
    font-size: 20px;
    color: #9333ea;
  }
}

.card-title {
  font-size: 16px;
  font-weight: 700;
  color: #111827;
  :deep(.dark) & { color: #fff; }
}

.format-badge {
  font-size: 10px;
  color: #9ca3af;
  background-color: #f3f4f6;
  padding: 2px 8px;
  border-radius: 4px;
  :deep(.dark) & { background-color: #374151; }
}

.tags {
  display: flex;
  flex-wrap: wrap;
  gap: 8px;
  margin-bottom: 16px;
}

.tag {
  display: flex;
  align-items: center;
  gap: 6px;
  padding: 6px 12px;
  border-radius: 999px;
  font-size: 12px;
  font-weight: 500;
  
  &.orange { background-color: rgba(245, 158, 11, 0.1); border: 1px solid rgba(245, 158, 11, 0.2); .dot { background-color: #f59e0b; } .tag-text { color: #d97706; } }
  &.red { background-color: rgba(239, 68, 68, 0.1); border: 1px solid rgba(239, 68, 68, 0.2); .dot { background-color: #ef4444; } .tag-text { color: #dc2626; } }
  &.blue { background-color: rgba(59, 130, 246, 0.1); border: 1px solid rgba(59, 130, 246, 0.2); .dot { background-color: #3b82f6; } .tag-text { color: #2563eb; } }
}

.dot {
  width: 6px;
  height: 6px;
  border-radius: 99px;
}

.analysis-text-box {
  display: flex;
  gap: 12px;
}

.decoration-line {
  width: 2px;
  background-color: rgba(108, 155, 210, 0.3);
  border-radius: 1px;
}

.analysis-text {
  font-size: 14px;
  line-height: 1.6;
  color: #4b5563;
  :deep(.dark) & { color: #d1d5db; }
}

.transcript-content {
  display: flex;
  flex-direction: column;
  gap: 12px;
}

.transcript-line {
  display: flex;
  gap: 8px;
  font-size: 14px;
  line-height: 1.5;
}

.timestamp {
  font-weight: 700;
  color: #111827;
  flex-shrink: 0;
  :deep(.dark) & { color: #fff; }
}

.text {
  color: #4b5563;
  :deep(.dark) & { color: #d1d5db; }
}

.divider {
  height: 1px;
  background-color: #f3f4f6;
  margin: 16px 0;
  :deep(.dark) & { background-color: #374151; }
}

.view-more-btn {
  width: 100%;
  font-size: 14px;
  font-weight: 600;
  color: #6C9BD2;
  background: transparent;
  padding: 4px;
  &::after { border: none; }
}

.spacer {
  height: 160px;
}

.footer {
  position: fixed;
  bottom: 0;
  left: 0;
  right: 0;
  padding: 20px;
  padding-bottom: calc(24px + env(safe-area-inset-bottom));
  background-color: #ffffff;
  border-top-left-radius: 20px;
  border-top-right-radius: 20px;
  box-shadow: 0 -4px 10px rgba(0,0,0,0.05);
  z-index: 100;
  
  :deep(.dark) & {
    background-color: #1e242b;
    border-top: 1px solid #1f2937;
  }
}

.footer-title {
  font-size: 16px;
  font-weight: 700;
  margin-bottom: 16px;
  color: #111827;
  :deep(.dark) & { color: #fff; }
}

.action-buttons {
  display: flex;
  gap: 12px;
}

.action-btn {
  flex: 1;
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
  gap: 8px;
  padding: 12px;
  border-radius: 12px;
  background-color: #f9fafb;
  border: 1px solid #f3f4f6;
  
  :deep(.dark) & {
    background-color: #14191e;
    border-color: #374151;
  }
  
  &.ai {
    background-color: rgba(108, 155, 210, 0.1);
    border-color: rgba(108, 155, 210, 0.2);
  }
  
  &::after { border: none; }
  
  &:active {
    transform: scale(0.96);
    opacity: 0.8;
  }
}

.btn-icon {
  width: 40px;
  height: 40px;
  border-radius: 999px;
  background-color: #ffffff;
  display: flex;
  align-items: center;
  justify-content: center;
  box-shadow: 0 1px 3px rgba(0,0,0,0.05);
  
  :deep(.dark) & { background-color: #374151; }
  
  &.primary {
    background-color: #6C9BD2;
    color: #ffffff;
    box-shadow: 0 2px 6px rgba(108, 155, 210, 0.3);
  }
  
  .material-symbols-outlined { font-size: 24px; color: #6C9BD2; }
  &.primary .material-symbols-outlined { color: #ffffff; }
}

.btn-text {
  font-size: 14px;
  font-weight: 500;
  color: #111827;
  :deep(.dark) & { color: #fff; }
  &.primary { color: #6C9BD2; }
}

.no-scrollbar::-webkit-scrollbar {
  display: none;
}
</style>

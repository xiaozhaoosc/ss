<template>
  <view class="child-task-page" :class="{ 'dark': isDarkMode }">
    <!-- Header -->
    <view class="header">
      <button class="back-btn" @click="handleBack">
        <text class="material-symbols-outlined icon">arrow_back</text>
      </button>
      <text class="page-title">专注时刻</text>
      <view class="spacer"></view>
    </view>

    <view class="main-content">
      <!-- Progress Indicator -->
      <view class="progress-pill">
        <text class="material-symbols-outlined flag-icon">flag</text>
        <text class="step-text">第 1/3 步</text>
      </view>

      <!-- Headline -->
      <text class="headline">正在阅读...</text>

      <!-- Timer -->
      <mission-timer 
        :duration="900" 
        :is-playing="true"
        @finish="handleTimerFinish"
      />

      <!-- Decor -->
      <view class="loading-dots">
        <view class="dot"></view>
        <view class="dot delay-1"></view>
        <view class="dot delay-2"></view>
      </view>
    </view>

    <!-- Footer Action -->
    <view class="footer">
      <button class="complete-btn" :loading="isLoading" @click="handleComplete">
        <!-- Shine effect -->
        <view class="shine"></view>
        <view class="btn-content">
          <text class="btn-text">我完成了！</text>
          <text class="material-symbols-outlined check-icon">check_circle</text>
        </view>
      </button>
      <text class="hint-text">点击上方按钮完成当前任务</text>
    </view>

    <!-- Background Decorations -->
    <view class="blob blob-1"></view>
    <view class="blob blob-2"></view>
    
    <!-- Child Nav -->
    <child-bottom-nav active="task" />
  </view>
</template>

<script setup>
import { ref } from 'vue'
import { onLoad } from '@dcloudio/uni-app'
import MissionTimer from '@/components/child/mission-timer/mission-timer.vue'
import ChildBottomNav from '@/components/child/child-bottom-nav/child-bottom-nav.vue'
import { updateTask, getTask } from '@/api/task'

const isDarkMode = ref(false)
const taskId = ref(null)
const isLoading = ref(false)

onLoad((options) => {
  if (options.taskId) {
    taskId.value = options.taskId
  }
})

const handleBack = () => {
  uni.navigateBack()
}

const handleTimerFinish = () => {
  uni.showToast({ title: '时间到！', icon: 'none' })
}

const handleComplete = () => {
  if (!taskId.value) {
    uni.showToast({ title: '任务ID丢失', icon: 'error' })
    return
  }
  
  isLoading.value = true
  uni.showLoading({ title: '提交中...' })
  
  updateTask({ taskId: taskId.value, status: '1' }).then(() => {
    uni.hideLoading()
    uni.showToast({ title: '太棒了！任务完成！', icon: 'success' })
    setTimeout(() => {
      uni.navigateBack()
    }, 1500)
  }).catch(() => {
    uni.hideLoading()
    isLoading.value = false
  })
}
</script>

<style lang="scss" scoped>
.child-task-page {
  height: 100vh;
  display: flex;
  flex-direction: column;
  background-color: #F0F9FF;
  position: relative;
  overflow: hidden;
  
  :deep(.dark) & { background-color: #102216; }
}

.header {
  display: flex;
  align-items: center;
  justify-content: space-between;
  padding: 24px 24px 8px 24px;
  padding-top: calc(32px + env(safe-area-inset-top));
  position: relative;
  z-index: 10;
}

.back-btn {
  width: 48px;
  height: 48px;
  border-radius: 999px;
  background-color: rgba(255, 255, 255, 0.5);
  display: flex;
  align-items: center;
  justify-content: center;
  color: #334155;
  border: none;
  
  &::after { border: none; }
  
  :deep(.dark) & { background-color: rgba(255, 255, 255, 0.1); color: #fff; }
  
  .icon { font-size: 28px; }
}

.page-title {
  font-size: 18px;
  font-weight: 700;
  color: #1e293b;
  :deep(.dark) & { color: #fff; }
}

.spacer { width: 48px; }

.main-content {
  flex: 1;
  display: flex;
  flex-direction: column;
  align-items: center;
  padding: 0 24px;
  position: relative;
  z-index: 10;
}

.progress-pill {
  margin-top: 16px;
  margin-bottom: 8px;
  display: flex;
  align-items: center;
  gap: 8px;
  padding: 8px 16px;
  border-radius: 999px;
  background-color: rgba(140, 208, 161, 0.2);
  border: 1px solid rgba(140, 208, 161, 0.3);
  
  .flag-icon { font-size: 20px; color: #059669; }
  .step-text { font-size: 14px; font-weight: 700; color: #065f46; letter-spacing: 0.5px; }
  
  :deep(.dark) & { .flag-icon { color: #34d399; } .step-text { color: #d1fae5; } }
}

.headline {
  font-size: 36px;
  font-weight: 900;
  color: #1e293b;
  text-align: center;
  padding: 16px 0;
  letter-spacing: -1px;
  :deep(.dark) & { color: #fff; }
}

.loading-dots {
  display: flex;
  justify-content: center;
  gap: 4px;
  padding-bottom: 24px;
  opacity: 0.6;
}

.dot {
  width: 8px;
  height: 8px;
  border-radius: 999px;
  background-color: #8CD0A1;
  animation: pulse 1.5s infinite;
  
  &.delay-1 { animation-delay: 0.1s; }
  &.delay-2 { animation-delay: 0.2s; }
}

@keyframes pulse {
  0%, 100% { opacity: 1; transform: scale(1); }
  50% { opacity: 0.5; transform: scale(0.8); }
}

.footer {
  padding: 0 24px 40px 24px;
  padding-bottom: calc(100px + env(safe-area-inset-bottom)); /* Extra padding for bottom nav */
  position: relative;
  z-index: 20;
}

.complete-btn {
  width: 100%;
  height: 80px;
  background-color: #13ec54;
  border-radius: 999px;
  position: relative;
  overflow: hidden;
  box-shadow: 0 10px 25px -5px rgba(19, 236, 84, 0.4), 0 8px 0 rgba(15, 184, 64, 1);
  transition: transform 0.1s cubic-bezier(0.34, 1.56, 0.64, 1);
  border: none;
  
  &::after { border: none; }
  
  &:active {
    transform: scale(0.98) translateY(4px);
    box-shadow: 0 4px 0 rgba(15, 184, 64, 1);
  }
}

.shine {
  position: absolute;
  top: 0;
  left: 0;
  width: 100%;
  height: 50%;
  background: linear-gradient(to bottom, rgba(255,255,255,0.3), transparent);
  pointer-events: none;
}

.btn-content {
  display: flex;
  align-items: center;
  justify-content: center;
  gap: 12px;
  height: 100%;
  position: relative;
  z-index: 10;
}

.btn-text {
  font-size: 24px;
  font-weight: 900;
  color: #0d1b12;
  letter-spacing: 0.5px;
}

.check-icon {
  font-size: 32px;
  color: #0d1b12;
}

.hint-text {
  text-align: center;
  font-size: 12px;
  font-weight: 500;
  color: #94a3b8;
  margin-top: 16px;
  display: block;
}

.blob {
  position: absolute;
  border-radius: 999px;
  filter: blur(40px);
  z-index: 0;
  pointer-events: none;
}

.blob-1 {
  width: 96px;
  height: 96px;
  background-color: rgba(140, 208, 161, 0.1);
  top: 80px;
  left: -20px;
}

.blob-2 {
  width: 128px;
  height: 128px;
  background-color: rgba(19, 236, 84, 0.1);
  bottom: 160px;
  right: -10px;
}
</style>

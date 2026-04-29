<template>
  <view class="art-class-page">
    <!-- Premium Header -->
    <view class="glass-header">
      <view class="back-btn" @click="handleBack">
        <text class="material-symbols-outlined">arrow_back_ios_new</text>
      </view>
      <text class="header-title">艺术实验室</text>
      <view class="save-btn" @click="handleSave">
        <text class="material-symbols-outlined">auto_awesome</text>
      </view>
    </view>

    <!-- Inspiration Card -->
    <view class="inspiration-card">
      <view class="sparkle-icon">✨</view>
      <view class="inspiration-content">
        <text class="inspiration-label">今日灵感</text>
        <text class="inspiration-text">“用你喜欢的颜色，画一个快乐的云朵吧！”</text>
      </view>
    </view>

    <!-- Pixel Canvas Area -->
    <view class="canvas-container">
      <view class="canvas-grid">
        <view 
          v-for="(cell, index) in canvasData" 
          :key="index"
          class="pixel-cell"
          :style="{ backgroundColor: cell }"
          @click="paintPixel(index)"
        ></view>
      </view>
    </view>

    <!-- Tools & Palette -->
    <view class="tools-bar glass-morphism">
      <view class="palette">
        <view 
          v-for="color in colors" 
          :key="color"
          class="color-swatch"
          :class="{ active: currentColor === color }"
          :style="{ backgroundColor: color }"
          @click="currentColor = color"
        >
          <view v-if="currentColor === color" class="active-dot"></view>
        </view>
      </view>
      
      <view class="action-btns">
        <view class="tool-btn" @click="clearCanvas">
          <text class="material-symbols-outlined">delete</text>
        </view>
        <view class="tool-btn primary" @click="handleShowParent">
          <text class="material-symbols-outlined">send</text>
          <text class="btn-label">作品上墙</text>
        </view>
      </view>
    </view>

    <!-- Success Modal -->
    <view v-if="showSuccess" class="success-overlay" @click="showSuccess = false">
      <view class="success-card scale-up">
        <view class="confetti">🎉</view>
        <text class="success-title">太棒了！</text>
        <text class="success-msg">你的作品已经成功上墙，爸爸妈妈很快就能看到啦！</text>
        <view class="ok-btn" @click="handleBack">回首页</view>
      </view>
    </view>
  </view>
</template>

<script setup lang="ts">
import { ref, reactive } from 'vue'

const handleBack = () => {
  uni.navigateBack()
}

const colors = [
  '#FF6B6B', '#4ECDC4', '#45B7D1', '#FFA07A', 
  '#98D8C8', '#F7DC6F', '#BB8FCE', '#82E0AA',
  '#F1948A', '#85C1E9', '#FFFFFF', '#34495E'
]

const currentColor = ref(colors[0])
const canvasData = ref(Array(320).fill('#F8FAFC')) // 16x20 grid

const paintPixel = (index: number) => {
  uni.vibrateShort()
  canvasData.value[index] = currentColor.value
}

const clearCanvas = () => {
  uni.showModal({
    title: '重新开始',
    content: '确定要清除当前的画作吗？',
    success: (res) => {
      if (res.confirm) {
        canvasData.value = Array(320).fill('#F8FAFC')
      }
    }
  })
}

const showSuccess = ref(false)
const handleShowParent = () => {
  uni.vibrateLong()
  showSuccess.value = true
  // In a real app, we would send the canvas data to the backend here
}

const handleSave = () => {
  uni.showToast({ title: '已保存到草稿箱', icon: 'success' })
}
</script>

<style lang="scss" scoped>
.art-class-page {
  min-height: 100vh;
  background: linear-gradient(135deg, #FDF2F8 0%, #FAE8FF 100%);
  padding-top: env(safe-area-inset-top);
  display: flex;
  flex-direction: column;
}

.glass-header {
  display: flex;
  align-items: center;
  justify-content: space-between;
  padding: 16px;
  background: rgba(255, 255, 255, 0.6);
  backdrop-filter: blur(10px);
  border-bottom: 1px solid rgba(255, 255, 255, 0.3);
}

.header-title {
  font-size: 18px;
  font-weight: 800;
  color: #701A75;
}

.back-btn, .save-btn {
  width: 40px;
  height: 40px;
  display: flex;
  align-items: center;
  justify-content: center;
  border-radius: 12px;
  background: white;
  box-shadow: 0 4px 10px rgba(0,0,0,0.05);
  color: #701A75;
}

.inspiration-card {
  margin: 16px;
  padding: 16px;
  background: white;
  border-radius: 20px;
  display: flex;
  align-items: center;
  gap: 12px;
  box-shadow: 0 8px 20px rgba(112, 26, 117, 0.08);
  border: 2px solid #FDF2F8;
}

.sparkle-icon {
  font-size: 24px;
}

.inspiration-content {
  display: flex;
  flex-direction: column;
}

.inspiration-label {
  font-size: 12px;
  font-weight: 700;
  color: #D946EF;
  text-transform: uppercase;
}

.inspiration-text {
  font-size: 14px;
  color: #4B5563;
  font-weight: 600;
}

.canvas-container {
  flex: 1;
  display: flex;
  align-items: center;
  justify-content: center;
  padding: 0 16px;
}

.canvas-grid {
  width: 100%;
  aspect-ratio: 16 / 20;
  background: white;
  display: grid;
  grid-template-columns: repeat(16, 1fr);
  grid-template-rows: repeat(20, 1fr);
  border-radius: 12px;
  overflow: hidden;
  box-shadow: 0 20px 50px rgba(0,0,0,0.1);
  border: 4px solid white;
}

.pixel-cell {
  border: 0.5px solid #F1F5F9;
  transition: background-color 0.1s;
}

.tools-bar {
  padding: 20px;
  padding-bottom: calc(20px + env(safe-area-inset-bottom));
  background: rgba(255, 255, 255, 0.8);
  backdrop-filter: blur(20px);
  border-top-left-radius: 30px;
  border-top-right-radius: 30px;
  box-shadow: 0 -10px 30px rgba(0,0,0,0.05);
}

.palette {
  display: flex;
  flex-wrap: wrap;
  gap: 12px;
  margin-bottom: 20px;
  justify-content: center;
}

.color-swatch {
  width: 32px;
  height: 32px;
  border-radius: 50%;
  border: 2px solid white;
  box-shadow: 0 4px 8px rgba(0,0,0,0.1);
  position: relative;
  
  &.active {
    transform: scale(1.2);
    box-shadow: 0 6px 12px rgba(0,0,0,0.15);
  }
}

.active-dot {
  position: absolute;
  top: 50%;
  left: 50%;
  transform: translate(-50%, -50%);
  width: 8px;
  height: 8px;
  background: rgba(0,0,0,0.3);
  border-radius: 50%;
}

.action-btns {
  display: flex;
  gap: 12px;
}

.tool-btn {
  height: 54px;
  display: flex;
  align-items: center;
  justify-content: center;
  border-radius: 16px;
  background: white;
  box-shadow: 0 4px 10px rgba(0,0,0,0.05);
  color: #4B5563;
  
  &.primary {
    flex: 1;
    background: #D946EF;
    color: white;
    gap: 8px;
    font-weight: 800;
    box-shadow: 0 8px 20px rgba(217, 70, 239, 0.3);
  }
  
  &:active { transform: scale(0.95); }
}

.success-overlay {
  position: fixed;
  top: 0;
  left: 0;
  right: 0;
  bottom: 0;
  background: rgba(0,0,0,0.5);
  z-index: 100;
  display: flex;
  align-items: center;
  justify-content: center;
  padding: 30px;
}

.success-card {
  background: white;
  border-radius: 30px;
  padding: 30px;
  display: flex;
  flex-direction: column;
  align-items: center;
  text-align: center;
}

.confetti { font-size: 60px; margin-bottom: 20px; }
.success-title { font-size: 24px; font-weight: 800; color: #1F2937; margin-bottom: 12px; }
.success-msg { font-size: 16px; color: #6B7280; margin-bottom: 24px; }
.ok-btn {
  width: 100%;
  height: 54px;
  background: #D946EF;
  color: white;
  display: flex;
  align-items: center;
  justify-content: center;
  border-radius: 16px;
  font-weight: 800;
}

.scale-up {
  animation: scaleUp 0.4s cubic-bezier(0.175, 0.885, 0.32, 1.275);
}

@keyframes scaleUp {
  from { transform: scale(0.8); opacity: 0; }
  to { transform: scale(1); opacity: 1; }
}
</style>

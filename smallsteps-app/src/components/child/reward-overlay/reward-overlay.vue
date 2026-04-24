<template>
  <view v-if="visible" class="reward-overlay" @touchmove.stop.prevent>
    <!-- Celebration Backdrop -->
    <view class="backdrop"></view>
    
    <!-- Star Particles -->
    <view class="star-container">
      <view 
        v-for="i in 20" 
        :key="i" 
        class="star-particle" 
        :style="getStarStyle(i)"
      >
        <text class="material-symbols-outlined">star</text>
      </view>
    </view>
    
    <!-- Central Card -->
    <view class="reward-card" :class="{ 'card-show': visible }">
      <view class="card-header">
        <view class="crown-icon">
          <text class="material-symbols-outlined">workspace_premium</text>
        </view>
        <text class="title">任务达成！</text>
        <text class="subtitle">你做得太棒了，{{ childName }}！</text>
      </view>
      
      <view class="reward-content">
        <view class="star-display">
          <view class="star-icon-wrapper">
            <text class="material-symbols-outlined star-icon">star</text>
          </view>
          <text class="star-count">+{{ points }}</text>
        </view>
        <text class="congrats-text">勇气碎片已存入你的能量罐</text>
      </view>
      
      <view class="card-footer">
        <button class="collect-btn" @click="handleCollect">
          <text class="btn-text">领取奖励</text>
          <text class="material-symbols-outlined">keyboard_double_arrow_right</text>
        </button>
      </view>
    </view>
  </view>
</template>

<script setup lang="ts">
import { ref, watch } from 'vue'

const props = defineProps({
  visible: { type: Boolean, default: false },
  points: { type: Number, default: 10 },
  childName: { type: String, default: '小英雄' }
})

const emit = defineEmits(['collect'])

const handleCollect = () => {
  emit('collect')
}

const getStarStyle = (i: number) => {
  const left = Math.random() * 100
  const delay = Math.random() * 2
  const duration = 1.5 + Math.random() * 2
  const size = 20 + Math.random() * 20
  const rotation = Math.random() * 360
  
  return {
    left: `${left}%`,
    animationDelay: `${delay}s`,
    animationDuration: `${duration}s`,
    fontSize: `${size}px`,
    transform: `rotate(${rotation}deg)`
  }
}
</script>

<style lang="scss" scoped>
.reward-overlay {
  position: fixed;
  inset: 0;
  z-index: 9999;
  display: flex;
  align-items: center;
  justify-content: center;
  overflow: hidden;
}

.backdrop {
  position: absolute;
  inset: 0;
  background-color: rgba(13, 27, 18, 0.85);
  backdrop-filter: blur(12px);
}

.star-container {
  position: absolute;
  inset: 0;
  pointer-events: none;
}

.star-particle {
  position: absolute;
  top: -50px;
  color: #F5D76E;
  animation: fall linear infinite;
  opacity: 0;
  
  .material-symbols-outlined {
    font-variation-settings: 'FILL' 1;
    filter: drop-shadow(0 0 10px rgba(245, 215, 110, 0.8));
  }
}

@keyframes fall {
  0% { transform: translateY(0) rotate(0); opacity: 0; }
  10% { opacity: 1; }
  90% { opacity: 1; }
  100% { transform: translateY(110vh) rotate(360deg); opacity: 0; }
}

.reward-card {
  position: relative;
  width: 300px;
  background: linear-gradient(180deg, #FFFFFF 0%, #F0FDF4 100%);
  border-radius: 32px;
  padding: 32px 24px;
  box-shadow: 0 20px 50px rgba(0,0,0,0.5);
  display: flex;
  flex-direction: column;
  align-items: center;
  transform: scale(0.8) translateY(20px);
  opacity: 0;
  transition: all 0.5s cubic-bezier(0.34, 1.56, 0.64, 1);
  
  &.card-show {
    transform: scale(1) translateY(0);
    opacity: 1;
  }
}

.card-header {
  display: flex;
  flex-direction: column;
  align-items: center;
  margin-bottom: 24px;
}

.crown-icon {
  width: 64px;
  height: 64px;
  background-color: #FEF3C7;
  border-radius: 999px;
  display: flex;
  align-items: center;
  justify-content: center;
  margin-bottom: 16px;
  border: 4px solid #F5D76E;
  
  .material-symbols-outlined {
    font-size: 40px;
    color: #D97706;
    font-variation-settings: 'FILL' 1;
  }
}

.title {
  font-size: 28px;
  font-weight: 900;
  color: #166534;
  margin-bottom: 4px;
}

.subtitle {
  font-size: 16px;
  color: #6B7280;
  font-weight: 500;
}

.reward-content {
  display: flex;
  flex-direction: column;
  align-items: center;
  gap: 12px;
  margin-bottom: 32px;
}

.star-display {
  display: flex;
  align-items: center;
  gap: 12px;
}

.star-icon-wrapper {
  width: 48px;
  height: 48px;
  background-color: #13ec54;
  border-radius: 12px;
  display: flex;
  align-items: center;
  justify-content: center;
  box-shadow: 0 4px 10px rgba(19, 236, 84, 0.3);
  
  .star-icon {
    color: #fff;
    font-size: 32px;
    font-variation-settings: 'FILL' 1;
  }
}

.star-count {
  font-size: 40px;
  font-weight: 900;
  color: #1c140d;
}

.congrats-text {
  font-size: 14px;
  color: #15803D;
  font-weight: 700;
  background-color: #DCFCE7;
  padding: 4px 12px;
  border-radius: 999px;
}

.collect-btn {
  width: 200px;
  height: 56px;
  background-color: #1c140d;
  color: #fff;
  border-radius: 16px;
  display: flex;
  align-items: center;
  justify-content: center;
  gap: 8px;
  border: none;
  box-shadow: 0 10px 20px rgba(0,0,0,0.2);
  
  &::after { border: none; }
  
  &:active { transform: scale(0.98); background-color: #000; }
  
  .btn-text {
    font-size: 18px;
    font-weight: 700;
  }
}
</style>

<template>
  <view class="mission-card-container">
    <view class="mission-card" :class="{ 'completed': isCompleted }">
      <view class="card-inner">
        <!-- Background Pattern -->
        <view class="bg-pattern"></view>
        
        <view class="content">
          <view class="icon-box">
            <text class="material-symbols-outlined icon">{{ icon }}</text>
          </view>
          
          <text class="title">{{ title }}</text>
          <text class="subtitle">{{ subtitle }}</text>
          
          <view class="reward-badge">
            <text class="material-symbols-outlined star">star</text>
            <text>+{{ points }} Stars Reward</text>
          </view>
          
          <button class="action-btn" :class="{ 'done': isCompleted }" @click="handleComplete">
            <text>{{ isCompleted ? 'Good Job!' : 'I Did It!' }}</text>
            <text class="material-symbols-outlined check-icon">check_circle</text>
          </button>
        </view>
      </view>
    </view>
  </view>
</template>

<script setup>
import { ref } from 'vue'

const props = defineProps({
  title: String,
  subtitle: String,
  icon: String,
  points: Number
})

const emit = defineEmits(['complete'])
const isCompleted = ref(false)

const handleComplete = () => {
  if (isCompleted.value) return
  isCompleted.value = true
  emit('complete')
}
</script>

<style lang="scss" scoped>
.mission-card-container {
  padding: 0 16px;
  width: 100%;
  max-width: 480px;
}

.mission-card {
  background-color: #ffffff;
  border-radius: 20px;
  padding: 4px;
  box-shadow: 0 8px 0 rgba(0,0,0,0.1);
  border: 4px solid #ffffff;
  transform: rotate(1deg);
  transition: transform 0.3s ease;
  
  &:active { transform: rotate(0) translateY(4px); box-shadow: 0 4px 0 rgba(0,0,0,0.1); }
  &.completed { transform: scale(0.95); opacity: 0.8; }
}

.card-inner {
  background-color: #eff6ff; // blue-50
  border-radius: 16px;
  padding: 24px;
  position: relative;
  overflow: hidden;
  text-align: center;
}

.bg-pattern {
  position: absolute;
  top: 0;
  left: 0;
  width: 100%;
  height: 100%;
  opacity: 0.1;
  background-image: radial-gradient(#4b5563 1px, transparent 1px);
  background-size: 20px 20px;
  pointer-events: none;
}

.content {
  position: relative;
  z-index: 10;
  display: flex;
  flex-direction: column;
  align-items: center;
}

.icon-box {
  background-color: #ffffff;
  padding: 12px;
  border-radius: 16px;
  margin-bottom: 16px;
  box-shadow: 0 1px 2px rgba(0,0,0,0.05);
  border: 2px solid #dbeafe;
  
  .icon { font-size: 48px; color: #3b82f6; }
}

.title {
  font-size: 24px;
  font-weight: 900;
  color: #1c140d;
  margin-bottom: 4px;
  font-family: 'Spline Sans', sans-serif;
}

.subtitle {
  font-size: 16px;
  font-weight: 500;
  color: #6b7280;
  margin-bottom: 24px;
}

.reward-badge {
  background-color: #fef9c3;
  color: #854d0e;
  padding: 6px 16px;
  border-radius: 999px;
  font-size: 14px;
  font-weight: 700;
  margin-bottom: 24px;
  display: flex;
  align-items: center;
  gap: 4px;
  border: 1px solid #fef08a;
  
  .star { font-size: 18px; font-variation-settings: 'FILL' 1; }
}

.action-btn {
  width: 100%;
  height: 64px;
  background-color: #f48c25;
  color: #ffffff;
  font-size: 20px;
  font-weight: 700;
  border-radius: 16px;
  display: flex;
  align-items: center;
  justify-content: center;
  gap: 8px;
  box-shadow: 0 6px 0 #d67614;
  border: none;
  transition: all 0.2s ease;
  
  &::after { border: none; }
  
  &:active { transform: translateY(6px); box-shadow: none; }
  
  &.done {
    background-color: #10b981;
    box-shadow: 0 6px 0 #059669;
  }
  
  .check-icon { font-size: 28px; }
}
</style>

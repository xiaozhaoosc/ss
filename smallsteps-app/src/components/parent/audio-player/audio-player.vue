<template>
  <view class="audio-player">
    <view class="player-header">
      <view class="cover-box">
        <view class="cover-image" :style="{ backgroundImage: `url(${cover})` }"></view>
        <view class="overlay">
          <text class="material-symbols-outlined icon">graphic_eq</text>
        </view>
      </view>
      <view class="info">
        <text class="title">{{ title }}</text>
        <text class="subtitle">{{ subtitle }}</text>
      </view>
    </view>
    
    <!-- Waveform simulation -->
    <view class="waveform">
      <view 
        v-for="i in 24" 
        :key="i"
        class="bar"
        :class="{ 'active': isPlaying, 'pulse': isPlaying && i % 3 === 0 }"
        :style="{ height: getBarHeight(i) + 'px' }"
      ></view>
    </view>
    
    <!-- Progress -->
    <view class="progress-section">
      <text class="time">{{ formatTime(currentTime) }}</text>
      <slider 
        class="slider"
        :value="currentTime" 
        :max="duration" 
        activeColor="#6C9BD2" 
        backgroundColor="#e5e7eb" 
        block-size="12"
        @change="handleSeek"
      />
      <text class="time">{{ formatTime(duration) }}</text>
    </view>
    
    <!-- Play Control -->
    <view class="controls">
      <button class="play-btn" @click="togglePlay">
        <text class="material-symbols-outlined icon">{{ isPlaying ? 'pause' : 'play_arrow' }}</text>
      </button>
    </view>
  </view>
</template>

<script setup>
import { ref, onUnmounted } from 'vue'

const props = defineProps({
  src: String,
  title: String,
  subtitle: String,
  cover: String
})

const isPlaying = ref(false)
const currentTime = ref(0)
const duration = ref(90) // 模拟 90 秒

let audioContext = null

const togglePlay = () => {
  isPlaying.value = !isPlaying.value
  // 这里可以集成真实的音频控制逻辑
}

const handleSeek = (e) => {
  currentTime.value = e.detail.value
}

const formatTime = (seconds) => {
  const m = Math.floor(seconds / 60)
  const s = Math.floor(seconds % 60)
  return `${m.toString().padStart(2, '0')}:${s.toString().padStart(2, '0')}`
}

const getBarHeight = (i) => {
  const base = [12, 20, 32, 16, 24, 40, 20, 12, 24, 16, 32, 20, 12, 24, 40, 16, 24, 12, 20, 12, 16, 24, 32, 12]
  return base[i - 1] || 10
}

onUnmounted(() => {
  if (audioContext) {
    audioContext.destroy()
  }
})
</script>

<style lang="scss" scoped>
.audio-player {
  padding: 20px;
  background-color: #ffffff;
  border-radius: 16px;
  border: 1px solid #f3f4f6;
  box-shadow: 0 1px 2px rgba(0, 0, 0, 0.05);
  
  :deep(.dark) & {
    background-color: #1e242b;
    border-color: #374151;
  }
}

.player-header {
  display: flex;
  align-items: center;
  gap: 16px;
  margin-bottom: 16px;
}

.cover-box {
  position: relative;
  width: 64px;
  height: 64px;
  border-radius: 12px;
  overflow: hidden;
  background-color: #f3f4f6;
  
  :deep(.dark) & { background-color: #111827; }
}

.cover-image {
  width: 100%;
  height: 100%;
  background-size: cover;
  background-position: center;
}

.overlay {
  position: absolute;
  inset: 0;
  background-color: rgba(108, 155, 210, 0.1);
  display: flex;
  align-items: center;
  justify-content: center;
  
  .icon {
    font-size: 28px;
    color: #ffffff;
    text-shadow: 0 2px 4px rgba(0,0,0,0.2);
  }
}

.info {
  flex: 1;
  min-width: 0;
  display: flex;
  flex-direction: column;
}

.title {
  font-size: 16px;
  font-weight: 700;
  color: #111827;
  overflow: hidden;
  text-overflow: ellipsis;
  white-space: nowrap;
  
  :deep(.dark) & { color: #ffffff; }
}

.subtitle {
  font-size: 12px;
  color: #6b7280;
  margin-top: 4px;
}

.waveform {
  display: flex;
  align-items: center;
  justify-content: center;
  height: 48px;
  gap: 4px;
  margin-bottom: 20px;
}

.bar {
  width: 4px;
  border-radius: 99px;
  background-color: rgba(108, 155, 210, 0.3);
  transition: height 0.3s ease;
  
  &.active {
    background-color: #6C9BD2;
  }
  
  &.pulse {
    animation: pulse 1.5s infinite ease-in-out;
  }
}

@keyframes pulse {
  0% { opacity: 1; transform: scaleY(1); }
  50% { opacity: 0.6; transform: scaleY(0.6); }
  100% { opacity: 1; transform: scaleY(1); }
}

.progress-section {
  display: flex;
  align-items: center;
  gap: 12px;
  margin-bottom: 16px;
}

.time {
  font-size: 12px;
  color: #6b7280;
  width: 40px;
  text-align: center;
}

.slider {
  flex: 1;
  margin: 0;
}

.controls {
  display: flex;
  justify-content: center;
}

.play-btn {
  width: 48px;
  height: 48px;
  border-radius: 999px;
  background-color: #6C9BD2;
  display: flex;
  align-items: center;
  justify-content: center;
  color: #ffffff;
  box-shadow: 0 4px 12px rgba(108, 155, 210, 0.3);
  border: none;
  
  &::after { border: none; }
  
  &:active {
    transform: scale(0.95);
    background-color: #5a82b0;
  }
  
  .icon {
    font-size: 28px;
  }
}
</style>

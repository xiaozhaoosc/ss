<template>
  <view class="mission-timer">
    <view class="timer-container">
      <!-- Decorative background glow -->
      <view class="glow-bg"></view>
      
      <!-- Outer Ring -->
      <view class="outer-ring"></view>
      
      <!-- SVG Progress Ring -->
      <!-- Note: Using simple CSS border approach for cross-platform compatibility instead of inline SVG if possible, 
           but SVG is fine in uni-app. Let's use SVG for the dashoffset animation. -->
      <svg class="progress-svg" viewBox="0 0 120 120">
        <circle 
          class="bg-circle" 
          cx="60" 
          cy="60" 
          r="52" 
          fill="none" 
          stroke-width="8"
        />
        <circle 
          class="progress-circle" 
          cx="60" 
          cy="60" 
          r="52" 
          fill="none" 
          stroke-width="8"
          stroke-linecap="round"
          :stroke-dasharray="circumference"
          :stroke-dashoffset="dashOffset"
        />
      </svg>
      
      <!-- Center Content -->
      <view class="center-content">
        <text class="time-text">{{ formattedTime }}</text>
        <text class="label">剩余时间</text>
      </view>
    </view>
  </view>
</template>

<script setup>
import { ref, computed, onMounted, onUnmounted, watch } from 'vue'

const props = defineProps({
  duration: { type: Number, default: 900 }, // seconds, default 15 mins
  isPlaying: { type: Boolean, default: false }
})

const emit = defineEmits(['finish'])

const timeLeft = ref(props.duration)
const radius = 52
const circumference = 2 * Math.PI * radius
let timerInterval = null

const dashOffset = computed(() => {
  const progress = timeLeft.value / props.duration
  return circumference * (1 - progress)
})

const formattedTime = computed(() => {
  const m = Math.floor(timeLeft.value / 60)
  const s = timeLeft.value % 60
  return `${m.toString().padStart(2, '0')}:${s.toString().padStart(2, '0')}`
})

const startTimer = () => {
  if (timerInterval) return
  timerInterval = setInterval(() => {
    if (timeLeft.value > 0) {
      timeLeft.value--
    } else {
      stopTimer()
      emit('finish')
    }
  }, 1000)
}

const stopTimer = () => {
  if (timerInterval) {
    clearInterval(timerInterval)
    timerInterval = null
  }
}

watch(() => props.isPlaying, (val) => {
  if (val) startTimer()
  else stopTimer()
}, { immediate: true })

onUnmounted(() => {
  stopTimer()
})
</script>

<style lang="scss" scoped>
.mission-timer {
  display: flex;
  justify-content: center;
  align-items: center;
  padding: 32px 0;
}

.timer-container {
  position: relative;
  width: 280px;
  height: 280px;
  display: flex;
  justify-content: center;
  align-items: center;
}

.glow-bg {
  position: absolute;
  inset: 0;
  background-color: rgba(19, 236, 84, 0.2);
  border-radius: 999px;
  filter: blur(40px);
  transform: scale(0.9);
}

.outer-ring {
  position: absolute;
  inset: 0;
  border-radius: 999px;
  border: 24px solid #ffffff;
  box-shadow: 0 10px 25px rgba(0,0,0,0.1);
  :deep(.dark) & { border-color: rgba(255,255,255,0.05); }
}

.progress-svg {
  width: 280px;
  height: 280px;
  transform: rotate(-90deg);
  position: relative;
  z-index: 10;
}

.bg-circle {
  stroke: #e5e7eb;
  :deep(.dark) & { stroke: #374151; }
}

.progress-circle {
  stroke: #13ec54;
  transition: stroke-dashoffset 1s linear;
}

.center-content {
  position: absolute;
  inset: 0;
  display: flex;
  flex-direction: column;
  justify-content: center;
  align-items: center;
  z-index: 20;
}

.time-text {
  font-size: 60px;
  font-weight: 900;
  color: #1e293b;
  line-height: 1;
  font-variant-numeric: tabular-nums;
  :deep(.dark) & { color: #fff; }
}

.label {
  font-size: 14px;
  font-weight: 700;
  color: #94a3b8;
  text-transform: uppercase;
  letter-spacing: 2px;
  margin-top: 4px;
}
</style>

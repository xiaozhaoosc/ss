<template>
  <view class="mission-timer" :class="{ 'timer-breathing': isPlaying }">
    <view class="timer-container">
      <!-- Decorative background glow -->
      <view class="glow-bg" :class="{ 'glow-pulse': isPlaying }"></view>
      
      <!-- Outer Ring -->
      <view class="outer-ring"></view>
      
      <!-- Liquid Container -->
      <view class="liquid-mask">
        <!-- SVG Progress liquid -->
        <svg class="liquid-svg" viewBox="0 0 120 120">
          <defs>
            <clipPath id="circleView">
              <circle cx="60" cy="60" r="50" />
            </clipPath>
            <linearGradient id="liquidGradient" x1="0%" y1="0%" x2="0%" y2="100%">
              <stop offset="0%" stop-color="#13ec54" />
              <stop offset="100%" stop-color="#065f46" />
            </linearGradient>
          </defs>
          
          <!-- Background circle -->
          <circle cx="60" cy="60" r="50" fill="rgba(0,0,0,0.05)" />
          
          <!-- Liquid Fill -->
          <g clip-path="url(#circleView)">
            <rect 
              x="0" 
              :y="liquidY" 
              width="120" 
              height="120" 
              fill="url(#liquidGradient)"
              class="liquid-rect"
            />
            <!-- Wave effect -->
            <path 
              v-if="isPlaying"
              class="wave" 
              :d="wavePath" 
              fill="url(#liquidGradient)"
            />
          </g>
        </svg>
      </view>
      
      <!-- Center Content -->
      <view class="center-content">
        <text class="time-text">{{ formattedTime }}</text>
        <text class="label">专注中</text>
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
let timerInterval = null
const wavePhase = ref(0)
let waveInterval = null

const liquidY = computed(() => {
  const progress = timeLeft.value / props.duration
  // Y goes from 10 to 110 (top to bottom)
  return 110 - (progress * 100)
})

const wavePath = computed(() => {
  const y = liquidY.value
  const amp = 4 // Amplitude
  const freq = 0.05 // Frequency
  const p = wavePhase.value
  
  let path = `M 0 ${y} `
  for (let x = 0; x <= 120; x += 5) {
    const dy = Math.sin(x * freq + p) * amp
    path += `L ${x} ${y + dy} `
  }
  path += `L 120 120 L 0 120 Z`
  return path
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
  
  waveInterval = setInterval(() => {
    wavePhase.value += 0.1
  }, 50)
}

const stopTimer = () => {
  if (timerInterval) {
    clearInterval(timerInterval)
    timerInterval = null
  }
  if (waveInterval) {
    clearInterval(waveInterval)
    waveInterval = null
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
  transition: transform 0.3s;
}

.timer-breathing {
  animation: breathe 4s ease-in-out infinite;
}

@keyframes breathe {
  0%, 100% { transform: scale(1); }
  50% { transform: scale(1.02); }
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
  background-color: rgba(19, 236, 84, 0.15);
  border-radius: 999px;
  filter: blur(40px);
  transform: scale(0.8);
  opacity: 0;
  transition: opacity 0.5s;
}

.glow-pulse {
  opacity: 1;
  animation: glow-pulse 2s ease-in-out infinite;
}

@keyframes glow-pulse {
  0%, 100% { transform: scale(0.8); opacity: 0.4; }
  50% { transform: scale(0.95); opacity: 0.7; }
}

.outer-ring {
  position: absolute;
  inset: 0;
  border-radius: 999px;
  border: 16px solid #ffffff;
  box-shadow: 0 10px 30px rgba(0,0,0,0.08);
  z-index: 5;
  :deep(.dark) & { border-color: rgba(255,255,255,0.05); }
}

.liquid-mask {
  width: 240px;
  height: 240px;
  border-radius: 999px;
  overflow: hidden;
  position: relative;
  z-index: 1;
  background-color: #f8fafc;
  :deep(.dark) & { background-color: #1e293b; }
}

.liquid-svg {
  width: 100%;
  height: 100%;
}

.liquid-rect {
  transition: y 1s linear;
}

.wave {
  transition: d 0.1s linear;
}

.center-content {
  position: absolute;
  inset: 0;
  display: flex;
  flex-direction: column;
  justify-content: center;
  align-items: center;
  z-index: 20;
  pointer-events: none;
}

.time-text {
  font-size: 64px;
  font-weight: 900;
  color: #1e293b;
  line-height: 1;
  text-shadow: 0 2px 4px rgba(255,255,255,0.8);
  font-variant-numeric: tabular-nums;
  :deep(.dark) & { color: #fff; text-shadow: 0 2px 4px rgba(0,0,0,0.5); }
}

.label {
  font-size: 16px;
  font-weight: 800;
  color: #065f46;
  text-transform: uppercase;
  letter-spacing: 3px;
  margin-top: 8px;
  background-color: rgba(255,255,255,0.6);
  padding: 2px 12px;
  border-radius: 999px;
  :deep(.dark) & { color: #34d399; background-color: rgba(0,0,0,0.4); }
}
</style>

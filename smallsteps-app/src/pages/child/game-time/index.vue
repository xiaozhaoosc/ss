<template>
  <view class="game-time-page" :class="{ 'flash-active': isFlashing }">
    <!-- Premium Header -->
    <view class="glass-header">
      <view class="back-btn" @click="handleBack">
        <text class="material-symbols-outlined">close</text>
      </view>
      <text class="header-title">能量运动场</text>
      <view class="timer-badge">
        <text class="material-symbols-outlined timer-icon">timer</text>
        <text class="timer-text">{{ formatTime(timeLeft) }}</text>
      </view>
    </view>

    <!-- Main Game Area -->
    <view class="game-container">
      <!-- Energy Bar (Circular) -->
      <view class="energy-circle">
        <view class="inner-circle" :style="{ height: energyPercent + '%' }"></view>
        <view class="circle-content">
          <text v-if="gameState === 'idle'" class="start-hint">点击小步开始挑战！</text>
          <text v-if="gameState === 'waiting'" class="game-status">准备好...</text>
          <text v-if="gameState === 'go'" class="game-status go-text">快按！</text>
          <text v-if="gameState === 'result'" class="result-text">{{ lastScore }}ms</text>
        </view>
      </view>

      <!-- Robot Character (Animated) -->
      <view 
        class="robot-mascot" 
        :class="{ 'robot-bouncing': gameState === 'idle', 'robot-alert': gameState === 'waiting' }"
        @click="handleAction"
      >
        <image 
          src="/static/images/avatar/robot_default.png" 
          class="mascot-img"
        />
      </view>
    </view>

    <!-- Instructions -->
    <view class="instructions-card glass-morphism">
      <text class="instr-title">反应力大挑战</text>
      <text class="instr-text">当屏幕变绿时，以最快速度点击小步！看看你的反应有多快？🚀</text>
    </view>

    <!-- Exit Ritual Modal -->
    <view v-if="showExitRitual" class="ritual-overlay">
      <view class="ritual-card scale-up">
        <view class="sleep-icon">💤</view>
        <text class="ritual-title">好棒的运动！</text>
        <text class="ritual-msg">你今天的能量已经完全释放啦。现在，小步也累了，让我们一起帮它盖好被子，准备休息吧。</text>
        <view class="exit-btn" @click="confirmExit">盖好被子，休息吧</view>
      </view>
    </view>
  </view>
</template>

<script setup lang="ts">
import { ref, onUnmounted } from 'vue'

const gameState = ref('idle') // idle, waiting, go, result
const timeLeft = ref(300) // 5 minutes
const energyPercent = ref(100)
const isFlashing = ref(false)
const lastScore = ref(0)
const showExitRitual = ref(false)

let timerInterval: any = null
let gameTimeout: any = null
let startTime: number = 0

const startGlobalTimer = () => {
  if (timerInterval) return
  timerInterval = setInterval(() => {
    if (timeLeft.value > 0) {
      timeLeft.value--
      energyPercent.value = (timeLeft.value / 300) * 100
      
      // Low energy warning
      if (timeLeft.value === 60) {
        uni.vibrateLong()
        uni.showToast({ title: '能量快用完咯，加油！', icon: 'none' })
      }
    } else {
      handleGameOver()
    }
  }, 1000)
}

const formatTime = (seconds: number) => {
  const m = Math.floor(seconds / 60)
  const s = seconds % 60
  return `${m}:${s < 10 ? '0' + s : s}`
}

const handleAction = () => {
  if (gameState.value === 'idle' || gameState.value === 'result') {
    startGameRound()
  } else if (gameState.value === 'waiting') {
    // Too early!
    clearTimeout(gameTimeout)
    gameState.value = 'idle'
    uni.showToast({ title: '太快啦！等变绿再按哦', icon: 'none' })
    uni.vibrateLong()
  } else if (gameState.value === 'go') {
    // Success!
    const endTime = Date.now()
    lastScore.value = endTime - startTime
    gameState.value = 'result'
    isFlashing.value = false
    uni.vibrateShort()
    
    // Auto reset to idle after 2 seconds
    setTimeout(() => {
      if (gameState.value === 'result') gameState.value = 'idle'
    }, 2000)
  }
}

const startGameRound = () => {
  startGlobalTimer()
  gameState.value = 'waiting'
  const delay = Math.random() * 2000 + 1000 // 1-3 seconds
  gameTimeout = setTimeout(() => {
    gameState.value = 'go'
    isFlashing.value = true
    startTime = Date.now()
  }, delay)
}

const handleGameOver = () => {
  clearInterval(timerInterval)
  showExitRitual.value = true
  uni.vibrateLong()
}

const handleBack = () => {
  if (gameState.value !== 'idle') {
    uni.showModal({
      title: '要离开吗？',
      content: '挑战还没结束，现在离开能量就不会满格哦',
      success: (res) => {
        if (res.confirm) uni.navigateBack()
      }
    })
  } else {
    uni.navigateBack()
  }
}

const confirmExit = () => {
  uni.navigateBack()
}

onUnmounted(() => {
  clearInterval(timerInterval)
  clearTimeout(gameTimeout)
})
</script>

<style lang="scss" scoped>
.game-time-page {
  min-height: 100vh;
  background: linear-gradient(135deg, #ECFDF5 0%, #D1FAE5 100%);
  padding-top: env(safe-area-inset-top);
  display: flex;
  flex-direction: column;
  transition: background-color 0.1s;
  
  &.flash-active {
    background: #10B981 !important;
  }
}

.glass-header {
  display: flex;
  align-items: center;
  justify-content: space-between;
  padding: 16px;
  background: rgba(255, 255, 255, 0.6);
  backdrop-filter: blur(10px);
}

.header-title { font-size: 18px; font-weight: 800; color: #065F46; }

.back-btn {
  width: 40px;
  height: 40px;
  display: flex;
  align-items: center;
  justify-content: center;
  border-radius: 12px;
  background: white;
  color: #065F46;
}

.timer-badge {
  display: flex;
  align-items: center;
  gap: 6px;
  background: #065F46;
  color: white;
  padding: 6px 12px;
  border-radius: 999px;
  font-weight: 700;
}

.timer-icon { font-size: 18px; }

.game-container {
  flex: 1;
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
  position: relative;
}

.energy-circle {
  width: 240px;
  height: 240px;
  border-radius: 50%;
  background: rgba(255, 255, 255, 0.5);
  border: 10px solid white;
  position: relative;
  overflow: hidden;
  box-shadow: 0 20px 40px rgba(0,0,0,0.1);
  display: flex;
  align-items: center;
  justify-content: center;
}

.inner-circle {
  position: absolute;
  bottom: 0;
  left: 0;
  right: 0;
  background: #34D399;
  transition: height 0.3s;
  opacity: 0.6;
}

.circle-content {
  position: relative;
  z-index: 10;
  text-align: center;
}

.start-hint { font-size: 14px; color: #065F46; font-weight: 700; }
.game-status { font-size: 24px; font-weight: 900; color: #065F46; }
.go-text { color: white; text-shadow: 0 4px 8px rgba(0,0,0,0.2); }
.result-text { font-size: 40px; font-weight: 900; color: #065F46; }

.robot-mascot {
  width: 140px;
  height: 140px;
  margin-top: 40px;
  position: relative;
  transition: transform 0.1s;
  
  &:active { transform: scale(0.9); }
}

.mascot-img {
  width: 100%;
  height: 100%;
  border-radius: 50%;
  border: 4px solid white;
  box-shadow: 0 10px 20px rgba(0,0,0,0.1);
}

.robot-bouncing {
  animation: bounce 2s infinite ease-in-out;
}

.robot-alert {
  transform: scale(1.1);
  filter: saturate(1.5);
}

@keyframes bounce {
  0%, 100% { transform: translateY(0); }
  50% { transform: translateY(-15px); }
}

.instructions-card {
  margin: 30px;
  padding: 24px;
  border-radius: 24px;
  background: rgba(255, 255, 255, 0.8);
  backdrop-filter: blur(20px);
  text-align: center;
  box-shadow: 0 8px 30px rgba(6, 95, 70, 0.05);
}

.instr-title { font-size: 18px; font-weight: 800; color: #065F46; display: block; margin-bottom: 8px; }
.instr-text { font-size: 14px; color: #4B5563; font-weight: 600; line-height: 1.5; }

.ritual-overlay {
  position: fixed;
  top: 0; left: 0; right: 0; bottom: 0;
  background: rgba(0,0,0,0.7);
  z-index: 100;
  display: flex;
  align-items: center;
  justify-content: center;
  padding: 30px;
}

.ritual-card {
  background: white;
  border-radius: 30px;
  padding: 40px;
  display: flex;
  flex-direction: column;
  align-items: center;
  text-align: center;
}

.sleep-icon { font-size: 60px; margin-bottom: 20px; }
.ritual-title { font-size: 24px; font-weight: 800; color: #1F2937; margin-bottom: 16px; }
.ritual-msg { font-size: 16px; color: #6B7280; margin-bottom: 30px; line-height: 1.6; }
.exit-btn {
  width: 100%;
  height: 60px;
  background: #10B981;
  color: white;
  display: flex;
  align-items: center;
  justify-content: center;
  border-radius: 20px;
  font-weight: 800;
  box-shadow: 0 10px 20px rgba(16, 185, 129, 0.3);
}

.scale-up {
  animation: scaleUp 0.5s cubic-bezier(0.175, 0.885, 0.32, 1.275);
}
</style>

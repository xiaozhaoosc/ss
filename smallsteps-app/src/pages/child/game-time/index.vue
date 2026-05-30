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

    <!-- History Trigger Button -->
    <view class="history-btn-wrapper">
      <view class="history-trigger-btn glass-morphism" @click="toggleHistoryModal">
        <text class="material-symbols-outlined trophy-icon">trophy</text>
        <text class="btn-text">查看历史最佳 10 次</text>
      </view>
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

    <!-- Glassmorphic History Top 10 Modal -->
    <view v-if="showHistoryModal" class="history-overlay" @click.self="toggleHistoryModal">
      <view class="history-modal glass-morphism scale-up">
        <view class="modal-header">
          <text class="trophy-badge">🏆</text>
          <text class="modal-title">历史最佳 Top 10</text>
          <view class="clear-btn" @click="clearHistoryScores" v-if="historyScores.length > 0">
            <text class="material-symbols-outlined">delete</text>
          </view>
        </view>

        <view class="scores-container">
          <view v-if="historyScores.length === 0" class="empty-state">
            <text class="empty-emoji">🏃💨</text>
            <text class="empty-text">还没有挑战成绩哦~</text>
            <text class="empty-subtext">快去点击小步测试你的反应速度吧！</text>
          </view>
          
          <scroll-view v-else scroll-y class="scores-scroll">
            <view 
              v-for="(item, index) in historyScores" 
              :key="index" 
              class="score-item"
              :class="'rank-' + (index + 1)"
            >
              <view class="rank-badge">
                <text v-if="index === 0" class="medal">🏆</text>
                <text v-else-if="index === 1" class="medal">🥈</text>
                <text v-else-if="index === 2" class="medal">🥉</text>
                <text v-else class="rank-number">{{ index + 1 }}</text>
              </view>
              
              <view class="score-info">
                <text class="score-val">{{ item.score }} <text class="ms-unit">ms</text></text>
                <text class="score-time">{{ formatTimestamp(item.timestamp) }}</text>
              </view>
            </view>
          </scroll-view>
        </view>

        <view class="close-modal-btn" @click="toggleHistoryModal">知道了</view>
      </view>
    </view>
  </view>
</template>

<script setup lang="ts">
import { ref, onUnmounted } from 'vue'
import { useUserStore } from '@/store/modules/user'

const userStore = useUserStore()

const gameState = ref('idle') // idle, waiting, go, result
const timeLeft = ref(300) // 5 minutes
const energyPercent = ref(100)
const isFlashing = ref(false)
const lastScore = ref(0)
const showExitRitual = ref(false)

// New state for score tracking & history最佳展示
const bestScoreThisRound = ref(Infinity) // 本轮挑战的最好成绩 (反应毫秒数越低越好)
const showHistoryModal = ref(false)
const historyScores = ref<{ score: number; timestamp: number }[]>([])
let hasSaved = false

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
    const duration = endTime - startTime
    lastScore.value = duration
    
    // 记录本次挑战最好的成绩 (反应时间越短越好)
    if (duration < bestScoreThisRound.value) {
      bestScoreThisRound.value = duration
    }
    
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

// 离开时记录本次挑战最好成绩的持久化函数
const saveBestScore = () => {
  if (hasSaved) return
  if (bestScoreThisRound.value === Infinity || bestScoreThisRound.value <= 0) return
  
  const key = `energy_game_scores_${userStore.id || 'guest'}`
  let list: { score: number; timestamp: number }[] = []
  try {
    const existing = uni.getStorageSync(key)
    if (existing) {
      list = JSON.parse(existing)
    }
  } catch (e) {
    console.error('Failed to read score history', e)
  }
  
  list.push({
    score: bestScoreThisRound.value,
    timestamp: Date.now()
  })
  
  try {
    uni.setStorageSync(key, JSON.stringify(list))
    hasSaved = true
    console.log('Saved best score of this round successfully:', bestScoreThisRound.value)
  } catch (e) {
    console.error('Failed to persist best score', e)
  }
}

// 查看历史最佳10次成绩逻辑
const loadHistoryScores = () => {
  const key = `energy_game_scores_${userStore.id || 'guest'}`
  try {
    const existing = uni.getStorageSync(key)
    if (existing) {
      const list = JSON.parse(existing) as { score: number; timestamp: number }[]
      // 升序排列（微秒越小说明反应越快越好），取前 10 次
      historyScores.value = list.sort((a, b) => a.score - b.score).slice(0, 10)
    } else {
      historyScores.value = []
    }
  } catch (e) {
    console.error('Failed to load history scores', e)
    historyScores.value = []
  }
}

const toggleHistoryModal = () => {
  if (!showHistoryModal.value) {
    loadHistoryScores()
  }
  showHistoryModal.value = !showHistoryModal.value
}

const clearHistoryScores = () => {
  uni.showModal({
    title: '确定要清空成绩吗？',
    content: '清空后你的所有历史挑战记录都会被安全擦除哦。',
    confirmColor: '#ef4444',
    success: (res) => {
      if (res.confirm) {
        const key = `energy_game_scores_${userStore.id || 'guest'}`
        try {
          uni.removeStorageSync(key)
          historyScores.value = []
          uni.showToast({ title: '记录已安全擦除', icon: 'success' })
        } catch (e) {
          console.error('Failed to clear scores', e)
        }
      }
    }
  })
}

const formatTimestamp = (ts: number) => {
  const date = new Date(ts)
  const m = date.getMonth() + 1
  const d = date.getDate()
  const h = date.getHours()
  const min = date.getMinutes()
  return `${m < 10 ? '0' + m : m}-${d < 10 ? '0' + d : d} ${h < 10 ? '0' + h : h}:${min < 10 ? '0' + min : min}`
}

const handleBack = () => {
  if (gameState.value !== 'idle') {
    uni.showModal({
      title: '要离开吗？',
      content: '挑战还没结束，现在离开能量就不会满格哦',
      success: (res) => {
        if (res.confirm) {
          saveBestScore()
          uni.navigateBack()
        }
      }
    })
  } else {
    saveBestScore()
    uni.navigateBack()
  }
}

const confirmExit = () => {
  saveBestScore()
  uni.navigateBack()
}

onUnmounted(() => {
  clearInterval(timerInterval)
  clearTimeout(gameTimeout)
  saveBestScore() // 最终防漏兜底
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

.history-btn-wrapper {
  margin: 0 30px 20px 30px;
  display: flex;
  justify-content: center;
}

.history-trigger-btn {
  display: flex;
  align-items: center;
  justify-content: center;
  gap: 8px;
  padding: 14px 24px;
  border-radius: 20px;
  background: rgba(255, 255, 255, 0.7);
  box-shadow: 0 10px 25px rgba(6, 95, 70, 0.08);
  border: 2px solid white;
  transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
  width: 100%;
  cursor: pointer;

  &:active {
    transform: scale(0.97);
    background: rgba(255, 255, 255, 0.9);
    box-shadow: 0 5px 15px rgba(6, 95, 70, 0.05);
  }

  .trophy-icon {
    font-size: 22px;
    color: #D97706;
  }

  .btn-text {
    font-size: 15px;
    font-weight: 800;
    color: #065F46;
  }
}

.history-overlay {
  position: fixed;
  top: 0; left: 0; right: 0; bottom: 0;
  background: rgba(6, 95, 70, 0.3);
  backdrop-filter: blur(10px);
  z-index: 150;
  display: flex;
  align-items: center;
  justify-content: center;
  padding: 24px;
}

.history-modal {
  width: 100%;
  max-width: 360px;
  background: rgba(255, 255, 255, 0.85);
  border: 3px solid white;
  border-radius: 30px;
  padding: 28px;
  box-shadow: 0 25px 50px rgba(0, 0, 0, 0.15);
  display: flex;
  flex-direction: column;
  align-items: center;
  position: relative;
}

.modal-header {
  display: flex;
  align-items: center;
  width: 100%;
  margin-bottom: 20px;
  position: relative;

  .trophy-badge {
    font-size: 26px;
    margin-right: 8px;
  }

  .modal-title {
    font-size: 20px;
    font-weight: 900;
    color: #065F46;
    flex: 1;
  }

  .clear-btn {
    width: 36px;
    height: 36px;
    border-radius: 50%;
    background: rgba(239, 68, 68, 0.1);
    color: #EF4444;
    display: flex;
    align-items: center;
    justify-content: center;
    transition: all 0.2s;
    cursor: pointer;

    &:active {
      transform: scale(0.9);
      background: rgba(239, 68, 68, 0.2);
    }
  }
}

.scores-container {
  width: 100%;
  height: 280px;
  margin-bottom: 24px;
  display: flex;
  align-items: center;
  justify-content: center;
}

.empty-state {
  display: flex;
  flex-direction: column;
  align-items: center;
  text-align: center;

  .empty-emoji {
    font-size: 48px;
    margin-bottom: 16px;
    animation: float 3s infinite ease-in-out;
  }

  .empty-text {
    font-size: 16px;
    font-weight: 800;
    color: #374151;
    margin-bottom: 6px;
  }

  .empty-subtext {
    font-size: 12px;
    color: #6B7280;
    font-weight: 600;
    padding: 0 20px;
  }
}

.scores-scroll {
  width: 100%;
  height: 100%;
}

.score-item {
  display: flex;
  align-items: center;
  padding: 12px 16px;
  border-radius: 18px;
  background: rgba(255, 255, 255, 0.6);
  margin-bottom: 10px;
  border: 1px solid rgba(255, 255, 255, 0.5);
  box-shadow: 0 4px 10px rgba(6, 95, 70, 0.02);
  transition: all 0.2s;

  &:last-child {
    margin-bottom: 0;
  }

  &.rank-1 {
    background: linear-gradient(135deg, rgba(254, 243, 199, 0.8) 0%, rgba(252, 211, 77, 0.3) 100%);
    border-color: rgba(251, 191, 36, 0.3);
  }
  &.rank-2 {
    background: linear-gradient(135deg, rgba(243, 244, 246, 0.8) 0%, rgba(209, 213, 219, 0.4) 100%);
    border-color: rgba(156, 163, 175, 0.2);
  }
  &.rank-3 {
    background: linear-gradient(135deg, rgba(255, 237, 213, 0.8) 0%, rgba(253, 186, 116, 0.4) 100%);
    border-color: rgba(249, 115, 22, 0.2);
  }
}

.rank-badge {
  width: 32px;
  height: 32px;
  display: flex;
  align-items: center;
  justify-content: center;
  margin-right: 12px;

  .medal {
    font-size: 22px;
  }

  .rank-number {
    width: 24px;
    height: 24px;
    background: rgba(6, 95, 70, 0.1);
    color: #065F46;
    font-size: 12px;
    font-weight: 800;
    border-radius: 50%;
    display: flex;
    align-items: center;
    justify-content: center;
  }
}

.score-info {
  flex: 1;
  display: flex;
  justify-content: space-between;
  align-items: center;

  .score-val {
    font-size: 18px;
    font-weight: 900;
    color: #111827;

    .rank-1 & { color: #92400e; }
    .rank-2 & { color: #374151; }
    .rank-3 & { color: #c2410c; }

    .ms-unit {
      font-size: 11px;
      font-weight: 700;
      color: #6B7280;
      margin-left: 2px;
    }
  }

  .score-time {
    font-size: 11px;
    font-weight: 700;
    color: #9CA3AF;
  }
}

.close-modal-btn {
  width: 100%;
  height: 52px;
  background: linear-gradient(135deg, #10B981 0%, #059669 100%);
  color: white;
  display: flex;
  align-items: center;
  justify-content: center;
  border-radius: 18px;
  font-weight: 800;
  font-size: 16px;
  box-shadow: 0 8px 20px rgba(16, 185, 129, 0.25);
  transition: all 0.2s;
  cursor: pointer;

  &:active {
    transform: scale(0.98);
    box-shadow: 0 4px 10px rgba(16, 185, 129, 0.15);
  }
}

@keyframes float {
  0%, 100% { transform: translateY(0); }
  50% { transform: translateY(-8px); }
}

@keyframes scaleUp {
  from { transform: scale(0.8); opacity: 0; }
  to { transform: scale(1); opacity: 1; }
}
</style>

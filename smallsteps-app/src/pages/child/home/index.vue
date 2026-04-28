<template>
  <view class="child-home-page" @click="handleScreenTap">
    <!-- Decorative Background Elements -->
    <view class="blob blob-1"></view>
    <view class="blob blob-2"></view>

    <!-- Header: Stats Bar -->
    <view class="header-bar">
      <!-- Streak Counter -->
      <view class="streak-badge">
        <view class="fire-circle">
          <text class="material-symbols-outlined fire-icon">local_fire_department</text>
        </view>
        <view class="streak-info">
          <text class="streak-label">坚持打卡</text>
          <text class="streak-val">{{ streak }} 天</text>
        </view>
      </view>
      
      <!-- Settings (Hidden) -->
      <view class="settings-btn" hover-class="btn-hover" @click="handleSettings">
        <text class="material-symbols-outlined">settings</text>
      </view>
      
      <!-- Star Jar -->
      <trophy-jar :count="userStore.balance" />
    </view>

    <scroll-view scroll-y class="main-content no-scrollbar">
      <!-- Robot Avatar Area -->
      <view class="robot-area" hover-class="robot-hover" @click="handleRobotClick" @longpress="handleRobotLongPress">
        <!-- Speech Bubble -->
        <view class="speech-bubble">
          <text class="bubble-text">{{ greetingText }}</text>
          <view class="tap-hint">点我聊天吧！</view>
        </view>
        
        <!-- Robot Image -->
        <view class="robot-circle">
          <image 
            class="robot-img" 
            :src="avatarUrl" 
            mode="aspectCover"
          />
        </view>
      </view>

      <!-- Current Mission Card -->
      <view class="mission-section">
        <mission-card 
          v-if="currentMission"
          :title="currentMission.title"
          :subtitle="currentMission.subtitle"
          :icon="currentMission.icon"
          :points="currentMission.points"
          @complete="handleMissionComplete"
        />
        <view v-else class="no-mission">
          <text class="bubble-text">全部任务完成！太棒了！🎉</text>
        </view>
      </view>

      <!-- Secondary Actions -->
      <view class="quick-links">
        <view class="link-card" hover-class="card-hover" @click="handleQuickLink('艺术课')">
          <view class="link-icon bg-purple">
            <text class="material-symbols-outlined">palette</text>
          </view>
          <text class="link-text">艺术课</text>
        </view>
        <view class="link-card" hover-class="card-hover" @click="handleQuickLink('游戏时间')">
          <view class="link-icon bg-green">
            <text class="material-symbols-outlined">sports_soccer</text>
          </view>
          <text class="link-text">游戏时间</text>
        </view>
      </view>
      
      <view class="spacer"></view>
    </scroll-view>

    <!-- Bottom Nav -->
    <child-bottom-nav active="home" />
  </view>
</template>

<script setup lang="ts">
import { ref, computed } from 'vue'
import { onLoad, onShow } from '@dcloudio/uni-app'
import TrophyJar from '@/components/child/trophy-jar/trophy-jar.vue'
import MissionCard from '@/components/child/mission-card/mission-card.vue'
import ChildBottomNav from '@/components/child/child-bottom-nav/child-bottom-nav.vue'
import { useUserStore } from '@/store/modules/user'
import { getInfo } from '@/api/auth'
import { getPendingTasks, getStreak, submitEmotion } from '@/api/child'

const userStore = useUserStore()
const streak = ref(0)
// Balance is now in userStore
const childName = computed(() => userStore.userInfo?.user?.nickName || 'Star Hero')
const avatarUrl = computed(() => {
  const avatar = userStore.userInfo?.user?.avatar
  if (avatar) return avatar.startsWith('http') ? avatar : import.meta.env.VITE_APP_BASE_API + avatar
  return 'https://lh3.googleusercontent.com/aida-public/AB6AXuAA0RmcSQACImzUoE9woyc6-iyIeWXkvAw4lxZnIr9f-HJd8UDiHGwhHva02eLf1l--Q5SMauQxBc1YriECXhMtDDCPrO4m9Ab_7FvJ0xhktITS2cOnh7snQbeQSqNH7003z1j2AZfQatNbPTCZn4SczwbadodstvQLdfrwsStdm6WYruauaA2fXZWL-lKaGVKEEFmLni1Pz7ZUP0OkMVZom1KOsZ4vhRSI6-Ph-P2B25ItChVNt_BamCyGzq0fOcy_u6ce0eEdOPQ'
})

const greetingText = computed(() => {
  const hour = new Date().getHours()
  if (hour < 9) return `早上好，${childName.value}！开启元气满满的一天吧 ☀️`
  if (hour < 14) return `中午好，${childName.value}！休息一下，准备下午的挑战吧 🍱`
  if (hour < 19) return `下午好，${childName.value}！完成任务，赢得更多星星吧 ⭐`
  return `晚上好，${childName.value}！今天的你非常努力，准备进入梦乡吧 🌙`
})

const currentMission = ref<any>(null)
const pendingTasks = ref<any[]>([])

async function loadData() {
  try {
    // 1. Get User Info
    if (!userStore.userInfo) {
       const infoRes: any = await getInfo()
       userStore.setUserInfo(infoRes.data || infoRes)
    }

    const childId = userStore.id
    if (!childId) return

    // 2. Get Streak
    getStreak(Number(childId)).then((res: any) => {
      streak.value = res.data || 0
    })

    // 3. Get Task (First active task)
    loadPendingTasks()
  } catch (e) {
    console.error(e)
  }
}

const loadPendingTasks = () => {
  const childId = userStore.id
  if (!childId) return
  getPendingTasks(Number(childId)).then((res: any) => {
    pendingTasks.value = res.data || []
    if (pendingTasks.value.length > 0) {
      const task = pendingTasks.value[0]
      currentMission.value = {
        taskId: task.taskId,
        title: task.taskName || task.title,
        subtitle: task.description || '加油完成任务！',
        icon: task.icon || 'star', // Default icon
        points: task.rewardStars || task.rewardPoints || 5
      }
    } else {
      currentMission.value = null
    }
  }).catch((err: any) => {
    console.error('Failed to load pending tasks:', err)
  })
}

const handleSettings = () => {
  uni.vibrateShort()
  // Easter egg or parent gate could go here
  uni.showToast({ title: 'Parent Zone', icon: 'none' })
}

const handleMissionComplete = () => {
  uni.vibrateShort()
  if (currentMission.value && currentMission.value.taskId) {
     navigateToTask(currentMission.value.taskId)
  }
}

const navigateToTask = (taskId: number) => {
  uni.navigateTo({
    url: `/pages/child/task-execute/index?taskId=${taskId}`
  })
}

const handleQuickLink = (name: string) => {
  uni.vibrateShort()
  uni.showToast({ title: `Open ${name}`, icon: 'none' })
}

const handleRobotClick = () => {
  uni.vibrateShort()
  uni.navigateTo({
    url: '/pages/child/treehole-chat/index'
  })
}

const handleRobotLongPress = async () => {
  uni.vibrateLong()
  try {
    // 自动记录情绪预警（影子观察者模式）
    const childId = userStore.id
    if (childId) {
      await submitEmotion({
        childId: Number(childId),
        moodLevel: 2, // 2: Low/Sad/Frustrated
        moodType: 'frustrated',
        description: '[影子观察] 检测到异常长按机器人，可能存在情绪波动或操作困难。'
      })
      uni.showToast({
        title: '已为你记录情绪状态',
        icon: 'none'
      })
      console.log('[Shadow Observer] Emotion warning reported.')
    }
  } catch (e) {
    console.error('Failed to report emotion warning:', e)
  }
}

const clickHistory = ref<number[]>([])
const handleScreenTap = () => {
  const now = Date.now()
  clickHistory.value.push(now)
  
  // Keep only last 10 clicks within 2 seconds
  clickHistory.value = clickHistory.value.filter(t => now - t < 2000)
  
  if (clickHistory.value.length >= 6) {
    console.warn('Shadow Observer: High frequency clicking detected!')
    triggerShadowWarning('躁动点击', '系统检测到高频点击，可能存在焦虑或挫败感。')
    clickHistory.value = [] // Reset
  }
}

const triggerShadowWarning = async (type: string, desc: string) => {
  try {
    await submitEmotion({
      childId: userStore.userId,
      moodLevel: 3, // High arousal
      moodType: type,
      description: desc
    })
    console.log('Shadow Warning reported to backend')
  } catch (err) {
    console.error('Failed to report shadow warning', err)
  }
}

onLoad(() => {
  // 角色校验：防止家长误入儿童界面
  if (userStore.role !== 'child') {
    uni.reLaunch({ url: '/pages/parent/dashboard/index' })
    return
  }
  
  // 强制隐藏原生 TabBar，确保使用自定义导航
  uni.hideTabBar({
    fail: () => {}
  })
  
  loadData()
  userStore.fetchBalance()
})
</script>

<style lang="scss" scoped>
.child-home-page {
  height: 100vh;
  display: flex;
  flex-direction: column;
  background: linear-gradient(135deg, #8CD0A1, #F5D76E);
  overflow: hidden;
  position: relative;
}

.blob {
  position: absolute;
  background-color: rgba(255, 255, 255, 0.2);
  border-radius: 999px;
  filter: blur(40px);
  z-index: 0;
}
.blob-1 { width: 160px; height: 160px; top: 40px; left: -50px; }
.blob-2 { width: 240px; height: 240px; bottom: 160px; right: -20px; }

.header-bar {
  position: relative;
  z-index: 10;
  display: flex;
  align-items: center;
  justify-content: space-between;
  padding: 24px 16px 16px 16px;
  padding-top: calc(24px + env(safe-area-inset-top));
}

.streak-badge {
  display: flex;
  align-items: center;
  gap: 8px;
  background-color: rgba(255, 255, 255, 0.9);
  backdrop-filter: blur(4px);
  padding: 8px;
  padding-right: 16px;
  border-radius: 999px;
  border: 2px solid #ffffff;
  box-shadow: 0 4px 0 rgba(0,0,0,0.1);
}

.fire-circle {
  width: 40px;
  height: 40px;
  border-radius: 999px;
  background-color: #ffedd5;
  display: flex;
  align-items: center;
  justify-content: center;
  
  .fire-icon { font-size: 24px; color: #f97316; font-variation-settings: 'FILL' 1; }
}

.streak-info {
  display: flex;
  flex-direction: column;
}

.streak-label {
  font-size: 10px;
  font-weight: 700;
  color: #9ca3af;
  letter-spacing: 0.5px;
  line-height: 1;
  margin-bottom: 2px;
}

.streak-val {
  font-size: 16px;
  font-weight: 700;
  color: #1c140d;
  line-height: 1;
}

.settings-btn {
  background-color: rgba(255, 255, 255, 0.4);
  width: 40px;
  height: 40px;
  border-radius: 999px;
  display: flex;
  align-items: center;
  justify-content: center;
  color: #ffffff;
  
  &:active { background-color: rgba(255, 255, 255, 0.6); }
}

.main-content {
  flex: 1;
  position: relative;
  z-index: 10;
  display: flex;
  flex-direction: column;
  padding: 0 16px;
}

.robot-area {
  display: flex;
  flex-direction: column;
  align-items: center;
  padding: 16px 0;
  margin-bottom: -24px;
  position: relative;
  z-index: 10;
}

.speech-bubble {
  background-color: #ffffff;
  padding: 16px;
  border-radius: 16px;
  border-bottom-left-radius: 0;
  box-shadow: 0 4px 12px rgba(0,0,0,0.1);
  margin-bottom: 16px;
  max-width: 240px;
  animation: float 4s ease-in-out infinite;
}

.bubble-text {
  font-size: 16px;
  font-weight: 700;
  text-align: center;
  color: #1c140d;
  line-height: 1.3;
}

.tap-hint {
  font-size: 10px;
  color: #0EA5E9;
  text-align: center;
  margin-top: 4px;
  font-weight: 700;
  text-transform: uppercase;
  letter-spacing: 1px;
}

.robot-circle {
  width: 160px;
  height: 160px;
  border-radius: 999px;
  background-color: rgba(255, 255, 255, 0.3);
  backdrop-filter: blur(8px);
  padding: 8px;
  box-shadow: 0 0 20px rgba(244, 140, 37, 0.4);
  border: 4px solid rgba(255, 255, 255, 0.5);
}

.robot-img {
  width: 100%;
  height: 100%;
  border-radius: 999px;
  border: 4px solid #ffffff;
}

.mission-section {
  display: flex;
  justify-content: center;
  position: relative;
  z-index: 20;
}

.quick-links {
  display: flex;
  gap: 16px;
  margin-top: 32px;
  padding: 0 16px;
  justify-content: center;
}

.link-card {
  flex: 1;
  max-width: 160px;
  background-color: rgba(255, 255, 255, 0.8);
  backdrop-filter: blur(4px);
  padding: 16px;
  border-radius: 16px;
  border: 2px solid rgba(255, 255, 255, 0.5);
  display: flex;
  flex-direction: column;
  align-items: center;
  gap: 8px;
  transition: transform 0.2s;
  
  &:active { transform: scale(0.95); background-color: #ffffff; }
}

.link-icon {
  padding: 8px;
  border-radius: 999px;
  display: flex;
  
  &.bg-purple { background-color: #f3e8ff; color: #9333ea; }
  &.bg-green { background-color: #dcfce7; color: #16a34a; }
  
  .material-symbols-outlined { font-size: 24px; }
}

.link-text {
  font-size: 14px;
  font-weight: 700;
  color: #374151;
}

.btn-hover {
  opacity: 0.7;
  transform: scale(0.9);
}

.card-hover {
  transform: scale(0.95);
  background-color: #ffffff !important;
}

.robot-hover {
  transform: scale(1.05);
  filter: brightness(1.1);
  box-shadow: 0 0 30px rgba(14, 165, 233, 0.4);
}

.spacer {
  height: 120px;
}

@keyframes float {
  0%, 100% { transform: translateY(0); }
  50% { transform: translateY(-10px); }
}

.no-scrollbar::-webkit-scrollbar {
  display: none;
}
</style>

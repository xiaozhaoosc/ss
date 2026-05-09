<template>
  <view class="child-task-page" :class="{ 'dark': isDarkMode }">
    <!-- Header -->
    <view class="header">
      <button class="back-btn" hover-class="btn-hover" @click="handleBack">
        <text class="material-symbols-outlined icon">arrow_back</text>
      </button>
      <text class="page-title">专注时刻</text>
      <view class="spacer"></view>
    </view>

    <view class="main-content">
      <!-- Progress Indicator -->
      <view class="progress-pill">
        <text class="material-symbols-outlined flag-icon">flag</text>
        <text class="step-text" v-if="!hasSteps">正在进行中</text>
        <text class="step-text" v-else>第 {{ currentStepIndex + 1 }} / {{ steps.length }} 步</text>
      </view>

      <!-- Headline -->
      <text class="headline" v-if="!hasSteps">{{ taskTitle }}</text>
      <text class="headline" v-else>{{ steps[currentStepIndex].content }}</text>
      <text class="sub-headline" v-if="hasSteps">{{ taskTitle }}</text>

      <!-- Timer -->
      <mission-timer 
        :key="currentStepIndex"
        :duration="currentDuration" 
        :is-playing="!isRewardVisible"
        @finish="handleTimerFinish"
      />

      <!-- Step Navigation -->
      <view class="step-nav" v-if="hasSteps">
        <view class="step-dots">
          <view v-for="(s, index) in steps" :key="index" class="dot" :class="{ 'active': index === currentStepIndex, 'done': index < currentStepIndex }"></view>
        </view>
      </view>

      <!-- Photo Proof Area -->
      <view class="proof-section" v-if="!hasSteps || isLastStep">
        <view v-if="!proofImage" class="upload-placeholder" @click="handleSelectImage">
          <text class="material-symbols-outlined camera-icon">add_a_photo</text>
          <text class="upload-text">拍张照片留个纪念吧</text>
        </view>
        <view v-else class="preview-container">
          <image :src="proofImage" mode="aspectFill" class="proof-img" @click="handleSelectImage" />
          <view class="remove-badge" @click.stop="proofImage = ''">
            <text class="material-symbols-outlined">close</text>
          </view>
        </view>
      </view>
    </view>

    <!-- Footer Action -->
    <view class="footer">
      <button class="complete-btn" hover-class="complete-hover" :loading="isLoading" @click="handleAction">
        <view class="shine"></view>
        <view class="btn-content">
          <text class="btn-text">{{ actionText }}</text>
          <text class="material-symbols-outlined check-icon">{{ actionIcon }}</text>
        </view>
      </button>
      <text class="hint-text">{{ actionHint }}</text>
    </view>

    <!-- Reward Overlay -->
    <reward-overlay 
      :visible="isRewardVisible" 
      :points="rewardPoints"
      :child-name="childNickName"
      @collect="handleRewardCollect" 
    />

    <!-- Background Decorations -->
    <view class="blob blob-1"></view>
    <view class="blob blob-2"></view>
  </view>
</template>

<script setup>
import { ref, computed } from 'vue'
import { onLoad } from '@dcloudio/uni-app'
import MissionTimer from '@/components/child/mission-timer/mission-timer.vue'
import RewardOverlay from '@/components/child/reward-overlay/reward-overlay.vue'
import { completeTask, getChildTask } from '@/api/child'
import { useUserStore } from '@/store/modules/user'
import upload from '@/utils/upload'

const userStore = useUserStore()
const isDarkMode = ref(false)
const taskId = ref(null)
const isLoading = ref(false)
const isRewardVisible = ref(false)
const proofImage = ref('')
const taskTitle = ref('正在进行任务...')
const rewardPoints = ref(10)

// Step Tracking
const steps = ref([])
const currentStepIndex = ref(0)
const hasSteps = computed(() => steps.value && steps.value.length > 0)
const isLastStep = computed(() => !hasSteps.value || currentStepIndex.value === steps.value.length - 1)
const currentDuration = computed(() => {
  if (hasSteps.value) return steps.value[currentStepIndex.value].expectedDuration || 300
  return 900
})

const actionText = computed(() => {
  if (!hasSteps.value || isLastStep.value) return '我完成了！'
  return '下一步'
})

const actionIcon = computed(() => {
  if (!hasSteps.value || isLastStep.value) return 'check_circle'
  return 'arrow_forward'
})

const actionHint = computed(() => {
  if (!hasSteps.value || isLastStep.value) return '点击按钮结算奖励'
  return '准备好了就进入下一阶段吧'
})

onLoad((options) => {
  if (options.taskId) {
    taskId.value = parseInt(options.taskId)
    loadTaskInfo()
  }
})

const loadTaskInfo = () => {
  getChildTask(taskId.value).then(res => {
    if (res.data) {
      const task = res.data.taskDefinition || res.data
      taskTitle.value = task.title || task.taskName
      rewardPoints.value = task.rewardPoints || 10
      steps.value = task.steps || []
    }
  })
}

const handleBack = () => {
  uni.vibrateShort()
  if (isRewardVisible.value) return
  uni.showModal({
    title: '确定要离开吗？',
    content: '专注还没有结束，离开将不会获得奖励哦',
    success: (res) => {
      if (res.confirm) {
        uni.navigateBack()
      }
    }
  })
}

const handleSelectImage = () => {
  uni.chooseImage({
    count: 1,
    success: (res) => {
      proofImage.value = res.tempFilePaths[0]
    }
  })
}

const handleTimerFinish = () => {
  uni.showToast({ title: '时间到！真棒！', icon: 'none' })
}

const handleAction = () => {
  if (!hasSteps.value || isLastStep.value) {
    handleComplete()
  } else {
    currentStepIndex.value++
    uni.vibrateShort()
  }
}

const handleComplete = async () => {
  uni.vibrateShort()
  if (!taskId.value) {
    uni.showToast({ title: '任务信息缺失', icon: 'none' })
    return
  }
  
  const childId = userStore.userId || userStore.id
  if (!childId) {
    uni.showToast({ title: '登录信息失效，请重新登录', icon: 'none' })
    return 
  }
  isLoading.value = true
  
  try {
    let proofUrl = ''
    if (proofImage.value) {
      uni.showLoading({ title: '正在上传照片...' })
      const uploadRes = await upload({
        url: '/common/upload',
        filePath: proofImage.value,
        name: 'file'
      })
      proofUrl = uploadRes.url || ''
      uni.hideLoading()
    }

    uni.showLoading({ title: '同步状态中...' })
    console.log(`[Task] Completing task: taskId=${taskId.value}, childId=${childId}`)
    const res = await completeTask(taskId.value, Number(childId), proofUrl)
    uni.hideLoading()
    
    // Check if back-end actually updated the record
    // In RuoYi, a successful response doesn't always mean the business logic succeeded (e.g. update count = 0)
    if (res.code === 200) {
      isRewardVisible.value = true
    } else {
      uni.showToast({ title: res.msg || '任务完成失败', icon: 'none' })
    }
  } catch (e) {
    console.error('[Task Error]', e)
    uni.hideLoading()
    uni.showToast({ title: '同步失败，请重试', icon: 'none' })
  } finally {
    isLoading.value = false
  }
}

const handleRewardCollect = () => {
  isRewardVisible.value = false
  uni.navigateBack()
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
  .icon { font-size: 28px; }
}

.page-title {
  font-size: 18px;
  font-weight: 700;
  color: #1e293b;
}

.sub-headline {
  font-size: 14px;
  color: #94a3b8;
  text-align: center;
  margin-top: -8px;
  margin-bottom: 8px;
}

.step-nav {
  margin-top: 24px;
  width: 100%;
  display: flex;
  justify-content: center;
}

.step-dots {
  display: flex;
  gap: 12px;
  
  .dot {
    width: 8px;
    height: 8px;
    border-radius: 999px;
    background-color: #CBD5E1;
    transition: all 0.3s;
    
    &.active { width: 24px; background-color: #0ea5e9; }
    &.done { background-color: #8cd0a1; }
  }
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
  margin-top: 8px;
  display: flex;
  align-items: center;
  gap: 8px;
  padding: 8px 16px;
  border-radius: 999px;
  background-color: rgba(140, 208, 161, 0.2);
  
  .flag-icon { font-size: 20px; color: #059669; }
  .step-text { font-size: 14px; font-weight: 700; color: #065f46; }
}

.headline {
  font-size: 32px;
  font-weight: 900;
  color: #1e293b;
  text-align: center;
  padding: 12px 0;
  letter-spacing: -1px;
}

.proof-section {
  width: 100%;
  max-width: 280px;
  margin-top: 16px;
}

.upload-placeholder {
  height: 120px;
  border: 3px dashed #CBD5E1;
  border-radius: 24px;
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
  gap: 8px;
  background-color: rgba(255, 255, 255, 0.5);
  
  .camera-icon { font-size: 32px; color: #94A3B8; }
  .upload-text { font-size: 12px; font-weight: 700; color: #94A3B8; }
  
  &:active { background-color: #fff; }
}

.preview-container {
  position: relative;
  height: 120px;
  border-radius: 24px;
  overflow: hidden;
  box-shadow: 0 8px 20px rgba(0,0,0,0.1);
  border: 3px solid #fff;
}

.proof-img {
  width: 100%;
  height: 100%;
}

.remove-badge {
  position: absolute;
  top: 8px;
  right: 8px;
  width: 24px;
  height: 24px;
  background-color: rgba(0,0,0,0.5);
  border-radius: 999px;
  display: flex;
  align-items: center;
  justify-content: center;
  color: #fff;
  .material-symbols-outlined { font-size: 16px; }
}

.footer {
  padding: 0 24px 40px 24px;
  padding-bottom: calc(40px + env(safe-area-inset-bottom));
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
  border: none;
  
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
}

.btn-content {
  display: flex;
  align-items: center;
  justify-content: center;
  gap: 12px;
  height: 100%;
}

.btn-text { font-size: 24px; font-weight: 900; color: #0d1b12; }
.check-icon { font-size: 32px; color: #0d1b12; }
.hint-text { text-align: center; font-size: 12px; color: #94a3b8; margin-top: 16px; display: block; }

.blob {
  position: absolute;
  border-radius: 999px;
  filter: blur(40px);
  z-index: 0;
}

.blob-1 { width: 96px; height: 96px; background-color: rgba(140, 208, 161, 0.1); top: 80px; left: -20px; }
.blob-2 { width: 128px; height: 128px; background-color: rgba(19, 236, 84, 0.1); bottom: 160px; right: -10px; }

.btn-hover {
  opacity: 0.7;
  transform: scale(0.9);
}

.complete-hover {
  transform: scale(0.98) translateY(4px);
  box-shadow: 0 4px 0 rgba(15, 184, 64, 1) !important;
}
</style>

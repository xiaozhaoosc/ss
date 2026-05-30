<template>
  <view class="daily-focus-page">
    <view class="status-bar-placeholder"></view>
    
    <!-- 顶部导航栏 -->
    <view class="top-nav">
      <view class="back-btn" @click="goBack">
        <text class="material-symbols-outlined">arrow_back_ios</text>
      </view>
      <text class="nav-title">今日焦点</text>
      <view class="right-placeholder"></view>
    </view>

    <scroll-view scroll-y class="main-scroll">
      <!-- 积分余额卡片 -->
      <view class="score-card">
        <view class="score-info">
          <text class="score-label">当前星星余额</text>
          <view class="score-value">
            <text class="material-symbols-outlined star-icon">stars</text>
            <text class="number">{{ starBalance }}</text>
          </view>
        </view>
        <view class="score-decoration"></view>
      </view>

      <!-- 今日任务列表 -->
      <view class="section">
        <view class="section-header">
          <text class="section-title">今日任务</text>
          <text class="section-subtitle">{{ completedTasks }}/{{ totalTasks }} 已完成</text>
        </view>
        
        <view v-if="tasks.length === 0" class="empty-state">
          <text>今日暂无任务安排</text>
        </view>
        
        <view v-for="task in tasks" :key="task.id" class="task-item">
          <view class="task-icon">
            <text class="material-symbols-outlined">{{ task.icon || 'task' }}</text>
          </view>
          <view class="task-content">
            <text class="task-name">{{ task.title }}</text>
            <text class="task-reward">+{{ task.starReward }} 星星</text>
          </view>
          <view class="task-status" :class="{ 'done': task.status === '2' || task.status === '3' }">
            {{ (task.status === '2' || task.status === '3') ? '已完成' : '未完成' }}
          </view>
        </view>
      </view>

      <!-- 可选奖励 -->
      <view class="section mt-4">
        <view class="section-header">
          <text class="section-title">可兑换奖励</text>
          <text class="see-all" @click="navigateToRewards">管理</text>
        </view>
        
        <view class="reward-grid">
          <view v-for="reward in rewards" :key="reward.rewardId" class="reward-card">
            <view class="reward-icon">{{ reward.icon || '🎁' }}</view>
            <text class="reward-name">{{ reward.name }}</text>
            <view class="reward-cost">
              <text class="cost-val">{{ reward.pointsRequired }}</text>
              <text class="cost-unit">星星</text>
            </view>
          </view>
        </view>
      </view>
    </scroll-view>
  </view>
</template>

<script setup lang="ts">
import { ref } from 'vue'
import { onLoad } from '@dcloudio/uni-app'
import { getTaskStatus } from '@/api/parent'
import { listReward } from '@/api/reward'
import { getFamilyMembers } from '@/api/family'
import { useUserStore } from '@/store/modules/user'

const userStore = useUserStore()
const childId = ref<number | null>(null)
const starBalance = ref(0)
const tasks = ref<any[]>([])
const rewards = ref<any[]>([])
const completedTasks = ref(0)
const totalTasks = ref(0)

onLoad((options: any) => {
  childId.value = options.childId || userStore.currentChildId
  loadData()
})

const loadData = async () => {
  if (!childId.value) return
  
  try {
    // 1. 获取任务状态
    const statusRes: any = await getTaskStatus(childId.value)
    if (statusRes.data) {
      tasks.value = statusRes.data.todayTasks || []
      completedTasks.value = statusRes.data.completedTasks || 0
      totalTasks.value = statusRes.data.totalTasks || 0
    }

    // 2. 获取奖励列表
    const rewardRes: any = await listReward({ pageNum: 1, pageSize: 6 })
    rewards.value = rewardRes.rows || []

    // 3. 获取余额 (从任务状态接口获取真实的 starBalance)
    starBalance.value = statusRes.data.starBalance || 0
  } catch (err) {
    console.error(err)
  }
}

const goBack = () => {
  uni.navigateBack()
}

const navigateToRewards = () => {
  uni.navigateTo({ url: '/pages/parent/reward-config/index' })
}
</script>

<style lang="scss" scoped>
.daily-focus-page {
  min-height: 100vh;
  background-color: #f8f9fa;
}

.status-bar-placeholder {
  height: var(--status-bar-height);
  width: 100%;
}

.top-nav {
  height: 44px;
  background-color: #ffffff;
  display: flex;
  align-items: center;
  justify-content: space-between;
  padding: 0 16px;
  border-bottom: 1px solid #f0f0f0;

  .back-btn {
    width: 32px;
    height: 32px;
    display: flex;
    align-items: center;
    justify-content: center;
    .material-symbols-outlined { font-size: 20px; }
  }

  .nav-title { font-size: 18px; font-weight: 700; }
  .right-placeholder { width: 32px; }
}

.main-scroll {
  padding: 16px;
  box-sizing: border-box;
}

.score-card {
  background: linear-gradient(135deg, #6C9BD2 0%, #89b1e5 100%);
  border-radius: 20px;
  padding: 24px;
  color: white;
  position: relative;
  overflow: hidden;
  margin-bottom: 24px;

  .score-label { font-size: 14px; opacity: 0.9; }
  .score-value {
    display: flex;
    align-items: center;
    gap: 8px;
    margin-top: 8px;
    .star-icon { font-size: 32px; color: #ffd700; }
    .number { font-size: 36px; font-weight: 800; }
  }
}

.section {
  background-color: #ffffff;
  border-radius: 20px;
  padding: 20px;
  
  .section-header {
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin-bottom: 16px;
  }
  
  .section-title { font-size: 18px; font-weight: 700; color: #111827; }
  .section-subtitle { font-size: 14px; color: #6b7280; }
  .see-all { font-size: 14px; color: #6C9BD2; font-weight: 600; }
}

.task-item {
  display: flex;
  align-items: center;
  gap: 12px;
  padding: 12px 0;
  border-bottom: 1px solid #f3f4f6;
  &:last-child { border-bottom: none; }

  .task-icon {
    width: 44px;
    height: 44px;
    background-color: #f0f7ff;
    border-radius: 12px;
    display: flex;
    align-items: center;
    justify-content: center;
    .material-symbols-outlined { color: #6C9BD2; }
  }

  .task-content {
    flex: 1;
    display: flex;
    flex-direction: column;
    .task-name { font-size: 15px; font-weight: 600; color: #111827; }
    .task-reward { font-size: 12px; color: #10b981; font-weight: 700; margin-top: 2px; }
  }

  .task-status {
    font-size: 12px;
    padding: 4px 8px;
    border-radius: 6px;
    background-color: #f3f4f6;
    color: #9ca3af;
    &.done { background-color: #ecfdf5; color: #10b981; }
  }
}

.reward-grid {
  display: grid;
  grid-template-columns: repeat(2, 1fr);
  gap: 12px;
}

.reward-card {
  background-color: #f9fafb;
  border-radius: 16px;
  padding: 16px;
  display: flex;
  flex-direction: column;
  align-items: center;
  text-align: center;

  .reward-icon { font-size: 32px; margin-bottom: 8px; }
  .reward-name { font-size: 14px; font-weight: 600; color: #374151; }
  .reward-cost {
    margin-top: 8px;
    display: flex;
    align-items: center;
    gap: 2px;
    .cost-val { font-size: 16px; font-weight: 700; color: #f59e0b; }
    .cost-unit { font-size: 10px; color: #9ca3af; }
  }
}

.mt-4 { margin-top: 16px; }
.empty-state { text-align: center; padding: 20px; color: #9ca3af; font-size: 14px; }
</style>

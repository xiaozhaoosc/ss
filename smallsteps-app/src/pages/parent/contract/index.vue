<template>
  <view class="contract-page" :class="{ 'dark': isDarkMode }">
    <!-- Header -->
    <view class="header">
      <button class="back-btn" @click="handleBack">
        <text class="material-symbols-outlined icon">arrow_back</text>
      </button>
      <text class="page-title">星空契约</text>
      <view class="star-count">
        <text class="material-symbols-outlined star-icon">stars</text>
        <text class="count">{{ starBalance }}</text>
      </view>
    </view>

    <scroll-view scroll-y class="main-content no-scrollbar">
      <!-- Section: Pending Redemptions -->
      <view class="section">
        <view class="section-header">
          <text class="section-title">待处理兑换</text>
          <text class="badge" v-if="pendingList.length">{{ pendingList.length }}</text>
        </view>

        <view v-if="pendingList.length === 0" class="empty-mini">
          <text class="empty-text">目前没有待处理的愿望哦 🌟</text>
        </view>

        <view v-else class="card-list">
          <view v-for="item in pendingList" :key="item.redemptionId" class="redemption-card">
            <view class="card-left">
              <view class="reward-icon-box">
                <text class="material-symbols-outlined">redeem</text>
              </view>
              <view class="reward-info">
                <text class="reward-name">{{ item.rewardName || '神秘奖励' }}</text>
                <text class="reward-cost">{{ item.pointsCost }} 颗星星</text>
              </view>
            </view>
            <view class="card-actions">
              <button class="action-btn reject" @click="handleReject(item.redemptionId)">
                <text class="material-symbols-outlined">close</text>
              </button>
              <button class="action-btn approve" @click="handleApprove(item.redemptionId)">
                <text class="material-symbols-outlined">check</text>
              </button>
            </view>
          </view>
        </view>
      </view>

      <!-- Section: Active Contracts (Mock for now) -->
      <view class="section">
        <view class="section-header">
          <text class="section-title">活跃契约</text>
        </view>
        
        <view class="contract-card">
          <view class="contract-header">
            <text class="contract-type">每日动力</text>
            <text class="contract-status">进行中</text>
          </view>
          <text class="contract-desc">连续 7 天完成“整理书包”，即可兑换“周末游乐园之旅”</text>
          <view class="progress-bar">
            <view class="progress-fill" style="width: 60%"></view>
          </view>
          <view class="progress-stats">
            <text>已坚持 4 天</text>
            <text>目标 7 天</text>
          </view>
        </view>
      </view>

      <view class="spacer"></view>
    </scroll-view>

    <!-- Background Decorations -->
    <view class="blob blob-1"></view>
    <view class="blob blob-2"></view>
  </view>
</template>

<script setup>
import { ref, onMounted } from 'vue'
import { getRedemptionList, approveRedemption, rejectRedemption } from '@/api/parent'
import { useUserStore } from '@/store/modules/user'

const userStore = useUserStore()
const isDarkMode = ref(false)
const starBalance = ref(0)
const pendingList = ref([])

const handleBack = () => {
  uni.navigateBack()
}

const loadData = async () => {
  const childId = userStore.currentChildId || 1
  try {
    const res = await getRedemptionList({ userId: childId, status: '0' })
    pendingList.value = res.rows || []
    
    // Fetch star balance
    const scoreRes = await uni.request({
      url: `${import.meta.env.VITE_APP_BASE_API}/parent/reward/score/${childId}`,
      method: 'GET',
      header: { Authorization: 'Bearer ' + uni.getStorageSync('token') }
    })
    starBalance.value = scoreRes.data?.data?.balance || 0
  } catch (e) {
    console.error(e)
  }
}

const handleApprove = async (id) => {
  uni.showModal({
    title: '确认批准',
    content: '批准后将扣除孩子的星星，并标记为已兑换',
    success: async (res) => {
      if (res.confirm) {
        try {
          await approveRedemption(id)
          uni.showToast({ title: '已批准！孩子会开心的', icon: 'success' })
          loadData()
        } catch (e) {
          uni.showToast({ title: '操作失败', icon: 'none' })
        }
      }
    }
  })
}

const handleReject = async (id) => {
  uni.showModal({
    title: '确认拒绝',
    content: '确定要拒绝这次兑换申请吗？建议先和孩子沟通哦',
    success: async (res) => {
      if (res.confirm) {
        try {
          await rejectRedemption(id)
          uni.showToast({ title: '已拒绝', icon: 'none' })
          loadData()
        } catch (e) {
          uni.showToast({ title: '操作失败', icon: 'none' })
        }
      }
    }
  })
}

onMounted(() => {
  loadData()
})
</script>

<style lang="scss" scoped>
.contract-page {
  height: 100vh;
  display: flex;
  flex-direction: column;
  background-color: #f8fafc;
  position: relative;
  overflow: hidden;
  :deep(.dark) & { background-color: #0f172a; }
}

.header {
  display: flex;
  align-items: center;
  justify-content: space-between;
  padding: 24px 20px 16px 20px;
  padding-top: calc(24px + env(safe-area-inset-top));
  position: relative;
  z-index: 10;
  background-color: rgba(255, 255, 255, 0.8);
  backdrop-filter: blur(10px);
}

.back-btn {
  width: 40px;
  height: 40px;
  border-radius: 12px;
  background-color: #ffffff;
  display: flex;
  align-items: center;
  justify-content: center;
  color: #64748b;
  box-shadow: 0 2px 8px rgba(0,0,0,0.05);
  border: none;
  &::after { border: none; }
}

.page-title {
  font-size: 18px;
  font-weight: 800;
  color: #1e293b;
}

.star-count {
  display: flex;
  align-items: center;
  gap: 4px;
  background: linear-gradient(135deg, #fbbf24, #f59e0b);
  padding: 6px 12px;
  border-radius: 999px;
  color: #ffffff;
  box-shadow: 0 4px 12px rgba(245, 158, 11, 0.2);
  
  .star-icon { font-size: 18px; font-variation-settings: 'FILL' 1; }
  .count { font-size: 14px; font-weight: 700; }
}

.main-content {
  flex: 1;
  padding: 20px;
  position: relative;
  z-index: 10;
}

.section {
  margin-bottom: 24px;
}

.section-header {
  display: flex;
  align-items: center;
  gap: 8px;
  margin-bottom: 16px;
}

.section-title {
  font-size: 16px;
  font-weight: 700;
  color: #334155;
}

.badge {
  background-color: #ef4444;
  color: #ffffff;
  font-size: 10px;
  font-weight: 700;
  padding: 2px 6px;
  border-radius: 999px;
}

.card-list {
  display: flex;
  flex-direction: column;
  gap: 12px;
}

.redemption-card {
  background-color: #ffffff;
  padding: 16px;
  border-radius: 20px;
  display: flex;
  align-items: center;
  justify-content: space-between;
  box-shadow: 0 4px 20px rgba(0,0,0,0.03);
}

.card-left {
  display: flex;
  align-items: center;
  gap: 12px;
}

.reward-icon-box {
  width: 48px;
  height: 48px;
  border-radius: 16px;
  background-color: #eff6ff;
  color: #3b82f6;
  display: flex;
  align-items: center;
  justify-content: center;
  .material-symbols-outlined { font-size: 28px; }
}

.reward-info {
  display: flex;
  flex-direction: column;
}

.reward-name {
  font-size: 15px;
  font-weight: 700;
  color: #1e293b;
}

.reward-cost {
  font-size: 12px;
  color: #64748b;
  margin-top: 2px;
}

.card-actions {
  display: flex;
  gap: 8px;
}

.action-btn {
  width: 36px;
  height: 36px;
  border-radius: 10px;
  display: flex;
  align-items: center;
  justify-content: center;
  border: none;
  &::after { border: none; }
  
  .material-symbols-outlined { font-size: 20px; }
  
  &.approve { background-color: #dcfce7; color: #16a34a; }
  &.reject { background-color: #fee2e2; color: #ef4444; }
  
  &:active { transform: scale(0.9); }
}

.contract-card {
  background-color: #ffffff;
  padding: 20px;
  border-radius: 24px;
  box-shadow: 0 10px 30px rgba(59, 130, 246, 0.08);
  border-left: 6px solid #3b82f6;
}

.contract-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-bottom: 12px;
}

.contract-type {
  font-size: 12px;
  font-weight: 700;
  color: #3b82f6;
  text-transform: uppercase;
  letter-spacing: 1px;
}

.contract-status {
  font-size: 11px;
  background-color: #dcfce7;
  color: #16a34a;
  padding: 2px 8px;
  border-radius: 6px;
  font-weight: 700;
}

.contract-desc {
  font-size: 16px;
  font-weight: 700;
  color: #1e293b;
  line-height: 1.5;
  margin-bottom: 20px;
}

.progress-bar {
  height: 8px;
  background-color: #f1f5f9;
  border-radius: 999px;
  overflow: hidden;
  margin-bottom: 12px;
}

.progress-fill {
  height: 100%;
  background: linear-gradient(90deg, #3b82f6, #60a5fa);
  border-radius: 999px;
}

.progress-stats {
  display: flex;
  justify-content: space-between;
  font-size: 12px;
  color: #94a3b8;
  font-weight: 600;
}

.empty-mini {
  padding: 32px 0;
  text-align: center;
  .empty-text { font-size: 14px; color: #94a3b8; font-style: italic; }
}

.blob {
  position: absolute;
  z-index: 0;
  filter: blur(60px);
  opacity: 0.4;
  border-radius: 999px;
}

.blob-1 { width: 300px; height: 300px; background-color: #dbeafe; top: -100px; right: -100px; }
.blob-2 { width: 200px; height: 200px; background-color: #fef3c7; bottom: 100px; left: -50px; }

.no-scrollbar::-webkit-scrollbar { display: none; }

.spacer { height: 100px; }
</style>

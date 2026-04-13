<template>
  <view class="reward-config-page" :class="{ 'dark': isDarkMode }">
    <!-- Top Bar -->
    <top-bar title="奖励设置" :show-back="true"></top-bar>

    <scroll-view scroll-y class="main-content no-scrollbar">
      <!-- Pending Requests Section -->
      <view class="section">
        <view class="section-header">
          <text class="material-symbols-outlined icon">notifications_active</text>
          <text class="section-title">待处理请求</text>
        </view>
        
        <view class="requests-list">
          <reward-request-card
            v-for="req in pendingRequests"
            :key="req.id"
            :child-name="req.childName"
            :reward-name="req.rewardName"
            :points="req.points"
            @approve="handleApprove(req)"
            @deny="handleDeny(req)"
          />
        </view>
      </view>

      <!-- Tabs -->
      <view class="tabs-container">
        <view class="tabs">
          <view 
            class="tab-item" 
            :class="{ active: activeTab === 'config' }"
            @click="activeTab = 'config'"
          >配置奖励</view>
          <view 
            class="tab-item" 
            :class="{ active: activeTab === 'history' }"
            @click="activeTab = 'history'"
          >兑换历史</view>
        </view>
      </view>

      <!-- Content based on Tab -->
      <view v-if="activeTab === 'config'" class="tab-content">
        <view class="section-header">
          <text class="material-symbols-outlined icon">list_alt</text>
          <text class="section-title">现有奖励</text>
        </view>
        
        <button class="add-reward-btn" @click="handleAddReward">
          <text class="material-symbols-outlined icon">add_circle</text>
          <text>添加新奖励</text>
        </button>
        
        <view class="rewards-list">
          <reward-config-item
            v-for="item in rewards"
            :key="item.id"
            v-model="item.active"
            :name="item.name"
            :points="item.points"
            :icon="item.icon"
            @change="handleRewardToggle(item)"
          />
        </view>
      </view>
      
      <view v-else class="tab-content">
        <!-- Redemption History Integration -->
        <view class="history-list">
          <view v-for="h in history" :key="h.id" class="history-item">
            <view class="info">
              <text class="h-name">{{ h.rewardName }}</text>
              <text class="h-date">{{ h.date }}</text>
            </view>
            <view class="status" :class="h.status">
              {{ h.statusText }}
            </view>
          </view>
        </view>
      </view>
      
      <view class="spacer"></view>
    </scroll-view>
    
    <!-- Bottom Nav -->
    <bottom-nav mode="parent" />
  </view>
</template>

<script setup>
import { ref } from 'vue'
import { onShow } from '@dcloudio/uni-app'
import TopBar from '@/components/common/top-bar/top-bar.vue'
import BottomNav from '@/components/common/bottom-nav/bottom-nav.vue'
import RewardRequestCard from '@/components/parent/reward-request-card/reward-request-card.vue'
import RewardConfigItem from '@/components/parent/reward-config-item/reward-config-item.vue'
import { listReward, updateReward, listRedemptions, approveRedemption, rejectRedemption } from '@/api/reward'
import { useUserStore } from '@/store/modules/user'

const userStore = useUserStore()
const isDarkMode = ref(false)
const activeTab = ref('config')

const pendingRequests = ref([])
const rewards = ref([])
const history = ref([])

async function loadData() {
  try {
     // 1. 加载奖励配置
     const res = await listReward({ pageNum: 1, pageSize: 50 })
     if (res.rows) {
       rewards.value = res.rows.map(r => ({
         id: r.rewardId,
         name: r.name,
         points: r.pointsRequired,
         icon: r.icon || 'star',
         active: r.status === '0'
       }))
     }

     // 2. 加载待处理申请
     const redRes = await listRedemptions({ status: '0', pageNum: 1, pageSize: 20 })
     if (redRes.rows) {
       pendingRequests.value = redRes.rows.map(r => ({
         id: r.redemptionId,
         childName: '孩子', // 实际开发中需通过关联查询或前端缓存映射
         rewardName: r.rewardName || '奖品',
         points: r.pointsCost
       }))
     }

     // 3. 加载历史记录 (已批准和已拒绝)
     const histRes = await listRedemptions({ pageNum: 1, pageSize: 20 })
     if (histRes.rows) {
       history.value = histRes.rows.filter(r => r.status !== '0').map(r => ({
         id: r.redemptionId,
         rewardName: r.rewardName || '奖品',
         date: r.createTime ? r.createTime.substring(0, 16) : '',
         status: r.status === '1' ? 'approved' : 'denied',
         statusText: r.status === '1' ? '已批准' : '已拒绝'
       }))
     }
  } catch (e) {
    console.error(e)
  }
}

onShow(() => {
  loadData()
})

const handleApprove = (req) => {
  uni.showModal({
    title: '确认批准',
    content: `准备消耗 ${req.points} 颗星兑换“${req.rewardName}”吗？`,
    success: (res) => {
      if (res.confirm) {
        uni.showLoading({ title: '处理中...' })
        approveRedemption(req.id).then(() => {
          uni.hideLoading()
          uni.showToast({ title: '已批准', icon: 'success' })
          loadData() // 刷新列表
        }).catch(err => {
          uni.hideLoading()
          uni.showToast({ title: err.msg || '批准失败', icon: 'error' })
        })
      }
    }
  })
}

const handleDeny = (req) => {
  uni.showModal({
    title: '确认拒绝',
    content: `确定要拒绝该兑换申请吗？`,
    success: (res) => {
      if (res.confirm) {
        uni.showLoading({ title: '处理中...' })
        rejectRedemption(req.id).then(() => {
          uni.hideLoading()
          uni.showToast({ title: '已拒绝', icon: 'none' })
          loadData()
        }).catch(() => {
          uni.hideLoading()
        })
      }
    }
  })
}

const handleAddReward = () => {
  uni.showToast({ title: '跳转到新增奖励页 (TODO)', icon: 'none' })
}

const handleRewardToggle = (item) => {
    // Optimistic UI update already happened via v-model
    const newStatus = item.active ? '0' : '1'
    updateReward({ rewardId: item.id, status: newStatus }).then(() => {
        // Success
    }).catch(() => {
        // Revert on failure
        item.active = !item.active
    })
}
</script>

<style lang="scss" scoped>
.reward-config-page {
  height: 100vh;
  display: flex;
  flex-direction: column;
  background-color: #f6f7f8;
  
  :deep(.dark) & {
    background-color: #14191e;
  }
}

.main-content {
  flex: 1;
  padding: 16px;
  padding-top: 60px;
}

.section {
  margin-bottom: 24px;
}

.section-header {
  display: flex;
  align-items: center;
  gap: 8px;
  margin-bottom: 12px;
  
  .icon {
    font-size: 20px;
    color: #6C9BD2;
  }
}

.section-title {
  font-size: 14px;
  font-weight: 700;
  text-transform: uppercase;
  color: #6b7280;
  letter-spacing: 0.5px;
}

.tabs-container {
  margin-bottom: 20px;
}

.tabs {
  display: flex;
  background-color: #e5e7eb;
  padding: 4px;
  border-radius: 8px;
  
  :deep(.dark) & {
    background-color: #1f2937;
  }
}

.tab-item {
  flex: 1;
  text-align: center;
  font-size: 12px;
  font-weight: 700;
  padding: 8px 0;
  border-radius: 6px;
  color: #6b7280;
  transition: all 0.3s ease;
  
  &.active {
    background-color: #ffffff;
    color: #6C9BD2;
    box-shadow: 0 1px 3px rgba(0, 0, 0, 0.1);
    
    :deep(.dark) & {
      background-color: #1e242b;
    }
  }
}

.add-reward-btn {
  display: flex;
  align-items: center;
  justify-content: center;
  gap: 8px;
  width: 100%;
  height: 48px;
  margin-bottom: 24px;
  background-color: rgba(108, 155, 210, 0.05);
  border: 2px dashed rgba(108, 155, 210, 0.3);
  border-radius: 8px;
  color: #6C9BD2;
  font-weight: 700;
  transition: all 0.3s ease;
  
  &::after { border: none; }
  
  &:active {
    background-color: rgba(108, 155, 210, 0.1);
    border-color: #6C9BD2;
    transform: scale(0.99);
  }
  
  .icon {
    font-size: 20px;
  }
}

.rewards-list, .requests-list {
  display: flex;
  flex-direction: column;
  gap: 12px;
}

.history-item {
  display: flex;
  justify-content: space-between;
  align-items: center;
  padding: 16px;
  background-color: #ffffff;
  border-radius: 12px;
  margin-bottom: 12px;
  
  :deep(.dark) & {
    background-color: #1e242b;
  }
}

.history-item .info {
  display: flex;
  flex-direction: column;
}

.h-name {
  font-size: 14px;
  font-weight: 600;
  color: #111827;
  :deep(.dark) & { color: #fff; }
}

.h-date {
  font-size: 12px;
  color: #9ca3af;
}

.status {
  font-size: 12px;
  font-weight: 700;
  
  &.approved { color: #10b981; }
  &.denied { color: #ef4444; }
}

.spacer {
  height: 80px;
}

.no-scrollbar::-webkit-scrollbar {
  display: none;
}
</style>

<template>
  <view class="star-history-page">
    <!-- Header -->
    <view class="header">
      <view class="top-row">
        <button class="back-btn" hover-class="btn-hover" @click="handleBack">
          <text class="material-symbols-outlined">arrow_back_ios_new</text>
        </button>
        <text class="page-title">星星流水账</text>
        <view class="balance-pill">
          <text class="material-symbols-outlined star-icon">star</text>
          <text class="balance-val">{{ userStore.balance }}</text>
        </view>
      </view>

      <!-- 筛选 Tab -->
      <view class="filter-tabs">
        <view
          v-for="tab in tabs"
          :key="tab.key"
          class="tab-item"
          :class="{ active: activeTab === tab.key }"
          @click="switchTab(tab.key)"
        >
          <text>{{ tab.label }}</text>
        </view>
      </view>
    </view>

    <!-- 列表 -->
    <scroll-view
      scroll-y
      class="list-container no-scrollbar"
      @scrolltolower="loadMore"
      :lower-threshold="80"
    >
      <!-- 空状态 -->
      <view v-if="!loading && filteredList.length === 0" class="empty-state">
        <view class="empty-icon-wrap">
          <text class="material-symbols-outlined empty-icon">stars</text>
        </view>
        <text class="empty-title">还没有记录</text>
        <text class="empty-sub">完成任务就能赢得星星哦 ✨</text>
      </view>

      <!-- 记录列表 -->
      <view v-else class="record-list">
        <!-- 按日期分组 -->
        <view v-for="group in groupedList" :key="group.date" class="date-group">
          <view class="date-label-row">
            <view class="date-line"></view>
            <text class="date-label">{{ group.date }}</text>
            <view class="date-line"></view>
          </view>

          <view
            v-for="item in group.items"
            :key="item.id"
            class="record-item"
            :class="item.type === '增加' ? 'earn' : 'consume'"
          >
            <!-- 图标 -->
            <view class="icon-circle" :class="item.type === '增加' ? 'icon-earn' : 'icon-consume'">
              <text class="material-symbols-outlined">
                {{ item.type === '增加' ? 'emoji_events' : 'redeem' }}
              </text>
            </view>

            <!-- 文字 -->
            <view class="record-info">
              <text class="record-reason">{{ item.reason || (item.type === '增加' ? '完成任务奖励' : '兑换奖励消耗') }}</text>
              <text class="record-time">{{ formatTime(item.createTime) }}</text>
            </view>

            <!-- 数值 -->
            <view class="record-amount" :class="item.type === '增加' ? 'amount-earn' : 'amount-consume'">
              <text class="amount-sign">{{ item.type === '增加' ? '+' : '-' }}</text>
              <text class="amount-val">{{ item.points }}</text>
              <text class="material-symbols-outlined amount-star">star</text>
            </view>
          </view>
        </view>
      </view>

      <!-- 加载中 / 没有更多 -->
      <view class="load-footer">
        <view v-if="loading" class="loading-dots">
          <view class="dot"></view>
          <view class="dot"></view>
          <view class="dot"></view>
        </view>
        <text v-else-if="noMore && list.length > 0" class="no-more-text">已经到底啦 🎉</text>
      </view>

      <view class="safe-spacer"></view>
    </scroll-view>
  </view>
</template>

<script setup lang="ts">
import { ref, computed, onMounted } from 'vue'
import { onLoad } from '@dcloudio/uni-app'
import { useUserStore } from '@/store/modules/user'
import { getScoreHistory } from '@/api/child'

const userStore = useUserStore()

const tabs = [
  { key: 'all', label: '全部' },
  { key: 'earn', label: '⭐ 获得' },
  { key: 'consume', label: '🛍️ 消耗' }
]
const activeTab = ref('all')

const list = ref<any[]>([])
const loading = ref(false)
const noMore = ref(false)
const pageNum = ref(1)
const pageSize = 15

async function fetchHistory(reset = false) {
  const childId = userStore.id
  if (!childId || loading.value) return
  if (noMore.value && !reset) return

  loading.value = true
  if (reset) {
    list.value = []
    pageNum.value = 1
    noMore.value = false
  }

  try {
    const res: any = await getScoreHistory(childId, {
      pageNum: pageNum.value,
      pageSize
    })
    const rows = res.rows || res.data?.rows || []
    const total = res.total || res.data?.total || 0

    list.value = reset ? rows : [...list.value, ...rows]
    noMore.value = list.value.length >= total
    pageNum.value += 1
  } catch (e) {
    console.error('Failed to load score history', e)
  } finally {
    loading.value = false
  }
}

function loadMore() {
  if (!noMore.value && !loading.value) {
    fetchHistory()
  }
}

function switchTab(key: string) {
  activeTab.value = key
}

// 根据 Tab 过滤
const filteredList = computed(() => {
  if (activeTab.value === 'earn') return list.value.filter(i => i.type === '增加')
  if (activeTab.value === 'consume') return list.value.filter(i => i.type === '扣除' || i.type === '消耗')
  return list.value
})

// 按日期分组
const groupedList = computed(() => {
  const groups: Record<string, any[]> = {}
  filteredList.value.forEach(item => {
    const dateKey = formatDate(item.createTime)
    if (!groups[dateKey]) groups[dateKey] = []
    groups[dateKey].push(item)
  })
  return Object.keys(groups).map(date => ({ date, items: groups[date] }))
})

function formatDate(timeStr: string): string {
  if (!timeStr) return '未知日期'
  const d = new Date(timeStr)
  const today = new Date()
  const isToday = d.toDateString() === today.toDateString()
  const yesterday = new Date(today)
  yesterday.setDate(today.getDate() - 1)
  const isYesterday = d.toDateString() === yesterday.toDateString()
  if (isToday) return '今天'
  if (isYesterday) return '昨天'
  return `${d.getMonth() + 1}月${d.getDate()}日`
}

function formatTime(timeStr: string): string {
  if (!timeStr) return ''
  const d = new Date(timeStr)
  const h = String(d.getHours()).padStart(2, '0')
  const m = String(d.getMinutes()).padStart(2, '0')
  return `${h}:${m}`
}

function handleBack() {
  uni.vibrateShort()
  uni.navigateBack()
}

onLoad(() => {
  fetchHistory(true)
  userStore.fetchBalance()
})
</script>

<style lang="scss" scoped>
.star-history-page {
  height: 100vh;
  display: flex;
  flex-direction: column;
  background: linear-gradient(180deg, #FFFBF0 0%, #FFF8E7 100%);
}

/* ===== Header ===== */
.header {
  padding: 20px 20px 0;
  padding-top: calc(20px + env(safe-area-inset-top));
  background: linear-gradient(180deg, #FFFBF0, transparent);
}

.top-row {
  display: flex;
  align-items: center;
  justify-content: space-between;
  margin-bottom: 20px;
}

.back-btn {
  width: 40px;
  height: 40px;
  border-radius: 999px;
  background: rgba(255,255,255,0.9);
  display: flex;
  align-items: center;
  justify-content: center;
  color: #d97706;
  border: none;
  box-shadow: 0 2px 8px rgba(0,0,0,0.06);
  &::after { border: none; }
  .material-symbols-outlined { font-size: 20px; }
}

.btn-hover {
  transform: scale(0.9);
  opacity: 0.8;
}

.page-title {
  font-size: 20px;
  font-weight: 900;
  color: #1c1409;
  letter-spacing: -0.5px;
}

.balance-pill {
  display: flex;
  align-items: center;
  gap: 4px;
  background: linear-gradient(135deg, #F5D76E, #fbbf24);
  padding: 6px 14px 6px 10px;
  border-radius: 999px;
  box-shadow: 0 4px 12px rgba(245, 215, 110, 0.5);
}

.star-icon {
  font-size: 18px;
  color: #ffffff;
  font-variation-settings: 'FILL' 1;
}

.balance-val {
  font-size: 18px;
  font-weight: 900;
  color: #ffffff;
}

/* ===== Filter Tabs ===== */
.filter-tabs {
  display: flex;
  gap: 8px;
  margin-bottom: 16px;
}

.tab-item {
  flex: 1;
  padding: 10px 0;
  text-align: center;
  font-size: 13px;
  font-weight: 700;
  color: #9ca3af;
  background: rgba(255,255,255,0.6);
  border-radius: 14px;
  border: 1.5px solid transparent;
  transition: all 0.25s ease;

  &.active {
    background: #ffffff;
    color: #d97706;
    border-color: rgba(245, 215, 110, 0.6);
    box-shadow: 0 4px 12px rgba(245, 215, 110, 0.25);
  }
}

/* ===== List ===== */
.list-container {
  flex: 1;
  height: 0;
  padding: 0 16px;
}

.empty-state {
  display: flex;
  flex-direction: column;
  align-items: center;
  padding: 80px 20px;
  gap: 12px;
}

.empty-icon-wrap {
  width: 80px;
  height: 80px;
  border-radius: 999px;
  background: linear-gradient(135deg, #fef3c7, #fde68a);
  display: flex;
  align-items: center;
  justify-content: center;
  box-shadow: 0 8px 24px rgba(251, 191, 36, 0.25);
}

.empty-icon {
  font-size: 40px;
  color: #f59e0b;
  font-variation-settings: 'FILL' 1;
}

.empty-title {
  font-size: 18px;
  font-weight: 800;
  color: #374151;
}

.empty-sub {
  font-size: 13px;
  color: #9ca3af;
  font-weight: 500;
}

/* ===== Date Group ===== */
.record-list {
  display: flex;
  flex-direction: column;
  gap: 4px;
  padding-top: 4px;
}

.date-group {
  display: flex;
  flex-direction: column;
  gap: 8px;
  margin-bottom: 8px;
}

.date-label-row {
  display: flex;
  align-items: center;
  gap: 10px;
  padding: 4px 0;
}

.date-line {
  flex: 1;
  height: 1px;
  background: rgba(217, 119, 6, 0.12);
}

.date-label {
  font-size: 11px;
  font-weight: 700;
  color: #d97706;
  white-space: nowrap;
  letter-spacing: 0.5px;
}

/* ===== Record Item ===== */
.record-item {
  display: flex;
  align-items: center;
  gap: 14px;
  background: #ffffff;
  border-radius: 20px;
  padding: 14px 16px;
  box-shadow: 0 2px 10px rgba(0,0,0,0.04);
  border: 1.5px solid transparent;
  transition: all 0.2s ease;

  &.earn {
    border-color: rgba(140, 208, 161, 0.2);
  }
  &.consume {
    border-color: rgba(248, 113, 113, 0.15);
  }
  &:active {
    transform: scale(0.98);
    box-shadow: 0 1px 4px rgba(0,0,0,0.06);
  }
}

.icon-circle {
  width: 44px;
  height: 44px;
  border-radius: 16px;
  display: flex;
  align-items: center;
  justify-content: center;
  flex-shrink: 0;

  .material-symbols-outlined {
    font-size: 22px;
    font-variation-settings: 'FILL' 1;
  }

  &.icon-earn {
    background: linear-gradient(135deg, #d1fae5, #a7f3d0);
    .material-symbols-outlined { color: #059669; }
  }
  &.icon-consume {
    background: linear-gradient(135deg, #fee2e2, #fecaca);
    .material-symbols-outlined { color: #ef4444; }
  }
}

.record-info {
  flex: 1;
  display: flex;
  flex-direction: column;
  gap: 4px;
  min-width: 0;
}

.record-reason {
  font-size: 14px;
  font-weight: 700;
  color: #1c1409;
  line-height: 1.3;
  overflow: hidden;
  text-overflow: ellipsis;
  white-space: nowrap;
}

.record-time {
  font-size: 11px;
  font-weight: 500;
  color: #9ca3af;
}

.record-amount {
  display: flex;
  align-items: center;
  gap: 2px;
  flex-shrink: 0;

  .amount-sign {
    font-size: 16px;
    font-weight: 900;
    line-height: 1;
  }
  .amount-val {
    font-size: 22px;
    font-weight: 900;
    line-height: 1;
  }
  .amount-star {
    font-size: 16px;
    font-variation-settings: 'FILL' 1;
    margin-left: 1px;
  }

  &.amount-earn {
    color: #10b981;
    .amount-star { color: #10b981; }
  }
  &.amount-consume {
    color: #ef4444;
    .amount-star { color: #ef4444; }
  }
}

/* ===== Load footer ===== */
.load-footer {
  display: flex;
  justify-content: center;
  align-items: center;
  padding: 20px 0 12px;
  min-height: 48px;
}

.loading-dots {
  display: flex;
  gap: 6px;
  align-items: center;
}

.dot {
  width: 8px;
  height: 8px;
  border-radius: 50%;
  background: #fbbf24;
  animation: dotBounce 1.2s infinite ease-in-out;

  &:nth-child(2) { animation-delay: 0.2s; }
  &:nth-child(3) { animation-delay: 0.4s; }
}

@keyframes dotBounce {
  0%, 80%, 100% { transform: scale(0.7); opacity: 0.5; }
  40% { transform: scale(1.1); opacity: 1; }
}

.no-more-text {
  font-size: 12px;
  color: #d1d5db;
  font-weight: 600;
}

.safe-spacer {
  height: 40px;
}

.no-scrollbar::-webkit-scrollbar { display: none; }
</style>

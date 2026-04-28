<template>
  <view class="exec-record-page">
    <view class="status-bar-placeholder"></view>
    
    <!-- 顶部导航栏 -->
    <view class="top-nav">
      <view class="back-btn" @click="goBack">
        <text class="material-symbols-outlined">arrow_back_ios</text>
      </view>
      <text class="nav-title">执行记录</text>
      <view class="right-placeholder"></view>
    </view>

    <!-- 列表内容 -->
    <scroll-view 
      scroll-y 
      class="list-container"
      @scrolltolower="loadMore"
      refresher-enabled
      :refresher-triggered="isRefreshing"
      @refresherrefresh="onRefresh"
    >
      <view v-if="recordList.length === 0 && !loading" class="empty-state">
        <text class="material-symbols-outlined empty-icon">history</text>
        <text class="empty-text">暂无历史记录</text>
      </view>

      <view v-for="item in recordList" :key="item.id" class="record-card">
        <view class="card-header">
          <view class="task-info">
            <view class="task-icon">
              <text class="material-symbols-outlined">{{ item.taskDefinition?.icon || 'task' }}</text>
            </view>
            <view class="task-meta">
              <text class="task-title">{{ item.taskDefinition?.title || item.titleSnap || '未知任务' }}</text>
              <text class="task-time">{{ formatTime(item.endTime || item.createTime) }}</text>
            </view>
          </view>
          <view class="status-badge" :class="getStatusClass(item.status)">
            {{ getStatusText(item.status) }}
          </view>
        </view>

        <view class="card-body">
          <view class="detail-row">
            <text class="label">预计完成日期:</text>
            <text class="value">{{ item.targetDate || '-' }}</text>
          </view>
          <view v-if="item.actualDuration" class="detail-row">
            <text class="label">实际耗时:</text>
            <text class="value">{{ formatDuration(item.actualDuration) }}</text>
          </view>
          <view v-if="item.proof" class="proof-container">
            <text class="label">任务证明:</text>
            <image :src="item.proof" mode="aspectFill" class="proof-image" @click="previewImage(item.proof)" />
          </view>
        </view>

        <view class="card-footer">
          <view class="action-btn delete" @click="confirmDelete(item.id)">
            <text class="material-symbols-outlined">delete</text>
            <text>删除</text>
          </view>
        </view>
      </view>

      <view v-if="loading" class="loading-state">
        <text class="loading-text">加载中...</text>
      </view>
      <view v-if="noMore && recordList.length > 0" class="no-more">
        <text>没有更多记录了</text>
      </view>
    </scroll-view>
  </view>
</template>

<script setup lang="ts">
import { ref, onMounted } from 'vue'
import { onLoad } from '@dcloudio/uni-app'
import { getTimeline, deleteExecutionRecord } from '@/api/parent'
import { useUserStore } from '@/store/modules/user'

const userStore = useUserStore()
const childId = ref<number | null>(null)
const recordList = ref<any[]>([])
const loading = ref(false)
const isRefreshing = ref(false)
const noMore = ref(false)
const pageNum = ref(1)
const pageSize = ref(10)

onLoad((options: any) => {
  childId.value = options.childId || userStore.currentChildId
  loadData()
})

const loadData = async (refresh = false) => {
  if (loading.value || (!refresh && noMore.value)) return
  if (!childId.value) return

  loading.value = true
  if (refresh) {
    pageNum.value = 1
    noMore.value = false
  }

  try {
    // 这里后端 selectChildTaskList 目前不支持分页参数，先按全部加载逻辑写，后续后端支持分页再改
    const res: any = await getTimeline(childId.value)
    const data = res.data || []
    
    if (refresh) {
      recordList.value = data.map((item: any) => ({ ...item, id: item.childTaskId || item.id }))
    } else {
      const mappedData = data.map((item: any) => ({ ...item, id: item.childTaskId || item.id }))
      const existingIds = new Set(recordList.value.map(item => item.id))
      const uniqueNewData = mappedData.filter((item: any) => item.id && !existingIds.has(item.id))
      recordList.value = [...recordList.value, ...uniqueNewData]
    }
    
    // 模拟分页逻辑 (因为目前 API 是全量返回)
    if (data.length < pageSize.value) {
      noMore.value = true
    }
  } catch (err) {
    console.error('Failed to load records', err)
  } finally {
    loading.value = false
    isRefreshing.value = false
  }
}

const onRefresh = () => {
  isRefreshing.value = true
  loadData(true)
}

const loadMore = () => {
  // pageNum.value++
  // loadData()
}

const goBack = () => {
  uni.navigateBack()
}

const confirmDelete = (id: number) => {
  uni.showModal({
    title: '确认删除',
    content: '删除后执行记录将无法找回，确认继续吗？',
    success: async (res) => {
      if (res.confirm) {
        try {
          await deleteExecutionRecord(id)
          uni.showToast({ title: '已删除', icon: 'success' })
          recordList.value = recordList.value.filter(item => item.id !== id)
        } catch (err) {
          uni.showToast({ title: '删除失败', icon: 'none' })
        }
      }
    }
  })
}

const getStatusText = (status: string) => {
  const map: Record<string, string> = {
    '1': '进行中',
    '2': '已完成',
    '3': '已点亮',
    '4': '已失效'
  }
  return map[status] || '未知'
}

const getStatusClass = (status: string) => {
  const map: Record<string, string> = {
    '1': 'status-progress',
    '2': 'status-done',
    '3': 'status-highlight',
    '4': 'status-fail'
  }
  return map[status] || ''
}

const formatTime = (timeStr: string) => {
  if (!timeStr) return '--:--'
  return timeStr.substring(5, 16)
}

const formatDuration = (seconds: number) => {
  const m = Math.floor(seconds / 60)
  const s = seconds % 60
  return `${m}分${s}秒`
}

const previewImage = (url: string) => {
  uni.previewImage({
    urls: [url]
  })
}
</script>

<style lang="scss" scoped>
.exec-record-page {
  min-height: 100vh;
  background-color: #f8f9fa;
  display: flex;
  flex-direction: column;
}

.status-bar-placeholder {
  height: var(--status-bar-height);
  width: 100%;
  background-color: #ffffff;
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
    .material-symbols-outlined { font-size: 20px; color: #333; }
  }

  .nav-title {
    font-size: 18px;
    font-weight: 700;
    color: #111827;
  }

  .right-placeholder { width: 32px; }
}

.list-container {
  flex: 1;
  padding: 16px;
  box-sizing: border-box;
}

.record-card {
  background-color: #ffffff;
  border-radius: 16px;
  padding: 16px;
  margin-bottom: 16px;
  box-shadow: 0 4px 12px rgba(0, 0, 0, 0.05);
}

.card-header {
  display: flex;
  justify-content: space-between;
  align-items: flex-start;
  margin-bottom: 16px;

  .task-info {
    display: flex;
    gap: 12px;
  }

  .task-icon {
    width: 40px;
    height: 40px;
    background-color: #f0f7ff;
    border-radius: 10px;
    display: flex;
    align-items: center;
    justify-content: center;
    .material-symbols-outlined { color: #6C9BD2; font-size: 24px; }
  }

  .task-meta {
    display: flex;
    flex-direction: column;
    .task-title { font-size: 16px; font-weight: 700; color: #111827; }
    .task-time { font-size: 12px; color: #9ca3af; margin-top: 2px; }
  }
}

.status-badge {
  padding: 4px 10px;
  border-radius: 999px;
  font-size: 12px;
  font-weight: 600;

  &.status-progress { background-color: #ebf5ff; color: #3b82f6; }
  &.status-done { background-color: #ecfdf5; color: #10b981; }
  &.status-highlight { background-color: #fffbeb; color: #f59e0b; }
  &.status-fail { background-color: #fef2f2; color: #ef4444; }
}

.card-body {
  border-top: 1px solid #f9fafb;
  padding-top: 12px;
  display: flex;
  flex-direction: column;
  gap: 8px;

  .detail-row {
    display: flex;
    justify-content: space-between;
    font-size: 14px;
    .label { color: #6b7280; }
    .value { color: #374151; font-weight: 500; }
  }
}

.proof-container {
  display: flex;
  flex-direction: column;
  gap: 8px;
  margin-top: 4px;
  .label { font-size: 14px; color: #6b7280; }
  .proof-image {
    width: 100px;
    height: 100px;
    border-radius: 8px;
    background-color: #f3f4f6;
  }
}

.card-footer {
  margin-top: 16px;
  border-top: 1px solid #f9fafb;
  padding-top: 12px;
  display: flex;
  justify-content: flex-end;

  .action-btn {
    display: flex;
    align-items: center;
    gap: 4px;
    font-size: 14px;
    font-weight: 600;
    padding: 6px 12px;
    border-radius: 8px;
    cursor: pointer;

    &.delete { color: #ef4444; background-color: #fef2f2; }
    .material-symbols-outlined { font-size: 18px; }
  }
}

.empty-state {
  display: flex;
  flex-direction: column;
  align-items: center;
  padding: 100px 0;
  color: #9ca3af;
  .empty-icon { font-size: 64px; margin-bottom: 16px; opacity: 0.3; }
  .empty-text { font-size: 16px; }
}

.loading-state, .no-more {
  text-align: center;
  padding: 20px 0;
  font-size: 12px;
  color: #9ca3af;
}
</style>

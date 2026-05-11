<template>
  <view class="dashboard-page" :class="{ 'dark': isDarkMode }">
    <!-- 顶部状态栏占位 -->
    <view class="status-bar-placeholder"></view>

    <!-- 顶部标题栏 -->
    <view class="top-app-bar">
      <view class="user-info">
        <view class="avatar" :style="{ backgroundImage: `url(${userAvatar})` }"></view>
        <view class="welcome">
          <text class="greeting">欢迎回来,</text>
          <text class="username">{{ userName }}</text>
        </view>
      </view>
      <view class="actions">
        <view class="icon-btn" hover-class="btn-hover" @click="toggleNotifications">
          <text class="material-symbols-outlined">notifications</text>
          <view v-if="unreadCount > 0" class="badge-dot"></view>
        </view>
      </view>
      
      <!-- 通知下拉菜单 -->
      <view v-if="showNotifications" class="notification-dropdown">
        <view class="dropdown-header">
          <text class="dropdown-title">通知中心</text>
          <text class="mark-read" @click="markAllRead">全部已读</text>
        </view>
        <scroll-view scroll-y class="notification-list">
          <view v-for="note in notifications" :key="note.id" class="notification-item">
            <view class="note-icon" :class="note.type">
              <text class="material-symbols-outlined">{{ note.icon }}</text>
            </view>
            <view class="note-content">
              <text class="note-text">{{ note.message }}</text>
              <text class="note-time">{{ note.time }}</text>
              <view v-if="note.actions" class="note-actions">
                <button class="btn btn-primary" hover-class="btn-hover-primary" size="mini" @click="handleAction(note, 'approve')">批准</button>
                <button class="btn btn-secondary" hover-class="btn-hover-secondary" size="mini" @click="handleAction(note, 'deny')">拒绝</button>
              </view>
            </view>
          </view>
        </scroll-view>
      </view>
    </view>

    <scroll-view scroll-y class="main-content">
      <!-- AI 观察者建议 -->
      <ai-insight-card 
        v-if="aiInsight" 
        :content="aiInsight" 
        @click="navigateToAiDetails"
        @viewWeekly="navigateToWeeklyReport"
      />

      <!-- 今日焦点 -->
      <view class="section-header">
        <text class="section-title">今日焦点</text>
        <view class="see-all-btn" hover-class="btn-hover-opacity" @click="navigateToDailyFocus">
          <text class="see-all">详情</text>
        </view>
      </view>
      
      <scroll-view scroll-x class="stats-scroll no-scrollbar">
        <view class="stats-container">
          <stat-card 
            v-for="stat in stats" 
            :key="stat.label"
            v-bind="stat"
          />
        </view>
      </scroll-view>

      <!-- 任务执行记录 (时间轴) -->
      <view class="section-header mt-6">
        <text class="section-title">执行记录</text>
        <view class="see-all-btn" hover-class="btn-hover-opacity" @click="navigateToExecRecord">
          <text class="see-all">查看全部</text>
        </view>
      </view>
      
      <view class="timeline-container">
        <view v-if="timeline.length === 0" class="empty-state">
          <text class="material-symbols-outlined empty-icon">history</text>
          <text class="empty-text">暂无执行记录</text>
        </view>
        <timeline-item 
          v-for="(item, index) in timeline" 
          :key="index"
          v-bind="item"
          :is-last="index === timeline.length - 1"
        />
      </view>
    </scroll-view>

    <!-- 底部导航 -->
    <bottom-nav mode="parent" />
  </view>
</template>

<script setup lang="ts">
import { ref, computed } from 'vue'
import { onLoad, onShow } from '@dcloudio/uni-app'
import AiInsightCard from '@/components/parent/ai-insight-card/ai-insight-card.vue'
import StatCard from '@/components/parent/stat-card/stat-card.vue'
import EmotionAlert from '@/components/parent/emotion-alert/emotion-alert.vue'
import TimelineItem from '@/components/parent/timeline-item/timeline-item.vue'
import BottomNav from '@/components/common/bottom-nav/bottom-nav.vue'
import { useUserStore } from '@/store/modules/user'
import { getFamilyMembers } from '@/api/family'
import { 
  getTaskStatus, 
  getSummaryInsight, 
  getTimeline,
  getWeeklyHeatmap,
  getWeeklyAiAnalysis,
  getRedemptionList,
  approveRedemption,
  rejectRedemption
} from '@/api/parent'
import { listReward } from '@/api/reward'

// User info
const userStore = useUserStore()
const userAvatar = ref('https://lh3.googleusercontent.com/aida-public/AB6AXuBXSaBUjkmzRo1U3JyO-es_moeOQg_OvUxIvbH0ROD2h5i3fJBnVg38LUIDigs7AdcXWRqhOZxpc1Q0CCxrokZ9tm_6QYGs88bUR--C-6E5k2kxM1xrC-Qc0P_pHpYsHksNowi3cROSk01tNRc69_TAGf7XTIDVeJO5aWaoWURVxTh90LTxk3yIQ2nIbd_0CbqBt6dtKXVYLtYKujugHTIrITJN6LFKhy5LwJxXrmN-3Jp-am186GV7mkFQAJNC1_DM8KNyeajRDH4')
// const userName = computed(() => userStore.userInfo?.user?.nickName || '家长')
const userName = ref('家长') // Default
const unreadCount = ref(0)
const showNotifications = ref(false)
const isDarkMode = ref(false)

const stats = ref([
  { label: '任务总数', value: '0', unit: '个', icon: 'check_circle', type: 'purple', trend: 0 },
  { label: '奖励总数', value: '0', unit: '个', icon: 'emoji_events', type: 'blue', trend: 0 }
])

const activeAlert = ref(null)
const aiInsight = ref('')
const timeline = ref<any[]>([])
const notifications = ref<any[]>([])
const childId = ref<number | null>(null)

async function initChildIdAndLoad() {
  if (userStore.currentChildId) {
    childId.value = userStore.currentChildId
    await loadData()
  } else {
    try {
      const res: any = await getFamilyMembers()
      const members = res.data || []
      const children = members.filter((m: any) => String(m.userType) === '2' || m.roles?.includes('child'))
      if (children.length > 0) {
        childId.value = children[0].userId
        await loadData()
      } else {
        if (members.length > 0) {
          childId.value = members[0].userId
          await loadData()
        } else {
          uni.showToast({ title: '未绑定儿童', icon: 'none' })
        }
      }
    } catch (err) {
      console.error('Failed to get family members', err)
      childId.value = 1
      await loadData()
    }
  }
}

// Data Loading
async function loadData() {
  if (!childId.value) return
  uni.showLoading({ title: '加载中...' })
  try {
    // 1. Get AI Insight
    const aiRes: any = await getSummaryInsight(childId.value)
    aiInsight.value = aiRes.data

    // 2. Get Task Status (Stats)
    const statusRes: any = await getTaskStatus(childId.value)
    if (statusRes.data) {
      stats.value[0].value = String(statusRes.data.totalTasks || 0)
    }
    
    // 3. Get Execution Timeline
    const timelineRes: any = await getTimeline(childId.value)
    let logs = timelineRes.data || []
    
    // De-duplicate logs by childTaskId or id
    const uniqueMap = new Map()
    logs.forEach((l: any) => {
      const id = l.childTaskId || l.id
      if (id && !uniqueMap.has(id)) {
        uniqueMap.set(id, l)
      }
    })
    logs = Array.from(uniqueMap.values())
    
    timeline.value = logs.map((l: any) => ({
      id: l.childTaskId || l.id,
      time: l.endTime ? l.endTime.substring(5, 16) : (l.createTime ? l.createTime.substring(5, 16) : '--:--'),
      title: l.taskDefinition?.title || '未知任务',
      description: l.taskDefinition?.description || '任务记录',
      status: l.status === '2' || l.status === '3' ? 'completed' : (l.status === '1' ? 'in-progress' : 'upcoming'),
      icon: l.taskDefinition?.icon || 'task',
      proof: l.proof
    }))

    // 4. Get Rewards (Mocking Notifications)
    const rewardRes: any = await listReward({ pageNum: 1, pageSize: 5 })
    stats.value[1].value = String(rewardRes.total || 0)

    notifications.value = (rewardRes.rows || []).map((r: any) => ({
      id: r.rewardId,
      type: 'warning',
      icon: 'shopping_bag',
      message: `新增奖励: ${r.name}`,
      time: r.createTime,
      actions: false
    }))
    unreadCount.value = notifications.value.length

  } catch (error) {
    console.error(error)
  } finally {
    uni.hideLoading()
  }
}

// 交互逻辑
const toggleNotifications = () => {
  showNotifications.value = !showNotifications.value
}

const markAllRead = () => {
  unreadCount.value = 0
}

const navigateToDailyFocus = () => {
  uni.navigateTo({ url: `/pages/parent/daily-focus/index?childId=${childId.value}` })
}

const navigateToExecRecord = () => {
  uni.navigateTo({ url: `/pages/parent/exec-record/index?childId=${childId.value}` })
}

const navigateToDetails = () => {
  uni.navigateTo({ url: '/pages/parent/emotion-detail/index' })
}

const navigateToAiDetails = () => {
  uni.navigateTo({ url: '/pages/parent/ai-insight-detail/index' })
}

const navigateToWeeklyReport = () => {
  if (childId.value) {
    uni.navigateTo({ url: `/pages/parent/weekly-report/index?cid=${childId.value}` })
  }
}

const handleAction = (note: any, action: string) => {
  console.log(`Notification ${note.id} action: ${action}`)
  notifications.value = notifications.value.filter(n => n.id !== note.id)
}

onShow(() => {
  initChildIdAndLoad()
})
</script>

<style lang="scss" scoped>
.dashboard-page {
  min-height: 100vh;
  background-color: #f6f7f8;
  
  &.dark {
    background-color: #121720;
  }
}

.status-bar-placeholder {
  height: var(--status-bar-height);
  width: 100%;
}

.top-app-bar {
  position: sticky;
  top: 0;
  z-index: 100;
  display: flex;
  align-items: center;
  justify-content: space-between;
  padding: 16px;
  background-color: rgba(246, 247, 248, 0.95);
  backdrop-filter: blur(8px);
  border-bottom: 1px solid #f3f4f6;
  
  :deep(.dark) & {
    background-color: rgba(18, 23, 32, 0.95);
    border-color: #1f2937;
  }
}

.user-info {
  display: flex;
  align-items: center;
  gap: 12px;
}

.avatar {
  width: 40px;
  height: 40px;
  border-radius: 999px;
  background-size: cover;
  background-position: center;
  box-shadow: 0 2px 4px rgba(0,0,0,0.1);
  border: 2px solid white;
}

.welcome {
  display: flex;
  flex-direction: column;
}

.greeting {
  font-size: 12px;
  color: #6b7280;
}

.username {
  font-size: 18px;
  font-weight: 700;
  color: #111827;
  
  :deep(.dark) & {
    color: #ffffff;
  }
}

.icon-btn {
  width: 40px;
  height: 40px;
  border-radius: 999px;
  background-color: #ffffff;
  display: flex;
  align-items: center;
  justify-content: center;
  box-shadow: 0 1px 2px rgba(0,0,0,0.05);
  position: relative;
  
  :deep(.dark) & {
    background-color: #1e242b;
  }
}

.btn-hover {
  transform: scale(0.92);
  background-color: #f3f4f6 !important;
}

.btn-hover-primary {
  transform: scale(0.96);
  background-color: #4b89c2 !important;
}

.btn-hover-secondary {
  transform: scale(0.96);
  background-color: #e5e7eb !important;
}

.btn-hover-opacity {
  opacity: 0.6;
}

.see-all-btn {
  display: flex;
  align-items: center;
  justify-content: center;
  padding: 4px 8px;
  margin: -4px -8px;
  border-radius: 4px;
}

.badge-dot {
  position: absolute;
  top: 10px;
  right: 12px;
  width: 8px;
  height: 8px;
  background-color: #ef4444;
  border-radius: 999px;
  border: 1px solid white;
}

/* 通知下拉栏 */
.notification-dropdown {
  position: absolute;
  top: 64px;
  right: 16px;
  width: 280px;
  background-color: #ffffff;
  border-radius: 12px;
  box-shadow: 0 10px 25px rgba(0,0,0,0.1);
  border: 1px solid #f3f4f6;
  overflow: hidden;
  
  :deep(.dark) & {
    background-color: #1e242b;
    border-color: #1f2937;
  }
}

.dropdown-header {
  padding: 12px 16px;
  border-bottom: 1px solid #f3f4f6;
  display: flex;
  justify-content: space-between;
  align-items: center;
  
  .dropdown-title { font-size: 14px; font-weight: 700; color: #111827; :deep(.dark) & { color: #fff; } }
  .mark-read { font-size: 12px; color: #6C9BD2; cursor: pointer; }
}

.notification-list {
  max-height: 300px;
}

.notification-item {
  padding: 12px;
  display: flex;
  gap: 12px;
  border-bottom: 1px solid #f9fafb;
  
  &:last-child { border-bottom: none; }
}

.note-icon {
  width: 32px;
  height: 32px;
  border-radius: 999px;
  display: flex;
  align-items: center;
  justify-content: center;
  flex-shrink: 0;
  
  &.success { background-color: #ecfdf5; color: #10b981; }
  &.warning { background-color: #fffbeb; color: #f59e0b; }
  
  .material-symbols-outlined { font-size: 18px; }
}

.note-content {
  flex: 1;
  display: flex;
  flex-direction: column;
}

.note-text { font-size: 12px; font-weight: 700; color: #374151; :deep(.dark) & { color: #e5e7eb; } }
.note-time { font-size: 10px; color: #9ca3af; margin-top: 2px; }

.note-actions {
  display: flex;
  gap: 8px;
  margin-top: 8px;
  
  .btn {
    flex: 1;
    font-size: 10px;
    padding: 0;
  }
  .btn-primary { background-color: #6C9BD2; color: white; }
  .btn-secondary { background-color: #f3f4f6; color: #4b5563; }
}

/* 主内容区 */
.main-content {
  flex: 1;
  padding-bottom: 80px;
}

.section-header {
  display: flex;
  justify-content: space-between;
  align-items: flex-end;
  padding: 24px 16px 8px;
}

.section-title {
  font-size: 24px;
  font-weight: 700;
  color: #111827;
  letter-spacing: -0.5px;
  
  :deep(.dark) & { color: #ffffff; }
}

.see-all {
  font-size: 14px;
  font-weight: 600;
  color: #6C9BD2;
}

.stats-scroll {
  width: 100%;
}

.stats-container {
  display: flex;
  padding: 0 16px 16px;
  gap: 16px;
}

.timeline-container {
  padding: 16px;
}

.empty-state {
  display: flex;
  flex-direction: column;
  align-items: center;
  padding: 40px 0;
  color: #9ca3af;
  
  .empty-icon {
    font-size: 48px;
    margin-bottom: 12px;
    opacity: 0.5;
  }
  
  .empty-text {
    font-size: 14px;
  }
}

.no-scrollbar::-webkit-scrollbar {
  display: none;
}
</style>

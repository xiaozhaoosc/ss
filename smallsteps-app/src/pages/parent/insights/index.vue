<template>
  <view class="container">
    <view class="status-bar"></view>
    
    <!-- 顶部导航栏 -->
    <view class="header">
      <text class="title">家长洞察</text>
      <view class="header-right">
        <view class="lang-switch">
          <text class="lang-btn active">CN</text>
        </view>
        <image class="avatar" src="/static/logo.png" mode="aspectFill"></image>
      </view>
    </view>

    <scroll-view class="content" scroll-y>
      <!-- 每周重点 -->
      <view class="section">
        <view class="section-header">
          <text class="section-title">每周重点</text>
          <view class="more-btn" @click="navigateToDetails">
            <text>详情</text>
            <text class="icon">></text>
          </view>
        </view>
        
        <view class="card">
          <view class="card-header">
            <view>
              <text class="subtitle">能力发展总览</text>
              <view class="main-status">
                <text class="status-text">总体良好</text>
                <view class="trend-tag">
                  <text class="trend-icon">↑</text>
                  <text>+5%</text>
                </view>
              </view>
            </view>
            <view class="icon-circle">
              <text class="chart-icon">📊</text>
            </view>
          </view>
          
          <!-- 图表占位 -->
          <view class="chart-container">
            <view class="bar-chart">
              <view v-for="(item, index) in abilityData" :key="index" class="bar-item">
                <view class="bar-wrapper">
                  <view class="bar" :style="{ height: item.value + '%' }">
                    <view class="value-capsule">{{ item.value }}%</view>
                  </view>
                </view>
                <text class="bar-label">{{ item.label }}</text>
              </view>
            </view>
          </view>
        </view>
      </view>

      <!-- 月度情绪热力图 -->
      <view class="section">
        <text class="section-title">月度情绪热力图</text>
        <view class="card calendar-card">
          <view class="calendar-header">
            <text class="nav-arrow"><</text>
            <text class="calendar-month">{{ currentMonthStr }}</text>
            <text class="nav-arrow">></text>
          </view>
          
          <view class="weekday-row">
            <text v-for="day in ['日','一','二','三','四','五','六']" :key="day" class="weekday">{{day}}</text>
          </view>
          
          <view class="calendar-grid">
            <view v-for="(day, index) in calendarDays" :key="index" 
                  class="day-cell" :class="{ 'selected': day.isToday }">
              <template v-if="!day.empty">
                <text class="day-num">{{ day.day }}</text>
                <!-- 修改判断条件：非透明才渲染 dot -->
                <view class="dot" v-show="getEmotionColor(day.date) !== 'transparent'" 
                      :style="{ background: getEmotionColor(day.date) }"></view>
              </template>
            </view>
          </view>
          
          <view class="legend">
            <view class="legend-item">
              <view class="dot primary"></view>
              <text>平静/开心</text>
            </view>
            <view class="legend-item">
              <view class="dot yellow"></view>
              <text>兴奋</text>
            </view>
            <view class="legend-item">
              <view class="dot gray"></view>
              <text>一般</text>
            </view>
          </view>
        </view>
      </view>
      
      <view class="safe-bottom"></view>
    </scroll-view>

    <!-- 底部导航占位 -->
    <bottom-nav mode="parent" />
  </view>
</template>

<script setup>
import { ref } from 'vue'
import { onShow } from '@dcloudio/uni-app'
import BottomNav from '@/components/common/bottom-nav/bottom-nav.vue'
import { listChildAchievement, getAbilityRadar, getEmotionTrend } from '@/api/child'
import { getFamilyMembers } from '@/api/family'
import { useUserStore } from '@/store/modules/user'

const userStore = useUserStore()
const childId = ref(null)

const abilityData = ref([])

// 情绪热力图相关
const emotionData = ref([])
const calendarDays = ref([])
const currentMonthStr = ref('')
const achievements = ref([])

onShow(() => {
  initChildIdAndLoad()
})

const navigateToDetails = () => {
  if (!childId.value) {
    uni.showToast({ title: '未选择儿童', icon: 'none' })
    return
  }
  uni.navigateTo({ url: `/pages/parent/weekly-report/index?cid=${childId.value}` })
}

const initChildIdAndLoad = async () => {
  if (userStore.currentChildId) {
    childId.value = userStore.currentChildId
    loadData(childId.value)
  } else {
    try {
      const res = await getFamilyMembers()
      const members = res.data || []
      // Find the first member that acts as a child (assumed roles logic or just filter out parents)
      // Usually, kids might have userType = '3' or 3 or simply be the other ones in the family.
      // If we don't know, we can just pick the first child in the list.
      const children = members.filter(m => String(m.userType) === '3' || m.roles?.includes('child'))
      if (children.length > 0) {
        childId.value = children[0].userId
        loadData(childId.value)
      } else {
        // Fallback to first member if no explicit child found, or just show error
        if (members.length > 0) {
          childId.value = members[0].userId
          loadData(childId.value)
        } else {
          uni.showToast({ title: '当前家庭未绑定儿童', icon: 'none' })
        }
      }
    } catch (err) {
      console.error('Failed to get family members', err)
      childId.value = 1 // fallback
      loadData(childId.value)
    }
  }
}

const loadData = (cId) => {
  // 获取能力发展雷达图数据
  getAbilityRadar(cId).then(res => {
    const data = res.data || {}
    const abilities = data.abilities || []
    const scores = data.scores || []

    if (abilities.length > 0 && scores.length === abilities.length) {
      abilityData.value = abilities.map((label, index) => ({
        label: label,
        value: scores[index]
      }))
    } else {
      // 如果没有数据，使用默认占位数据
      abilityData.value = [
        { label: '数学', value: 65 },
        { label: '社交', value: 42 },
        { label: '专注', value: 85 },
        { label: '创造', value: 30 }
      ]
    }
  }).catch(err => {
    console.error('Failed to load ability radar data:', err)
    abilityData.value = [
      { label: '数学', value: 65 },
      { label: '社交', value: 42 },
      { label: '专注', value: 85 },
      { label: '创造', value: 30 }
    ]
  })

  loadEmotionHeatmap(cId)
  loadAchievements(cId)
}

const loadAchievements = (cId) => {
  listChildAchievement(cId).then(res => {
    const list = res.data || res.rows || []
    achievements.value = list.slice(0, 3).map((item, index) => ({
      ...item,
      bgColor: index % 2 === 0 ? '#fef3c7' : '#e0f2fe'
    }))
  }).catch(err => {
    console.error('Failed to load insights achievements:', err)
  })
}

const loadEmotionHeatmap = (cId) => {
  const now = new Date()
  const year = now.getFullYear()
  const month = now.getMonth()
  currentMonthStr.value = `${year}年 ${month + 1}月`

  // 获取本月第一天是周几
  const firstDay = new Date(year, month, 1)
  const startingDay = firstDay.getDay()
  
  // 获取本月天数
  const daysInMonth = new Date(year, month + 1, 0).getDate()
  
  const days = []
  // 填充月初空白
  for (let i = 0; i < startingDay; i++) {
    days.push({ empty: true })
  }
  
  const today = now.getDate()
  
  for (let i = 1; i <= daysInMonth; i++) {
    const dateStr = `${year}-${String(month + 1).padStart(2, '0')}-${String(i).padStart(2, '0')}`
    days.push({
      day: i,
      date: dateStr,
      isToday: i === today && month === now.getMonth() && year === now.getFullYear()
    })
  }
  calendarDays.value = days

  // 获取情绪趋势数据 (最近30天)
  getEmotionTrend(cId, 30).then(res => {
    emotionData.value = res.data || []
  }).catch(err => {
    console.error('Failed to load emotion trend:', err)
  })
}

const getEmotionColor = (dateStr) => {
  if (!dateStr) return 'transparent'
  
  const entry = emotionData.value.find(item => {
    // 假设后端返回的时间包含 T 或者空格
    const itemDate = item.createTime ? item.createTime.split('T')[0].split(' ')[0] : ''
    return itemDate === dateStr
  })
  
  if (!entry) return 'transparent' // 无数据透明
  
  // 1: 开心, 5: 平静 -> 蓝
  // 3: 愤怒 (此处根据方案映射为黄/兴奋态) -> 黄
  // 2: 难过, 4: 焦虑, 默认 -> 灰
  switch (entry.emotionType) {
    case 1:
    case 5:
      return '#6b9bd1' // 平静/开心
    case 3:
      return '#fbbf24' // 兴奋/愤怒 (High Arousal)
    case 2:
    case 4:
    default:
      return '#d1d5db' // 一般/其他
  }
}
</script>

<style lang="scss" scoped>
.container {
  display: flex;
  flex-direction: column;
  height: 100vh;
  background-color: #f6f7f8;
}

.status-bar {
  height: var(--status-bar-height);
  width: 100%;
}

.header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  padding: 20rpx 40rpx;
  background-color: #ffffff;
  border-bottom: 1rpx solid #efefef;
  
  .title {
    font-size: 40rpx;
    font-weight: bold;
    color: #101419;
  }
  
  .header-right {
    display: flex;
    align-items: center;
    gap: 20rpx;
  }
  
  .lang-switch {
    display: flex;
    background-color: #f3f4f6;
    border-radius: 40rpx;
    padding: 4rpx;
    
    .lang-btn {
      padding: 4rpx 20rpx;
      font-size: 20rpx;
      font-weight: bold;
      color: #6b7280;
      border-radius: 40rpx;
      
      &.active {
        background-color: #6b9bd1;
        color: #ffffff;
      }
    }
  }
  
  .avatar {
    width: 64rpx;
    height: 64rpx;
    border-radius: 50%;
    background-color: #e5e7eb;
  }
}

.content {
  flex: 1;
  padding: 30rpx 40rpx;
}

.section {
  margin-bottom: 40rpx;
  
  &-header {
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin-bottom: 20rpx;
  }
  
  &-title {
    font-size: 32rpx;
    font-weight: bold;
    color: #101419;
  }
}

.more-btn, .view-all {
  font-size: 24rpx;
  color: #6b9bd1;
  font-weight: 500;
  display: flex;
  align-items: center;
  gap: 4rpx;
}

.card {
  background-color: #ffffff;
  border-radius: 24rpx;
  padding: 30rpx;
  box-shadow: 0 2rpx 10rpx rgba(0,0,0,0.03);
  border: 1rpx solid #f3f4f6;
}

.card-header {
  display: flex;
  justify-content: space-between;
  margin-bottom: 40rpx;
  
  .subtitle {
    font-size: 24rpx;
    color: #5b718b;
  }
  
  .main-status {
    display: flex;
    align-items: baseline;
    gap: 16rpx;
    margin-top: 8rpx;
    
    .status-text {
      font-size: 40rpx;
      font-weight: bold;
    }
  }
}

.trend-tag {
  display: flex;
  align-items: center;
  background-color: #f0fdf4;
  color: #16a34a;
  padding: 2rpx 12rpx;
  border-radius: 8rpx;
  font-size: 20rpx;
  font-weight: bold;
}

.icon-circle {
  width: 80rpx;
  height: 80rpx;
  background-color: rgba(107, 155, 209, 0.1);
  border-radius: 50%;
  display: flex;
  align-items: center;
  justify-content: center;
  color: #6b9bd1;
}

.chart-container {
  height: 320rpx;
  padding: 0 20rpx;
}

.bar-chart {
  display: flex;
  justify-content: space-around;
  align-items: flex-end;
  height: 100%;
}

.bar-item {
  display: flex;
  flex-direction: column;
  align-items: center;
  flex: 1;
  height: 100%;
}

.bar-wrapper {
  position: relative;
  width: 60rpx;
  height: 240rpx;
  background-color: #f3f4f6;
  border-radius: 12rpx;
  display: flex;
  align-items: flex-end;
  overflow: hidden;
}

.bar {
  width: 100%;
  background-color: #6b9bd1;
  border-radius: 12rpx 12rpx 0 0;
  position: relative;
  transition: height 0.3s ease;
  display: flex;
  justify-content: center;
  align-items: flex-start;
  padding-top: 10rpx;
  
  .value-capsule {
    background-color: #4b5563;
    color: #ffffff;
    font-size: 18rpx;
    padding: 4rpx 12rpx;
    border-radius: 20rpx;
    font-weight: bold;
  }
}

.bar-label {
  margin-top: 16rpx;
  font-size: 20rpx;
  color: #5b718b;
}

// 日历样式
.calendar-card {
  padding: 30rpx 40rpx;
}

.calendar-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-bottom: 30rpx;
  
  .calendar-month {
    font-size: 28rpx;
    font-weight: bold;
  }
  
  .nav-arrow {
    color: #6b7280;
    padding: 10rpx;
  }
}

.weekday-row {
  display: grid;
  grid-template-columns: repeat(7, 1fr);
  margin-bottom: 20rpx;
  
  .weekday {
    text-align: center;
    font-size: 20rpx;
    color: #9ca3af;
  }
}

.calendar-grid {
  display: grid;
  grid-template-columns: repeat(7, 1fr);
  gap: 20rpx 0;
}

.day-cell {
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: flex-start;
  padding-top: 10rpx;
  height: 90rpx;
  position: relative;
  
  .day-num {
    font-size: 26rpx;
    color: #5b718b;
    width: 56rpx;
    height: 56rpx;
    line-height: 56rpx;
    text-align: center;
    border-radius: 50%;
  }
  
  .dot {
    width: 8rpx;
    height: 8rpx;
    border-radius: 50%;
    margin-top: 6rpx;
  }
  
  &.selected {
    .day-num {
      background-color: #6b9bd1;
      color: #ffffff;
      font-weight: bold;
    }
  }
}

.legend {
  display: flex;
  justify-content: center;
  gap: 40rpx;
  margin-top: 40rpx;
  padding-top: 30rpx;
  border-top: 1rpx solid #f3f4f6;
  
  &-item {
    display: flex;
    align-items: center;
    gap: 8rpx;
    
    text {
      font-size: 20rpx;
      color: #5b718b;
    }
  }
  
  .dot {
    width: 12rpx;
    height: 12rpx;
    border-radius: 50%;
    
    &.primary { background-color: #6b9bd1; }
    &.yellow { background-color: #fbbf24; }
    &.gray { background-color: #d1d5db; }
  }
}

.last-section {
  padding-bottom: 200rpx; // 为底部导航留出空间
}

.safe-bottom {
  height: env(safe-area-inset-bottom);
}
</style>

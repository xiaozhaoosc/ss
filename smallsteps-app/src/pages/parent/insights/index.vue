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

    <!-- 儿童切换选择器 -->
    <view class="child-selector" v-if="familyChildren.length > 0">
      <scroll-view scroll-x class="child-scroll">
        <view v-for="child in familyChildren" :key="child.userId" 
              class="child-item" :class="{ 'active': childId === child.userId }"
              @click="switchChild(child.userId)">
          <view class="avatar-wrapper">
            <image class="child-avatar" :src="child.avatar || '/static/logo.png'" mode="aspectFill"></image>
            <view class="active-dot" v-if="childId === child.userId"></view>
          </view>
          <text class="child-name">{{ child.nickName }}</text>
        </view>
      </scroll-view>
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

      <!-- 影子观察者：情绪预警趋势 -->
      <view class="section">
        <view class="section-header">
          <text class="section-title">影子观察者：情绪预警趋势</text>
          <view class="hint-icon" @click="showShadowHint">
            <text>?</text>
          </view>
        </view>
        
        <view class="card shadow-card">
          <view class="shadow-stats">
            <view class="stat-item">
              <text class="stat-value">{{ shadowTrendData.reduce((acc, cur) => acc + (cur.frustrationCount || 0), 0) }}</text>
              <text class="stat-label">本周预警总数</text>
            </view>
            <view class="stat-divider"></view>
            <view class="stat-item">
              <text class="stat-value">{{ calculateAvgMood() }}</text>
              <text class="stat-label">平均情绪指数</text>
            </view>
          </view>

          <view class="shadow-chart">
            <view v-for="(item, index) in shadowTrendData" :key="index" class="shadow-bar-item">
              <view class="chart-column">
                <!-- 预警次数：顶部的小红点/胶囊 -->
                <view class="warning-capsule" v-if="item.frustrationCount > 0">
                  <text>{{ item.frustrationCount }}</text>
                </view>
                <!-- 情绪指数：主柱状图 -->
                <view class="mood-bar-wrapper">
                  <view class="mood-bar" 
                        :style="{ 
                          height: (item.avgMood * 20) + '%',
                          backgroundColor: getMoodColor(item.avgMood)
                        }">
                  </view>
                </view>
              </view>
              <text class="day-label">{{ item.dayLabel }}</text>
            </view>
          </view>
          
          <view class="chart-legend">
            <view class="legend-item">
              <view class="color-block" style="background: linear-gradient(to bottom, #f87171, #ef4444)"></view>
              <text>高频预警</text>
            </view>
            <view class="legend-item">
              <view class="color-block" style="background: #6b9bd1"></view>
              <text>情绪指数</text>
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
import { listChildAchievement, getAbilityRadar, getEmotionTrend, getShadowEmotionTrend } from '@/api/child'
import { getFamilyMembers } from '@/api/family'
import { useUserStore } from '@/store/modules/user'

const userStore = useUserStore()
const childId = ref(null)

const abilityData = ref([])
const shadowTrendData = ref([])
const familyChildren = ref([])

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

const switchChild = (id) => {
  if (childId.value === id) return
  childId.value = id
  loadData(id)
}

const initChildIdAndLoad = async () => {
  try {
    const res = await getFamilyMembers()
    const members = res.data || []
    // 过滤出儿童 (userType 为 '3' 或角色包含 'child')
    familyChildren.value = members.filter(m => String(m.userType) === '3' || (m.roles && m.roles.includes('child')))
    
    if (userStore.currentChildId) {
      childId.value = userStore.currentChildId
      loadData(childId.value)
    } else if (familyChildren.value.length > 0) {
      childId.value = familyChildren.value[0].userId
      loadData(childId.value)
    } else {
      uni.showToast({ title: '当前家庭未绑定儿童', icon: 'none' })
    }
  } catch (err) {
    console.error('Failed to get family members', err)
    // Fallback logic
    if (userStore.currentChildId) {
      childId.value = userStore.currentChildId
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
  loadShadowTrend(cId)
}

const loadShadowTrend = (cId) => {
  getShadowEmotionTrend(cId, 7).then(res => {
    shadowTrendData.value = res.data || []
  }).catch(err => {
    console.error('Failed to load shadow trend data:', err)
  })
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

const calculateAvgMood = () => {
  if (!shadowTrendData.value.length) return '3.0'
  const sum = shadowTrendData.value.reduce((acc, cur) => acc + (cur.avgMood || 0), 0)
  return (sum / shadowTrendData.value.length).toFixed(1)
}

const getMoodColor = (mood) => {
  if (mood >= 4.5) return '#10b981' // 极佳
  if (mood >= 3.5) return '#6b9bd1' // 稳定
  if (mood >= 2.5) return '#fbbf24' // 一般
  return '#f87171' // 挫折/波动
}

const showShadowHint = () => {
  uni.showModal({
    title: '影子观察者说明',
    content: '“影子预警”是系统通过分析孩子在 App 上的交互行为（如高频点击、长时间长按头像等）自动捕捉到的情绪波动，旨在帮助家长发现孩子未能表达的挫败感。',
    showCancel: false,
    confirmText: '知道了'
  })
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

.child-selector {
  background-color: #ffffff;
  padding: 10rpx 0 20rpx;
  border-bottom: 1rpx solid #f3f4f6;
  
  .child-scroll {
    white-space: nowrap;
    padding: 0 30rpx;
    width: 100%;
    box-sizing: border-box;
  }
  
  .child-item {
    display: inline-flex;
    flex-direction: column;
    align-items: center;
    margin-right: 40rpx;
    transition: all 0.3s ease;
    
    .avatar-wrapper {
      position: relative;
      margin-bottom: 8rpx;
    }
    
    .child-avatar {
      width: 90rpx;
      height: 90rpx;
      border-radius: 50%;
      border: 4rpx solid transparent;
      background-color: #f3f4f6;
      transition: all 0.3s ease;
    }
    
    .active-dot {
      position: absolute;
      bottom: -4rpx;
      left: 50%;
      transform: translateX(-50%);
      width: 12rpx;
      height: 12rpx;
      background-color: #6b9bd1;
      border-radius: 50%;
      border: 2rpx solid #ffffff;
    }
    
    .child-name {
      font-size: 22rpx;
      color: #9ca3af;
      max-width: 120rpx;
      overflow: hidden;
      text-overflow: ellipsis;
      white-space: nowrap;
    }
    
    &.active {
      .child-avatar {
        border-color: #6b9bd1;
        transform: scale(1.05);
      }
      .child-name {
        color: #6b9bd1;
        font-weight: bold;
      }
    }
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

// 影子观察者卡片样式
.shadow-card {
  padding: 30rpx;
  background: linear-gradient(135deg, #ffffff 0%, #f9fafb 100%);
}

.hint-icon {
  width: 32rpx;
  height: 32rpx;
  border-radius: 50%;
  background-color: #e5e7eb;
  display: flex;
  align-items: center;
  justify-content: center;
  margin-left: 10rpx;
  
  text {
    font-size: 20rpx;
    color: #6b7280;
    font-weight: bold;
  }
}

.shadow-stats {
  display: flex;
  justify-content: space-around;
  align-items: center;
  margin-bottom: 40rpx;
  padding: 20rpx 0;
  background-color: rgba(107, 155, 209, 0.05);
  border-radius: 20rpx;

  .stat-item {
    display: flex;
    flex-direction: column;
    align-items: center;
    
    .stat-value {
      font-size: 36rpx;
      font-weight: bold;
      color: #101419;
    }
    
    .stat-label {
      font-size: 20rpx;
      color: #6b7280;
      margin-top: 4rpx;
    }
  }

  .stat-divider {
    width: 1rpx;
    height: 40rpx;
    background-color: #e5e7eb;
  }
}

.shadow-chart {
  display: flex;
  justify-content: space-between;
  align-items: flex-end;
  height: 240rpx;
  padding: 20rpx 10rpx;
}

.shadow-bar-item {
  flex: 1;
  display: flex;
  flex-direction: column;
  align-items: center;
  height: 100%;
}

.chart-column {
  flex: 1;
  display: flex;
  flex-direction: column;
  justify-content: flex-end;
  align-items: center;
  width: 100%;
  position: relative;
}

.warning-capsule {
  background: linear-gradient(to bottom, #f87171, #ef4444);
  color: #ffffff;
  font-size: 18rpx;
  padding: 2rpx 10rpx;
  border-radius: 20rpx;
  margin-bottom: 10rpx;
  font-weight: bold;
  box-shadow: 0 4rpx 12rpx rgba(239, 68, 68, 0.3);
  z-index: 2;
}

.mood-bar-wrapper {
  width: 40rpx;
  height: 160rpx;
  background-color: #f3f4f6;
  border-radius: 20rpx;
  display: flex;
  align-items: flex-end;
  overflow: hidden;
}

.mood-bar {
  width: 100%;
  border-radius: 20rpx;
  transition: height 0.6s cubic-bezier(0.34, 1.56, 0.64, 1);
}

.day-label {
  margin-top: 16rpx;
  font-size: 20rpx;
  color: #6b7280;
}

.chart-legend {
  display: flex;
  justify-content: center;
  gap: 30rpx;
  margin-top: 20rpx;
  
  .legend-item {
    display: flex;
    align-items: center;
    gap: 8rpx;
    
    .color-block {
      width: 16rpx;
      height: 16rpx;
      border-radius: 4rpx;
    }
    
    text {
      font-size: 20rpx;
      color: #9ca3af;
    }
  }
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

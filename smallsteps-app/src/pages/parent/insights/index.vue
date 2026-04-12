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
          <view class="more-btn">
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
                    <view class="tooltip">{{ item.value }}%</view>
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
            <text class="calendar-month">2023年 10月</text>
            <text class="nav-arrow">></text>
          </view>
          
          <view class="weekday-row">
            <text v-for="day in ['日','一','二','三','四','五','六']" :key="day" class="weekday">{{day}}</text>
          </view>
          
          <view class="calendar-grid">
            <view v-for="n in 4" :key="'empty-'+n" class="day-cell"></view>
            <view v-for="day in 14" :key="day" class="day-cell" :class="{ 'selected': day === 5 }">
              <text class="day-num">{{day}}</text>
              <view v-if="day !== 5" class="dot" :style="{ background: getEmotionColor(day) }"></view>
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

      <!-- 成就亮点 -->
      <view class="section last-section">
        <view class="section-header">
          <text class="section-title">成就亮点</text>
          <text class="view-all">查看全部</text>
        </view>
        
        <view class="achievement-list">
          <view class="achievement-card" v-for="(item, index) in achievements" :key="index">
            <view class="ach-icon" :style="{ background: item.bgColor }">
              <text class="icon">{{ item.icon }}</text>
            </view>
            <view class="ach-info">
              <text class="ach-title">{{ item.title }}</text>
              <text class="ach-desc">{{ item.desc }}</text>
              <text class="ach-date">{{ item.date }}</text>
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
import { listChildAchievement } from '@/api/child'
import { useUserStore } from '@/store/modules/user'

const userStore = useUserStore()

// Keep abilityData mocked until backend API is ready
const abilityData = ref([
  { label: '数学', value: 65 },
  { label: '社交', value: 42 },
  { label: '专注', value: 85 },
  { label: '创造', value: 30 }
])

const achievements = ref([])

onShow(() => {
  loadData()
})

const loadData = () => {
  const childId = userStore.currentChildId || 1 
  listChildAchievement(childId).then(res => {
    const list = res.data || res.rows || []
    achievements.value = list.map((item, index) => ({
      id: item.achievementId,
      title: item.achievementName || '新成就',
      desc: item.description || '完成了一个阶段性目标',
      date: item.obtainTime ? item.obtainTime.substring(5, 10) : '今日',
      icon: index % 2 === 0 ? '🏆' : '🌟',
      bgColor: index % 2 === 0 ? '#fef3c7' : '#e0f2fe'
    }))
  }).catch(err => {
    console.error('Failed to load insights achievements:', err)
  })
}

const getEmotionColor = (day) => {
  const colors = ['#6b9bd1', '#fbbf24', '#d1d5db']
  return colors[day % 3]
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
  border-radius: 12rpx 12rpx 0 0;
  display: flex;
  align-items: flex-end;
  overflow: visible;
}

.bar {
  width: 100%;
  background-color: #6b9bd1;
  border-radius: 12rpx 12rpx 0 0;
  position: relative;
  transition: height 0.3s ease;
  
  .tooltip {
    position: absolute;
    top: -40rpx;
    left: 50%;
    transform: translateX(-50%);
    background-color: #1f2937;
    color: #ffffff;
    font-size: 16rpx;
    padding: 4rpx 12rpx;
    border-radius: 8rpx;
    white-space: nowrap;
    opacity: 0.8;
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
  justify-content: center;
  height: 80rpx;
  position: relative;
  
  .day-num {
    font-size: 24rpx;
    color: #5b718b;
  }
  
  .dot {
    width: 8rpx;
    height: 8rpx;
    border-radius: 50%;
    margin-top: 8rpx;
  }
  
  &.selected {
    .day-num {
      background-color: #6b9bd1;
      color: #ffffff;
      width: 60rpx;
      height: 60rpx;
      line-height: 60rpx;
      text-align: center;
      border-radius: 50%;
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

// 成就列表
.achievement-list {
  display: flex;
  flex-direction: column;
  gap: 20rpx;
}

.achievement-card {
  display: flex;
  gap: 24rpx;
  padding: 30rpx;
  background-color: #ffffff;
  border-radius: 24rpx;
  border: 1rpx solid #f3f4f6;
  
  .ach-icon {
    width: 96rpx;
    height: 96rpx;
    border-radius: 50%;
    display: flex;
    align-items: center;
    justify-content: center;
    font-size: 40rpx;
    flex-shrink: 0;
  }
  
  .ach-info {
    flex: 1;
    display: flex;
    flex-direction: column;
  }
  
  .ach-title {
    font-size: 28rpx;
    font-weight: bold;
    color: #101419;
    margin-bottom: 8rpx;
  }
  
  .ach-desc {
    font-size: 24rpx;
    color: #5b718b;
    line-height: 1.4;
    margin-bottom: 12rpx;
  }
  
  .ach-date {
    font-size: 20rpx;
    color: #9ca3af;
  }
}

.last-section {
  padding-bottom: 200rpx; // 为底部导航留出空间
}

.safe-bottom {
  height: env(safe-area-inset-bottom);
}
</style>

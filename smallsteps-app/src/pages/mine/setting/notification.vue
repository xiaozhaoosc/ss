<template>
  <view class="notification-page">
    <top-bar title="通知设置" show-back />
    
    <view class="main-content">
      <view class="section">
        <text class="section-title">应用内通知</text>
        <view class="settings-group">
          <view class="setting-row">
            <view class="row-info">
              <text class="title">任务提醒</text>
              <text class="subtitle">当孩子开始或完成任务时通知我</text>
            </view>
            <switch :checked="notifyTask" color="#6C9BD2" @change="e => notifyTask = e.detail.value" />
          </view>
          
          <view class="setting-row">
            <view class="row-info">
              <text class="title">情绪预警</text>
              <text class="subtitle">当系统检测到孩子情绪波动大时通知我</text>
            </view>
            <switch :checked="notifyMood" color="#6C9BD2" @change="e => notifyMood = e.detail.value" />
          </view>
          
          <view class="setting-row">
            <view class="row-info">
              <text class="title">系统公告</text>
              <text class="subtitle">版本更新、活动通知等</text>
            </view>
            <switch :checked="notifySystem" color="#6C9BD2" @change="e => notifySystem = e.detail.value" />
          </view>
        </view>
      </view>

      <view class="section">
        <text class="section-title">声音与振动</text>
        <view class="settings-group">
          <view class="setting-row">
            <text class="title">提示音</text>
            <switch :checked="soundEnabled" color="#6C9BD2" @change="e => soundEnabled = e.detail.value" />
          </view>
          <view class="setting-row">
            <text class="title">振动</text>
            <switch :checked="vibrateEnabled" color="#6C9BD2" @change="e => vibrateEnabled = e.detail.value" />
          </view>
        </view>
      </view>

      <view class="save-section">
        <button class="save-btn" @click="handleSave">保存设置</button>
      </view>
    </view>
  </view>
</template>

<script setup>
import { ref } from 'vue'
import TopBar from '@/components/common/top-bar/top-bar.vue'

const notifyTask = ref(true)
const notifyMood = ref(true)
const notifySystem = ref(false)
const soundEnabled = ref(true)
const vibrateEnabled = ref(true)

function handleSave() {
  uni.showToast({
    title: '设置已保存',
    icon: 'success'
  })
  setTimeout(() => {
    uni.navigateBack()
  }, 1500)
}
</script>

<style lang="scss" scoped>
.notification-page {
  min-height: 100vh;
  background-color: #f6f7f8;
}

.main-content {
  padding: 16px;
  padding-top: 60px;
}

.section {
  margin-bottom: 24px;
}

.section-title {
  font-size: 14px;
  font-weight: 600;
  color: #9ca3af;
  margin-bottom: 12px;
  margin-left: 4px;
  text-transform: uppercase;
}

.settings-group {
  background-color: #ffffff;
  border-radius: 16px;
  overflow: hidden;
  box-shadow: 0 4px 12px rgba(0, 0, 0, 0.03);
}

.setting-row {
  display: flex;
  align-items: center;
  justify-content: space-between;
  padding: 16px;
  border-bottom: 1px solid #f3f4f6;
  
  &:last-child {
    border-bottom: none;
  }
}

.row-info {
  display: flex;
  flex-direction: column;
  gap: 4px;
}

.title {
  font-size: 16px;
  font-weight: 500;
  color: #111827;
}

.subtitle {
  font-size: 12px;
  color: #9ca3af;
}

.save-section {
  margin-top: 40px;
  padding: 0 16px;
}

.save-btn {
  height: 50px;
  background: linear-gradient(135deg, #6C9BD2 0%, #8EADDA 100%);
  color: white;
  border-radius: 12px;
  font-weight: 600;
  display: flex;
  align-items: center;
  justify-content: center;
  box-shadow: 0 4px 12px rgba(108, 155, 210, 0.3);
  
  &:active {
    transform: scale(0.98);
    opacity: 0.9;
  }
}
</style>

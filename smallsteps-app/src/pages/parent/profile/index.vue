<template>
  <view class="profile-page" :class="{ 'dark': isDarkMode }">
    <!-- Top Bar -->
    <top-bar title="家长中心">
      <template #right>
        <view class="lang-switch">
          <text class="lang-tag active">CN</text>
        </view>
      </template>
    </top-bar>

    <scroll-view scroll-y class="main-content no-scrollbar">
      <!-- Device Status Card (Temporarily Disabled) -->
      <!-- <view class="section">
        <view class="device-card" @click="showDeviceModal = true">
          <view class="device-info">
            <text class="label">设备状态</text>
            <view class="status-line">
              <view class="status-dot-box">
                <view class="dot-ping"></view>
                <view class="dot"></view>
              </view>
              <text class="status-text">StarBuddy {{ isOnline ? '在线' : '离线' }}</text>
            </view>
            <text class="detail-text">电量 85% · 信号良好</text>
          </view>
          <view class="device-image-box">
            <image class="device-image" src="https://lh3.googleusercontent.com/aida-public/AB6AXuCdOjbuDRV_9s9SX7I4wtdTwjubQMRl1JUlr4VFPN5N3he7m81Jfp9Y7VTN_F_QZqfxf0n3jtSgGNZkaaA_3GgRuEiJG24_JQnK_nDfqDnaSRgN6lVOZ8zZ-13l8yzntIVhsOV5Cj_PzlyLehxqfSX1wmi_HTlmw5rA-YgeeVBZ9lkvRqz4cjaXNrIIfFPd0dbQuVxvRkaX79hV7e91jSb4-nYIi3O9QzelSLVOj-bH7qQqstSlYEYj12WFxEIF-srchtR45wJ1wfA" mode="aspectFit" />
          </view>
        </view>
      </view> -->

      <!-- User Profile Section -->
      <view class="section">
        <view class="user-card">
          <view class="user-info-box" @click="handleToInfo">
            <view class="avatar-wrapper">
              <image class="avatar" :src="userStore.userInfo?.user?.avatar || 'https://lh3.googleusercontent.com/aida-public/AB6AXuAJ1cciJ4i8VZa4i84tUg3c73WgpXsHDPWFJTFC1HCyoJaWAw63sCD6sYtGoggTmCxZPkFLdgXZ0jMVUEjuhNaybs-1a06VWI-j7Tv_k-GcxylNpE1U9cjTL6ICQBnyg02gLWhSCCy1SnHe6psYMG-13HPVdTV9vR6odzmSIWG_6kD9m5MrzeKyalS3Ewhx_px4_a3iAVFvHE4SYxL6Z13ZA7UVC9fVC7U29WKKz0G9msv4O4zW9MUm2t6NZ6FOtcNY4-8SHhP3MgM'" mode="aspectFill" />
            </view>
            <view class="name-box">
              <text class="user-name">{{ userStore.userInfo?.user?.nickName || '小红' }}</text>
            </view>
          </view>
          <view class="user-actions">
            <view class="icon-btn" @click="handleShowMyQr">
              <text class="material-symbols-outlined">qr_code_2</text>
            </view>
            <view class="icon-btn" @click="handleToEditInfo">
              <text class="material-symbols-outlined">edit</text>
            </view>
          </view>
        </view>
      </view>

      <!-- Child Profile Section -->
      <view class="section">
        <view class="section-header">
          <text class="section-title">孩子档案</text>
          <button class="add-btn" @click="handleAddChild">
            <text class="material-symbols-outlined icon">add</text>
            <text>添加</text>
          </button>
        </view>
        
        <view v-if="children.length === 0 && !loading" class="empty-box">
          <text class="empty-text">暂无孩子档案，请点击右上角添加</text>
        </view>

        <view v-for="child in children" :key="child.id" class="child-card">
          <view class="avatar-box">
            <image class="avatar" :src="child.avatarUrl || 'https://lh3.googleusercontent.com/aida-public/AB6AXuAJ1cciJ4i8VZa4i84tUg3c73WgpXsHDPWFJTFC1HCyoJaWAw63sCD6sYtGoggTmCxZPkFLdgXZ0jMVUEjuhNaybs-1a06VWI-j7Tv_k-GcxylNpE1U9cjTL6ICQBnyg02gLWhSCCy1SnHe6psYMG-13HPVdTV9vR6odzmSIWG_6kD9m5MrzeKyalS3Ewhx_px4_a3iAVFvHE4SYxL6Z13ZA7UVC9fVC7U29WKKz0G9msv4O4zW9MUm2t6NZ6FOtcNY4-8SHhP3MgM'" mode="aspectFill" />
          </view>
          <view class="info">
            <text class="name">{{ child.nickname }}</text>
            <text class="desc">{{ getChildDesc(child) }}</text>
          </view>
          <view class="actions">
            <view class="icon-btn" @click="handleShowQr(child)">
              <text class="material-symbols-outlined">qr_code_2</text>
            </view>
            <view class="icon-btn primary" @click="handleEditChild(child)">
              <text class="material-symbols-outlined">edit</text>
            </view>
          </view>
        </view>
      </view>

      <!-- Common Settings -->
      <view class="section">
        <text class="section-title mt-4">通用设置</text>
        <view class="settings-group">
          <view v-for="item in settings" :key="item.title" class="setting-row" @click="handleSettingClick(item)">
            <view class="row-left">
              <view class="icon-box" :class="item.colorClass">
                <text class="material-symbols-outlined">{{ item.icon }}</text>
              </view>
              <text class="row-title">{{ item.title }}</text>
            </view>
            <text class="material-symbols-outlined arrow">chevron_right</text>
          </view>
        </view>
      </view>

      <!-- Help & Feedback -->
      <view class="section mt-4">
        <view class="settings-group">
          <view class="setting-row" @click="handleSettingClick({title: '帮助与反馈'})">
            <view class="row-left">
              <view class="icon-box orange">
                <text class="material-symbols-outlined">help</text>
              </view>
              <text class="row-title">帮助与反馈</text>
            </view>
            <text class="material-symbols-outlined arrow">chevron_right</text>
          </view>
        </view>
      </view>

      <!-- Logout -->
      <view class="logout-section">
        <button class="logout-btn" @click="handleLogout">退出登录</button>
        <text class="version">版本号 v2.4.0 (Small Steps)</text>
      </view>

      <view class="spacer"></view>
    </scroll-view>

    <!-- Modal (Temporarily Disabled) -->
    <!-- <device-settings-modal 
      v-model="showDeviceModal"
      v-model:volume="deviceVolume"
    /> -->

    <!-- Bottom Nav -->
    <bottom-nav mode="parent" />
  </view>
</template>

<script setup>
import { ref, onMounted, computed } from 'vue'
import TopBar from '@/components/common/top-bar/top-bar.vue'
import BottomNav from '@/components/common/bottom-nav/bottom-nav.vue'
import { useUserStore } from '@/store/modules/user'
import { listChildren } from '@/api/child'

const userStore = useUserStore()

const isDarkMode = ref(false)
const children = ref([])
const loading = ref(false)

const settings = ref([
  { title: '亲子契约手册', icon: 'description', colorClass: 'blue', url: '/pages/parent/contract/index' },
  { title: '情绪急救包', icon: 'medical_services', colorClass: 'rose', url: '/pages/parent/emotion-kit/index' },
  { title: '硬件玩偶设备', icon: 'smart_toy', colorClass: 'orange', url: '/pages/parent/device-config/index' },
  { title: '通知设置', icon: 'notifications', colorClass: 'blue', url: '/pages/mine/setting/notification' },
  { title: '隐私政策', icon: 'shield', colorClass: 'purple', url: '/pages/mine/about/privacy' },
  { title: '账号安全', icon: 'lock', colorClass: 'emerald', url: '/pages/mine/pwd/index' }
])

// 获取儿童列表
const fetchChildren = async () => {
  if (!userStore.userInfo?.user?.userId) return
  
  loading.value = true
  try {
    const res = await listChildren({ 
      parentId: userStore.userInfo.user.userId 
    })
    if (res.code === 200) {
      children.value = res.data || []
    }
  } catch (e) {
    console.error('Failed to fetch children:', e)
  } finally {
    loading.value = false
  }
}

// 计算年龄
const calculateAge = (birthday) => {
  if (!birthday) return ''
  const birthDate = new Date(birthday)
  const today = new Date()
  let age = today.getFullYear() - birthDate.getFullYear()
  const m = today.getMonth() - birthDate.getMonth()
  if (m < 0 || (m === 0 && today.getDate() < birthDate.getDate())) {
    age--
  }
  return age > 0 ? `${age}岁` : '1岁以下'
}

// 格式化描述 (年龄 + 备注)
const getChildDesc = (child) => {
  const ageStr = calculateAge(child.birthday)
  const remark = child.remark || ''
  // 提取备注中的班级信息 (如果有的话)
  const grade = remark.split('·')[1]?.trim() || remark.split(',')[1]?.trim() || remark
  return `${ageStr}${grade ? ' · ' + grade : ''}`
}

const handleAddChild = () => {
  uni.navigateTo({ url: '/pages/parent/family/create' })
}

const handleEditChild = (child) => {
  uni.navigateTo({
    url: `/pages/parent/family/edit?id=${child.id}`
  })
}

const handleShowQr = (child) => {
  uni.showModal({
    title: `${child.nickname} 的登录码`,
    content: '请在 StarBuddy 设备的屏幕上扫描此二维码（模拟）',
    showCancel: false
  })
}

const handleToInfo = () => {
  uni.navigateTo({ url: '/pages/mine/info/index' })
}

const handleToEditInfo = () => {
  uni.navigateTo({ url: '/pages/mine/info/edit' })
}

const handleShowMyQr = () => {
  uni.showModal({
    title: '我的名片',
    content: '这是您的个人名片二维码（展示用）',
    showCancel: false
  })
}

const handleSettingClick = (item) => {
  if (item.url) {
    uni.navigateTo({ url: item.url })
  } else if (item.title === '帮助与反馈') {
    uni.navigateTo({ url: '/pages/mine/help/index' })
  }
}

const handleLogout = () => {
  uni.showModal({
    title: '退出登录',
    content: '确定要退出当前账号吗？',
    confirmColor: '#ef4444',
    success: (res) => {
      if (res.confirm) {
        userStore.logOut()
        uni.reLaunch({ url: '/pages/login/index' })
      }
    }
  })
}

onMounted(() => {
  fetchChildren()
})
</script>

<style lang="scss" scoped>
.profile-page {
  height: 100vh;
  display: flex;
  flex-direction: column;
  background-color: #f6f7f8;
  
  :deep(.dark) & {
    background-color: #14191e;
  }
}

.lang-switch {
  display: flex;
  align-items: center;
  background-color: #e5e7eb;
  border-radius: 999px;
  padding: 2px;
  
  :deep(.dark) & { background-color: #374151; }
}

.lang-tag {
  font-size: 10px;
  font-weight: 500;
  padding: 2px 8px;
  border-radius: 999px;
  color: #6b7280;
  
  &.active {
    background-color: #ffffff;
    color: #111827;
    font-weight: 700;
    box-shadow: 0 1px 2px rgba(0,0,0,0.1);
    :deep(.dark) & { background-color: #1e242b; color: #fff; }
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

.user-card {
  display: flex;
  align-items: center;
  justify-content: space-between;
  padding: 24px;
  background-color: #ffffff;
  border-radius: 20px;
  box-shadow: 0 4px 20px rgba(0, 0, 0, 0.03);
}

.user-info-box {
  display: flex;
  align-items: center;
  gap: 16px;
}

.avatar-wrapper {
  width: 64px;
  height: 64px;
  border-radius: 999px;
  overflow: hidden;
  background-color: #f3f4f6;
  border: 4px solid #fff;
  box-shadow: 0 2px 10px rgba(0, 0, 0, 0.05);
}

.user-name {
  font-size: 20px;
  font-weight: 700;
  color: #111827;
}

.user-actions {
  display: flex;
  gap: 12px;
}

.device-card {
  display: flex;
  align-items: center;
  justify-content: space-between;
  padding: 20px;
  background-color: #ffffff;
  border-radius: 12px;
  box-shadow: 0 2px 8px rgba(0,0,0,0.04);
  
  :deep(.dark) & {
    background-color: #1f2937;
    box-shadow: 0 2px 8px rgba(0,0,0,0.2);
  }
}

.device-info {
  flex: 1;
  display: flex;
  flex-direction: column;
  gap: 8px;
}

.label {
  font-size: 10px;
  font-weight: 700;
  color: #9ca3af;
  text-transform: uppercase;
  letter-spacing: 0.5px;
}

.status-line {
  display: flex;
  align-items: center;
  gap: 8px;
}

.status-dot-box {
  position: relative;
  width: 12px;
  height: 12px;
}

.dot {
  width: 12px;
  height: 12px;
  background-color: #10b981;
  border-radius: 99px;
}

.dot-ping {
  position: absolute;
  inset: 0;
  background-color: #10b981;
  border-radius: 99px;
  animation: ping 1.5s infinite;
}

@keyframes ping {
  0% { transform: scale(1); opacity: 0.8; }
  100% { transform: scale(3); opacity: 0; }
}

.status-text {
  font-size: 18px;
  font-weight: 700;
  color: #111827;
  :deep(.dark) & { color: #fff; }
}

.detail-text {
  font-size: 12px;
  color: #9ca3af;
}

.device-image-box {
  width: 96px;
  height: 96px;
  background-color: #f0f9ff;
  border-radius: 12px;
  display: flex;
  align-items: center;
  justify-content: center;
  
  :deep(.dark) & { background-color: #374151; }
}

.device-image {
  width: 80px;
  height: 80px;
}

.section-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-bottom: 12px;
}

.section-title {
  font-size: 16px;
  font-weight: 700;
  color: #111827;
  :deep(.dark) & { color: #fff; }
}

.empty-box {
  padding: 32px;
  display: flex;
  justify-content: center;
  align-items: center;
  background-color: #fff;
  border-radius: 12px;
  border: 1px dashed #e5e7eb;
  :deep(.dark) & { background-color: #1f2937; border-color: #374151; }
}

.empty-text {
  font-size: 14px;
  color: #9ca3af;
}

.add-btn {
  display: flex;
  align-items: center;
  gap: 4px;
  padding: 4px 12px;
  background-color: rgba(108, 155, 210, 0.1);
  border-radius: 999px;
  color: #6C9BD2;
  font-size: 12px;
  font-weight: 700;
  &::after { border: none; }
}

.child-card {
  display: flex;
  align-items: center;
  gap: 16px;
  padding: 16px;
  background-color: #ffffff;
  border-radius: 12px;
  box-shadow: 0 1px 3px rgba(0,0,0,0.05);
  border: 1px solid transparent;
  
  :deep(.dark) & { background-color: #1f2937; }
  
  &:active { border-color: rgba(108, 155, 210, 0.2); }
}

.avatar-box {
  width: 56px;
  height: 56px;
  border-radius: 999px;
  overflow: hidden;
  border: 2px solid rgba(108, 155, 210, 0.2);
}

.avatar {
  width: 100%;
  height: 100%;
}

.child-card .info {
  flex: 1;
  display: flex;
  flex-direction: column;
}

.name {
  font-size: 18px;
  font-weight: 700;
  color: #111827;
  :deep(.dark) & { color: #fff; }
}

.desc {
  font-size: 14px;
  color: #6b7280;
}

.actions {
  display: flex;
  gap: 8px;
}

.icon-btn {
  width: 36px;
  height: 36px;
  border-radius: 999px;
  background-color: #f3f4f6;
  display: flex;
  align-items: center;
  justify-content: center;
  color: #4b5563;
  
  :deep(.dark) & { background-color: #374151; color: #d1d5db; }
  
  &.primary { color: #6C9BD2; }
}

.settings-group {
  background-color: #ffffff;
  border-radius: 12px;
  overflow: hidden;
  box-shadow: 0 1px 3px rgba(0,0,0,0.05);
  
  :deep(.dark) & { background-color: #1f2937; }
}

.setting-row {
  display: flex;
  align-items: center;
  justify-content: space-between;
  padding: 16px;
  border-bottom: 1px solid #f3f4f6;
  
  :deep(.dark) & { border-bottom-color: #374151; }
  
  &:last-child { border-bottom: none; }
  &:active { background-color: #f9fafb; :deep(.dark) & { background-color: #374151; } }
}

.row-left {
  display: flex;
  align-items: center;
  gap: 16px;
}

.icon-box {
  width: 32px;
  height: 32px;
  border-radius: 999px;
  display: flex;
  align-items: center;
  justify-content: center;
  
  &.blue { background-color: #dbeafe; color: #3b82f6; }
  &.purple { background-color: #f3e8ff; color: #a855f7; }
  &.emerald { background-color: #d1fae5; color: #10b981; }
  &.orange { background-color: #ffedd5; color: #f97316; }
  &.rose { background-color: #ffe4e6; color: #f43f5e; }
  
  .material-symbols-outlined { font-size: 18px; }
}

.row-title {
  font-size: 16px;
  font-weight: 500;
  color: #111827;
  :deep(.dark) & { color: #fff; }
}

.arrow {
  color: #d1d5db;
  font-size: 20px;
}

.logout-section {
  padding: 32px 16px;
  display: flex;
  flex-direction: column;
  align-items: center;
  gap: 16px;
}

.logout-btn {
  width: 100%;
  height: 50px;
  background-color: #ffffff;
  border: 1px solid #fee2e2;
  color: #ef4444;
  font-weight: 700;
  border-radius: 12px;
  box-shadow: 0 1px 3px rgba(0,0,0,0.05);
  
  &::after { border: none; }
  
  :deep(.dark) & { background-color: #1f2937; border-color: #7f1d1d; color: #f87171; }
  
  &:active { transform: scale(0.98); }
}

.version {
  font-size: 12px;
  color: #9ca3af;
}

.spacer {
  height: 100px;
}

.no-scrollbar::-webkit-scrollbar {
  display: none;
}
</style>

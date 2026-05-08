<template>
  <view class="parent-center min-h-screen bg-[#f6f7f8] pb-10">
    <!-- Header Section -->
    <view class="header bg-white px-6 pt-12 pb-6 rounded-b-[40px] shadow-sm mb-6">
      <view class="flex items-center justify-between mb-4">
        <text class="text-xl font-bold text-gray-800">家长中心</text>
        <view class="lang-selector px-3 py-1 bg-gray-100 rounded-full text-sm font-medium text-gray-600">CN</view>
      </view>
      
      <view class="user-profile flex items-center justify-between py-4">
        <view class="flex items-center gap-4">
          <view class="avatar-wrapper relative">
            <image 
              v-if="avatar" 
              :src="avatar" 
              class="w-20 h-20 rounded-full border-4 border-blue-50 shadow-md"
              mode="aspectFill"
              @click="handleToAvatar"
            />
            <view v-else class="w-20 h-20 rounded-full bg-blue-100 flex items-center justify-center border-4 border-blue-50 shadow-md">
              <text class="text-blue-500 font-bold text-2xl">{{ name ? name.substring(0,1) : '?' }}</text>
            </view>
          </view>
          <view class="info">
            <text class="text-2xl font-bold text-gray-800">{{ name || '家长用户' }}</text>
            <view class="flex items-center mt-1 text-gray-400 text-sm">
              <text>陪伴成长的第 128 天</text>
            </view>
          </view>
        </view>
        <view class="actions flex gap-3">
          <view class="icon-btn p-2 bg-gray-50 rounded-xl" @click="handleToQRCode">
            <image src="https://img.icons8.com/material-outlined/24/9ca3af/qr-code.png" class="w-6 h-6" />
          </view>
          <view class="icon-btn p-2 bg-gray-50 rounded-xl" @click="handleToEditInfo">
            <image src="https://img.icons8.com/material-outlined/24/9ca3af/edit--v1.png" class="w-6 h-6" />
          </view>
        </view>
      </view>
    </view>

    <!-- Settings Groups -->
    <view class="px-5 space-y-6">
      <!-- 通用设置 -->
      <view class="settings-card bg-white rounded-[32px] overflow-hidden shadow-sm">
        <view class="p-5 border-b border-gray-50">
          <text class="text-sm font-bold text-gray-400 uppercase tracking-wider">通用设置</text>
        </view>
        
        <view class="menu-list">
          <view class="menu-item flex items-center justify-between p-5 active:bg-gray-50 transition-colors" @click="handleToNotification">
            <view class="flex items-center gap-4">
              <view class="w-12 h-12 bg-blue-50 rounded-2xl flex items-center justify-center">
                <image src="https://img.icons8.com/fluency/48/bell.png" class="w-6 h-6" />
              </view>
              <text class="text-lg font-medium text-gray-700">通知设置</text>
            </view>
            <image src="https://img.icons8.com/material-outlined/24/d1d5db/forward.png" class="w-5 h-5" />
          </view>
          
          <view class="menu-item flex items-center justify-between p-5 active:bg-gray-50 transition-colors" @click="handleToPrivacy">
            <view class="flex items-center gap-4">
              <view class="w-12 h-12 bg-purple-50 rounded-2xl flex items-center justify-center">
                <image src="https://img.icons8.com/fluency/48/shield.png" class="w-6 h-6" />
              </view>
              <text class="text-lg font-medium text-gray-700">隐私政策</text>
            </view>
            <image src="https://img.icons8.com/material-outlined/24/d1d5db/forward.png" class="w-5 h-5" />
          </view>
          
          <view class="menu-item flex items-center justify-between p-5 active:bg-gray-50 transition-colors" @click="handleToSecurity">
            <view class="flex items-center gap-4">
              <view class="w-12 h-12 bg-green-50 rounded-2xl flex items-center justify-center">
                <image src="https://img.icons8.com/fluency/48/lock.png" class="w-6 h-6" />
              </view>
              <text class="text-lg font-medium text-gray-700">账号安全</text>
            </view>
            <image src="https://img.icons8.com/material-outlined/24/d1d5db/forward.png" class="w-5 h-5" />
          </view>
        </view>
      </view>

      <!-- 帮助与支持 -->
      <view class="settings-card bg-white rounded-[32px] overflow-hidden shadow-sm">
        <view class="menu-list">
          <view class="menu-item flex items-center justify-between p-5 active:bg-gray-50 transition-colors" @click="handleToHelp">
            <view class="flex items-center gap-4">
              <view class="w-12 h-12 bg-orange-50 rounded-2xl flex items-center justify-center">
                <image src="https://img.icons8.com/fluency/48/help.png" class="w-6 h-6" />
              </view>
              <text class="text-lg font-medium text-gray-700">帮助与反馈</text>
            </view>
            <image src="https://img.icons8.com/material-outlined/24/d1d5db/forward.png" class="w-5 h-5" />
          </view>
        </view>
      </view>

      <!-- Logout -->
      <view class="mt-10 px-10">
        <button 
          class="w-full h-16 bg-white border-none rounded-[24px] text-red-500 font-bold text-lg shadow-sm active:bg-gray-50 active:scale-98 transition-all"
          @click="handleLogout"
        >
          退出登录
        </button>
        <view class="text-center mt-6 text-gray-400 text-sm">
          版本号 v2.4.0 (Small Steps)
        </view>
      </view>
    </view>
  </view>
</template>

<script setup>
import { useUserStore } from '@/store'
import { computed, getCurrentInstance } from "vue"

const { proxy } = getCurrentInstance()
const userStore = useUserStore()
const name = userStore.name
const avatar = computed(() => userStore.avatar)

const handleToNotification = () => proxy.$tab.navigateTo('/pages/mine/setting/notification')
const handleToPrivacy = () => proxy.$tab.navigateTo('/pages/mine/setting/privacy')
const handleToSecurity = () => proxy.$tab.navigateTo('/pages/mine/setting/security')
const handleToHelp = () => proxy.$tab.navigateTo('/pages/mine/help/index')
const handleToEditInfo = () => proxy.$tab.navigateTo('/pages/mine/info/edit')
const handleToAvatar = () => proxy.$tab.navigateTo('/pages/mine/avatar/index')

const handleToQRCode = () => {
  proxy.$modal.showToast('二维码功能建设中~')
}

const handleLogout = () => {
  proxy.$modal.confirm('确定要退出登录吗？').then(() => {
    userStore.logout().then(() => {
      proxy.$tab.reLaunch('/pages/login')
    })
  })
}
</script>

<style lang="scss" scoped>
.parent-center {
  padding-top: env(safe-area-inset-top);
}

.settings-card {
  box-shadow: 0 4px 20px rgba(0, 0, 0, 0.02);
}

.menu-item {
  border-bottom: 1px solid #fcfcfc;
  &:last-child {
    border-bottom: none;
  }
}

button::after {
  border: none;
}
</style>

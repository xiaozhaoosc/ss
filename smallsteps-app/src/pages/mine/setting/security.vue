<template>
  <view class="security-page min-h-screen bg-[#f6f7f8]">
    <top-bar title="账号安全" show-back />
    
    <view class="main-content p-5 pt-20">
      <view class="settings-card bg-white rounded-[32px] overflow-hidden shadow-sm">
        <view class="menu-list">
          <view class="menu-item flex items-center justify-between p-5 border-b border-gray-50" @click="handleToResetPwd">
            <view class="flex items-center gap-4">
              <text class="text-lg font-medium text-gray-700">修改密码</text>
            </view>
            <image src="https://img.icons8.com/material-outlined/24/d1d5db/forward.png" class="w-5 h-5" />
          </view>
          
          <view class="menu-item flex items-center justify-between p-5 border-b border-gray-50">
            <view class="flex items-center gap-4">
              <text class="text-lg font-medium text-gray-700">注销账号</text>
            </view>
            <text class="text-gray-300 text-sm">暂未开放</text>
          </view>
        </view>
      </view>
      
      <view class="p-4 text-center">
        <text class="text-gray-400 text-xs">为了保障您的账号安全，建议定期修改密码。</text>
      </view>
    </view>
  </view>
</template>

<script setup>
import { getCurrentInstance } from 'vue'
import TopBar from '@/components/common/top-bar/top-bar.vue'

const { proxy } = getCurrentInstance()
const handleToResetPwd = () => proxy.$tab.navigateTo('/pages/mine/pwd/index')
</script>

<style lang="scss" scoped>
.security-page {
  padding-top: env(safe-area-inset-top);
}
</style>

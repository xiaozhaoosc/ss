<template>
  <view class="demo-page">
    <!-- 顶部标题栏 -->
    <top-bar 
      title="组件演示" 
      :mode="mode"
      :show-back="true"
    >
      <template #right>
        <theme-toggle />
      </template>
    </top-bar>
    
    <!-- 内容区域 -->
    <view class="content">
      <view class="section">
        <text class="section-title">模式切换</text>
        <view class="mode-switch">
          <view 
            class="mode-btn" 
            :class="{ active: mode === 'parent' }"
            @click="mode = 'parent'"
          >
            家长端
          </view>
          <view 
            class="mode-btn" 
            :class="{ active: mode === 'child' }"
            @click="mode = 'child'"
          >
            儿童端
          </view>
        </view>
      </view>
      
      <view class="section">
        <text class="section-title">当前模式</text>
        <text class="mode-text">{{ mode === 'parent' ? '家长端' : '儿童端' }}</text>
      </view>
    </view>
    
    <!-- 底部导航 -->
    <bottom-nav :mode="mode" />
  </view>
</template>

<script setup>
import { ref } from 'vue'
import TopBar from '@/components/common/top-bar/top-bar.vue'
import BottomNav from '@/components/common/bottom-nav/bottom-nav.vue'
import ThemeToggle from '@/components/common/theme-toggle/theme-toggle.vue'

const mode = ref('parent')
</script>

<style lang="scss" scoped>
.demo-page {
  min-height: 100vh;
  background: #f9fafb;
}

.content {
  padding: 60px 16px 70px;
}

.section {
  background: #ffffff;
  border-radius: 12px;
  padding: 16px;
  margin-bottom: 16px;
}

.section-title {
  font-size: 14px;
  font-weight: 600;
  color: #6b7280;
  margin-bottom: 12px;
  display: block;
}

.mode-switch {
  display: flex;
  gap: 12px;
}

.mode-btn {
  flex: 1;
  padding: 12px;
  background: #f3f4f6;
  border-radius: 8px;
  text-align: center;
  font-size: 14px;
  font-weight: 500;
  color: #6b7280;
  cursor: pointer;
  transition: all 0.3s ease;
  
  &.active {
    background: #6C9BD2;
    color: #ffffff;
  }
  
  &:active {
    opacity: 0.8;
  }
}

.mode-text {
  font-size: 16px;
  font-weight: 600;
  color: #111827;
}
</style>

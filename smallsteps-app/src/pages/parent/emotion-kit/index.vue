<template>
  <view class="emotion-kit-page" :class="{ 'dark': isDarkMode }">
    <view class="header">
      <button class="back-btn" @click="handleBack">
        <text class="material-symbols-outlined icon">arrow_back</text>
      </button>
      <text class="page-title">情绪急救包</text>
      <view class="spacer"></view>
    </view>

    <view class="main-content">
      <view class="empty-state">
        <text class="material-symbols-outlined empty-icon">healing</text>
        <text class="empty-text">暂无内容</text>
        <text class="empty-desc">情绪急救功能即将上线！</text>
      </view>
    </view>
  </view>
</template>

<script setup>
import { ref } from 'vue'

const isDarkMode = ref(false)

const handleBack = () => {
  uni.navigateBack()
}
</script>

<style lang="scss" scoped>
.emotion-kit-page {
  height: 100vh;
  display: flex;
  flex-direction: column;
  background-color: #ffffff;
  position: relative;
  overflow: hidden;

  :deep(.dark) & { background-color: #101622; }
}

.header {
  display: flex;
  align-items: center;
  justify-content: space-between;
  padding: 24px 16px 16px 16px;
  padding-top: calc(24px + env(safe-area-inset-top));
  position: relative;
  z-index: 10;
}

.back-btn {
  width: 48px;
  height: 48px;
  border-radius: 999px;
  background-color: #f3f4f6;
  display: flex;
  align-items: center;
  justify-content: center;
  color: #1e293b;
  border: none;

  &::after { border: none; }

  :deep(.dark) & { background-color: #1e293b; color: #fff; }

  &:active { transform: scale(0.95); }
}

.page-title {
  font-size: 20px;
  font-weight: 900;
  color: #0f172a;
  :deep(.dark) & { color: #fff; }
}

.spacer { width: 48px; }

.main-content {
  flex: 1;
  display: flex;
  align-items: center;
  justify-content: center;
  position: relative;
  z-index: 10;
}

.empty-state {
  display: flex;
  flex-direction: column;
  align-items: center;
  gap: 16px;
}

.empty-icon {
  font-size: 80px;
  color: #9ca3af;
}

.empty-text {
  font-size: 20px;
  font-weight: 700;
  color: #374151;
  :deep(.dark) & { color: #d1d5db; }
}

.empty-desc {
  font-size: 14px;
  color: #6b7280;
  :deep(.dark) & { color: #9ca3af; }
}
</style>

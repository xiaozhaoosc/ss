<template>
  <view class="container">
    <view class="status-bar-placeholder"></view>
    <view class="top-nav">
      <view class="back-btn" @click="goBack">
        <text class="material-symbols-outlined">arrow_back_ios</text>
      </view>
      <text class="nav-title">AI 模型配置</text>
      <view class="right-placeholder"></view>
    </view>
    
    <view class="content">
      <view class="empty-state">
        <text class="material-symbols-outlined empty-icon">construction</text>
        <text class="empty-text">该功能模块正在建设中...</text>
        <text class="empty-desc">敬请期待更强大的 AI 伴学能力</text>
      </view>
    </view>
  </view>
</template>

<script setup>
const goBack = () => {
  uni.navigateBack()
}
</script>

<style lang="scss" scoped>
.container {
  min-height: 100vh;
  background-color: #f8f9fa;
  display: flex;
  flex-direction: column;
}

.status-bar-placeholder {
  height: var(--status-bar-height);
  background-color: #ffffff;
}

.top-nav {
  height: 44px;
  background-color: #ffffff;
  display: flex;
  align-items: center;
  justify-content: space-between;
  padding: 0 16px;
  border-bottom: 1px solid #f0f0f0;

  .back-btn {
    width: 32px;
    height: 32px;
    display: flex;
    align-items: center;
    justify-content: center;
    .material-symbols-outlined { font-size: 20px; color: #333; }
  }

  .nav-title {
    font-size: 18px;
    font-weight: 700;
    color: #111827;
  }

  .right-placeholder { width: 32px; }
}

.content {
  flex: 1;
  display: flex;
  align-items: center;
  justify-content: center;
  padding: 32px;
}

.empty-state {
  display: flex;
  flex-direction: column;
  align-items: center;
  text-align: center;
  
  .empty-icon {
    font-size: 80px;
    color: #6C9BD2;
    margin-bottom: 24px;
    opacity: 0.5;
  }
  
  .empty-text {
    font-size: 20px;
    font-weight: 700;
    color: #111827;
    margin-bottom: 8px;
  }
  
  .empty-desc {
    font-size: 14px;
    color: #6b7280;
  }
}
</style>

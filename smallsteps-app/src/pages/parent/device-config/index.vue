<template>
  <view class="device-config-page">
    <!-- 顶部导航栏 -->
    <view class="custom-navbar">
      <view class="navbar-content">
        <view class="navbar-left" @click="goBack">
          <text class="icon-back">←</text>
        </view>
        <view class="navbar-title">设备配置</view>
        <view class="navbar-right"></view>
      </view>
    </view>

    <!-- 主内容区 -->
    <view class="content">
      <!-- 暂时不可用提示 -->
      <view class="step-content">
        <view class="disabled-section">
          <view class="disabled-icon">🔧</view>
          <text class="disabled-title">功能暂时不可用</text>
          <text class="disabled-message">ESP32相关功能已临时关闭，敬请期待</text>
          
          <button class="btn-primary" @click="goBack">返回</button>
        </view>
      </view>
    </view>
  </view>
</template>

<script>
export default {
  methods: {
    // 返回
    goBack() {
      uni.navigateBack()
    }
  }
}
</script>

<style scoped>
/* 暂时不可用部分 */
.disabled-section {
  display: flex;
  flex-direction: column;
  align-items: center;
  gap: 20px;
  padding: 40px 20px;
}

.disabled-icon {
  font-size: 64px;
}

.disabled-title {
  font-size: 20px;
  font-weight: 600;
  color: #333;
}

.disabled-message {
  font-size: 14px;
  color: #6b7280;
  text-align: center;
  line-height: 1.5;
}
</style>

<style scoped>
.device-config-page {
  min-height: 100vh;
  background: #f5f7fa;
}

/* 自定义导航栏 */
.custom-navbar {
  background: #fff;
  padding-top: var(--status-bar-height);
}

.navbar-content {
  display: flex;
  align-items: center;
  justify-content: space-between;
  height: 44px;
  padding: 0 16px;
}

.navbar-left, .navbar-right {
  width: 60px;
}

.icon-back {
  font-size: 24px;
  color: #333;
}

.navbar-title {
  font-size: 17px;
  font-weight: 600;
  color: #333;
}

/* 内容区 */
.content {
  padding: 20px 16px;
}

/* 步骤指示器 */
.steps {
  display: flex;
  align-items: center;
  justify-content: center;
  margin-bottom: 30px;
  padding: 20px;
  background: #fff;
  border-radius: 12px;
}

.step {
  display: flex;
  flex-direction: column;
  align-items: center;
  gap: 8px;
}

.step-number {
  width: 32px;
  height: 32px;
  border-radius: 50%;
  background: #e5e7eb;
  color: #9ca3af;
  display: flex;
  align-items: center;
  justify-content: center;
  font-size: 14px;
  font-weight: 600;
  transition: all 0.3s;
}

.step.active .step-number {
  background: #6C9BD2;
  color: #fff;
}

.step.completed .step-number {
  background: #10b981;
  color: #fff;
}

.step-text {
  font-size: 12px;
  color: #9ca3af;
}

.step.active .step-text {
  color: #333;
  font-weight: 500;
}

.step-line {
  width: 60px;
  height: 2px;
  background: #e5e7eb;
  margin: 0 8px;
  transition: all 0.3s;
}

.step-line.active {
  background: #6C9BD2;
}

/* 步骤内容 */
.step-content {
  background: #fff;
  border-radius: 12px;
  padding: 24px;
}

/* 扫描部分 */
.scan-section {
  display: flex;
  flex-direction: column;
  align-items: center;
  gap: 20px;
}

.scan-icon {
  font-size: 64px;
}

.scan-title {
  font-size: 18px;
  font-weight: 600;
  color: #333;
}

.device-list {
  width: 100%;
  margin-top: 20px;
}

.device-item {
  display: flex;
  align-items: center;
  justify-content: space-between;
  padding: 16px;
  background: #f9fafb;
  border-radius: 8px;
  margin-bottom: 12px;
}

.device-info {
  display: flex;
  flex-direction: column;
  gap: 4px;
}

.device-name {
  font-size: 16px;
  font-weight: 500;
  color: #333;
}

.device-id {
  font-size: 12px;
  color: #9ca3af;
}

.device-signal {
  display: flex;
  align-items: center;
  gap: 4px;
}

.signal-icon {
  font-size: 16px;
}

.signal-text {
  font-size: 12px;
  color: #6b7280;
}

.scanning-tip {
  color: #9ca3af;
  font-size: 14px;
}

/* 配置部分 */
.config-section {
  display: flex;
  flex-direction: column;
  gap: 24px;
}

.config-header {
  display: flex;
  align-items: center;
  justify-content: space-between;
  padding-bottom: 16px;
  border-bottom: 1px solid #e5e7eb;
}

.config-device-name {
  font-size: 18px;
  font-weight: 600;
  color: #333;
}

.config-status {
  font-size: 14px;
  padding: 4px 12px;
  border-radius: 12px;
}

.config-status.connected {
  background: #d1fae5;
  color: #065f46;
}

.config-status.connecting {
  background: #fef3c7;
  color: #92400e;
}

.config-group {
  display: flex;
  flex-direction: column;
  gap: 16px;
}

.group-title {
  font-size: 16px;
  font-weight: 600;
  color: #333;
}

.form-item {
  display: flex;
  flex-direction: column;
  gap: 8px;
}

.label {
  font-size: 14px;
  color: #6b7280;
}

.input {
  padding: 12px;
  background: #f9fafb;
  border: 1px solid #e5e7eb;
  border-radius: 8px;
  font-size: 14px;
}

.action-buttons {
  display: flex;
  gap: 12px;
  margin-top: 8px;
}

/* 成功部分 */
.success-section {
  display: flex;
  flex-direction: column;
  align-items: center;
  gap: 20px;
}

.success-icon {
  font-size: 64px;
}

.success-title {
  font-size: 20px;
  font-weight: 600;
  color: #333;
}

.success-message {
  font-size: 14px;
  color: #6b7280;
  text-align: center;
}

.config-summary {
  width: 100%;
  background: #f9fafb;
  border-radius: 8px;
  padding: 16px;
  margin-top: 8px;
}

.summary-item {
  display: flex;
  justify-content: space-between;
  padding: 8px 0;
  border-bottom: 1px solid #e5e7eb;
}

.summary-item:last-child {
  border-bottom: none;
}

.summary-label {
  font-size: 14px;
  color: #6b7280;
}

.summary-value {
  font-size: 14px;
  font-weight: 500;
  color: #333;
}

/* 按钮 */
.btn-primary, .btn-secondary {
  flex: 1;
  padding: 14px 24px;
  border-radius: 8px;
  font-size: 16px;
  font-weight: 500;
  border: none;
}

.btn-primary {
  background: #6C9BD2;
  color: #fff;
}

.btn-primary[disabled] {
  background: #d1d5db;
  color: #9ca3af;
}

.btn-secondary {
  background: #f3f4f6;
  color: #374151;
}
</style>

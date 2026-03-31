<template>
  <view v-if="modelValue" class="modal-mask" @click="$emit('update:modelValue', false)">
    <view class="modal-container" @click.stop>
      <view class="modal-header">
        <text class="modal-title">StarBuddy 设置</text>
        <button class="close-btn" @click="$emit('update:modelValue', false)">
          <text class="material-symbols-outlined">close</text>
        </button>
      </view>

      <!-- Volume Control -->
      <view class="setting-item">
        <text class="item-label">音量控制</text>
        <view class="volume-slider-box">
          <text class="material-symbols-outlined icon">volume_mute</text>
          <slider 
            class="slider"
            :value="volume" 
            activeColor="#6C9BD2" 
            backgroundColor="#e5e7eb" 
            block-size="16"
            @change="handleVolumeChange"
          />
          <text class="material-symbols-outlined icon">volume_up</text>
        </view>
      </view>

      <!-- WiFi Config -->
      <view class="setting-item">
        <text class="item-label">网络连接</text>
        <view class="wifi-box">
          <view class="wifi-info">
            <text class="material-symbols-outlined wifi-icon">wifi</text>
            <view class="wifi-details">
              <text class="wifi-name">{{ wifiName }}</text>
              <text class="wifi-status">已连接</text>
            </view>
          </view>
          <button class="change-btn" @click="handleWifiChange">更换</button>
        </view>
      </view>

      <!-- Firmware -->
      <view class="firmware-footer">
        <text class="version-text">固件版本 {{ version }}</text>
        <button class="update-btn" @click="handleCheckUpdate">检查更新</button>
      </view>
    </view>
  </view>
</template>

<script setup>
const props = defineProps({
  modelValue: Boolean,
  volume: { type: Number, default: 60 },
  wifiName: { type: String, default: 'Home_5G' },
  version: { type: String, default: 'v1.2.0' }
})

const emit = defineEmits(['update:modelValue', 'update:volume'])

const handleVolumeChange = (e) => {
  emit('update:volume', e.detail.value)
}

const handleWifiChange = () => {
  uni.showToast({ title: '搜索设备中...', icon: 'none' })
}

const handleCheckUpdate = () => {
  uni.showLoading({ title: '检查中' })
  setTimeout(() => {
    uni.hideLoading()
    uni.showToast({ title: '已是最新版本', icon: 'success' })
  }, 1000)
}
</script>

<style lang="scss" scoped>
.modal-mask {
  position: fixed;
  inset: 0;
  background-color: rgba(0, 0, 0, 0.5);
  backdrop-filter: blur(4px);
  z-index: 999;
  display: flex;
  align-items: center;
  justify-content: center;
  padding: 20px;
}

.modal-container {
  width: 100%;
  max-width: 320px;
  background-color: #ffffff;
  border-radius: 20px;
  padding: 24px;
  box-shadow: 0 10px 25px rgba(0, 0, 0, 0.2);
  
  :deep(.dark) & {
    background-color: #1e242b;
  }
}

.modal-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-bottom: 24px;
}

.modal-title {
  font-size: 18px;
  font-weight: 700;
  color: #111827;
  :deep(.dark) & { color: #fff; }
}

.close-btn {
  background: transparent;
  padding: 4px;
  color: #9ca3af;
  &::after { border: none; }
}

.setting-item {
  margin-bottom: 24px;
}

.item-label {
  font-size: 12px;
  font-weight: 700;
  color: #9ca3af;
  text-transform: uppercase;
  margin-bottom: 12px;
  display: block;
}

.volume-slider-box {
  display: flex;
  align-items: center;
  gap: 12px;
  
  .icon { color: #9ca3af; font-size: 20px; }
  .slider { flex: 1; margin: 0; }
}

.wifi-box {
  display: flex;
  justify-content: space-between;
  align-items: center;
  padding: 12px;
  background-color: #f9fafb;
  border-radius: 12px;
  
  :deep(.dark) & {
    background-color: #14191e;
  }
}

.wifi-info {
  display: flex;
  align-items: center;
  gap: 12px;
}

.wifi-icon {
  color: #6C9BD2;
  font-size: 20px;
}

.wifi-details {
  display: flex;
  flex-direction: column;
}

.wifi-name {
  font-size: 14px;
  font-weight: 700;
  color: #111827;
  :deep(.dark) & { color: #fff; }
}

.wifi-status {
  font-size: 10px;
  color: #10b981;
}

.change-btn {
  font-size: 12px;
  font-weight: 700;
  color: #6C9BD2;
  background: transparent;
  padding: 0;
  &::after { border: none; }
}

.firmware-footer {
  display: flex;
  justify-content: space-between;
  align-items: center;
  padding-top: 16px;
  border-top: 1px solid #f3f4f6;
  
  :deep(.dark) & { border-top-color: #374151; }
}

.version-text {
  font-size: 12px;
  color: #9ca3af;
}

.update-btn {
  font-size: 12px;
  font-weight: 700;
  color: #6C9BD2;
  background: transparent;
  padding: 0;
  &::after { border: none; }
}
</style>

<template>
  <view class="emotion-alert">
    <view class="alert-content">
      <view class="image-box" :style="{ backgroundImage: `url(${image})` }"></view>
      <view class="info-box">
        <view class="title-row">
          <text class="title">情绪警报</text>
          <view v-if="active" class="pulse-dot"></view>
        </view>
        <text class="message">{{ message }}</text>
        <view class="footer-action" @click="handleDetails">
          <text class="action-text">查看详情</text>
          <text class="material-symbols-outlined icon">arrow_forward</text>
        </view>
      </view>
    </view>
  </view>
</template>

<script setup>
const props = defineProps({
  image: {
    type: String,
    default: 'https://lh3.googleusercontent.com/aida-public/AB6AXuBEaBQ_WB33k57A56ucieYH4kZLwqVy9YhwGhLgjWTZ8izqGjhRXYbTCZ1FsnerZMj6M5yVO-OKQMxN1fXLcFlVS6V3CAmoCkF1pDqjopS5S1H2ZgaWfs75iLrJTBTl89NqE9rZ4q67EnmqxQgJLQUmBUxD_fbY85H7DCfbZASthgFdMaxStY8CZIvGr8ldkysJrcrQN__aRuc7VH7e1m01wdPxRodXI4-QsQU8ZLlpnRYpc_bFXEU4d871GZshVRTDV4JHS_pMPA0'
  },
  message: String,
  active: {
    type: Boolean,
    default: true
  }
})

const emit = defineEmits(['view-details'])

const handleDetails = () => {
  emit('view-details')
}
</script>

<style lang="scss" scoped>
.emotion-alert {
  padding: 8px 16px;
}

.alert-content {
  display: flex;
  flex-direction: row;
  border-radius: 16px;
  background-color: #ffffff;
  box-shadow: 0 1px 3px rgba(0, 0, 0, 0.1);
  border-left: 4px solid #6C9BD2;
  overflow: hidden;
  padding: 16px;
  gap: 16px;
  align-items: flex-start;
  
  :deep(.dark) & {
    background-color: #1e242b;
  }
}

.image-box {
  flex-shrink: 0;
  width: 80px;
  height: 80px;
  border-radius: 12px;
  background-position: center;
  background-repeat: no-repeat;
  background-size: cover;
  box-shadow: inset 0 0 10px rgba(0,0,0,0.1);
}

.info-box {
  display: flex;
  flex-direction: column;
  flex-grow: 1;
  justify-content: center;
  gap: 4px;
}

.title-row {
  display: flex;
  align-items: center;
  justify-content: space-between;
}

.title {
  color: #111827;
  font-size: 18px;
  font-weight: 700;
  
  :deep(.dark) & {
    color: #ffffff;
  }
}

.pulse-dot {
  width: 8px;
  height: 8px;
  background-color: #ef4444;
  border-radius: 999px;
  animation: pulse 2s infinite;
}

.message {
  color: #6b7280;
  font-size: 14px;
  line-height: 1.5;
  margin-bottom: 4px;
  
  :deep(.dark) & {
    color: #9ca3af;
  }
}

.footer-action {
  display: flex;
  justify-content: flex-end;
  padding-top: 4px;
  align-items: center;
  gap: 4px;
  cursor: pointer;
  
  &:active {
    opacity: 0.7;
  }
}

.action-text {
  font-size: 12px;
  font-weight: 700;
  color: #6C9BD2;
  text-transform: uppercase;
  letter-spacing: 0.5px;
}

.icon {
  font-size: 14px;
  color: #6C9BD2;
}

@keyframes pulse {
  0% { transform: scale(0.95); opacity: 0.9; }
  70% { transform: scale(1.1); opacity: 0.5; }
  100% { transform: scale(0.95); opacity: 0.9; }
}
</style>

<template>
  <view class="pending-request-card">
    <view class="content">
      <!-- Avatar -->
      <view class="avatar-box">
        <text class="material-symbols-outlined icon">face_6</text>
      </view>
      
      <!-- Info -->
      <view class="info">
        <text class="reward-name">{{ rewardName }}</text>
        <view class="user-line">
          <text class="username">{{ childName }}</text>
          <text class="action-type"> 想要兑换</text>
        </view>
        <view class="star-badge">
          <text class="material-symbols-outlined star-icon">star</text>
          <text class="star-text">{{ points }} 颗星</text>
        </view>
      </view>
    </view>
    
    <!-- Actions -->
    <view class="actions">
      <button class="btn deny" @click="$emit('deny')">拒绝</button>
      <button class="btn approve" @click="$emit('approve')">批准</button>
    </view>
  </view>
</template>

<script setup>
defineProps({
  childName: String,
  rewardName: String,
  points: [Number, String]
})

defineEmits(['approve', 'deny'])
</script>

<style lang="scss" scoped>
.pending-request-card {
  padding: 20px;
  background-color: #ffffff;
  border-radius: 12px;
  border: 1px solid #d4dbe3;
  box-shadow: 0 1px 2px rgba(0, 0, 0, 0.05);
  
  :deep(.dark) & {
    background-color: #1e242b;
    border-color: #374151;
  }
}

.content {
  display: flex;
  gap: 16px;
  align-items: flex-start;
  margin-bottom: 20px;
}

.avatar-box {
  width: 48px;
  height: 48px;
  border-radius: 999px;
  background-color: #dbeafe;
  display: flex;
  align-items: center;
  justify-content: center;
  flex-shrink: 0;
  
  :deep(.dark) & {
    background-color: #1e3a8a;
  }
  
  .icon {
    font-size: 24px;
    color: #6C9BD2;
  }
}

.info {
  flex: 1;
  display: flex;
  flex-direction: column;
  gap: 4px;
}

.reward-name {
  font-size: 16px;
  font-weight: 700;
  color: #111827;
  
  :deep(.dark) & {
    color: #ffffff;
  }
}

.user-line {
  font-size: 14px;
  color: #6b7280;
}

.username {
  font-weight: 600;
  color: #111827;
  
  :deep(.dark) & {
    color: #e5e7eb;
  }
}

.star-badge {
  display: inline-flex;
  align-items: center;
  gap: 4px;
  margin-top: 4px;
}

.star-icon {
  font-size: 18px;
  color: #f59e0b;
}

.star-text {
  font-size: 14px;
  font-weight: 700;
  color: #d97706;
  
  :deep(.dark) & {
    color: #f6e05e;
  }
}

.actions {
  display: flex;
  gap: 12px;
}

.btn {
  flex: 1;
  height: 40px;
  display: flex;
  align-items: center;
  justify-content: center;
  font-size: 14px;
  font-weight: 500;
  border-radius: 8px;
  transition: all 0.3s ease;
  
  &::after { border: none; }
  
  &.deny {
    background-color: transparent;
    border: 1px solid #d1d5db;
    color: #4b5563;
    
    :deep(.dark) & {
      border-color: #374151;
      color: #9ca3af;
    }
  }
  
  &.approve {
    background-color: #6C9BD2;
    color: #ffffff;
    box-shadow: 0 1px 2px rgba(108, 155, 210, 0.3);
  }
  
  &:active {
    opacity: 0.8;
    transform: scale(0.98);
  }
}
</style>

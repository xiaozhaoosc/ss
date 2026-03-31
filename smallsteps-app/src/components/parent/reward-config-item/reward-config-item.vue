<template>
  <view class="reward-item" :class="{ 'disabled': !modelValue }">
    <!-- Icon -->
    <view class="icon-box">
      <text class="material-symbols-outlined">{{ icon }}</text>
    </view>
    
    <!-- Info -->
    <view class="info">
      <text class="name">{{ name }}</text>
      <view class="cost">
        <text class="material-symbols-outlined star-icon">star</text>
        <text class="cost-text">{{ points }} 颗星</text>
      </view>
    </view>
    
    <!-- Toggle -->
    <view class="switch-box">
      <switch :checked="modelValue" color="#6C9BD2" @change="handleChange" />
    </view>
  </view>
</template>

<script setup>
const props = defineProps({
  name: String,
  points: [Number, String],
  icon: String,
  modelValue: Boolean
})

const emit = defineEmits(['update:modelValue'])

const handleChange = (e) => {
  emit('update:modelValue', e.detail.value)
}
</script>

<style lang="scss" scoped>
.reward-item {
  display: flex;
  align-items: center;
  gap: 16px;
  padding: 16px;
  background-color: #ffffff;
  border-radius: 12px;
  border: 1px solid transparent;
  box-shadow: 0 1px 3px rgba(0, 0, 0, 0.05);
  transition: all 0.3s ease;
  
  :deep(.dark) & {
    background-color: #1e242b;
  }
}

.disabled {
  opacity: 0.6;
}

.icon-box {
  width: 48px;
  height: 48px;
  border-radius: 12px;
  background-color: #f1f5f9;
  display: flex;
  align-items: center;
  justify-content: center;
  flex-shrink: 0;
  color: #6C9BD2;
  
  :deep(.dark) & {
    background-color: #1f2937;
    color: #9ca3af;
  }
  
  .material-symbols-outlined {
    font-size: 24px;
  }
}

.info {
  flex: 1;
  display: flex;
  flex-direction: column;
  gap: 4px;
  min-width: 0;
}

.name {
  font-size: 16px;
  font-weight: 500;
  color: #111827;
  overflow: hidden;
  text-overflow: ellipsis;
  white-space: nowrap;
  
  :deep(.dark) & {
    color: #ffffff;
  }
}

.cost {
  display: flex;
  align-items: center;
  gap: 4px;
}

.star-icon {
  font-size: 14px;
  color: #f59e0b;
}

.cost-text {
  font-size: 12px;
  color: #6b7280;
  
  :deep(.dark) & {
    color: #9ca3af;
  }
}

.switch-box {
  transform: scale(0.8);
  margin-right: -4px;
}
</style>

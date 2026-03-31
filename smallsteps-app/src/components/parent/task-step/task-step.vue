<template>
  <view class="task-step" :class="{ 'dragging': isDragging }">
    <view class="drag-handle">
      <text class="material-symbols-outlined icon">drag_indicator</text>
    </view>
    
    <view class="step-content">
      <text class="step-title">{{ title }}</text>
      <text class="step-desc">{{ description }}</text>
    </view>
    
    <view class="actions">
      <button class="action-btn" @click="$emit('edit')">
        <text class="material-symbols-outlined icon">edit</text>
      </button>
      <button class="action-btn delete" @click="$emit('delete')">
        <text class="material-symbols-outlined icon">delete</text>
      </button>
    </view>
  </view>
</template>

<script setup>
defineProps({
  title: String,
  description: String,
  isDragging: Boolean
})

defineEmits(['edit', 'delete'])
</script>

<style lang="scss" scoped>
.task-step {
  display: flex;
  align-items: center;
  gap: 12px;
  padding: 12px;
  background-color: #ffffff;
  border-radius: 8px;
  border: 1px solid transparent;
  box-shadow: 0 1px 3px rgba(0, 0, 0, 0.05);
  transition: all 0.3s ease;
  
  :deep(.dark) & {
    background-color: #1e242b;
  }
  
  &:active {
    background-color: #f9fafb;
    border-color: rgba(108, 155, 210, 0.2);
    
    :deep(.dark) & {
      background-color: #242b35;
    }
  }
}

.drag-handle {
  display: flex;
  align-items: center;
  justify-content: center;
  color: #9ca3af;
  
  .icon {
    font-size: 24px;
  }
  
  &:active {
    color: #6C9BD2;
  }
}

.step-content {
  flex: 1;
  min-width: 0;
  display: flex;
  flex-direction: column;
}

.step-title {
  font-size: 14px;
  font-weight: 600;
  color: #111827;
  overflow: hidden;
  text-overflow: ellipsis;
  white-space: nowrap;
  
  :deep(.dark) & {
    color: #ffffff;
  }
}

.step-desc {
  font-size: 12px;
  color: #6b7280;
  overflow: hidden;
  text-overflow: ellipsis;
  white-space: nowrap;
  margin-top: 2px;
}

.actions {
  display: flex;
  gap: 4px;
}

.action-btn {
  width: 32px;
  height: 32px;
  padding: 0;
  margin: 0;
  background: transparent;
  border-radius: 999px;
  display: flex;
  align-items: center;
  justify-content: center;
  color: #6b7280;
  
  &::after {
    border: none;
  }
  
  &:active {
    background-color: #f3f4f6;
    
    :deep(.dark) & {
      background-color: #374151;
    }
  }
  
  .icon {
    font-size: 18px;
  }
  
  &.delete:active {
    color: #ef4444;
  }
}
</style>

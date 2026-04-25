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
  gap: 16px;
  padding: 16px 20px;
  background: linear-gradient(135deg, #ffffff 0%, #f9fbff 100%);
  border-radius: 20px;
  border: 1px solid rgba(108, 155, 210, 0.1);
  box-shadow: 0 8px 24px rgba(149, 157, 165, 0.08);
  transition: all 0.4s cubic-bezier(0.175, 0.885, 0.32, 1.275);
  margin-bottom: 4px;
  
  :deep(.dark) & {
    background: linear-gradient(135deg, #1e242b 0%, #242b35 100%);
    border-color: rgba(255, 255, 255, 0.05);
    box-shadow: 0 8px 24px rgba(0, 0, 0, 0.2);
  }
  
  &:active {
    transform: scale(0.97);
    background: #ffffff;
    box-shadow: 0 4px 12px rgba(108, 155, 210, 0.15);
    
    :deep(.dark) & {
      background: #2a323d;
    }
  }
}

.drag-handle {
  display: flex;
  align-items: center;
  justify-content: center;
  color: #bdc3c7;
  width: 24px;
  
  .icon {
    font-size: 24px;
    font-weight: 300;
  }
}

.step-content {
  flex: 1;
  min-width: 0;
  display: flex;
  flex-direction: column;
}

.step-title {
  font-size: 16px;
  font-weight: 700;
  color: #2c3e50;
  line-height: 1.4;
  
  :deep(.dark) & {
    color: #e0e6ed;
  }
}

.step-desc {
  font-size: 13px;
  color: #7f8c8d;
  margin-top: 4px;
  line-height: 1.5;
  display: -webkit-box;
  -webkit-box-orient: vertical;
  -webkit-line-clamp: 1;
  overflow: hidden;
  
  :deep(.dark) & {
    color: #94a3b8;
  }
}

.actions {
  display: flex;
  gap: 8px;
}

.action-btn {
  width: 36px;
  height: 36px;
  padding: 0;
  margin: 0;
  background: rgba(108, 155, 210, 0.05);
  border-radius: 12px;
  display: flex;
  align-items: center;
  justify-content: center;
  color: #64748b;
  transition: all 0.2s ease;
  
  &::after {
    border: none;
  }
  
  &:active {
    background-color: rgba(108, 155, 210, 0.15);
    color: #6C9BD2;
    transform: translateY(-2px);
  }
  
  .icon {
    font-size: 20px;
  }
  
  &.delete:active {
    background-color: rgba(239, 68, 68, 0.1);
    color: #ef4444;
  }
}
</style>

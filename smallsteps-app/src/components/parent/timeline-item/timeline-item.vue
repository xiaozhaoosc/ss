<template>
  <view class="timeline-item" :class="[status, { last: isLast }]">
    <!-- Icon Node -->
    <view class="node" :class="status">
      <text class="material-symbols-outlined">{{ icon }}</text>
    </view>
    
    <!-- Content Card -->
    <view class="card" :class="status">
      <view class="header">
        <text class="time">{{ time }}</text>
        <view class="status-badge" :class="status">
          {{ statusText }}
        </view>
      </view>
      
      <text class="title">{{ title }}</text>
      <text class="description">{{ description }}</text>
      
      <!-- Optional Attachment -->
      <view v-if="attachment" class="attachment" @click="handleAttachment">
        <image v-if="attachment.image" class="thumb" :src="attachment.image" mode="aspectFill" />
        <text class="file-name">{{ attachment.name }}</text>
      </view>
    </view>
  </view>
</template>

<script setup>
import { computed } from 'vue'

const props = defineProps({
  time: String,
  title: String,
  description: String,
  status: {
    type: String,
    default: 'upcoming' // completed, in-progress, upcoming
  },
  icon: String,
  attachment: Object,
  isLast: Boolean
})

const statusText = computed(() => {
  const map = {
    'completed': '已完成',
    'in-progress': '进行中',
    'upcoming': '待开始'
  }
  return map[props.status] || '待开始'
})

const handleAttachment = () => {
  if (props.attachment?.url) {
    uni.navigateTo({
      url: `/pages/common/webview/index?url=${encodeURIComponent(props.attachment.url)}`
    })
  }
}
</script>

<style lang="scss" scoped>
.timeline-item {
  display: flex;
  gap: 16px;
  margin-bottom: 24px;
  position: relative;
  
  // Vertical Connector Line
  &::before {
    content: '';
    position: absolute;
    left: 15px; // Center of node
    top: 32px;
    bottom: -24px;
    width: 2px;
    background-color: #e5e7eb;
    border-radius: 999px;
    
    :deep(.dark) & {
      background-color: #374151;
    }
  }
  
  &.last::before {
    display: none;
  }
}

.node {
  z-index: 10;
  margin-top: 4px;
  width: 32px;
  height: 32px;
  flex-shrink: 0;
  display: flex;
  align-items: center;
  justify-content: center;
  border-radius: 999px;
  background-color: #ffffff;
  box-shadow: 0 0 0 4px #f6f7f8;
  
  :deep(.dark) & {
    box-shadow: 0 0 0 4px #121720;
  }
  
  .material-symbols-outlined {
    font-size: 16px;
  }
  
  &.completed {
    background-color: #dbeafe;
    color: #6C9BD2;
    
    :deep(.dark) & {
      background-color: #1e3a8a;
    }
  }
  
  &.in-progress {
    background-color: #6C9BD2;
    color: #ffffff;
    box-shadow: 0 0 0 4px #f6f7f8, 0 4px 12px rgba(108, 155, 210, 0.3);
    
    :deep(.dark) & {
      box-shadow: 0 0 0 4px #121720, 0 4px 12px rgba(108, 155, 210, 0.3);
    }
  }
  
  &.upcoming {
    background-color: #f3f4f6;
    color: #9ca3af;
    
    :deep(.dark) & {
      background-color: #374151;
    }
  }
}

.card {
  flex: 1;
  display: flex;
  flex-direction: column;
  padding: 16px;
  border-radius: 12px;
  background-color: #ffffff;
  border: 1px solid #f3f4f6;
  box-shadow: 0 1px 2px rgba(0, 0, 0, 0.05);
  transition: all 0.3s ease;
  
  :deep(.dark) & {
    background-color: #1e242b;
    border-color: #1f2937;
  }
  
  &.in-progress {
    border-left: 4px solid #6C9BD2;
    box-shadow: 0 4px 12px rgba(0, 0, 0, 0.05);
  }
  
  &.upcoming {
    border-style: dashed;
    border-color: #d1d5db;
    opacity: 0.6;
    
    :deep(.dark) & {
      border-color: #374151;
    }
  }
}

.header {
  display: flex;
  justify-content: space-between;
  align-items: flex-start;
  margin-bottom: 4px;
}

.time {
  color: #6C9BD2;
  font-size: 14px;
  font-weight: 700;
}

.status-badge {
  font-size: 12px;
  font-weight: 500;
  padding: 2px 8px;
  border-radius: 4px;
  background-color: #f9fafb;
  color: #9ca3af;
  
  :deep(.dark) & {
    background-color: #1f2937;
  }
  
  &.in-progress {
    background-color: #fff7ed;
    color: #f97316;
    font-weight: 700;
    animation: animate-pulse 2s infinite;
    
    :deep(.dark) & {
      background-color: rgba(124, 45, 18, 0.2);
    }
  }
}

.title {
  color: #111827;
  font-size: 16px;
  font-weight: 700;
  
  :deep(.dark) & {
    color: #ffffff;
  }
}

.description {
  color: #6b7280;
  font-size: 14px;
  margin-top: 4px;
  
  :deep(.dark) & {
    color: #9ca3af;
  }
}

.attachment {
  display: flex;
  align-items: center;
  gap: 8px;
  margin-top: 12px;
  cursor: pointer;
  
  .thumb {
    width: 40px;
    height: 40px;
    border-radius: 6px;
  }
  
  .file-name {
    font-size: 12px;
    color: #6b7280;
    
    :deep(.dark) & {
      color: #9ca3af;
    }
  }
}

@keyframes animate-pulse {
  0% { opacity: 1; }
  50% { opacity: 0.6; }
  100% { opacity: 1; }
}
</style>

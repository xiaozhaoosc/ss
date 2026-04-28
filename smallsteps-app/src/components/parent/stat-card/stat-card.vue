<template>
  <view class="stat-card" hover-class="stat-card-hover" :hover-stay-time="100">
    <view class="header">
      <view class="icon-box" :class="colorClass">
        <text class="material-symbols-outlined">{{ icon }}</text>
      </view>
      <text v-if="trend" class="trend-badge" :class="trendClass">
        {{ trend > 0 ? '+' : '' }}{{ trend }}{{ unit }}
      </text>
    </view>
    <view class="body">
      <text class="label">{{ label }}</text>
      <view class="value-container">
        <text class="value">{{ value }}</text>
        <text v-if="total" class="total">/ {{ total }}</text>
        <text v-if="unit && !total" class="unit">{{ unit }}</text>
      </view>
    </view>
  </view>
</template>

<script setup>
import { computed } from 'vue'

const props = defineProps({
  icon: String,
  label: String,
  value: [String, Number],
  total: [String, Number],
  unit: String,
  trend: Number,
  type: {
    type: String,
    default: 'blue' // blue, purple, indigo, green, red
  }
})

const colorClass = computed(() => {
  const map = {
    blue: 'bg-blue-50 text-blue-600 dark:bg-blue-900/20 dark:text-blue-400',
    purple: 'bg-purple-50 text-purple-600 dark:bg-purple-900/20 dark:text-purple-400',
    indigo: 'bg-indigo-50 text-indigo-600 dark:bg-indigo-900/20 dark:text-indigo-400',
    green: 'bg-green-50 text-green-600 dark:bg-green-900/20 dark:text-green-400',
    red: 'bg-red-50 text-red-600 dark:bg-red-900/20 dark:text-red-400'
  }
  return map[props.type] || map.blue
})

const trendClass = computed(() => {
  if (!props.trend) return ''
  return props.trend > 0 
    ? 'text-green-600 bg-green-50 dark:text-green-400 dark:bg-green-900/20' 
    : 'text-red-500 bg-red-50 dark:text-red-400 dark:bg-red-900/20'
})
</script>

<style lang="scss" scoped>
.stat-card {
  display: flex;
  min-width: 160px;
  flex-direction: column;
  gap: 12px;
  border-radius: 16px;
  padding: 20px;
  background-color: #ffffff;
  box-shadow: 0 1px 2px rgba(0, 0, 0, 0.05);
  border: 1px solid #f3f4f6;
  position: relative;
  
  :deep(.dark) & {
    background-color: #1e242b;
    border-color: #1f2937;
  }
}

.stat-card-hover {
  transform: scale(0.96);
  background-color: #f9fafb !important;
  border-color: #6C9BD2 !important;
  
  :deep(.dark) & {
    background-color: #242b33 !important;
  }
}

.header {
  display: flex;
  justify-content: space-between;
  align-items: flex-start;
}

.icon-box {
  padding: 8px;
  border-radius: 8px;
  display: flex;
  align-items: center;
  justify-content: center;
  
  .material-symbols-outlined {
    font-size: 20px;
  }
}

.trend-badge {
  font-size: 12px;
  font-weight: 700;
  padding: 4px 8px;
  border-radius: 999px;
}

.body {
  .label {
    color: #6b7280;
    font-size: 14px;
    font-weight: 500;
    
    :deep(.dark) & {
      color: #9ca3af;
    }
  }
}

.value-container {
  display: flex;
  align-items: baseline;
  gap: 4px;
}

.value {
  color: #111827;
  font-size: 24px;
  font-weight: 700;
  
  :deep(.dark) & {
    color: #ffffff;
  }
}

.total, .unit {
  font-size: 14px;
  font-weight: 400;
  color: #9ca3af;
}
</style>

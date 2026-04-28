<template>
  <view class="heatmap-container">
    <view class="heatmap-header">
      <text class="title">本周成长热力图</text>
      <view class="legend">
        <view v-for="i in 5" :key="i" class="legend-item">
          <view class="color-box" :class="`level-${i-1}`"></view>
        </view>
      </view>
    </view>
    
    <view class="heatmap-grid">
      <view v-for="(day, index) in data" :key="index" class="day-cell">
        <view 
          class="cell-box" 
          :class="[`level-${day.level}`, { active: activeIndex === index }]"
          @click="handleDayClick(index)"
        >
          <text class="day-label">{{ day.day }}</text>
        </view>
      </view>
    </view>
    
    <view v-if="activeDay" class="day-detail fade-in">
      <view class="detail-indicator" :class="`level-${activeDay.level}`"></view>
      <view class="detail-content">
        <text class="detail-status">{{ activeDay.status }}</text>
        <text class="detail-hint">当日表现评价</text>
      </view>
    </view>
  </view>
</template>

<script setup lang="ts">
import { ref, computed } from 'vue'

const props = defineProps<{
  data: Array<{
    day: string,
    level: number,
    status: string
  }>
}>()

const activeIndex = ref(new Date().getDay() - 1)
if (activeIndex.value < 0) activeIndex.value = 6 // Sunday

const handleDayClick = (index: number) => {
  activeIndex.value = index
}

const activeDay = computed(() => props.data[activeIndex.value])
</script>

<style lang="scss" scoped>
.heatmap-container {
  background: #ffffff;
  border-radius: 20px;
  padding: 20px;
  margin: 16px;
  box-shadow: 0 4px 12px rgba(0, 0, 0, 0.05);
  
  .dark & {
    background: #1e242b;
  }
}

.heatmap-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-bottom: 20px;
}

.title {
  font-size: 16px;
  font-weight: 700;
  color: #111827;
  .dark & { color: #fff; }
}

.legend {
  display: flex;
  gap: 4px;
}

.color-box {
  width: 12px;
  height: 12px;
  border-radius: 3px;
}

.heatmap-grid {
  display: flex;
  justify-content: space-between;
  margin-bottom: 24px;
}

.day-cell {
  flex: 1;
  display: flex;
  justify-content: center;
}

.cell-box {
  width: 40px;
  height: 48px;
  border-radius: 10px;
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
  transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
  position: relative;
  
  &.active {
    transform: scale(1.1);
    box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
    z-index: 2;
    
    &::after {
      content: '';
      position: absolute;
      bottom: -6px;
      width: 4px;
      height: 4px;
      border-radius: 50%;
      background: #6C9BD2;
    }
  }
}

.day-label {
  font-size: 10px;
  font-weight: 600;
  color: #6b7280;
  margin-bottom: 4px;
}

/* Heatmap Levels */
.level-0 { background-color: #f3f4f6; .dark & { background-color: #374151; } }
.level-1 { background-color: #dbeafe; color: #1e40af; }
.level-2 { background-color: #93c5fd; color: #1e40af; }
.level-3 { background-color: #60a5fa; color: #ffffff; }
.level-4 { background-color: #2563eb; color: #ffffff; }

.day-detail {
  display: flex;
  align-items: center;
  gap: 12px;
  padding: 12px;
  background: #f9fafb;
  border-radius: 12px;
  
  .dark & {
    background: #262c35;
  }
}

.detail-indicator {
  width: 8px;
  height: 32px;
  border-radius: 4px;
}

.detail-content {
  display: flex;
  flex-direction: column;
}

.detail-status {
  font-size: 14px;
  font-weight: 700;
  color: #111827;
  .dark & { color: #fff; }
}

.detail-hint {
  font-size: 11px;
  color: #6b7280;
}

.fade-in {
  animation: fadeIn 0.4s ease-out;
}

@keyframes fadeIn {
  from { opacity: 0; transform: translateY(4px); }
  to { opacity: 1; transform: translateY(0); }
}
</style>

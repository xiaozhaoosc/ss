<template>
  <view 
    class="template-card" 
    :style="{ '--bg-soft': bgColor + '15' }"
    @click="onClick"
    hover-class="card-hover"
    hover-stay-time="100"
  >
    <view class="icon-section" :style="{ backgroundColor: bgColor + '20' }">
      <text class="icon">{{ icon }}</text>
    </view>
    
    <view class="info-section">
      <view class="title-row">
        <text class="title">{{ title }}</text>
      </view>
      
      <view class="tags-row">
        <text v-for="(tag, index) in tags" :key="index" class="tag">{{ tag }}</text>
      </view>
      
      <view class="footer-row">
        <view class="step-badge">
          <text class="material-symbols-outlined s-icon">format_list_bulleted</text>
          <text>{{ stepCount }} 步</text>
        </view>
        <text class="use-count" v-if="useCount">{{ useCount }} 人使用</text>
      </view>
    </view>
    
    <view class="arrow-box">
      <text class="material-symbols-outlined arrow">chevron_right</text>
    </view>
  </view>
</template>

<script setup lang="ts">
const props = defineProps({
  id: [String, Number],
  title: String,
  bgColor: { type: String, default: '#6C9BD2' },
  icon: { type: String, default: '📚' },
  tags: { type: Array as () => string[], default: () => [] },
  stepCount: { type: Number, default: 0 },
  useCount: { type: Number, default: 0 }
})

const emit = defineEmits(['click'])
const onClick = () => emit('click', props.id)
</script>

<style lang="scss" scoped>
.template-card {
  display: flex;
  background: #ffffff;
  border-radius: 20px;
  padding: 16px;
  margin-bottom: 16px;
  border: 1px solid rgba(108, 155, 210, 0.1);
  box-shadow: 0 4px 20px rgba(108, 155, 210, 0.04);
  position: relative;
  transition: all 0.2s ease;
  
  :deep(.dark) & {
    background: rgba(30, 41, 59, 0.7);
    border-color: rgba(255, 255, 255, 0.1);
  }
}

.card-hover {
  transform: scale(0.98);
  background: #f8fbff;
  border-color: #6C9BD2;
}

.icon-section {
  width: 72px;
  height: 72px;
  border-radius: 18px;
  display: flex;
  align-items: center;
  justify-content: center;
  margin-right: 16px;
  
  .icon {
    font-size: 32px;
  }
}

.info-section {
  flex: 1;
  display: flex;
  flex-direction: column;
  justify-content: space-between;
}

.title {
  font-size: 17px;
  font-weight: 800;
  color: #1e293b;
  margin-bottom: 6px;
  
  :deep(.dark) & {
    color: #f1f5f9;
  }
}

.tags-row {
  display: flex;
  flex-wrap: wrap;
  gap: 6px;
  margin-bottom: 12px;
}

.tag {
  font-size: 11px;
  font-weight: 600;
  color: #6C9BD2;
  background: rgba(108, 155, 210, 0.1);
  padding: 2px 8px;
  border-radius: 6px;
}

.footer-row {
  display: flex;
  align-items: center;
  gap: 12px;
}

.step-badge {
  display: flex;
  align-items: center;
  gap: 4px;
  font-size: 12px;
  font-weight: 700;
  color: #64748b;
  
  .s-icon {
    font-size: 16px;
    color: #94a3b8;
  }
}

.use-count {
  font-size: 12px;
  color: #94a3b8;
}

.arrow-box {
  display: flex;
  align-items: center;
  padding-left: 8px;
  
  .arrow {
    color: #cbd5e1;
    font-size: 24px;
  }
}
</style>

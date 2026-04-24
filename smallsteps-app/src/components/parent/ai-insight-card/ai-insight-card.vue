<template>
  <view class="insight-card" @click="$emit('click')">
    <view class="insight-header">
      <view class="ai-badge">
        <text class="material-symbols-outlined ai-icon">magic_button</text>
        <text class="ai-text">AI 观察者建议</text>
      </view>
      <text class="insight-time">刚刚</text>
    </view>
    <view class="insight-content">
      <text class="insight-text">{{ content }}</text>
    </view>
    <view class="insight-footer">
      <view class="action-hint">
        <text class="hint-text">点击了解更多行为干预建议</text>
        <view class="weekly-btn" @click.stop="$emit('viewWeekly')">
          <text class="btn-text">查看周报</text>
          <text class="material-symbols-outlined arrow-icon">arrow_forward_ios</text>
        </view>
      </view>
    </view>
    
    <!-- 背景装饰图 -->
    <view class="bg-decor pulse"></view>
  </view>
</template>

<script setup lang="ts">
defineProps<{
  content: string
}>()

defineEmits(['click', 'viewWeekly'])
</script>

<style lang="scss" scoped>
.insight-card {
  position: relative;
  margin: 16px;
  padding: 20px;
  background: linear-gradient(135deg, #6C9BD2 0%, #8EADFF 100%);
  border-radius: 24px;
  overflow: hidden;
  box-shadow: 0 10px 20px rgba(108, 155, 210, 0.3);
}

.insight-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-bottom: 12px;
}

.ai-badge {
  display: flex;
  align-items: center;
  gap: 6px;
  background: rgba(255, 255, 255, 0.2);
  padding: 4px 10px;
  border-radius: 999px;
  backdrop-filter: blur(4px);
}

.ai-icon {
  font-size: 16px;
  color: white;
}

.ai-text {
  font-size: 11px;
  font-weight: 700;
  color: white;
  letter-spacing: 0.5px;
}

.insight-time {
  font-size: 11px;
  color: rgba(255, 255, 255, 0.8);
}

.insight-content {
  margin-bottom: 16px;
  position: relative;
  z-index: 1;
}

.insight-text {
  font-size: 15px;
  line-height: 1.6;
  color: white;
  font-weight: 500;
}

.insight-footer {
  border-top: 1px solid rgba(255, 255, 255, 0.1);
  padding-top: 12px;
  position: relative;
  z-index: 1;
}

.action-hint {
  display: flex;
  align-items: center;
  justify-content: space-between;
}

.hint-text {
  font-size: 12px;
  color: rgba(255, 255, 255, 0.9);
}

.weekly-btn {
  display: flex;
  align-items: center;
  gap: 4px;
  background: rgba(255, 255, 255, 0.3);
  padding: 4px 10px;
  border-radius: 6px;
}

.btn-text {
  font-size: 11px;
  font-weight: 700;
  color: white;
}

.arrow-icon {
  font-size: 10px;
  color: white;
}

.bg-decor {
  position: absolute;
  top: -20px;
  right: -20px;
  width: 100px;
  height: 100px;
  background: radial-gradient(circle, rgba(255,255,255,0.2) 0%, rgba(255,255,255,0) 70%);
  border-radius: 50%;
}

@keyframes pulse {
  0% { transform: scale(1); opacity: 0.5; }
  50% { transform: scale(1.2); opacity: 0.8; }
  100% { transform: scale(1); opacity: 0.5; }
}

.pulse {
  animation: pulse 4s infinite ease-in-out;
}
</style>

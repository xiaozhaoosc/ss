<template>
  <view class="report-card">
    <view class="report-header">
      <view class="ai-badge">
        <text class="material-symbols-outlined ai-icon">psychology</text>
        <text class="ai-text">AI 深度洞察</text>
      </view>
    </view>
    
    <view class="report-body">
      <mp-html :content="formattedContent" />
    </view>
    
    <view class="report-footer">
      <text class="footer-note">基于本周 {{ taskCount }} 次任务与 {{ emotionCount }} 次交互分析生成</text>
    </view>
  </view>
</template>

<script setup lang="ts">
import { computed } from 'vue'
import mpHtml from 'mp-html/dist/uni-app/components/mp-html/mp-html'

const props = defineProps<{
  content: string,
  taskCount: number,
  emotionCount: number
}>()

// Simple markdown to html conversion or just trust mp-html handles basic MD
const formattedContent = computed(() => {
  return props.content
    .replace(/### (.*)/g, '<h3>$1</h3>')
    .replace(/\*\*(.*)\*\*/g, '<strong>$1</strong>')
    .replace(/- (.*)/g, '<li>$1</li>')
    .replace(/\n/g, '<br/>')
})
</script>

<style lang="scss" scoped>
.report-card {
  background: #ffffff;
  border-radius: 20px;
  padding: 24px;
  margin: 16px;
  box-shadow: 0 4px 12px rgba(0, 0, 0, 0.05);
  border: 1px solid #f3f4f6;
  
  :deep(.dark) & {
    background: #1e242b;
    border-color: #374151;
  }
}

.report-header {
  margin-bottom: 20px;
}

.ai-badge {
  display: inline-flex;
  align-items: center;
  gap: 8px;
  background: #EEF2FF;
  padding: 6px 12px;
  border-radius: 8px;
  
  :deep(.dark) & {
    background: rgba(99, 102, 241, 0.1);
  }
}

.ai-icon {
  font-size: 20px;
  color: #6366F1;
}

.ai-text {
  font-size: 13px;
  font-weight: 700;
  color: #4F46E5;
  
  :deep(.dark) & { color: #818CF8; }
}

.report-body {
  font-size: 14px;
  line-height: 1.8;
  color: #374151;
  
  :deep(.dark) & { color: #e5e7eb; }
  
  :deep(h3) {
    font-size: 16px;
    font-weight: 700;
    margin: 16px 0 8px;
    color: #111827;
    :deep(.dark) & { color: #fff; }
  }
  
  :deep(li) {
    margin-bottom: 8px;
  }
}

.report-footer {
  margin-top: 24px;
  padding-top: 16px;
  border-top: 1px dashed #e5e7eb;
  
  :deep(.dark) & { border-color: #374151; }
}

.footer-note {
  font-size: 11px;
  color: #9ca3af;
}
</style>

<template>
  <view class="emotion-kit-page" :class="{ 'dark': isDarkMode }">
    <view class="header">
      <button class="back-btn" @click="handleBack">
        <text class="material-symbols-outlined icon">arrow_back</text>
      </button>
      <text class="page-title">情绪急救包</text>
      <view class="spacer"></view>
    </view>

    <scroll-view scroll-y class="main-content">
      <view v-if="kits.length === 0 && !isLoading" class="empty-state">
        <text class="material-symbols-outlined empty-icon">healing</text>
        <text class="empty-text">暂无内容</text>
        <text class="empty-desc">点击下方按钮添加第一个急救包！</text>
      </view>
      
      <view v-else class="kit-list">
        <view v-for="kit in kits" :key="kit.kitId" class="kit-card">
          <view class="kit-header">
             <text class="emotion-tag" :class="'emotion-' + kit.emotionType">{{ getEmotionLabel(kit.emotionType) }}</text>
             <text class="material-symbols-outlined action-icon">edit</text>
          </view>
          <text class="kit-content">{{ kit.content }}</text>
          <view v-if="kit.mediaUrl" class="media-hint">
            <text class="material-symbols-outlined media-icon">audiotrack</text>
            <text>含音频引导</text>
          </view>
          <button class="push-btn">推送到 StarBuddy</button>
        </view>
      </view>
      
      <!-- 加载状态占位 -->
      <view v-if="isLoading" class="loading-state">
        <text class="loading-text">加载中...</text>
      </view>

      <view class="fab-container">
        <button class="add-fab" @click="handleAdd">
          <text class="material-symbols-outlined fab-icon">add</text>
        </button>
      </view>
    </scroll-view>
  </view>
</template>

<script setup>
import { ref } from 'vue'
import { onShow } from '@dcloudio/uni-app'
import { listEmotionKits } from '@/api/emotion-kit'
import { useUserStore } from '@/store/modules/user'

const userStore = useUserStore()
const isDarkMode = ref(false)
const kits = ref([])
const isLoading = ref(false)

onShow(() => {
  loadKits()
})

const loadKits = async () => {
  const childId = userStore.currentChildId || 1
  isLoading.value = true
  try {
    const res = await listEmotionKits(childId)
    kits.value = res.data || []
  } catch (e) {
    console.error(e)
  } finally {
    isLoading.value = false
  }
}

const handleBack = () => {
  uni.navigateBack()
}

const handleAdd = () => {
  uni.showToast({ title: '添加急救包功能开发中', icon: 'none' })
}

const getEmotionLabel = (type) => {
  const labels = { '1': '开心', '2': '难过', '3': '愤怒', '4': '焦虑', '5': '平静' }
  return labels[type] || '未知'
}
</script>

<style lang="scss" scoped>
.emotion-kit-page {
  height: 100vh;
  display: flex;
  flex-direction: column;
  background-color: #f8fafc;
  position: relative;
  overflow: hidden;

  :deep(.dark) & { background-color: #101622; }
}

.header {
  display: flex;
  align-items: center;
  justify-content: space-between;
  padding: 24px 16px 16px 16px;
  padding-top: calc(24px + env(safe-area-inset-top));
  position: relative;
  z-index: 10;
  background-color: #f8fafc;
  :deep(.dark) & { background-color: #101622; }
}

.back-btn {
  width: 48px;
  height: 48px;
  border-radius: 999px;
  background-color: #f3f4f6;
  display: flex;
  align-items: center;
  justify-content: center;
  color: #1e293b;
  border: none;
  margin: 0;

  &::after { border: none; }

  :deep(.dark) & { background-color: #1e293b; color: #fff; }

  &:active { transform: scale(0.95); }
}

.page-title {
  font-size: 20px;
  font-weight: 900;
  color: #0f172a;
  :deep(.dark) & { color: #fff; }
}

.spacer { width: 48px; }

.main-content {
  flex: 1;
  position: relative;
  z-index: 10;
}

.empty-state {
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
  gap: 16px;
  padding-top: 100px;
}

.empty-icon {
  font-size: 80px;
  color: #9ca3af;
}

.empty-text {
  font-size: 20px;
  font-weight: 700;
  color: #374151;
  :deep(.dark) & { color: #d1d5db; }
}

.empty-desc {
  font-size: 14px;
  color: #6b7280;
  :deep(.dark) & { color: #9ca3af; }
}

.kit-list {
  padding: 16px;
  display: flex;
  flex-direction: column;
  gap: 16px;
}

.kit-card {
  background-color: #fff;
  border-radius: 20px;
  padding: 20px;
  box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.05);
  display: flex;
  flex-direction: column;
  gap: 12px;

  :deep(.dark) & { background-color: #1e293b; }
}

.kit-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
}

.emotion-tag {
  font-size: 12px;
  font-weight: 700;
  padding: 4px 12px;
  border-radius: 8px;
  
  &.emotion-1 { background-color: #fef9c3; color: #854d0e; } // 开心
  &.emotion-2 { background-color: #dbeafe; color: #1e40af; } // 难过
  &.emotion-3 { background-color: #fee2e2; color: #991b1b; } // 愤怒
  &.emotion-4 { background-color: #fef3c7; color: #92400e; } // 焦虑
  &.emotion-5 { background-color: #dcfce7; color: #166534; } // 平静
}

.action-icon {
  font-size: 20px;
  color: #94a3b8;
}

.kit-content {
  font-size: 16px;
  line-height: 1.6;
  color: #334155;
  :deep(.dark) & { color: #cbd5e1; }
}

.media-hint {
  display: flex;
  align-items: center;
  gap: 6px;
  font-size: 13px;
  color: #64748b;
  background-color: #f1f5f9;
  padding: 8px 12px;
  border-radius: 10px;
  width: fit-content;

  :deep(.dark) & { background-color: #334155; color: #94a3b8; }
}

.media-icon {
  font-size: 16px;
}

.push-btn {
  margin-top: 8px;
  background-color: #3b82f6;
  color: #fff;
  font-size: 15px;
  font-weight: 700;
  border-radius: 12px;
  padding: 8px;
  border: none;
  
  &::after { border: none; }

  &:active { transform: scale(0.98); opacity: 0.9; }
}

.fab-container {
  position: fixed;
  right: 20px;
  bottom: 40px;
  z-index: 100;
}

.add-fab {
  width: 60px;
  height: 60px;
  border-radius: 30px;
  background-color: #3b82f6;
  color: #fff;
  display: flex;
  align-items: center;
  justify-content: center;
  box-shadow: 0 10px 15px -3px rgba(59, 130, 246, 0.4);
  padding: 0;
  border: none;

  &::after { border: none; }

  &:active { transform: scale(0.9); }
}

.fab-icon {
  font-size: 32px;
}

.loading-state {
  padding: 20px;
  text-align: center;
}

.loading-text {
  font-size: 14px;
  color: #64748b;
}
</style>

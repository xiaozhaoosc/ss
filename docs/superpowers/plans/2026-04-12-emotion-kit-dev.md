# 情绪急救包 (Emotion Kit) 页面开发 Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** 实现「情绪急救包」功能。当家长在后台配置了针对不同情绪（如：愤怒、焦虑）的安抚策略（音频、文字引导、奖励）后，该模块允许家长查看、管理这些急救包，并模拟在紧急情况下如何推送给孩子。

**Architecture:** 
- **Backend:** 已经存在 `ParentEmotionKitController`，支持 CRUD 和按 `childId` 查询。
- **Frontend:** 修改 `smallsteps-app/src/pages/parent/emotion-kit/index.vue`。

**Tech Stack:** Uniapp, Vue 3, Pinia, Axios.

---

### Task 1: 前端 - 情绪急救包 API 封装

**Files:**
- Create: `smallsteps-app/src/api/emotion-kit.ts`

- [ ] **Step 1: Define and export Emotion Kit API methods**

```typescript
import request from '@/utils/request'

export interface EmotionKit {
    kitId?: number
    childId?: number
    emotionType?: string // 1: happy, 2: sad, 3: angry, 4: anxious, 5: neutral
    content?: string
    mediaUrl?: string
    status?: string
}

export function listEmotionKits(childId: number) {
    return request({
        url: `/parent/emotion-kit/child/${childId}`,
        method: 'GET'
    })
}

export function addEmotionKit(data: EmotionKit) {
    return request({
        url: '/parent/emotion-kit',
        method: 'POST',
        data: data
    })
}

export function updateEmotionKit(data: EmotionKit) {
    return request({
        url: '/parent/emotion-kit',
        method: 'PUT',
        data: data
    })
}

export function deleteEmotionKit(kitId: number) {
    return request({
        url: `/parent/emotion-kit/${kitId}`,
        method: 'DELETE'
    })
}
```

---

### Task 2: 前端 - 情绪急救包列表页面开发 (TDD 模式)

**Files:**
- Modify: `smallsteps-app/src/pages/parent/emotion-kit/index.vue`

- [ ] **Step 1: Write the failing UI state (Skeleton)**
修改页面模板，添加列表展示区域。

- [ ] **Step 2: Implement dynamic data fetching in `onShow`**
使用真实 API 获取当前孩子的情绪急救包。

```vue
<!-- Modify script setup -->
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

const getEmotionLabel = (type) => {
  const labels = { '1': '开心', '2': '难过', '3': '愤怒', '4': '焦虑', '5': '平静' }
  return labels[type] || '未知'
}
</script>
```

- [ ] **Step 3: Update Template for List View**
替换 `empty-state` 为真实的列表卡片。

```vue
<template>
  <view class="emotion-kit-page" :class="{ 'dark': isDarkMode }">
    <!-- Header -->
    <view class="header">...</view>

    <scroll-view scroll-y class="main-content">
      <view v-if="kits.length === 0 && !isLoading" class="empty-state">...</view>
      
      <view v-else class="kit-list">
        <view v-for="kit in kits" :key="kit.kitId" class="kit-card">
          <view class="kit-header">
             <text class="emotion-tag">{{ getEmotionLabel(kit.emotionType) }}</text>
             <text class="material-symbols-outlined action-icon">edit</text>
          </view>
          <text class="kit-content">{{ kit.content }}</text>
          <view v-if="kit.mediaUrl" class="media-hint">
            <text class="material-symbols-outlined">audiotrack</text>
            <text>含音频引导</text>
          </view>
          <button class="push-btn">推送到 StarBuddy</button>
        </view>
      </view>
      
      <button class="add-fab" @click="handleAdd">+</button>
    </scroll-view>
  </view>
</template>
```

---

### Task 3: 验证与提交

- [ ] **Step 1: Check build and syntax**
- [ ] **Step 2: Commit**

```bash
git add .
git commit -m "feat(app-parent): implement emotion kit list with real api integration"
```
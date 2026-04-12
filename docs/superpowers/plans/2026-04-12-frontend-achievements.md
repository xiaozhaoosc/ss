# 前端扩展模块真实 API 对接 Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** 继续移除移动端 App (smallsteps-app) 中的 Mock 数据，将「儿童成就页面」和「家长洞察页面 (成就板块)」连接到真实的后台 `/child/achievement` API。

**Architecture:** 基于 Uniapp + Vue 3 组合式 API (Setup)。通过 Pinia 的 userStore 获取当前用户的上下文，并在组件挂载时 (`onShow` 或 `onMounted`) 拉取真实数据更新响应式状态。

**Tech Stack:** Vue 3, Uniapp, Pinia, Axios

---

### Task 1: 儿童端 - 成就列表真实对接

**Files:**
- Modify: `smallsteps-app/src/pages/child/achievements/index.vue`

- [ ] **Step 1: Replace static empty state with dynamic data fetching**

```vue
<!-- Modify the <script setup> block and add v-for logic in smallsteps-app/src/pages/child/achievements/index.vue -->
<script setup>
import { ref } from 'vue'
import { onShow } from '@dcloudio/uni-app'
import ChildBottomNav from '@/components/child/child-bottom-nav/child-bottom-nav.vue'
import { listChildAchievement } from '@/api/child'
import { useUserStore } from '@/store/modules/user'

const userStore = useUserStore()
const isDarkMode = ref(false)
const achievements = ref([])

const handleBack = () => {
  uni.navigateBack()
}

onShow(() => {
  loadAchievements()
})

const loadAchievements = () => {
  const childId = userStore.id || 1
  listChildAchievement(childId).then(res => {
    // Assuming standard response format res.data or res.rows
    const list = res.data || res.rows || []
    achievements.value = list.map(item => ({
      id: item.achievementId,
      title: item.achievementName || '新成就',
      desc: item.description || '完成了一个里程碑',
      date: item.obtainTime ? item.obtainTime.substring(0, 10) : '刚刚'
    }))
  }).catch(err => {
    console.error('Failed to fetch achievements:', err)
  })
}
</script>

<template>
  <view class="achievements-page" :class="{ 'dark': isDarkMode }">
    <view class="header">
      <button class="back-btn" @click="handleBack">
        <text class="material-symbols-outlined icon">arrow_back</text>
      </button>
      <text class="page-title">我的成就</text>
      <view class="spacer"></view>
    </view>

    <scroll-view scroll-y class="main-content">
      <view v-if="achievements.length === 0" class="empty-state">
        <text class="material-symbols-outlined empty-icon">star</text>
        <text class="empty-text">暂无成就</text>
        <text class="empty-desc">完成任务后可以获得成就哦！</text>
      </view>
      
      <view v-else class="achievement-list">
        <view v-for="item in achievements" :key="item.id" class="ach-card">
           <view class="ach-icon"><text class="material-symbols-outlined">military_tech</text></view>
           <view class="ach-info">
             <text class="ach-title">{{ item.title }}</text>
             <text class="ach-desc">{{ item.desc }}</text>
           </view>
           <text class="ach-date">{{ item.date }}</text>
        </view>
      </view>
    </scroll-view>

    <view class="bg-gradient"></view>
    <child-bottom-nav active="home" />
  </view>
</template>

<style lang="scss" scoped>
/* Keep existing styles and append these */
.achievement-list {
  display: flex;
  flex-direction: column;
  gap: 16px;
  padding: 16px;
  width: 100%;
}
.ach-card {
  display: flex;
  align-items: center;
  gap: 16px;
  background: rgba(255, 255, 255, 0.9);
  padding: 16px;
  border-radius: 16px;
  box-shadow: 0 4px 12px rgba(0,0,0,0.05);
}
.ach-icon {
  width: 48px;
  height: 48px;
  border-radius: 50%;
  background: #fef3c7;
  color: #f59e0b;
  display: flex;
  align-items: center;
  justify-content: center;
  .material-symbols-outlined { font-size: 28px; }
}
.ach-info {
  flex: 1;
  display: flex;
  flex-direction: column;
  .ach-title { font-weight: bold; font-size: 16px; color: #1e293b; }
  .ach-desc { font-size: 12px; color: #64748b; margin-top: 4px; }
}
.ach-date { font-size: 12px; color: #94a3b8; }
</style>
```

- [ ] **Step 2: Commit changes**

```bash
git add smallsteps-app/src/pages/child/achievements/index.vue
git commit -m "feat(app-child): connect achievement list to real api"
```

---

### Task 2: 家长端 - 洞察页面 (成就板块) 真实对接

**Files:**
- Modify: `smallsteps-app/src/pages/parent/insights/index.vue`

- [ ] **Step 1: Replace mocked achievement array with API fetch**

Modify `<script setup>` in `smallsteps-app/src/pages/parent/insights/index.vue`:
```javascript
import { ref } from 'vue'
import { onShow } from '@dcloudio/uni-app'
import BottomNav from '@/components/common/bottom-nav/bottom-nav.vue'
import { listChildAchievement } from '@/api/child'
import { useUserStore } from '@/store/modules/user'

const userStore = useUserStore()

// Keep abilityData mocked until backend API is ready
const abilityData = ref([
  { label: '数学', value: 65 },
  { label: '社交', value: 42 },
  { label: '专注', value: 85 },
  { label: '创造', value: 30 }
])

const achievements = ref([])

onShow(() => {
  loadData()
})

const loadData = () => {
  // Assuming the parent views their current primary child's info
  // Wait for dynamic child switching in future, for now fallback to 1
  const childId = userStore.currentChildId || 1 
  
  listChildAchievement(childId).then(res => {
    const list = res.data || res.rows || []
    achievements.value = list.map((item, index) => ({
      id: item.achievementId,
      title: item.achievementName || '新成就',
      desc: item.description || '完成了一个阶段性目标',
      date: item.obtainTime ? item.obtainTime.substring(5, 10) : '今日', // like "10-12"
      icon: index % 2 === 0 ? '🏆' : '🌟', // dynamic based on type if possible
      bgColor: index % 2 === 0 ? '#fef3c7' : '#e0f2fe'
    }))
  }).catch(err => {
    console.error('Failed to load insights achievements:', err)
  })
}

const getEmotionColor = (day) => {
  const colors = ['#6b9bd1', '#fbbf24', '#d1d5db']
  return colors[day % 3]
}
```

- [ ] **Step 2: Commit changes**

```bash
git add smallsteps-app/src/pages/parent/insights/index.vue
git commit -m "feat(app-parent): connect insights achievements to real api"
```
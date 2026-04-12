# 家长洞察可视化数据对接 Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** 实现「能力发展总览」雷达图和「月度情绪热力图」的前后端数据闭环。通过调用后台 `ParentInsightController` 中的真实 API，替换前端 `insights/index.vue` 中的 Mock 数据和静态样式。

**Architecture:** 
- **Backend:** `ParentInsightController` 已经提供了 `/ability/radar/{childId}` (雷达图) 和 `/emotion/trend/{childId}` (情绪趋势) 接口。
- **Frontend:** Uniapp + Vue 3。通过 `userStore` 获取当前孩子 ID，调用 `api/child.ts` 中封装的接口。

**Tech Stack:** Java, Spring Boot, Vue 3, Uniapp, CSS Grids (for heatmaps)

---

### Task 1: 前端 - 对接能力发展雷达图 API

**Files:**
- Modify: `smallsteps-app/src/pages/parent/insights/index.vue`

- [ ] **Step 1: Fetch and Map Radar Data**

修改 `loadData` 方法和 `abilityData` 的定义，接入 `/parent/insight/ability/radar/{childId}` 接口。

```javascript
// smallsteps-app/src/pages/parent/insights/index.vue (Script Section)
import { getAbilityRadar } from '@/api/child' // Ensure this is exported in api/child.ts or similar

const abilityData = ref([])

const loadData = () => {
  const childId = userStore.currentChildId || 1
  
  // 1. 获取能力雷达数据
  getAbilityRadar(childId).then(res => {
    // 假设后端返回 Map<String, Double>，如 {"数学": 65, "社交": 42...}
    if (res.data) {
      abilityData.value = Object.entries(res.data).map(([label, value]) => ({
        label,
        value: Math.round(value)
      }))
    }
  })
  
  // 2. 原有的成就列表拉取逻辑...
}
```

- [ ] **Step 2: Ensure API export exists**

检查并在 `smallsteps-app/src/api/child.ts` 中补充接口定义：
```typescript
export function getAbilityRadar(childId: number) {
    return request({
        url: '/parent/insight/ability/radar/' + childId,
        method: 'GET'
    })
}
```

---

### Task 2: 前端 - 对接情绪热力图 API

**Files:**
- Modify: `smallsteps-app/src/pages/parent/insights/index.vue`

- [ ] **Step 1: Fetch Emotion Trend Data**

接入 `/parent/insight/emotion/trend/{childId}?days=30` 获取最近一个月的情绪记录。

```javascript
// smallsteps-app/src/pages/parent/insights/index.vue (Script Section)
import { getEmotionTrend } from '@/api/child'

const monthlyEmotions = ref({}) // Format: { "2023-10-01": "happy", "2023-10-02": "neutral" }

const loadEmotionHeatmap = () => {
  const childId = userStore.currentChildId || 1
  getEmotionTrend(childId, 30).then(res => {
    const list = res.data || []
    const map = {}
    list.forEach(item => {
      // 假设 item.interactionTime 是日期字符串，item.emotionType 是情绪枚举
      const date = item.interactionTime.substring(0, 10)
      map[date] = item.emotionType 
    })
    monthlyEmotions.value = map
  })
}

// 修改 getEmotionColor 逻辑以支持动态数据
const getEmotionColorByDate = (dateStr) => {
  const emotion = monthlyEmotions.value[dateStr]
  if (!emotion) return '#d1d5db' // 灰色 (无数据)
  
  // 根据后台 emotionType 定义颜色映射 (示例)
  const colorMap = {
    '1': '#6b9bd1', // 平静
    '2': '#fbbf24', // 兴奋
    '3': '#f87171', // 焦虑
  }
  return colorMap[emotion] || '#d1d5db'
}
```

- [ ] **Step 2: Update Calendar Template**

在模板中循环渲染日期时，传入真实的日期字符串。

```vue
<view v-for="day in 31" :key="day" class="day-cell">
  <text class="day-num">{{day}}</text>
  <view class="dot" :style="{ background: getEmotionColorByDate(`2026-04-${day.toString().padStart(2, '0')}`) }"></view>
</view>
```

---

### Task 3: 验证与清理

- [ ] **Step 1: Run project and verify visuals**
- [ ] **Step 2: Commit changes with descriptive messages**

```bash
git add .
git commit -m "feat(app-parent): implement real data for ability radar and emotion heatmap"
```
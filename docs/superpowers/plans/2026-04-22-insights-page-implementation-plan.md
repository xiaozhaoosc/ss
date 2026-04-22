# 家长洞察页面 UI 还原与全链路对接 Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** 将家长洞察页面 (`index.vue`) 与设计图进行像素级对齐，并完成“能力发展总览”和“月度情绪热力图”的真实数据对接。

**Architecture:** 前端 Vue 3 + TypeScript (UniApp 架构)。通过修改 `index.vue` 内部结构与 CSS，同时适配 `child.ts` 接口数据实现业务与 UI 解耦重构。采用 Fallback 机制保障空数据渲染。

**Tech Stack:** Vue 3, SCSS, UniApp

---

### Task 1: 移除无关模块并统一基础样式

**Files:**
- Modify: `smallsteps-app/src/pages/parent/insights/index.vue`

- [ ] **Step 1: 移除“成就亮点”模块**
在 `template` 中找到 `<view class="section last-section">` 包含“成就亮点”的部分，将其完整移除，并将 `<view class="safe-bottom"></view>` 保留在 `scroll-view` 末尾。
同时在 `<script setup>` 中移除对 `achievements` 的定义以及在 `loadData` 中调用 `listChildAchievement` 的相关代码。

- [ ] **Step 2: 清理相关 SCSS 样式**
移除 `<style lang="scss" scoped>` 中与 `.achievement-list`、`.achievement-card`、`.ach-icon`、`.ach-info`、`.ach-title`、`.ach-desc`、`.ach-date` 等所有以 `.ach-` 或 `.achievement-` 开头的冗余样式。保留 `.last-section` 类并将其应用到“月度情绪热力图”的 `<view class="section">` 上以确保底部留白。

- [ ] **Step 3: 优化全局背景与头部**
确保 `.container` 背景色为 `#f6f7f8`。
微调 `.header` 的 `padding` 和标题字号，语言切换按钮的样式确保圆角和字号符合现代感设计图（背景色 `#f3f4f6`，字体色灰色，激活态背景 `#6b9bd1`，白字）。

---

### Task 2: 能力发展总览 - 接口适配与数据处理

**Files:**
- Modify: `smallsteps-app/src/pages/parent/insights/index.vue`

- [ ] **Step 1: 适配 `getAbilityRadar` 返回结构**
修改 `<script setup>` 中的 `loadData` 方法。根据后端 `ParentInsightController` 返回结构 `{ abilities: [...], scores: [...] }` 处理数据。

```javascript
  // 修改后的逻辑
  getAbilityRadar(childId).then(res => {
    const data = res.data || {}
    const abilities = data.abilities || []
    const scores = data.scores || []
    
    if (abilities.length > 0 && scores.length === abilities.length) {
      abilityData.value = abilities.map((label, index) => ({
        label: label,
        value: scores[index]
      }))
    } else {
      // 兜底数据
      abilityData.value = [
        { label: '数学', value: 65 },
        { label: '社交', value: 42 },
        { label: '专注', value: 85 },
        { label: '创造', value: 30 }
      ]
    }
  }).catch(err => {
    console.error('Failed to load ability radar data:', err)
    abilityData.value = [
      { label: '数学', value: 65 },
      { label: '社交', value: 42 },
      { label: '专注', value: 85 },
      { label: '创造', value: 30 }
    ]
  })
```

---

### Task 3: 能力发展总览 - 柱状图 UI 像素级重构

**Files:**
- Modify: `smallsteps-app/src/pages/parent/insights/index.vue`

- [ ] **Step 1: 调整卡片头部结构**
保持 `总体良好` 与绿色趋势标签 `↑+5%` 的布局：
```html
<view class="main-status">
  <text class="status-text">总体良好</text>
  <view class="trend-tag">
    <text class="trend-icon">↑</text>
    <text>+5%</text>
  </view>
</view>
```

- [ ] **Step 2: 重构柱状图 HTML 结构**
将数值标签 (`tooltip`) 从绝对定位浮动改为嵌入在柱体内部。
```html
<view class="chart-container">
  <view class="bar-chart">
    <view v-for="(item, index) in abilityData" :key="index" class="bar-item">
      <view class="bar-wrapper">
        <view class="bar" :style="{ height: item.value + '%' }">
          <view class="value-capsule">{{ item.value }}%</view>
        </view>
      </view>
      <text class="bar-label">{{ item.label }}</text>
    </view>
  </view>
</view>
```

- [ ] **Step 3: 编写对应的 SCSS**
在 `<style lang="scss" scoped>` 中更新样式：
```scss
.bar-wrapper {
  position: relative;
  width: 60rpx;
  height: 240rpx;
  background-color: #f3f4f6;
  border-radius: 12rpx; // 调整为上下均圆角或仅上方圆角
  display: flex;
  align-items: flex-end;
  overflow: hidden; // 确保内部 bar 不溢出
}

.bar {
  width: 100%;
  background-color: #6b9bd1;
  border-radius: 12rpx 12rpx 0 0;
  transition: height 0.3s ease;
  display: flex;
  justify-content: center;
  align-items: flex-start; // 顶部对齐
  padding-top: 10rpx; // 内边距
  
  .value-capsule {
    background-color: #4b5563;
    color: #ffffff;
    font-size: 18rpx;
    padding: 4rpx 12rpx;
    border-radius: 20rpx; // 胶囊圆角
    font-weight: bold;
  }
}
```

---

### Task 4: 月度情绪热力图 - 接口对接与逻辑优化

**Files:**
- Modify: `smallsteps-app/src/pages/parent/insights/index.vue`

- [ ] **Step 1: 适配日历渲染逻辑**
修改 `getEmotionColor` 以准确匹配日期并支持 5 种情绪到 3 种颜色的映射。
```javascript
const getEmotionColor = (dateStr) => {
  if (!dateStr) return 'transparent'
  
  const entry = emotionData.value.find(item => {
    // 假设后端返回的时间包含 T 或者空格
    const itemDate = item.createTime ? item.createTime.split('T')[0].split(' ')[0] : ''
    return itemDate === dateStr
  })
  
  if (!entry) return 'transparent' // 无数据透明
  
  // 1: 开心, 5: 平静 -> 蓝
  // 3: 愤怒 (此处根据方案映射为黄/兴奋态) -> 黄
  // 2: 难过, 4: 焦虑, 默认 -> 灰
  switch (entry.emotionType) {
    case 1:
    case 5:
      return '#6b9bd1'
    case 3:
      return '#fbbf24'
    case 2:
    case 4:
    default:
      return '#d1d5db'
  }
}
```

- [ ] **Step 2: 更新 `loadEmotionHeatmap` 异常处理**
确保 `getEmotionTrend` 失败时 `emotionData.value` 初始化为空数组。

---

### Task 5: 月度情绪热力图 - UI 像素级重构

**Files:**
- Modify: `smallsteps-app/src/pages/parent/insights/index.vue`

- [ ] **Step 1: 更新日历组件 DOM 结构**
给包裹着图例或整体的 `section` 添加 `last-section` 类。
修改当天的显示逻辑，并且当非今天但有情绪点时显示对应圆点。

```html
<view class="calendar-grid">
  <view v-for="(day, index) in calendarDays" :key="index" 
        class="day-cell" :class="{ 'selected': day.isToday }">
    <template v-if="!day.empty">
      <text class="day-num">{{ day.day }}</text>
      <!-- 修改判断条件：非透明才渲染 dot -->
      <view class="dot" v-show="getEmotionColor(day.date) !== 'transparent'" 
            :style="{ background: getEmotionColor(day.date) }"></view>
    </template>
  </view>
</view>
```

- [ ] **Step 2: 编写对应的 SCSS**
确保边框彻底清除，并对当天的高亮以及底部圆点进行精确定位。
```scss
.day-cell {
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: flex-start; // 顶部对齐
  padding-top: 10rpx;
  height: 90rpx; // 留出圆点空间
  position: relative;
  
  .day-num {
    font-size: 26rpx;
    color: #5b718b;
    width: 56rpx;
    height: 56rpx;
    line-height: 56rpx;
    text-align: center;
    border-radius: 50%;
  }
  
  .dot {
    width: 8rpx;
    height: 8rpx;
    border-radius: 50%;
    margin-top: 6rpx;
  }
  
  &.selected {
    .day-num {
      background-color: #6b9bd1;
      color: #ffffff;
      font-weight: bold;
    }
    // 今天不需要再额外渲染底部的 dot (如果是设计要求的话)，目前通过上面的逻辑分离。
  }
}
```
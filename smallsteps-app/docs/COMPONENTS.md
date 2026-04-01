# 组件文档

## 儿童端组件

### ChildBottomNav

**功能**：儿童端底部导航栏

**使用示例**：

```vue
<child-bottom-nav :active="currentTab" @change="handleTabChange" />
```

**属性**：
- `active`：当前激活的标签页
- `tabs`：导航标签配置（可选）

**事件**：
- `change`：标签页切换时触发

### MissionCard

**功能**：任务卡片组件

**使用示例**：

```vue
<mission-card :task="task" @click="handleTaskClick" />
```

**属性**：
- `task`：任务对象
- `showProgress`：是否显示进度条（默认：true）

**事件**：
- `click`：点击卡片时触发

### MissionTimer

**功能**：任务计时器组件

**使用示例**：

```vue
<mission-timer :duration="taskDuration" @complete="handleTimerComplete" />
```

**属性**：
- `duration`：任务时长（秒）
- `autoStart`：是否自动开始（默认：false）

**事件**：
- `complete`：计时完成时触发
- `update`：计时更新时触发

### ShopProductCard

**功能**：奖励商店商品卡片

**使用示例**：

```vue
<shop-product-card :product="product" @buy="handleBuyProduct" />
```

**属性**：
- `product`：商品对象
- `userPoints`：用户当前积分

**事件**：
- `buy`：购买商品时触发

### TrophyJar

**功能**：奖杯罐组件，显示儿童成就

**使用示例**：

```vue
<trophy-jar :trophies="childTrophies" />
```

**属性**：
- `trophies`：奖杯列表
- `maxTrophies`：最大奖杯数量（默认：10）

## 家长端组件

### AudioPlayer

**功能**：音频播放器组件

**使用示例**：

```vue
<audio-player :src="audioUrl" :autoplay="false" />
```

**属性**：
- `src`：音频地址
- `autoplay`：是否自动播放（默认：false）
- `controls`：是否显示控制按钮（默认：true）

### DeviceSettingsModal

**功能**：设备设置模态框

**使用示例**：

```vue
<device-settings-modal :visible="showDeviceModal" :device="currentDevice" @save="handleDeviceSave" @close="showDeviceModal = false" />
```

**属性**：
- `visible`：是否显示
- `device`：设备对象

**事件**：
- `save`：保存设置时触发
- `close`：关闭模态框时触发

### EmotionAlert

**功能**：情绪提醒组件

**使用示例**：

```vue
<emotion-alert :emotion="childEmotion" :level="emotionLevel" />
```

**属性**：
- `emotion`：情绪类型
- `level`：情绪强度（1-5）
- `showSuggestion`：是否显示建议（默认：true）

### RewardConfigItem

**功能**：奖励配置项组件

**使用示例**：

```vue
<reward-config-item :reward="reward" @edit="handleEditReward" @delete="handleDeleteReward" />
```

**属性**：
- `reward`：奖励对象

**事件**：
- `edit`：编辑奖励时触发
- `delete`：删除奖励时触发

### StatCard

**功能**：统计卡片组件

**使用示例**：

```vue
<stat-card :title="'完成任务数'" :value="completedTasks" :icon="'task'" />
```

**属性**：
- `title`：卡片标题
- `value`：统计值
- `icon`：图标名称
- `color`：卡片颜色（默认：primary）

### TaskStep

**功能**：任务步骤组件

**使用示例**：

```vue
<task-step :step="step" :index="index" :completed="isCompleted" @complete="handleStepComplete" />
```

**属性**：
- `step`：步骤对象
- `index`：步骤索引
- `completed`：是否已完成
- `current`：是否为当前步骤

**事件**：
- `complete`：完成步骤时触发

### TimelineItem

**功能**：时间线项组件

**使用示例**：

```vue
<timeline-item :time="item.time" :content="item.content" :type="item.type" />
```

**属性**：
- `time`：时间
- `content`：内容
- `type`：类型（success, warning, error, info）

## 通用组件

### BottomNav

**功能**：通用底部导航栏

**使用示例**：

```vue
<bottom-nav :tabs="tabs" :active="currentTab" @change="handleTabChange" />
```

**属性**：
- `tabs`：导航标签配置
- `active`：当前激活的标签页

**事件**：
- `change`：标签页切换时触发

### ThemeToggle

**功能**：主题切换组件

**使用示例**：

```vue
<theme-toggle :current-theme="theme" @change="handleThemeChange" />
```

**属性**：
- `current-theme`：当前主题（light, dark）

**事件**：
- `change`：主题切换时触发

### TopBar

**功能**：顶部栏组件

**使用示例**：

```vue
<top-bar :title="'页面标题'" :show-back="true" @back="handleBack" />
```

**属性**：
- `title`：页面标题
- `show-back`：是否显示返回按钮（默认：false）
- `show-menu`：是否显示菜单按钮（默认：false）

**事件**：
- `back`：点击返回按钮时触发
- `menu`：点击菜单按钮时触发

## 组件开发规范

1. **命名规范**：
   - 组件名称使用 PascalCase
   - 文件名称与组件名称保持一致

2. **目录结构**：
   - 按功能模块组织组件
   - 每个组件单独创建目录，包含组件文件和样式文件

3. **Props 定义**：
   - 明确类型和默认值
   - 对必填属性进行标注

4. **事件定义**：
   - 使用 kebab-case 命名
   - 明确事件参数

5. **样式规范**：
   - 使用 Tailwind CSS 类
   - 避免内联样式
   - 组件样式隔离

6. **性能优化**：
   - 使用 `v-memo` 优化渲染
   - 合理使用 `v-if` 和 `v-show`
   - 避免不必要的计算属性

7. **测试**：
   - 为组件编写单元测试
   - 确保组件在不同设备上的兼容性

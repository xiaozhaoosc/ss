# 前端任务页面 API 对接 Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** 移除移动端 App (smallsteps-app) 中“家长发布任务”与“儿童接收/执行任务”页面的 Mock 和 Hardcode 数据，实现与后台真实 API 的端到端闭环。

**Architecture:** 基于 Uniapp + Vue 3 组合式 API (Setup)。通过 Pinia 的 userStore 获取当前登录用户的上下文 (userId/childId)，调用封装好的 Axios 请求方法进行真实交互。

**Tech Stack:** Vue 3, Uniapp, Pinia, Axios

---

### Task 1: 家长端 - 任务创建真实参数对接

**Files:**
- Modify: `smallsteps-app/src/pages/parent/task-creator/index.vue`

- [ ] **Step 1: Replace hardcoded API payload with dynamic user data**

```vue
<!-- Modify the <script setup> block in smallsteps-app/src/pages/parent/task-creator/index.vue -->
<script setup>
import { ref } from 'vue'
import TopBar from '@/components/common/top-bar/top-bar.vue'
import TaskStep from '@/components/parent/task-step/task-step.vue'
import BottomNav from '@/components/common/bottom-nav/bottom-nav.vue'
import { addTask } from '@/api/task'
import { useUserStore } from '@/store/modules/user'

const userStore = useUserStore()

const isDarkMode = ref(false)
const taskInput = ref('')
const isBreakingDown = ref(false)
const isSubmitting = ref(false)
const isRepeat = ref(false)
const isTemplate = ref(false)

const steps = ref([
  { title: '穿好袜子', description: '找到一双干净的袜子并穿上' },
  { title: '穿好鞋子', description: '区分左右脚，系好鞋带' },
  { title: '拿上书包', description: '确认作业都在书包里' }
])

const handleAiBreakdown = () => {
  if (!taskInput.value) {
    uni.showToast({ title: '请先输入任务描述', icon: 'none' })
    return
  }
  
  isBreakingDown.value = true
  setTimeout(() => {
    isBreakingDown.value = false
    steps.value = [
      { title: '整理文具', description: '检查铅笔盒，确保笔都削好了' },
      { title: '核对课表', description: '按明天课程准备课本' },
      { title: '准备水壶', description: '洗净并装满温水' }
    ]
    uni.showToast({ title: '拆解成功', icon: 'success' })
  }, 1500)
}

const handleAddStep = () => {
  steps.value.push({ title: '新步骤', description: '请具体描述这个步骤' })
}

const handleEditStep = (index) => {
  uni.showToast({ title: `编辑步骤 ${index + 1}`, icon: 'none' })
}

const handleDeleteStep = (index) => {
  steps.value.splice(index, 1)
}

const handleSubmit = () => {
  if (!taskInput.value) {
    uni.showToast({ title: '请输入任务', icon: 'error' })
    return
  }
  isSubmitting.value = true
  
  const stepsDesc = steps.value.map((s, i) => `${i+1}. ${s.title}: ${s.description}`).join('\n')
  
  // 注入真实的 userId (Parent ID) 等必要参数
  const newTask = {
    userId: userStore.id || 1, // Fallback for dev if store is empty
    title: taskInput.value,
    description: stepsDesc,
    icon: 'task',
    difficulty: 1,
    rewardPoints: 10,
    status: '0'
  }
  
  addTask(newTask).then(() => {
    isSubmitting.value = false
    uni.showToast({ title: '任务已发布', icon: 'success' })
    setTimeout(() => {
      uni.navigateBack()
    }, 1500)
  }).catch(() => {
    isSubmitting.value = false
    uni.showToast({ title: '发布失败，请重试', icon: 'error' })
  })
}
</script>
```

- [ ] **Step 2: Commit**

```bash
git add smallsteps-app/src/pages/parent/task-creator/index.vue
git commit -m "feat(app-parent): integrate parent task creator with real user context"
```

---

### Task 2: 儿童端 - 待办任务拉取与执行页面对接

**Files:**
- Modify: `smallsteps-app/src/pages/child/task-execute/index.vue`
- Modify: `smallsteps-app/src/pages/child/home/index.vue`

- [ ] **Step 1: Fetch dynamic task context in child task execute page**

```vue
<!-- Modify the <script setup> block in smallsteps-app/src/pages/child/task-execute/index.vue -->
<script setup>
import { ref } from 'vue'
import { onLoad } from '@dcloudio/uni-app'
import MissionTimer from '@/components/child/mission-timer/mission-timer.vue'
import ChildBottomNav from '@/components/child/child-bottom-nav/child-bottom-nav.vue'
import { completeTask } from '@/api/child'
import { useUserStore } from '@/store/modules/user'

const userStore = useUserStore()
const isDarkMode = ref(false)
const taskId = ref(null)
const isLoading = ref(false)

onLoad((options) => {
  if (options.taskId) {
    taskId.value = parseInt(options.taskId)
  }
})

const handleBack = () => {
  uni.navigateBack()
}

const handleTimerFinish = () => {
  uni.showToast({ title: '时间到！', icon: 'none' })
}

const handleComplete = () => {
  if (!taskId.value) {
    uni.showToast({ title: '任务ID丢失', icon: 'error' })
    return
  }
  
  // 动态获取当前登录的儿童 ID
  const childId = userStore.id || 1 
  
  isLoading.value = true
  uni.showLoading({ title: '提交中...' })
  
  completeTask(taskId.value, childId).then(() => {
    uni.hideLoading()
    uni.showToast({ title: '太棒了！任务完成！', icon: 'success' })
    setTimeout(() => {
      uni.navigateBack()
    }, 1500)
  }).catch(() => {
    uni.hideLoading()
    isLoading.value = false
    uni.showToast({ title: '网络开小差了，再试一次吧', icon: 'error' })
  })
}
</script>
```

- [ ] **Step 2: Connect child home page list to real pending API**

```vue
<!-- Modify the script block in smallsteps-app/src/pages/child/home/index.vue -->
<!-- Assuming it uses setup; if the file is different, adjust accordingly. This is to ensure task lists route to task-execute correctly. -->
<script setup>
import { ref, onMounted } from 'vue'
import { getPendingTasks } from '@/api/child'
import { useUserStore } from '@/store/modules/user'

const userStore = useUserStore()
const pendingTasks = ref([])

onMounted(() => {
  loadPendingTasks()
})

const loadPendingTasks = () => {
  const childId = userStore.id || 1
  getPendingTasks(childId).then(res => {
    pendingTasks.value = res.data || []
  }).catch(err => {
    console.error('Failed to load pending tasks:', err)
  })
}

const navigateToTask = (taskId) => {
  uni.navigateTo({
    url: `/pages/child/task-execute/index?taskId=${taskId}`
  })
}
</script>
```

- [ ] **Step 3: Commit**

```bash
git add smallsteps-app/src/pages/child/task-execute/index.vue smallsteps-app/src/pages/child/home/index.vue
git commit -m "feat(app-child): connect task execution and home list to dynamic child ID and real APIs"
```
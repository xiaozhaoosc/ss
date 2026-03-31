<template>
  <view class="task-creator-page" :class="{ 'dark': isDarkMode }">
    <!-- Top Bar -->
    <top-bar title="创建任务" :show-back="true">
      <template #right>
        <view class="lang-switch">
          <text class="lang-tag active">CN</text>
        </view>
      </template>
    </top-bar>

    <scroll-view scroll-y class="main-content no-scrollbar">
      <!-- Input Section -->
      <view class="input-section">
        <view class="textarea-wrapper">
          <textarea
            v-model="taskInput"
            class="task-textarea"
            placeholder="输入你想让孩子做的事...&#10;例如：收拾书包准备去学校"
            maxlength="200"
          />
          <text class="char-count">{{ taskInput.length }}/200</text>
        </view>
        
        <button class="ai-btn" :loading="isBreakingDown" @click="handleAiBreakdown">
          <text class="material-symbols-outlined icon">spark</text>
          <text>AI 拆解</text>
        </button>
      </view>

      <!-- Steps Section -->
      <view class="steps-section">
        <view class="section-header">
          <text class="section-title">任务步骤</text>
          <view class="step-count-badge">{{ steps.length }} 步</view>
        </view>
        
        <view class="steps-list">
          <task-step
            v-for="(step, index) in steps"
            :key="index"
            :title="step.title"
            :description="step.description"
            @edit="handleEditStep(index)"
            @delete="handleDeleteStep(index)"
          />
          
          <button class="add-step-btn" @click="handleAddStep">
            <text class="material-symbols-outlined icon">add_circle</text>
            <text>添加步骤</text>
          </button>
        </view>
      </view>
      
      <view class="spacer"></view>
    </scroll-view>

    <!-- 底部导航 -->
    <bottom-nav mode="parent" />

    <!-- Footer -->
    <footer class="footer">
      <view class="advanced-options">
        <label class="option-item">
          <checkbox :checked="isRepeat" color="#6C9BD2" @tap="isRepeat = !isRepeat" />
          <text class="option-label">每天重复</text>
        </label>
        <label class="option-item">
          <checkbox :checked="isTemplate" color="#6C9BD2" @tap="isTemplate = !isTemplate" />
          <text class="option-label">存为模板</text>
        </label>
      </view>
      
      <button class="submit-btn" :loading="isSubmitting" @click="handleSubmit">
        <text>发送给 StarBuddy</text>
        <text class="material-symbols-outlined icon">send</text>
      </button>
    </footer>
  </view>
</template>

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
  // 模拟 AI 拆解过程
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
  
  // Format steps into description
  const stepsDesc = steps.value.map((s, i) => `${i+1}. ${s.title}: ${s.description}`).join('\n')
  
  const newTask = {
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
  })
}
</script>

<style lang="scss" scoped>
.task-creator-page {
  height: 100vh;
  display: flex;
  flex-direction: column;
  background-color: #f8f9fa;
  
  :deep(.dark) & {
    background-color: #14191e;
  }
}

.lang-switch {
  display: flex;
  align-items: center;
  background-color: #f3f4f6;
  border-radius: 999px;
  padding: 2px;
  
  :deep(.dark) & {
    background-color: #1e242b;
  }
}

.lang-tag {
  font-size: 10px;
  font-weight: 500;
  padding: 2px 8px;
  border-radius: 999px;
  color: #6b7280;
  
  &.active {
    background-color: #6C9BD2;
    color: #ffffff;
    font-weight: 700;
    box-shadow: 0 1px 2px rgba(0, 0, 0, 0.1);
  }
}

.main-content {
  flex: 1;
  padding: 16px;
  padding-top: 60px; // Space for top bar
}

.input-section {
  display: flex;
  flex-direction: column;
  gap: 12px;
  margin-bottom: 24px;
}

.textarea-wrapper {
  position: relative;
  background-color: #ffffff;
  border-radius: 8px;
  border: 1px solid #e5e7eb;
  padding: 16px;
  
  :deep(.dark) & {
    background-color: #1e242b;
    border-color: #374151;
  }
}

.task-textarea {
  width: 100%;
  height: 120px;
  font-size: 16px;
  color: #111827;
  
  :deep(.dark) & {
    color: #ffffff;
  }
}

.char-count {
  position: absolute;
  bottom: 8px;
  right: 12px;
  font-size: 10px;
  color: #9ca3af;
}

.ai-btn {
  display: flex;
  align-items: center;
  justify-content: center;
  gap: 8px;
  height: 48px;
  background-color: rgba(108, 155, 210, 0.1);
  color: #6C9BD2;
  font-weight: 700;
  border-radius: 8px;
  transition: all 0.3s ease;
  
  &::after { border: none; }
  
  &:active {
    background-color: rgba(108, 155, 210, 0.2);
  }
  
  .icon {
    font-size: 18px;
  }
}

.steps-section {
  display: flex;
  flex-direction: column;
}

.section-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-bottom: 12px;
}

.section-title {
  font-size: 16px;
  font-weight: 700;
  color: #111827;
  
  :deep(.dark) & {
    color: #ffffff;
  }
}

.step-count-badge {
  font-size: 10px;
  font-weight: 500;
  padding: 2px 8px;
  background-color: #f3f4f6;
  color: #6b7280;
  border-radius: 4px;
  
  :deep(.dark) & {
    background-color: #1e242b;
  }
}

.steps-list {
  display: flex;
  flex-direction: column;
  gap: 12px;
}

.add-step-btn {
  display: flex;
  align-items: center;
  justify-content: center;
  gap: 8px;
  padding: 12px;
  background: transparent;
  border: 1px dashed #d1d5db;
  border-radius: 8px;
  color: #6b7280;
  font-size: 14px;
  font-weight: 500;
  
  &::after { border: none; }
  
  &:active {
    border-color: #6C9BD2;
    color: #6C9BD2;
    background-color: rgba(108, 155, 210, 0.05);
  }
  
  .icon {
    font-size: 18px;
  }
}

.spacer {
  height: 40px;
}

.footer {
  position: fixed;
  bottom: 0;
  left: 0;
  right: 0;
  padding: 16px;
  padding-bottom: calc(16px + env(safe-area-inset-bottom));
  background-color: rgba(255, 255, 255, 0.9);
  backdrop-filter: blur(10px);
  border-top: 1px solid #f3f4f6;
  z-index: 100;
  
  :deep(.dark) & {
    background-color: rgba(30, 36, 43, 0.9);
    border-color: #374151;
  }
}

.advanced-options {
  display: flex;
  gap: 24px;
  margin-bottom: 12px;
  padding: 0 4px;
}

.option-item {
  display: flex;
  align-items: center;
  gap: 6px;
}

.option-label {
  font-size: 12px;
  color: #6b7280;
}

.submit-btn {
  display: flex;
  align-items: center;
  justify-content: center;
  gap: 8px;
  height: 50px;
  background-color: #6C9BD2;
  color: #ffffff;
  font-weight: 700;
  border-radius: 8px;
  box-shadow: 0 4px 12px rgba(108, 155, 210, 0.3);
  
  &::after { border: none; }
  
  &:active {
    transform: scale(0.98);
    opacity: 0.9;
  }
  
  .icon {
    font-size: 20px;
  }
}

.no-scrollbar::-webkit-scrollbar {
  display: none;
}
</style>

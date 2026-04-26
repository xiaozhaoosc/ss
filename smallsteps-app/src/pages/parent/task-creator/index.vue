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
      
      <!-- Moved Footer inside scroll-view to avoid fixed overlap issues -->
      <view class="footer-in-scroll">
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
        
        <button class="submit-btn" :loading="isSubmitting" @click.stop.prevent="handleSubmit">
          <text>发布</text>
        </button>
        
        <view class="safe-area-spacer"></view>
      </view>
    </scroll-view>

    <!-- 底部导航 (固定在底部，不随内容滚动) -->
    <bottom-nav mode="parent" />
  </view>
</template>

<script setup lang="ts">
import { ref } from 'vue'
import TopBar from '@/components/common/top-bar/top-bar.vue'
import TaskStep from '@/components/parent/task-step/task-step.vue'
import BottomNav from '@/components/common/bottom-nav/bottom-nav.vue'
import { taskBreakdown } from '@/api/ai'
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

const handleAiBreakdown = async () => {
  if (!taskInput.value) {
    uni.showToast({ title: '请先输入任务描述', icon: 'none' })
    return
  }
  
  isBreakingDown.value = true
  try {
    const res: any = await taskBreakdown({
      taskName: taskInput.value,
      taskDesc: '',
      childAge: 8 // 默认年龄，后续可从 store 或设置中获取
    })
    
    if (res.code === 200 && res.data) {
      steps.value = res.data.map((item: any) => ({
        title: item.stepName || '新步骤',
        description: item.stepDesc || ''
      }))
      uni.showToast({ title: '拆解成功', icon: 'success' })
    } else {
      throw new Error(res.msg || '拆解失败')
    }
  } catch (error) {
    console.error('AI breakdown error:', error)
    uni.showToast({ title: 'AI 拆解服务暂不可用', icon: 'none' })
  } finally {
    isBreakingDown.value = false
  }
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
  
  if (!userStore.userId) {
    uni.showToast({ title: '用户信息未加载，请刷新', icon: 'none' })
    return
  }

  isSubmitting.value = true
  
  const stepsDesc = steps.value.map((s, i) => `${i+1}. ${s.title}: ${s.description}`).join('\n')
  
  const newTask = {
    userId: userStore.userId,
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
  }).catch((err) => {
    console.error('Add task failed:', err)
    isSubmitting.value = false
    uni.showToast({ title: '发布失败，请重试', icon: 'error' })
  })
}
</script>

<style lang="scss" scoped>
.task-creator-page {
  height: 100vh;
  display: flex;
  flex-direction: column;
  background: linear-gradient(180deg, #f0f7ff 0%, #f8faff 100%);
  
  :deep(.dark) & {
    background: radial-gradient(circle at top, #1e293b 0%, #0f172a 100%);
  }
}

.lang-switch {
  display: flex;
  align-items: center;
  background: rgba(255, 255, 255, 0.5);
  backdrop-filter: blur(8px);
  border-radius: 12px;
  padding: 4px;
  border: 1px solid rgba(108, 155, 210, 0.1);
}

.lang-tag {
  font-size: 11px;
  font-weight: 700;
  padding: 4px 10px;
  border-radius: 8px;
  color: #94a3b8;
  
  &.active {
    background: #6C9BD2;
    color: #ffffff;
    box-shadow: 0 4px 12px rgba(108, 155, 210, 0.2);
  }
}

.main-content {
  flex: 1;
  padding: 20px;
  padding-top: 80px;
}

.input-section {
  display: flex;
  flex-direction: column;
  gap: 20px;
  margin-bottom: 32px;
}

.textarea-wrapper {
  position: relative;
  background: rgba(255, 255, 255, 0.8);
  backdrop-filter: blur(12px);
  border-radius: 24px;
  border: 1px solid rgba(108, 155, 210, 0.15);
  padding: 20px;
  box-shadow: 0 10px 30px rgba(108, 155, 210, 0.05);
  
  :deep(.dark) & {
    background: rgba(30, 41, 59, 0.6);
    border-color: rgba(255, 255, 255, 0.1);
  }
}

.task-textarea {
  width: 100%;
  height: 100px;
  font-size: 17px;
  color: #1e293b;
  line-height: 1.6;
  
  :deep(.dark) & {
    color: #f1f5f9;
  }
}

.char-count {
  position: absolute;
  bottom: 12px;
  right: 20px;
  font-size: 11px;
  font-weight: 600;
  color: #cbd5e1;
}

.ai-btn {
  display: flex;
  align-items: center;
  justify-content: center;
  gap: 10px;
  height: 56px;
  background: linear-gradient(135deg, #6C9BD2 0%, #5d8bc2 100%);
  color: #ffffff;
  font-weight: 700;
  font-size: 16px;
  border-radius: 18px;
  box-shadow: 0 8px 25px rgba(108, 155, 210, 0.4);
  transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
  
  &::after { border: none; }
  
  &:active {
    transform: translateY(2px) scale(0.98);
    box-shadow: 0 4px 10px rgba(108, 155, 210, 0.3);
  }
  
  .icon {
    font-size: 24px;
    animation: sparkle 2s infinite ease-in-out;
  }
}

@keyframes sparkle {
  0%, 100% { opacity: 0.8; transform: scale(1); }
  50% { opacity: 1; transform: scale(1.2) rotate(15deg); }
}

.steps-section {
  display: flex;
  flex-direction: column;
}

.section-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-bottom: 16px;
  padding: 0 4px;
}

.section-title {
  font-size: 18px;
  font-weight: 800;
  color: #1e293b;
  letter-spacing: -0.5px;
  
  :deep(.dark) & {
    color: #f1f5f9;
  }
}

.step-count-badge {
  font-size: 12px;
  font-weight: 700;
  padding: 4px 12px;
  background: rgba(108, 155, 210, 0.1);
  color: #6C9BD2;
  border-radius: 10px;
}

.steps-list {
  display: flex;
  flex-direction: column;
  gap: 16px;
}

.add-step-btn {
  display: flex;
  align-items: center;
  justify-content: center;
  gap: 10px;
  padding: 16px;
  background: rgba(255, 255, 255, 0.5);
  border: 2px dashed rgba(108, 155, 210, 0.3);
  border-radius: 20px;
  color: #64748b;
  font-size: 15px;
  font-weight: 600;
  transition: all 0.3s ease;
  
  &::after { border: none; }
  
  &:active {
    background: rgba(108, 155, 210, 0.08);
    border-color: #6C9BD2;
    color: #6C9BD2;
    transform: scale(0.99);
  }
}

.spacer {
  height: 100px;
}

.footer-in-scroll {
  margin-top: 40px;
  padding: 20px 4px;
}

.advanced-options {
  display: flex;
  gap: 32px;
  margin-bottom: 24px;
  justify-content: center;
}

.option-item {
  display: flex;
  align-items: center;
  gap: 10px;
}

.option-label {
  font-size: 14px;
  font-weight: 600;
  color: #64748b;
  
  :deep(.dark) & {
    color: #94a3b8;
  }
}

.submit-btn {
  display: flex;
  align-items: center;
  justify-content: center;
  gap: 12px;
  height: 58px;
  background: #1e293b;
  color: #ffffff;
  font-weight: 800;
  font-size: 17px;
  border-radius: 20px;
  box-shadow: 0 10px 30px rgba(30, 41, 59, 0.3);
  margin: 0 10px;
  
  &::after { border: none; }
  
  &:active {
    transform: scale(0.96);
    opacity: 0.95;
  }
  
  :deep(.dark) & {
    background: #6C9BD2;
    box-shadow: 0 10px 30px rgba(108, 155, 210, 0.3);
  }
}

.safe-area-spacer {
  height: calc(80px + env(safe-area-inset-bottom)); // Account for tab bar height + safe area
}

.no-scrollbar::-webkit-scrollbar {
  display: none;
}
</style>

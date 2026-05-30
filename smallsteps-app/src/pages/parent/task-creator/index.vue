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
        
        <view class="action-btns">
          <button 
            class="ai-btn" 
            :loading="isBreakingDown" 
            @click="handleAiBreakdown"
            hover-class="btn-hover"
            hover-stay-time="100"
          >
            <text class="material-symbols-outlined icon">spark</text>
            <text>AI 拆解</text>
          </button>
          
          <button 
            class="template-btn" 
            @click="handleGoToTemplate"
            hover-class="btn-hover-subtle"
            hover-stay-time="100"
          >
            <text class="material-symbols-outlined icon">library_books</text>
            <text>模板库</text>
          </button>
        </view>
      </view>
      
      <!-- Child Selection Section -->
      <view class="child-selection-section">
        <view class="section-header">
          <text class="section-title">指派给</text>
          <text class="section-subtitle">点击头像选择孩子</text>
        </view>
        <scroll-view scroll-x class="child-list no-scrollbar" :show-scrollbar="false">
          <view class="child-list-inner">
            <view 
              v-for="child in children" 
              :key="child.userId"
              class="child-item"
              :class="{ 'active': selectedChildId === child.userId }"
              @click="handleSelectChild(child.userId)"
            >
              <view class="avatar-wrapper">
                <image 
                  :src="getAvatarUrl(child.avatar)" 
                  class="child-avatar"
                  mode="aspectFill"
                />
                <view class="active-ring" v-if="selectedChildId === child.userId"></view>
                <view class="check-badge" v-if="selectedChildId === child.userId">
                  <text class="material-symbols-outlined">done</text>
                </view>
              </view>
              <text class="child-name">{{ child.nickName }}</text>
            </view>
            
            <view class="add-child-item" @click="handleAddChild">
              <view class="add-avatar-placeholder">
                <text class="material-symbols-outlined">person_add</text>
              </view>
              <text class="child-name">添加</text>
            </view>
          </view>
        </scroll-view>
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
          
          <button 
            class="add-step-btn" 
            @click="handleAddStep"
            hover-class="btn-hover-subtle"
            hover-stay-time="100"
          >
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
        
        <button 
          class="submit-btn" 
          :loading="isSubmitting" 
          @click.stop.prevent="handleSubmit"
          hover-class="btn-hover"
          hover-stay-time="100"
        >
          <text>发布</text>
        </button>
        
        <view class="safe-area-spacer"></view>
      </view>
    </scroll-view>

    <!-- 底部导航 (固定在底部，不随内容滚动) -->
    <bottom-nav mode="parent" />

    <!-- Edit Step Modal -->
    <view class="modal-mask" v-if="isEditModalVisible" @tap.self="closeEditModal">
      <view class="modal-container">
        <view class="modal-header">
          <text class="modal-title">编辑任务步骤</text>
          <text class="material-symbols-outlined close-icon" @tap="closeEditModal">close</text>
        </view>
        
        <view class="modal-body">
          <view class="form-item">
            <text class="form-label">步骤名称</text>
            <input type="text" v-model="editingStep.title" class="form-input" placeholder="输入步骤名称，如：翻开课本到第10页" />
          </view>
          
          <view class="form-item">
            <text class="form-label">具体引导描述</text>
            <textarea v-model="editingStep.description" class="form-textarea" placeholder="输入具体引导描述，如：找到语文书，平放在桌子上并翻开" />
          </view>
        </view>
        
        <view class="modal-footer">
          <button class="modal-btn cancel" @tap="closeEditModal">取消</button>
          <button class="modal-btn confirm" @tap="saveEditStep">保存</button>
        </view>
      </view>
    </view>
  </view>
</template>

<script setup lang="ts">
import { ref, onMounted } from 'vue'
import TopBar from '@/components/common/top-bar/top-bar.vue'
import TaskStep from '@/components/parent/task-step/task-step.vue'
import BottomNav from '@/components/common/bottom-nav/bottom-nav.vue'
import { taskBreakdown } from '@/api/ai'
import { addTask } from '@/api/task'
import { getFamilyMembers } from '@/api/family'
import { useUserStore } from '@/store/modules/user'
import { getAvatarUrl } from '@/utils/common'

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

const children = ref([])
const selectedChildId = ref<number | null>(null)

onMounted(async () => {
  try {
    const res: any = await getFamilyMembers()
    if (res.code === 200 && res.data) {
      // 过滤出角色为儿童的成员
      children.value = res.data.filter((m: any) => 
        m.roles && m.roles.some((r: any) => r.roleKey === 'child' || r.roleName === '儿童')
      )
      
      // 如果没有专门的儿童角色，则显示所有非家长成员（简化逻辑）
      if (children.value.length === 0) {
        children.value = res.data.filter((m: any) => m.userId !== userStore.userId)
      }

      if (children.value.length > 0) {
        // 优先使用 store 中已选择的孩子
        if (userStore.currentChildId && children.value.some((c: any) => c.userId === userStore.currentChildId)) {
          selectedChildId.value = userStore.currentChildId
        } else {
          selectedChildId.value = children.value[0].userId
          userStore.setCurrentChildId(selectedChildId.value)
        }
      }
    }
  } catch (error) {
    console.error('Fetch family members failed:', error)
  }
})

const handleSelectChild = (id: number) => {
  selectedChildId.value = id
  userStore.setCurrentChildId(id)
}

const handleAddChild = () => {
  uni.navigateTo({
    url: '/pages/parent/family/index'
  })
}

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

const handleGoToTemplate = () => {
  uni.navigateTo({
    url: '/pages/template/library'
  })
}

const handleAddStep = () => {
  steps.value.push({ title: '新步骤', description: '请具体描述这个步骤' })
}

// Edit Step Modal States
const isEditModalVisible = ref(false)
const editingIndex = ref<number>(-1)
const editingStep = ref({ title: '', description: '' })

const handleEditStep = (index: number) => {
  editingIndex.value = index
  editingStep.value = { 
    title: steps.value[index].title, 
    description: steps.value[index].description || '' 
  }
  isEditModalVisible.value = true
}

const closeEditModal = () => {
  isEditModalVisible.value = false
  editingIndex.value = -1
}

const saveEditStep = () => {
  if (!editingStep.value.title.trim()) {
    uni.showToast({ title: '步骤名称不能为空', icon: 'none' })
    return
  }
  
  if (editingIndex.value > -1) {
    steps.value[editingIndex.value] = {
      title: editingStep.value.title,
      description: editingStep.value.description
    }
  }
  closeEditModal()
  uni.showToast({ title: '已保存步骤', icon: 'success' })
}

const handleDeleteStep = (index: number) => {
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
    childId: selectedChildId.value,
    title: taskInput.value,
    description: stepsDesc,
    icon: 'task',
    difficulty: 1,
    rewardPoints: 10,
    status: '0',
    cycleType: isRepeat.value ? 1 : 0,
    isTemplate: isTemplate.value ? 1 : 0,
    steps: steps.value.map((s, i) => ({
      stepOrder: i + 1,
      content: s.title,
      visualHint: s.description,
      expectedDuration: 120
    }))
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

.action-btns {
  display: flex;
  gap: 12px;
}

.ai-btn {
  flex: 2;
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

.template-btn {
  flex: 1;
  display: flex;
  align-items: center;
  justify-content: center;
  gap: 8px;
  height: 56px;
  background: rgba(255, 255, 255, 0.8);
  border: 1.5px solid rgba(108, 155, 210, 0.2);
  color: #64748b;
  font-weight: 700;
  font-size: 14px;
  border-radius: 18px;
  box-shadow: 0 4px 15px rgba(108, 155, 210, 0.05);
  
  &::after { border: none; }
  
  .icon {
    font-size: 20px;
    color: #6C9BD2;
  }
  
  :deep(.dark) & {
    background: rgba(30, 41, 59, 0.6);
    border-color: rgba(255, 255, 255, 0.1);
    color: #cbd5e1;
  }
}

@keyframes sparkle {
  0%, 100% { opacity: 0.8; transform: scale(1); }
  50% { opacity: 1; transform: scale(1.2) rotate(15deg); }
}

.child-selection-section {
  margin-bottom: 32px;
}

.section-subtitle {
  font-size: 12px;
  color: #94a3b8;
  font-weight: 500;
  margin-left: 8px;
}

.child-list {
  width: 100%;
  white-space: nowrap;
}

.child-list-inner {
  display: inline-flex;
  gap: 20px;
  padding: 10px 4px;
}

.child-item {
  display: flex;
  flex-direction: column;
  align-items: center;
  gap: 8px;
  transition: all 0.3s ease;
  
  &.active {
    .child-name {
      color: #6C9BD2;
      font-weight: 800;
    }
  }
}

.avatar-wrapper {
  position: relative;
  width: 64px;
  height: 64px;
}

.child-avatar {
  width: 100%;
  height: 100%;
  border-radius: 50%;
  background: #e2e8f0;
  border: 2px solid transparent;
  transition: all 0.3s ease;
  
  .active & {
    border-color: #6C9BD2;
    transform: scale(1.05);
  }
}

.active-ring {
  position: absolute;
  top: -4px;
  left: -4px;
  right: -4px;
  bottom: -4px;
  border: 2px solid #6C9BD2;
  border-radius: 50%;
  opacity: 0.3;
  animation: pulse 2s infinite;
}

@keyframes pulse {
  0% { transform: scale(0.95); opacity: 0.5; }
  50% { transform: scale(1.05); opacity: 0.2; }
  100% { transform: scale(0.95); opacity: 0.5; }
}

.check-badge {
  position: absolute;
  bottom: 0;
  right: 0;
  width: 20px;
  height: 20px;
  background: #6C9BD2;
  border-radius: 50%;
  display: flex;
  align-items: center;
  justify-content: center;
  border: 2px solid #ffffff;
  
  .material-symbols-outlined {
    font-size: 14px;
    color: #ffffff;
    font-weight: 900;
  }
}

.child-name {
  font-size: 13px;
  font-weight: 600;
  color: #64748b;
  transition: all 0.3s ease;
}

.add-child-item {
  display: flex;
  flex-direction: column;
  align-items: center;
  gap: 8px;
}

.add-avatar-placeholder {
  width: 64px;
  height: 64px;
  border-radius: 50%;
  background: rgba(108, 155, 210, 0.05);
  border: 2px dashed rgba(108, 155, 210, 0.3);
  display: flex;
  align-items: center;
  justify-content: center;
  
  .material-symbols-outlined {
    font-size: 28px;
    color: #6C9BD2;
  }
  
  &:active {
    background: rgba(108, 155, 210, 0.1);
    transform: scale(0.95);
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

.btn-hover {
  transform: scale(0.96) translateY(2px) !important;
  opacity: 0.9;
  filter: brightness(1.1);
}

.btn-hover-subtle {
  transform: scale(0.98) !important;
  background: rgba(108, 155, 210, 0.08) !important;
  border-color: #6C9BD2 !important;
}

.safe-area-spacer {
  height: calc(80px + env(safe-area-inset-bottom)); // Account for tab bar height + safe area
}

.no-scrollbar::-webkit-scrollbar {
  display: none;
}

/* Modal Mask */
.modal-mask {
  position: fixed;
  top: 0;
  left: 0;
  width: 100vw;
  height: 100vh;
  background: rgba(15, 23, 42, 0.6);
  backdrop-filter: blur(10px);
  display: flex;
  align-items: center;
  justify-content: center;
  z-index: 9999;
  transition: all 0.3s ease;
}

/* Modal Container */
.modal-container {
  width: 88%;
  max-width: 380px;
  background: #ffffff;
  border-radius: 28px;
  padding: 24px;
  box-shadow: 0 20px 50px rgba(15, 23, 42, 0.15);
  display: flex;
  flex-direction: column;
  gap: 20px;
  animation: modalBounce 0.4s cubic-bezier(0.175, 0.885, 0.32, 1.1) forwards;

  :deep(.dark) & {
    background: #1e293b;
    border: 1px solid rgba(255, 255, 255, 0.1);
  }
}

@keyframes modalBounce {
  from {
    opacity: 0;
    transform: scale(0.9) translateY(20px);
  }
  to {
    opacity: 1;
    transform: scale(1) translateY(0);
  }
}

.modal-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
}

.modal-title {
  font-size: 18px;
  font-weight: 800;
  color: #1e293b;

  :deep(.dark) & {
    color: #f1f5f9;
  }
}

.close-icon {
  font-size: 22px;
  color: #94a3b8;
  cursor: pointer;
  
  &:active {
    transform: scale(0.9);
  }
}

.modal-body {
  display: flex;
  flex-direction: column;
  gap: 16px;
}

.form-item {
  display: flex;
  flex-direction: column;
  gap: 8px;
}

.form-label {
  font-size: 13px;
  font-weight: 700;
  color: #64748b;

  :deep(.dark) & {
    color: #94a3b8;
  }
}

.form-input {
  height: 48px;
  background: #f8fafc;
  border: 1.5px solid rgba(108, 155, 210, 0.1);
  border-radius: 14px;
  padding: 0 16px;
  font-size: 14px;
  color: #1e293b;

  :deep(.dark) & {
    background: rgba(15, 23, 42, 0.4);
    border-color: rgba(255, 255, 255, 0.1);
    color: #f1f5f9;
  }
}

.form-textarea {
  height: 90px;
  background: #f8fafc;
  border: 1.5px solid rgba(108, 155, 210, 0.1);
  border-radius: 14px;
  padding: 12px 16px;
  font-size: 14px;
  color: #1e293b;

  :deep(.dark) & {
    background: rgba(15, 23, 42, 0.4);
    border-color: rgba(255, 255, 255, 0.1);
    color: #f1f5f9;
  }
}

.modal-footer {
  display: flex;
  gap: 12px;
  margin-top: 8px;
}

.modal-btn {
  flex: 1;
  height: 48px;
  border-radius: 16px;
  font-size: 15px;
  font-weight: 750;
  display: flex;
  align-items: center;
  justify-content: center;
  
  &::after { border: none; }
  
  &:active {
    transform: scale(0.97);
  }
  
  &.cancel {
    background: #f1f5f9;
    color: #475569;

    :deep(.dark) & {
      background: rgba(255, 255, 255, 0.05);
      color: #94a3b8;
    }
  }
  
  &.confirm {
    background: #6C9BD2;
    color: #ffffff;
    box-shadow: 0 6px 20px rgba(108, 155, 210, 0.3);
  }
}
</style>

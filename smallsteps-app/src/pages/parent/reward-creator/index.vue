<template>
  <view class="reward-creator-page">
    <view class="status-bar-placeholder"></view>
    
    <!-- 顶部导航 -->
    <view class="top-nav">
      <view class="back-btn" @click="goBack">
        <text class="material-symbols-outlined">close</text>
      </view>
      <text class="nav-title">添加新奖励</text>
      <view class="save-btn" :class="{ 'disabled': !isValid }" @click="handleSave">
        <text>保存</text>
      </view>
    </view>

    <view class="form-container">
      <!-- 预览区 -->
      <view class="reward-preview">
        <view class="preview-card">
          <text class="preview-icon">{{ form.icon || '🎁' }}</text>
          <text class="preview-name">{{ form.name || '奖励名称' }}</text>
          <view class="preview-cost">
            <text class="val">{{ form.pointsRequired || 0 }}</text>
            <text class="unit">星星</text>
          </view>
        </view>
      </view>

      <!-- 输入区 -->
      <view class="input-section">
        <view class="input-group">
          <text class="label">奖励名称</text>
          <input 
            v-model="form.name" 
            class="input-field" 
            placeholder="例如：看动画片30分钟" 
            placeholder-style="color: #9ca3af"
          />
        </view>

        <view class="input-group">
          <text class="label">所需星星</text>
          <view class="number-input">
            <input 
              v-model.number="form.pointsRequired" 
              type="number" 
              class="input-field" 
              placeholder="0"
            />
            <text class="suffix">颗星星</text>
          </view>
        </view>

        <view class="input-group">
          <text class="label">选择图标</text>
          <view class="icon-grid">
            <view 
              v-for="icon in iconList" 
              :key="icon" 
              class="icon-item" 
              :class="{ active: form.icon === icon }"
              @click="form.icon = icon"
            >
              {{ icon }}
            </view>
          </view>
        </view>
      </view>
    </view>
  </view>
</template>

<script setup lang="ts">
import { ref, computed } from 'vue'
import { addReward } from '@/api/reward'
import { useUserStore } from '@/store/modules/user'

const userStore = useUserStore()
const form = ref({
  name: '',
  pointsRequired: 10,
  icon: '🎁',
  stock: -1,
  status: '0'
})

const iconList = ['🎁', '🎮', '🍦', '🧸', '📚', '🎬', '🏞️', '🍕', '🎡', '🛹', '📱', '🚲']

const isValid = computed(() => {
  return form.value.name.trim().length > 0 && form.value.pointsRequired > 0
})

const goBack = () => {
  uni.navigateBack()
}

const handleSave = async () => {
  if (!isValid.value) return
  
  uni.showLoading({ title: '保存中...' })
  try {
    const payload = {
      ...form.value,
      userId: userStore.userInfo?.userId // 如果后端需要 userId
    }
    await addReward(payload)
    uni.hideLoading()
    uni.showToast({ title: '添加成功', icon: 'success' })
    
    // 延迟返回，让用户看到成功提示
    setTimeout(() => {
      uni.navigateBack()
    }, 1500)
  } catch (err: any) {
    uni.hideLoading()
    uni.showToast({ title: err.msg || '保存失败', icon: 'none' })
  }
}
</script>

<style lang="scss" scoped>
.reward-creator-page {
  min-height: 100vh;
  background-color: #f8f9fa;
}

.status-bar-placeholder {
  height: var(--status-bar-height);
  width: 100%;
  background-color: #ffffff;
}

.top-nav {
  height: 44px;
  background-color: #ffffff;
  display: flex;
  align-items: center;
  justify-content: space-between;
  padding: 0 16px;
  border-bottom: 1px solid #f0f0f0;

  .back-btn {
    width: 32px;
    height: 32px;
    display: flex;
    align-items: center;
    justify-content: center;
    .material-symbols-outlined { font-size: 24px; color: #6b7280; }
  }

  .nav-title { font-size: 18px; font-weight: 700; color: #111827; }

  .save-btn {
    padding: 6px 16px;
    background-color: #6C9BD2;
    color: white;
    border-radius: 999px;
    font-size: 14px;
    font-weight: 600;
    &.disabled { opacity: 0.5; background-color: #d1d5db; }
  }
}

.form-container {
  padding: 24px 16px;
}

.reward-preview {
  display: flex;
  justify-content: center;
  margin-bottom: 32px;
}

.preview-card {
  width: 160px;
  background-color: #ffffff;
  border-radius: 24px;
  padding: 24px;
  display: flex;
  flex-direction: column;
  align-items: center;
  box-shadow: 0 8px 24px rgba(0, 0, 0, 0.05);
  border: 2px solid #6C9BD2;

  .preview-icon { font-size: 48px; margin-bottom: 12px; }
  .preview-name { font-size: 16px; font-weight: 700; color: #111827; text-align: center; }
  .preview-cost {
    margin-top: 12px;
    display: flex;
    align-items: center;
    gap: 4px;
    background-color: #f0f7ff;
    padding: 4px 12px;
    border-radius: 999px;
    .val { font-size: 18px; font-weight: 800; color: #6C9BD2; }
    .unit { font-size: 12px; color: #6C9BD2; font-weight: 600; }
  }
}

.input-section {
  display: flex;
  flex-direction: column;
  gap: 24px;
}

.input-group {
  display: flex;
  flex-direction: column;
  gap: 8px;

  .label { font-size: 14px; font-weight: 700; color: #374151; margin-left: 4px; }
  .input-field {
    height: 50px;
    background-color: #ffffff;
    border-radius: 12px;
    padding: 0 16px;
    font-size: 16px;
    color: #111827;
  }
}

.number-input {
  display: flex;
  align-items: center;
  background-color: #ffffff;
  border-radius: 12px;
  padding-right: 16px;
  .input-field { flex: 1; border-radius: 12px 0 0 12px; }
  .suffix { font-size: 14px; color: #6b7280; font-weight: 600; }
}

.icon-grid {
  display: grid;
  grid-template-columns: repeat(6, 1fr);
  gap: 12px;
  padding: 8px 0;

  .icon-item {
    width: 44px;
    height: 44px;
    background-color: #ffffff;
    border-radius: 12px;
    display: flex;
    align-items: center;
    justify-content: center;
    font-size: 24px;
    transition: all 0.2s ease;
    border: 2px solid transparent;

    &.active {
      background-color: #f0f7ff;
      border-color: #6C9BD2;
      transform: scale(1.1);
    }
  }
}
</style>

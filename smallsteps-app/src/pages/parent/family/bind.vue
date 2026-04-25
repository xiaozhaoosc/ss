<template>
  <view class="bind-page">
    <top-bar title="绑定孩子档案" back-btn />
    
    <view class="content">
      <view class="header">
        <text class="title">关联新档案</text>
        <text class="subtitle">请输入孩子账号的用户名进行关联</text>
      </view>

      <view class="input-section">
        <view class="input-box">
          <text class="material-symbols-outlined icon">person</text>
          <input 
            v-model="userName" 
            class="input" 
            placeholder="请输入孩子用户名" 
            placeholder-style="color: #9ca3af"
          />
        </view>
      </view>

      <view class="tip-section">
        <view class="tip-card">
          <text class="material-symbols-outlined tip-icon">info</text>
          <text class="tip-text">关联后，您可以查看孩子的任务完成情况、情绪状态并进行奖励设置。</text>
        </view>
      </view>

      <button 
        class="bind-btn" 
        :loading="loading" 
        :disabled="!userName"
        @click="handleBind"
      >
        立即绑定
      </button>
    </view>
  </view>
</template>

<script setup>
import { ref } from 'vue'
import TopBar from '@/components/common/top-bar/top-bar.vue'
import { bindChild } from '@/api/family'

const userName = ref('')
const loading = ref(false)

const handleBind = async () => {
  if (!userName.value) return

  debugger
  loading.value = true
  try {
    const res = await bindChild({ userName: userName.value })
    if (res.code === 200 || res.code === '200') {
      uni.showToast({ title: '绑定成功', icon: 'success' })
      setTimeout(() => {
        uni.navigateBack()
      }, 1500)
    }else{
      uni.showToast({ title: res.msg, icon: 'warn' })
    }
  } catch (e) {
    console.error('[Page Debug] Bind failed details:', e)
    // 如果 request.ts 已经处理了业务错误（弹出了 Modal 或 Toast），这里可以保持静默
    // 否则（如代码运行时错误），才进行兜底提示
    if (!e?._isBusinessError) {
      const errorMsg = e?.msg || e?.message || (typeof e === 'string' ? e : '操作失败')
      uni.showToast({ title: errorMsg, icon: 'none' })
    }
  } finally {
    loading.value = false
  }
}
</script>

<style lang="scss" scoped>
.bind-page {
  height: 100vh;
  background-color: #f6f7f8;
}

.content {
  padding: 24px;
  padding-top: 80px;
}

.header {
  margin-bottom: 32px;
  display: flex;
  flex-direction: column;
  gap: 8px;
}

.title {
  font-size: 24px;
  font-weight: 700;
  color: #111827;
}

.subtitle {
  font-size: 14px;
  color: #6b7280;
}

.input-section {
  margin-bottom: 24px;
}

.input-box {
  display: flex;
  align-items: center;
  gap: 12px;
  padding: 16px;
  background-color: #ffffff;
  border-radius: 12px;
  border: 1px solid #e5e7eb;
  transition: border-color 0.3s;
  
  &:focus-within {
    border-color: #6C9BD2;
  }
}

.icon {
  color: #9ca3af;
  font-size: 20px;
}

.input {
  flex: 1;
  font-size: 16px;
  color: #111827;
}

.tip-section {
  margin-bottom: 40px;
}

.tip-card {
  display: flex;
  gap: 12px;
  padding: 16px;
  background-color: rgba(108, 155, 210, 0.05);
  border-radius: 12px;
  border: 1px solid rgba(108, 155, 210, 0.1);
}

.tip-icon {
  color: #6C9BD2;
  font-size: 20px;
}

.tip-text {
  flex: 1;
  font-size: 13px;
  line-height: 1.5;
  color: #4b5563;
}

.bind-btn {
  width: 100%;
  height: 52px;
  background-color: #6C9BD2;
  color: #ffffff;
  font-weight: 700;
  border-radius: 12px;
  display: flex;
  align-items: center;
  justify-content: center;
  border: none;
  box-shadow: 0 4px 12px rgba(108, 155, 210, 0.2);
  
  &:disabled {
    background-color: #d1d5db;
    box-shadow: none;
  }
  
  &::after { border: none; }
}
</style>

<template>
  <view class="security-page">
    <top-bar title="账号安全" show-back />
    
    <view class="main-content">
      <!-- Password Section -->
      <view class="section">
        <text class="section-title">修改密码</text>
        <view class="form-card">
          <view class="input-group" :class="{ 'has-error': errors.oldPassword }">
            <text class="input-label">当前密码</text>
            <input 
              type="password" 
              v-model="user.oldPassword" 
              placeholder="请输入旧密码" 
              class="native-input"
              placeholder-style="color: #9ca3af"
            />
            <text v-if="errors.oldPassword" class="error-msg">{{ errors.oldPassword }}</text>
          </view>
          
          <view class="divider"></view>
          
          <view class="input-group" :class="{ 'has-error': errors.newPassword }">
            <text class="input-label">新密码</text>
            <input 
              type="password" 
              v-model="user.newPassword" 
              placeholder="6-20位字符" 
              class="native-input"
              placeholder-style="color: #9ca3af"
            />
            <text v-if="errors.newPassword" class="error-msg">{{ errors.newPassword }}</text>
          </view>
          
          <view class="divider"></view>
          
          <view class="input-group" :class="{ 'has-error': errors.confirmPassword }">
            <text class="input-label">确认新密码</text>
            <input 
              type="password" 
              v-model="user.confirmPassword" 
              placeholder="请再次输入新密码" 
              class="native-input"
              placeholder-style="color: #9ca3af"
            />
            <text v-if="errors.confirmPassword" class="error-msg">{{ errors.confirmPassword }}</text>
          </view>
          
          <button class="submit-btn" @click="submit">更新密码</button>
        </view>
      </view>

      <!-- Sensitive Actions Section -->
      <view class="section">
        <text class="section-title danger">危险操作</text>
        <view class="form-card danger-card">
          <view class="row" @click="handleDeleteAccount">
            <view class="row-left">
              <text class="material-symbols-outlined icon">delete_forever</text>
              <view class="info">
                <text class="title">注销账号</text>
                <text class="desc">永久删除账号及所有关联的孩子档案</text>
              </view>
            </view>
            <text class="material-symbols-outlined arrow">chevron_right</text>
          </view>
        </view>
      </view>
    </view>
  </view>
</template>

<script setup>
import { updateUserPwd } from "@/api/system/user"
import { ref, reactive, getCurrentInstance } from "vue"
import TopBar from '@/components/common/top-bar/top-bar.vue'

const { proxy } = getCurrentInstance()
const user = reactive({
  oldPassword: '',
  newPassword: '',
  confirmPassword: ''
})

const errors = ref({
  oldPassword: '',
  newPassword: '',
  confirmPassword: ''
})

function validate() {
  let isValid = true
  errors.value = { oldPassword: '', newPassword: '', confirmPassword: '' }

  if (!user.oldPassword) {
    errors.value.oldPassword = '请输入旧密码'
    isValid = false
  }

  if (!user.newPassword) {
    errors.value.newPassword = '请输入新密码'
    isValid = false
  } else if (user.newPassword.length < 6 || user.newPassword.length > 20) {
    errors.value.newPassword = '长度在 6 到 20 个字符'
    isValid = false
  }

  if (!user.confirmPassword) {
    errors.value.confirmPassword = '请确认新密码'
    isValid = false
  } else if (user.newPassword !== user.confirmPassword) {
    errors.value.confirmPassword = '两次输入的密码不一致'
    isValid = false
  }

  return isValid
}

function submit() {
  if (!validate()) {
    const firstError = Object.values(errors.value).find(msg => msg !== "")
    if (firstError) {
      proxy.$modal.msgError(firstError)
    }
    return
  }

  updateUserPwd(user.oldPassword, user.newPassword).then(() => {
    if (proxy && proxy.$modal) {
      proxy.$modal.msgSuccess("修改成功")
    } else {
      uni.showToast({ title: '修改成功', icon: 'success' })
    }
    setTimeout(() => uni.navigateBack(), 1500)
  }).catch(err => {
    console.log('密码修改失败', err)
    const errMsg = typeof err === 'string' ? err : (err && err.msg ? err.msg : "修改失败，请重试")
    if (proxy && proxy.$modal) {
      proxy.$modal.msgError(errMsg)
    } else {
      uni.showToast({ title: errMsg, icon: 'error' })
    }
  })
}

function handleDeleteAccount() {
  uni.showModal({
    title: '极其重要',
    content: '注销账号将导致所有数据（任务记录、星星奖励、档案）被永久删除且无法恢复。您确定吗？',
    confirmColor: '#ef4444',
    confirmText: '确定注销',
    success: (res) => {
      if (res.confirm) {
        proxy.$modal.msgSuccess("注销申请已提交")
      }
    }
  })
}
</script>

<style lang="scss" scoped>
.security-page {
  min-height: 100vh;
  background-color: #f6f7f8;
}

.main-content {
  padding: 16px;
  padding-top: 76px;
}

.section {
  margin-bottom: 32px;
}

.section-title {
  font-size: 14px;
  font-weight: 600;
  color: #9ca3af;
  margin-bottom: 12px;
  margin-left: 4px;
  &.danger { color: #ef4444; }
}

.form-card {
  background-color: #ffffff;
  border-radius: 16px;
  padding: 16px;
  box-shadow: 0 4px 12px rgba(0, 0, 0, 0.03);
}

.input-group {
  padding: 12px 0;
  display: flex;
  flex-direction: column;
  
  .input-label {
    font-size: 13px;
    font-weight: 600;
    color: #4b5563;
    margin-bottom: 8px;
  }

  .native-input {
    height: 40px;
    font-size: 15px;
    color: #1f2937;
    padding: 0 4px;
    width: 100%;
    box-sizing: border-box;
  }

  &.has-error {
    .native-input {
      color: #ef4444;
    }
  }
}

.divider {
  height: 1px;
  background-color: #f3f4f6;
  margin: 4px 0;
}

.error-msg {
  font-size: 12px;
  color: #ef4444;
  margin-top: 4px;
  padding-left: 4px;
}

.submit-btn {
  margin-top: 24px;
  height: 48px;
  background: linear-gradient(135deg, #6C9BD2 0%, #8EADDA 100%);
  color: white;
  border-radius: 12px;
  font-size: 16px;
  font-weight: 600;
  display: flex;
  align-items: center;
  justify-content: center;
  box-shadow: 0 4px 12px rgba(108, 155, 210, 0.2);
  transition: all 0.2s ease;
  
  &:active {
    transform: translateY(1px);
    box-shadow: 0 2px 6px rgba(108, 155, 210, 0.1);
  }
  
  &::after { border: none; }
}

.danger-card {
  padding: 0;
  overflow: hidden;
}

.row {
  display: flex;
  align-items: center;
  justify-content: space-between;
  padding: 16px;
  transition: background-color 0.2s ease;
  
  &:active { background-color: #fff1f2; }
}

.row-left {
  display: flex;
  align-items: center;
  gap: 16px;
  
  .icon { color: #ef4444; font-size: 24px; }
  
  .info {
    display: flex;
    flex-direction: column;
    
    .title { font-size: 16px; font-weight: 500; color: #1f2937; }
    .desc { font-size: 12px; color: #9ca3af; }
  }
}

.arrow { color: #d1d5db; }
</style>


<template>
  <view class="security-page">
    <top-bar title="账号安全" show-back />
    
    <view class="main-content">
      <!-- Password Section -->
      <view class="section">
        <text class="section-title">修改密码</text>
        <view class="form-card">
          <uni-forms ref="form" :model="user" labelWidth="0">
            <view class="input-group">
              <text class="input-label">当前密码</text>
              <uni-easyinput type="password" v-model="user.oldPassword" :inputBorder="false" placeholder="请输入旧密码" />
            </view>
            <view class="divider"></view>
            <view class="input-group">
              <text class="input-label">新密码</text>
              <uni-easyinput type="password" v-model="user.newPassword" :inputBorder="false" placeholder="6-20位字符" />
            </view>
            <view class="divider"></view>
            <view class="input-group">
              <text class="input-label">确认新密码</text>
              <uni-easyinput type="password" v-model="user.confirmPassword" :inputBorder="false" placeholder="请再次输入新密码" />
            </view>
          </uni-forms>
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
import { onReady } from "@dcloudio/uni-app"
import TopBar from '@/components/common/top-bar/top-bar.vue'

const { proxy } = getCurrentInstance()
const user = reactive({
  oldPassword: '',
  newPassword: '',
  confirmPassword: ''
})

const rules = {
  oldPassword: {
    rules: [{ required: true, errorMessage: '请输入旧密码' }]
  },
  newPassword: {
    rules: [
      { required: true, errorMessage: '请输入新密码' },
      { minLength: 6, maxLength: 20, errorMessage: '长度在 6 到 20 个字符' }
    ]
  },
  confirmPassword: {
    rules: [
      { required: true, errorMessage: '请确认新密码' },
      {
        validateFunction: (rule, value, data) => user.newPassword === value,
        errorMessage: '两次输入的密码不一致'
      }
    ]
  }
}

onReady(() => {
  proxy.$refs.form.setRules(rules)
})

function submit() {
  proxy.$refs.form.validate().then(() => {
    updateUserPwd(user.oldPassword, user.newPassword).then(() => {
      proxy.$modal.msgSuccess("修改成功")
      setTimeout(() => uni.navigateBack(), 1500)
    })
  }).catch(err => {
    console.log('表单校验失败', err)
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
  padding-top: 60px;
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
  &.danger { color: #f87171; }
}

.form-card {
  background-color: #ffffff;
  border-radius: 16px;
  padding: 16px;
  box-shadow: 0 4px 12px rgba(0, 0, 0, 0.03);
}

.input-group {
  padding: 8px 0;
  
  .input-label {
    font-size: 12px;
    color: #6b7280;
    margin-bottom: 4px;
    display: block;
  }
}

.divider {
  height: 1px;
  background-color: #f3f4f6;
  margin: 4px 0;
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
    
    .title { font-size: 16px; font-weight: 500; color: #111827; }
    .desc { font-size: 12px; color: #9ca3af; }
  }
}

.arrow { color: #d1d5db; }
</style>

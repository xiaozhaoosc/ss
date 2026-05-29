<template>
  <view class="edit-profile-page">
    <top-bar title="个人信息" show-back />
    
    <view class="main-content">
      <view class="form-card">
        <!-- Nickname -->
        <view class="input-group" :class="{ 'has-error': errors.nickName }">
          <text class="input-label">用户昵称</text>
          <input 
            type="text" 
            v-model="user.nickName" 
            placeholder="请输入昵称" 
            class="native-input"
            placeholder-style="color: #9ca3af"
          />
          <text v-if="errors.nickName" class="error-msg">{{ errors.nickName }}</text>
        </view>
        
        <view class="divider"></view>
        
        <!-- Phone Number -->
        <view class="input-group" :class="{ 'has-error': errors.phonenumber }">
          <text class="input-label">手机号码</text>
          <input 
            type="number" 
            maxlength="11"
            v-model="user.phonenumber" 
            placeholder="请输入手机号码" 
            class="native-input"
            placeholder-style="color: #9ca3af"
          />
          <text v-if="errors.phonenumber" class="error-msg">{{ errors.phonenumber }}</text>
        </view>
        
        <view class="divider"></view>
        
        <!-- Email -->
        <view class="input-group" :class="{ 'has-error': errors.email }">
          <text class="input-label">邮箱</text>
          <input 
            type="text" 
            v-model="user.email" 
            placeholder="请输入邮箱" 
            class="native-input"
            placeholder-style="color: #9ca3af"
          />
          <text v-if="errors.email" class="error-msg">{{ errors.email }}</text>
        </view>
        
        <view class="divider"></view>
        
        <!-- Sex / Gender Selector -->
        <view class="input-group">
          <text class="input-label">性别</text>
          <view class="gender-selector">
            <view 
              class="gender-item boy" 
              :class="{ active: user.sex === '0' || user.sex === 0 }" 
              @click="user.sex = '0'"
            >
              <text class="gender-icon">👦</text>
              <text class="gender-text">男</text>
            </view>
            <view 
              class="gender-item girl" 
              :class="{ active: user.sex === '1' || user.sex === 1 }" 
              @click="user.sex = '1'"
            >
              <text class="gender-icon">👧</text>
              <text class="gender-text">女</text>
            </view>
          </view>
        </view>
      </view>

      <button class="submit-btn" @click="submit">保存修改</button>
    </view>
  </view>
</template>

<script setup>
  import { getUserProfile } from "@/api/system/user"
  import { updateUserProfile } from "@/api/system/user"
  import { ref, getCurrentInstance } from "vue"
  import TopBar from '@/components/common/top-bar/top-bar.vue'
  import { useUserStore } from "@/store/modules/user"

  const userStore = useUserStore()
  const { proxy } = getCurrentInstance()
  const user = ref({
    nickName: "",
    phonenumber: "",
    email: "",
    sex: "0"
  })

  const errors = ref({
    nickName: "",
    phonenumber: "",
    email: ""
  })

  function getUser() {
    getUserProfile().then(response => {
      user.value = response.data
    })
  }

  function validate() {
    let isValid = true
    errors.value = { nickName: "", phonenumber: "", email: "" }

    if (!user.value.nickName || !user.value.nickName.trim()) {
      errors.value.nickName = "用户昵称不能为空"
      isValid = false
    }

    if (!user.value.phonenumber) {
      errors.value.phonenumber = "手机号码不能为空"
      isValid = false
    } else if (!/^1[3-9]\d{9}$/.test(user.value.phonenumber)) {
      errors.value.phonenumber = "请输入正确的 11 位手机号码"
      isValid = false
    }

    if (!user.value.email) {
      errors.value.email = "邮箱地址不能为空"
      isValid = false
    } else if (!/^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(user.value.email)) {
      errors.value.email = "请输入正确的邮箱地址"
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

    // 统一将性别转成字符串 "0" 或 "1"
    user.value.sex = String(user.value.sex)

    updateUserProfile(user.value).then(response => {
      proxy.$modal.msgSuccess("修改成功")
      userStore.getUserInfo() // 重新加载全局个人用户信息以同步头像及昵称
      setTimeout(() => {
        uni.navigateBack()
      }, 1500)
    })
  }

  getUser()
</script>

<style lang="scss" scoped>
.edit-profile-page {
  min-height: 100vh;
  background-color: #f6f7f8;
}

.main-content {
  padding: 16px;
  padding-top: 76px;
}

.form-card {
  background-color: #ffffff;
  border-radius: 16px;
  padding: 16px;
  box-shadow: 0 4px 12px rgba(0, 0, 0, 0.03);
  margin-bottom: 24px;
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

.gender-selector {
  display: flex;
  gap: 16px;
  margin-top: 4px;
}

.gender-item {
  flex: 1;
  display: flex;
  align-items: center;
  justify-content: center;
  gap: 8px;
  height: 46px;
  border-radius: 12px;
  border: 1.5px solid #e5e7eb;
  background-color: #f9fafb;
  transition: all 0.25s ease;
  
  .gender-icon {
    font-size: 16px;
  }
  
  .gender-text {
    font-size: 14px;
    font-weight: 500;
    color: #6b7280;
  }

  &:active {
    transform: scale(0.98);
  }

  &.boy.active {
    border-color: #6C9BD2;
    background-color: #eff6ff;
    .gender-text {
      color: #6C9BD2;
      font-weight: 600;
    }
  }

  &.girl.active {
    border-color: #f472b6;
    background-color: #fdf2f8;
    .gender-text {
      color: #f472b6;
      font-weight: 600;
    }
  }
}

.submit-btn {
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
  
  &::after { 
    border: none; 
  }
}
</style>


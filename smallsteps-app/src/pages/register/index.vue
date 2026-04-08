<template>
  <view class="register-container">
    <!-- Header Section -->
    <view class="header-section">
      <view class="title-box">
        <text class="app-name">加入 Small Steps</text>
        <text class="app-slogan">开始您和孩子的成长之旅</text>
      </view>
    </view>

    <!-- Form Section -->
    <view class="form-section">
      <view class="input-group">
        <!-- 租户选择 (如果启用) -->
        <view class="input-item" v-if="tenantEnabled">
          <text class="iconfont icon-home input-icon"></text>
          <picker @change="handleTenantChange" :value="tenantIndex" :range="tenantList" range-key="companyName" class="input-picker">
            <view class="picker-text">{{ tenantList[tenantIndex] ? tenantList[tenantIndex].companyName : '选择租户' }}</view>
          </picker>
        </view>
        <view class="input-item">
          <text class="iconfont icon-user input-icon"></text>
          <input 
            v-model="registerForm.username" 
            class="input" 
            type="text" 
            placeholder="设置账号" 
            placeholder-class="input-placeholder"
            maxlength="30" 
          />
        </view>
        
        <view class="input-item">
          <text class="iconfont icon-password input-icon"></text>
          <input 
            v-model="registerForm.password" 
            type="password" 
            class="input" 
            placeholder="设置密码" 
            placeholder-class="input-placeholder"
            maxlength="20" 
          />
        </view>

        <view class="input-item">
          <text class="iconfont icon-password input-icon"></text>
          <input 
            v-model="registerForm.confirmPassword" 
            type="password" 
            class="input" 
            placeholder="确认密码" 
            placeholder-class="input-placeholder"
            maxlength="20" 
          />
        </view>

        <view class="input-item captcha-item" v-if="captchaEnabled">
          <text class="iconfont icon-safe input-icon"></text>
          <input 
            v-model="registerForm.code" 
            type="number" 
            class="input" 
            placeholder="验证码" 
            placeholder-class="input-placeholder"
            maxlength="4" 
          />
          <image :src="codeUrl" @click="getCode" class="captcha-img" mode="aspectFit"></image>
        </view>
      </view>

      <view class="action-section">
        <button 
          @click="handleRegister" 
          class="register-btn" 
          :loading="isRegistering"
          :disabled="isRegistering"
        >
          {{ isRegistering ? '注册中...' : '立即注册' }}
        </button>
        
        <view class="links">
          <text class="text-grey">已有账号？</text>
          <text class="link-text" @click="handleUserLogin">直接登录</text>
        </view>
      </view>
    </view>
    
    <!-- Footer Section -->
    <view class="footer-section">
      <view class="agreement-box">
        <text class="text-grey">点击注册即代表同意</text>
        <text @click="handleUserAgrement" class="link-blue">《用户协议》</text>
        <text class="text-grey">&</text>
        <text @click="handlePrivacy" class="link-blue">《隐私协议》</text>
      </view>
    </view>
  </view>
</template>

<script setup>
  import { getCodeImg, register, getTenantList } from '@/api/login'
  import { ref, getCurrentInstance } from "vue"
  import { onLoad } from "@dcloudio/uni-app"

  const { proxy } = getCurrentInstance()
  const codeUrl = ref("")
  const captchaEnabled = ref(false)
  const isRegistering = ref(false)
  const tenantEnabled = ref(false)
  const tenantList = ref([])
  const tenantIndex = ref(0)

  const registerForm = ref({
    username: "",
    password: "",
    confirmPassword: "",
    code: "",
    uuid: "",
    tenantId: "000000",
    userType: "sys_user",
    clientId: "428a8310cd442757ae699df5d894f051",
    grantType: "password"
  })

  // Navigation
  function handleUserLogin() {
    uni.navigateBack()
  }

  function handlePrivacy() {
    uni.navigateTo({
      url: '/pages/common/textview/index?title=隐私政策&key=privacyPolicy'
    })
  }

  function handleUserAgrement() {
    uni.navigateTo({
      url: '/pages/common/textview/index?title=用户协议&key=userAgreement'
    })
  }

  // Logic
  function getCode() {
    getCodeImg().then(res => {
      const data = res.data || {}
      captchaEnabled.value = data.captchaEnabled === undefined ? false : data.captchaEnabled
      if (captchaEnabled.value) {
        codeUrl.value = 'data:image/gif;base64,' + data.img
        registerForm.value.uuid = data.uuid
      } else {
        registerForm.value.code = ""
        registerForm.value.uuid = ""
      }
    })
  }

  async function initTenantList() {
    try {
      const res = await getTenantList()
      const data = res.data || {}
      tenantEnabled.value = data.tenantEnabled === undefined ? false : data.tenantEnabled
      if (tenantEnabled.value) {
        tenantList.value = data.voList || []
        if (tenantList.value.length > 0) {
          registerForm.value.tenantId = tenantList.value[0].tenantId
        }
      }
    } catch (error) {
      console.error('获取租户列表失败:', error)
    }
  }

  function handleTenantChange(e) {
    tenantIndex.value = e.detail.value
    registerForm.value.tenantId = tenantList.value[tenantIndex.value].tenantId
  }

  async function handleRegister() {
    if (!registerForm.value.username) {
      return uni.showToast({ title: "请输入账号", icon: "none" })
    }
    if (!registerForm.value.password) {
      return uni.showToast({ title: "请输入密码", icon: "none" })
    }
    if (registerForm.value.password.length < 5) {
      return uni.showToast({ title: "密码长度不能少于5位", icon: "none" })
    }
    if (!registerForm.value.confirmPassword) {
      return uni.showToast({ title: "请输入确认密码", icon: "none" })
    }
    if (registerForm.value.password !== registerForm.value.confirmPassword) {
      return uni.showToast({ title: "两次输入的密码不一致", icon: "none" })
    }
    if (captchaEnabled.value && !registerForm.value.code) {
      return uni.showToast({ title: "请输入验证码", icon: "none" })
    }

    isRegistering.value = true
    try {
      await register(registerForm.value)
      uni.showModal({
        title: "欢迎加入",
        content: `账号 ${registerForm.value.username} 注册成功！`,
        showCancel: false,
        confirmText: "去登录",
        success: function (res) {
          if (res.confirm) {
            uni.navigateBack()
          }
        }
      })
    } catch (error) {
       if (captchaEnabled.value) {
        getCode()
      }
    } finally {
      isRegistering.value = false
    }
  }

  onLoad(() => {
    getCode()
    initTenantList()
  })
</script>

<style lang="scss" scoped>
  .register-container {
    min-height: 100vh;
    background: linear-gradient(135deg, #f6f7f8 0%, #eef2f3 100%);
    padding: 60rpx;
    display: flex;
    flex-direction: column;
    justify-content: center;
  }

  .header-section {
    margin-bottom: 60rpx;
    padding-left: 20rpx;
    
    .title-box {
      display: flex;
      flex-direction: column;
      
      .app-name {
        font-size: 56rpx;
        font-weight: bold;
        color: #333;
        margin-bottom: 16rpx;
        font-family: 'Manrope', sans-serif;
      }
      
      .app-slogan {
        font-size: 30rpx;
        color: #888;
      }
    }
  }

  .form-section {
    background: #ffffff;
    border-radius: 40rpx;
    padding: 60rpx 40rpx;
    box-shadow: 0 20rpx 60rpx rgba(0, 0, 0, 0.05);
  }

  .input-group {
    margin-bottom: 50rpx;
  }

  .input-item {
    display: flex;
    align-items: center;
    background: #f8f9fa;
    border-radius: 24rpx;
    height: 100rpx;
    padding: 0 30rpx;
    margin-bottom: 30rpx;
    transition: all 0.3s ease;
    border: 2rpx solid transparent;

    &:focus-within {
      background: #ffffff;
      border-color: var(--parent-primary, #6C9BD2);
      box-shadow: 0 0 0 6rpx rgba(108, 155, 210, 0.1);
    }

    .input-icon {
      font-size: 40rpx;
      color: #b0b0b0;
      margin-right: 20rpx;
    }

    .input {
      flex: 1;
      height: 100%;
      font-size: 30rpx;
      color: #333;
    }

    .input-picker {
      flex: 1;
      height: 100%;
      display: flex;
      align-items: center;
      
      .picker-text {
        font-size: 30rpx;
        color: #333;
      }
    }
    
    .input-placeholder {
      color: #c0c0c0;
    }
  }

  .captcha-item {
    padding-right: 10rpx;
    
    .captcha-img {
      width: 200rpx;
      height: 80rpx;
      border-radius: 16rpx;
    }
  }

  .action-section {
    .register-btn {
      background: var(--child-mint, #8CD0A1); // Green for "Go"/Start
      color: #ffffff;
      font-size: 32rpx;
      font-weight: 600;
      height: 100rpx;
      line-height: 100rpx;
      border-radius: 50rpx;
      box-shadow: 0 10rpx 20rpx rgba(140, 208, 161, 0.3);
      border: none;
      
      &:active {
        transform: scale(0.98);
        filter: brightness(0.95);
      }
      
      &[disabled] {
        opacity: 0.7;
      }
    }

    .links {
      margin-top: 40rpx;
      display: flex;
      justify-content: center;
      align-items: center;
      font-size: 28rpx;
      
      .text-grey {
        color: #888;
        margin-right: 10rpx;
      }
      
      .link-text {
        color: var(--parent-primary, #6C9BD2);
        font-weight: 600;
        padding: 10rpx;
      }
    }
  }

  .footer-section {
    position: absolute;
    bottom: 60rpx;
    left: 0;
    width: 100%;
    
    .agreement-box {
      display: flex;
      justify-content: center;
      align-items: center;
      font-size: 24rpx;
      
      .text-grey {
        color: #b0b0b0;
      }
      
      .link-blue {
        color: var(--parent-primary, #6C9BD2);
        padding: 0 4rpx;
      }
    }
  }
</style>

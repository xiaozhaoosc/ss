<template>
  <view class="login-container">
    <!-- Header Section -->
    <view class="header-section">
      <view class="logo-box">
        <image class="logo" :src="globalConfig.appInfo.logo" mode="aspectFit"></image>
      </view>
      <view class="title-box">
        <text class="app-name">Small Steps</text>
        <text class="app-slogan">每一次进步，都值得被看见</text>
      </view>
    </view>

    <!-- Form Section -->
    <view class="form-section">
      <view class="welcome-text">欢迎回来</view>
      
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
            v-model="loginForm.username" 
            class="input" 
            type="text" 
            placeholder="账号" 
            placeholder-class="input-placeholder"
            maxlength="30" 
          />
        </view>
        
        <view class="input-item">
          <text class="iconfont icon-password input-icon"></text>
          <input 
            v-model="loginForm.password" 
            type="password" 
            class="input" 
            placeholder="密码" 
            placeholder-class="input-placeholder"
            maxlength="20" 
          />
        </view>

        <view class="input-item captcha-item" v-if="captchaEnabled">
          <text class="iconfont icon-safe input-icon"></text>
          <input 
            v-model="loginForm.code" 
            type="number" 
            class="input" 
            placeholder="验证码" 
            placeholder-class="input-placeholder"
            maxlength="4" 
          />
          <image :src="codeUrl" @click="getCode" class="captcha-img" mode="aspectFit"></image>
        </view>
      </view>
      <view class="options-section">
        <label class="checkbox-item" @click="loginForm.rememberMe = !loginForm.rememberMe">
          <checkbox :checked="loginForm.rememberMe" color="#6C9BD2" style="transform:scale(0.7)" />
          <text class="text-grey">记住密码</text>
        </label>
      </view>

      <view class="action-section">
        <button 
          @click="handleLogin" 
          class="login-btn" 
          :loading="isLoggingIn"
          :disabled="isLoggingIn"
        >
          {{ isLoggingIn ? '登录中...' : '登 录' }}
        </button>
        
        <view class="links">
          <text class="link-text" @click="handleUserRegister">注册账号</text>
          <text class="divider">|</text>
          <text class="link-text" @click="handleForgetPwd">忘记密码?</text>
        </view>
      </view>
    </view>
    
    <!-- Footer Section -->
    <view class="footer-section">
      <view class="agreement-box">
        <text class="text-grey">登录即代表同意</text>
        <text @click="handleUserAgrement" class="link-blue">《用户协议》</text>
        <text class="text-grey">&</text>
        <text @click="handlePrivacy" class="link-blue">《隐私协议》</text>
      </view>
    </view>
  </view>
</template>

<script setup>
  import { ref, getCurrentInstance } from "vue"
  import { onLoad } from "@dcloudio/uni-app"
  import { getCodeImg, getTenantList } from '@/api/login'
  import { useUserStore } from '@/store/modules/user'
  import { useConfigStore } from '@/store/modules/config' 

  const { proxy } = getCurrentInstance()
  const globalConfig = {
    appInfo: {
      logo: '/static/logo200.png', 
    }
  }

  const codeUrl = ref("")
  const captchaEnabled = ref(true)
  const isLoggingIn = ref(false)
  const tenantEnabled = ref(false)
  const tenantList = ref([])
  const tenantIndex = ref(0)
  
  const loginForm = ref({
    username: "",
    password: "",
    rememberMe: false,
    code: "",
    uuid: "",
    tenantId: "000000",
    clientId: "428a8310cd442757ae699df5d894f051",
    grantType: "password"
  })

  // Navigation
  function handleUserRegister() {
    uni.navigateTo({ url: '/pages/register/index' })
  }
  
  function handleForgetPwd() {
    uni.showToast({ title: '请联系管理员重置', icon: 'none' })
  }

  // 隐私协议
  function handlePrivacy() {
    uni.navigateTo({
      url: '/pages/common/textview/index?title=隐私政策&key=privacyPolicy'
    })
  }

  // 用户协议
  function handleUserAgrement() {
    uni.navigateTo({
      url: '/pages/common/textview/index?title=用户协议&key=userAgreement'
    })
  }

  async function getCode() {
    try {
      const res = await getCodeImg()
      const data = res.data || {}
      captchaEnabled.value = data.captchaEnabled === undefined ? true : data.captchaEnabled
      if (captchaEnabled.value) {
        codeUrl.value = 'data:image/gif;base64,' + data.img
        loginForm.value.uuid = data.uuid
      } else {
        loginForm.value.code = ""
        loginForm.value.uuid = ""
      }
    } catch (error) {
      console.error('获取验证码失败:', error)
    }
  }

  async function initTenantList() {
    try {
      const res = await getTenantList()
      const data = res.data || {}
      tenantEnabled.value = data.tenantEnabled === undefined ? true : data.tenantEnabled
      if (tenantEnabled.value) {
        tenantList.value = data.voList || []
        if (tenantList.value.length > 0) {
          // 查找本地是否有记住的ID
          const savedTenantId = uni.getStorageSync('tenantId')
          const index = tenantList.value.findIndex(item => item.tenantId === savedTenantId)
          if (index !== -1) {
            tenantIndex.value = index
            loginForm.value.tenantId = savedTenantId
          } else {
            loginForm.value.tenantId = tenantList.value[0].tenantId
          }
        }
      }
    } catch (error) {
      console.error('获取租户列表失败:', error)
    }
  }

  function handleTenantChange(e) {
    tenantIndex.value = e.detail.value
    loginForm.value.tenantId = tenantList.value[tenantIndex.value].tenantId
  }

  async function handleLogin() {
    if (!loginForm.value.username) {
      return uni.showToast({ title: "请输入账号", icon: "none" })
    }
    if (!loginForm.value.password) {
      return uni.showToast({ title: "请输入密码", icon: "none" })
    }
    if (captchaEnabled.value && !loginForm.value.code) {
      return uni.showToast({ title: "请输入验证码", icon: "none" })
    }

    isLoggingIn.value = true
    try {
      // 记住密码逻辑 (使用 uni storage)
      if (loginForm.value.rememberMe) {
        uni.setStorageSync('rememberMe', true)
        uni.setStorageSync('username', loginForm.value.username)
        uni.setStorageSync('password', loginForm.value.password)
        uni.setStorageSync('tenantId', loginForm.value.tenantId)
      } else {
        uni.removeStorageSync('rememberMe')
        uni.removeStorageSync('username')
        uni.removeStorageSync('password')
        uni.removeStorageSync('tenantId')
      }

      const userStore = useUserStore()
      await userStore.login(loginForm.value)
      
      // 角色分流 (Store 已自动处理角色更新)
      if (userStore.role === 'child') {
        uni.reLaunch({ url: '/pages/child/home/index' })
      } else {
        uni.reLaunch({ url: '/pages/parent/dashboard/index' })
      }
    } catch (error) {
      if (captchaEnabled.value) {
        getCode()
      }
    } finally {
      isLoggingIn.value = false
    }
  }

  function getLoginData() {
    const rememberMe = uni.getStorageSync('rememberMe')
    if (rememberMe) {
      loginForm.value.username = uni.getStorageSync('username') || ""
      loginForm.value.password = uni.getStorageSync('password') || ""
      loginForm.value.rememberMe = true
    }
  }

  onLoad(() => {
    getCode()
    initTenantList()
    getLoginData()
  })
</script>

<style lang="scss" scoped>
  .login-container {
    min-height: 100vh;
    background: linear-gradient(135deg, #f6f7f8 0%, #eef2f3 100%);
    padding: 60rpx;
    display: flex;
    flex-direction: column;
    justify-content: center;
  }

  .header-section {
    text-align: center;
    margin-bottom: 80rpx;
    
    .logo-box {
      margin-bottom: 30rpx;
      .logo {
        width: 160rpx;
        height: 160rpx;
        border-radius: 40rpx;
        box-shadow: 0 10rpx 30rpx rgba(108, 155, 210, 0.2); // Parent Blue Shadow
      }
    }
    
    .title-box {
      display: flex;
      flex-direction: column;
      
      .app-name {
        font-size: 48rpx;
        font-weight: bold;
        color: #333;
        margin-bottom: 10rpx;
        font-family: 'Manrope', sans-serif;
      }
      
      .app-slogan {
        font-size: 28rpx;
        color: #888;
        letter-spacing: 2rpx;
      }
    }
  }

  .form-section {
    background: #ffffff;
    border-radius: 40rpx;
    padding: 50rpx 40rpx;
    box-shadow: 0 20rpx 60rpx rgba(0, 0, 0, 0.05);
    
    .welcome-text {
      font-size: 36rpx;
      font-weight: 600;
      color: #333;
      margin-bottom: 40rpx;
      padding-left: 10rpx;
    }
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

  .options-section {
    display: flex;
    justify-content: flex-start;
    align-items: center;
    margin-bottom: 40rpx;
    padding-left: 10rpx;
    
    .checkbox-item {
      display: flex;
      align-items: center;
      font-size: 28rpx;
      color: #888;
      
      checkbox {
        margin-right: -4rpx;
      }
    }
  }

  .action-section {
    .login-btn {
      background: var(--parent-primary, #6C9BD2);
      color: #ffffff;
      font-size: 32rpx;
      font-weight: 600;
      height: 100rpx;
      line-height: 100rpx;
      border-radius: 50rpx;
      box-shadow: 0 10rpx 20rpx rgba(108, 155, 210, 0.3);
      border: none;
      
      &:active {
        transform: scale(0.98);
        background: #5a82b0;
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
      
      .link-text {
        font-size: 28rpx;
        color: #888;
        padding: 20rpx;
      }
      
      .divider {
        color: #eee;
        margin: 0 10rpx;
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
      }
    }
  }
</style>
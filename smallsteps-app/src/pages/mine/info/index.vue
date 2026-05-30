<template>
  <view class="container">
    <top-bar title="个人信息" show-back />
    
    <view class="main-content">
      <!-- Avatar Card -->
      <view class="avatar-card" @click="handleAvatarClick">
        <view class="avatar-wrapper">
          <image class="avatar-image" :src="avatarUrl" mode="aspectFill" />
          <view class="camera-badge">
            <text class="material-symbols-outlined">photo_camera</text>
          </view>
        </view>
        <text class="username-title">{{ user.nickName || '暂无昵称' }}</text>
        <text class="avatar-hint">点击更换头像</text>
      </view>

      <!-- Details Card -->
      <view class="info-card">
        <view class="info-item">
          <view class="item-left">
            <text class="material-symbols-outlined icon">person</text>
            <text class="item-label">昵称</text>
          </view>
          <text class="item-value">{{ user.nickName || '暂无' }}</text>
        </view>
        
        <view class="info-item">
          <view class="item-left">
            <text class="material-symbols-outlined icon">phone_android</text>
            <text class="item-label">手机号码</text>
          </view>
          <text class="item-value">{{ user.phonenumber || '暂无' }}</text>
        </view>
        
        <view class="info-item">
          <view class="item-left">
            <text class="material-symbols-outlined icon">mail</text>
            <text class="item-label">邮箱</text>
          </view>
          <text class="item-value">{{ user.email || '暂无' }}</text>
        </view>
        <view class="info-item">
          <view class="item-left">
            <text class="material-symbols-outlined icon">manage_accounts</text>
            <text class="item-label">角色</text>
          </view>
          <text class="item-value">{{ roleGroup || '暂无' }}</text>
        </view>
      </view>

      <!-- Action Section -->
      <view class="action-section">
        <button class="edit-btn" @click="handleEditProfile">
          修改资料
        </button>
      </view>
    </view>
  </view>
</template>

<script setup>
  import { getUserProfile } from "@/api/system/user"
  import { ref, computed } from "vue"
  import { onShow } from "@dcloudio/uni-app"
  import TopBar from '@/components/common/top-bar/top-bar.vue'

  const user = ref({})
  const roleGroup = ref("")
  const postGroup = ref("")

  const avatarUrl = computed(() => {
    const avatar = user.value.avatar
    if (avatar) {
      return avatar.startsWith('http') ? avatar : import.meta.env.VITE_APP_BASE_API + avatar
    }
    return 'https://lh3.googleusercontent.com/aida-public/AB6AXuAJ1cciJ4i8VZa4i84tUg3c73WgpXsHDPWFJTFC1HCyoJaWAw63sCD6sYtGoggTmCxZPkFLdgXZ0jMVUEjuhNaybs-1a06VWI-j7Tv_k-GcxylNpE1U9cjTL6ICQBnyg02gLWhSCCy1SnHe6psYMG-13HPVdTV9vR6odzmSIWG_6kD9m5MrzeKyalS3Ewhx_px4_a3iAVFvHE4SYxL6Z13ZA7UVC9fVC7U29WKKz0G9msv4O4zW9MUm2t6NZ6FOtcNY4-8SHhP3MgM'
  })

  function getUser() {
    getUserProfile().then(response => {
      user.value = response.data.user
      roleGroup.value = response.data.roleGroup
      postGroup.value = response.data.postGroup
    }).catch(err => {
      console.error("加载用户信息失败:", err)
    })
  }

  function handleAvatarClick() {
    uni.navigateTo({
      url: '/pages/mine/avatar/index'
    })
  }

  function handleEditProfile() {
    uni.navigateTo({
      url: '/pages/mine/info/edit'
    })
  }

  function formatDate(dateStr) {
    if (!dateStr) return '暂无';
    try {
      const date = new Date(dateStr);
      if (isNaN(date.getTime())) return dateStr;
      const year = date.getFullYear();
      const month = String(date.getMonth() + 1).padStart(2, '0');
      const day = String(date.getDate()).padStart(2, '0');
      return `${year}-${month}-${day}`;
    } catch (e) {
      return dateStr;
    }
  }

  // 使用 onShow 代替顶层直接执行，确保用户修改资料返回时数据能够即时更新
  onShow(() => {
    getUser()
  })
</script>

<style lang="scss" scoped>
.container {
  min-height: 100vh;
  background-color: #f6f7f8;
}

.main-content {
  padding: 16px;
  padding-top: 76px;
}

.avatar-card {
  display: flex;
  flex-direction: column;
  align-items: center;
  background-color: #ffffff;
  border-radius: 20px;
  padding: 24px 16px;
  box-shadow: 0 4px 16px rgba(0, 0, 0, 0.02);
  margin-bottom: 16px;
  
  .avatar-wrapper {
    position: relative;
    width: 90px;
    height: 90px;
    margin-bottom: 12px;
    border-radius: 50%;
    border: 3px solid #ffffff;
    box-shadow: 0 4px 12px rgba(108, 155, 210, 0.25);
    
    .avatar-image {
      width: 100%;
      height: 100%;
      border-radius: 50%;
    }
    
    .camera-badge {
      position: absolute;
      bottom: 0;
      right: 0;
      width: 28px;
      height: 28px;
      background: linear-gradient(135deg, #6C9BD2 0%, #8EADDA 100%);
      border-radius: 50%;
      display: flex;
      align-items: center;
      justify-content: center;
      border: 2px solid #ffffff;
      box-shadow: 0 2px 6px rgba(0, 0, 0, 0.1);
      
      text {
        font-size: 14px;
        color: #ffffff;
      }
    }
  }
  
  .username-title {
    font-size: 18px;
    font-weight: 600;
    color: #1f2937;
    margin-bottom: 4px;
  }
  
  .avatar-hint {
    font-size: 12px;
    color: #9ca3af;
  }
  
  &:active {
    opacity: 0.95;
  }
}

.info-card {
  background-color: #ffffff;
  border-radius: 20px;
  padding: 8px 16px;
  box-shadow: 0 4px 16px rgba(0, 0, 0, 0.02);
  margin-bottom: 24px;
}

.info-item {
  display: flex;
  align-items: center;
  justify-content: space-between;
  padding: 16px 0;
  border-bottom: 1px solid #f3f4f6;
  
  &:last-child {
    border-bottom: none;
  }
}

.item-left {
  display: flex;
  align-items: center;
  gap: 12px;
  
  .icon {
    font-size: 18px;
    color: #6C9BD2;
    background-color: #f0f4fa;
    width: 32px;
    height: 32px;
    border-radius: 10px;
    display: flex;
    align-items: center;
    justify-content: center;
  }
  
  .item-label {
    font-size: 15px;
    color: #374151;
    font-weight: 500;
  }
}

.item-value {
  font-size: 15px;
  color: #6b7280;
  max-width: 60%;
  text-align: right;
  word-break: break-all;
}

.action-section {
  padding: 0 4px;
}

.edit-btn {
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

page {
  background-color: #f6f7f8;
}
</style>


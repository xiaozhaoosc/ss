<template>
  <view class="container">
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
          <text class="material-symbols-outlined icon">badge</text>
          <text class="item-label">岗位</text>
        </view>
        <text class="item-value">{{ postGroup || '暂无' }}</text>
      </view>
      
      <view class="info-item">
        <view class="item-left">
          <text class="material-symbols-outlined icon">manage_accounts</text>
          <text class="item-label">角色</text>
        </view>
        <text class="item-value">{{ roleGroup || '暂无' }}</text>
      </view>
      
      <view class="info-item">
        <view class="item-left">
          <text class="material-symbols-outlined icon">calendar_today</text>
          <text class="item-label">创建日期</text>
        </view>
        <text class="item-value">{{ formatDate(user.createTime) }}</text>
      </view>
    </view>
  </view>
</template>

<script setup>
  import { getUserProfile } from "@/api/system/user"
  import { ref } from "vue"

  const user = ref({})
  const roleGroup = ref("")
  const postGroup = ref("")

  function getUser() {
    getUserProfile().then(response => {
      user.value = response.data
      roleGroup.value = response.roleGroup
      postGroup.value = response.postGroup
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

  getUser()
</script>

<style lang="scss" scoped>
.container {
  padding: 16px;
  min-height: 100vh;
  background-color: #f6f7f8;
}

.info-card {
  background-color: #ffffff;
  border-radius: 20px;
  padding: 8px 16px;
  box-shadow: 0 4px 16px rgba(0, 0, 0, 0.03);
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

page {
  background-color: #f6f7f8;
}
</style>

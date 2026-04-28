<template>
  <view class="invite-page">
    <top-bar title="邀请加入家庭" back-btn />

    <view class="content" v-if="loading">
      <view class="loading-container">
        <text class="loading-text">加载中...</text>
      </view>
    </view>

    <view class="content" v-else-if="inviteInfo && inviteInfo.isValid">
      <view class="family-card">
        <view class="family-icon">
          <text class="material-symbols-outlined">family_home</text>
        </view>
        <text class="family-name">{{ inviteInfo.familyName }}</text>
        <text class="creator-name">创建者：{{ inviteInfo.creatorName }}</text>
        <text class="expires">有效期至：{{ inviteInfo.expiresAt }}</text>
      </view>

      <view class="warning">
        <view class="warning-item">
          <text class="material-symbols-outlined warning-icon">info</text>
          <text class="warning-text">申请提交后，家庭管理员会收到通知进行审核</text>
        </view>
        <view class="warning-item">
          <text class="material-symbols-outlined warning-icon">info</text>
          <text class="warning-text">审核通过后，您将自动加入该家庭</text>
        </view>
      </view>

      <button class="apply-btn" @click="goToApply">申请加入</button>
    </view>

    <view class="content invalid" v-else>
      <view class="invalid-icon">
        <text class="material-symbols-outlined">error</text>
      </view>
      <text class="invalid-text">邀请码无效或已过期</text>
      <text class="invalid-hint">请联系家庭管理员获取新的邀请码</text>
      <button class="back-btn" @click="goBack">返回首页</button>
    </view>
  </view>
</template>

<script setup>
import { ref, onMounted } from 'vue'
import TopBar from '@/components/common/top-bar/top-bar.vue'
import { getInviteInfo } from '@/api/family-invite'

const inviteInfo = ref(null)
const loading = ref(true)

onMounted(async () => {
  const code = getInviteCodeFromUrl()
  if (code) {
    try {
      const res = await getInviteInfo(code)
      if (res.code === 200 || res.code === '200') {
        inviteInfo.value = res.data
      }
    } catch (e) {
      console.error('获取邀请信息失败', e)
    }
  }
  loading.value = false
})

function getInviteCodeFromUrl() {
  const pages = getCurrentPages()
  const currentPage = pages[pages.length - 1]
  const options = currentPage.options || {}
  return options.code || ''
}

function goToApply() {
  if (inviteInfo.value) {
    uni.navigateTo({
      url: `/pages/family/invite/apply?code=${inviteInfo.value.inviteCode}`
    })
  }
}

function goBack() {
  uni.switchTab({ url: '/pages/index/index' })
}
</script>

<style lang="scss" scoped>
.invite-page {
  height: 100vh;
  background-color: #f6f7f8;
}

.content {
  padding: 24px;
  padding-top: 80px;
}

.loading-container {
  display: flex;
  justify-content: center;
  align-items: center;
  height: 50vh;
}

.loading-text {
  font-size: 16px;
  color: #6b7280;
}

.family-card {
  background-color: #ffffff;
  border-radius: 16px;
  padding: 32px;
  display: flex;
  flex-direction: column;
  align-items: center;
  gap: 12px;
  margin-bottom: 24px;
  box-shadow: 0 2px 8px rgba(0, 0, 0, 0.05);
}

.family-icon {
  width: 64px;
  height: 64px;
  border-radius: 50%;
  background-color: #EEF2FF;
  display: flex;
  align-items: center;
  justify-content: center;
  margin-bottom: 8px;

  .material-symbols-outlined {
    font-size: 32px;
    color: #6C9BD2;
  }
}

.family-name {
  font-size: 20px;
  font-weight: 700;
  color: #111827;
}

.creator-name {
  font-size: 14px;
  color: #6b7280;
}

.expires {
  font-size: 12px;
  color: #9ca3af;
  margin-top: 4px;
}

.warning {
  background-color: #ffffff;
  border-radius: 12px;
  padding: 16px;
  margin-bottom: 32px;
  display: flex;
  flex-direction: column;
  gap: 12px;
}

.warning-item {
  display: flex;
  align-items: flex-start;
  gap: 12px;
}

.warning-icon {
  font-size: 18px;
  color: #6C9BD2;
}

.warning-text {
  flex: 1;
  font-size: 14px;
  line-height: 1.5;
  color: #4b5563;
}

.apply-btn {
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
  box-shadow: 0 4px 12px rgba(108, 155, 210, 0.3);

  &::after { border: none; }
}

.invalid {
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
  min-height: 60vh;
  gap: 16px;
}

.invalid-icon {
  width: 80px;
  height: 80px;
  border-radius: 50%;
  background-color: #FEE2E2;
  display: flex;
  align-items: center;
  justify-content: center;

  .material-symbols-outlined {
    font-size: 40px;
    color: #EF4444;
  }
}

.invalid-text {
  font-size: 18px;
  font-weight: 600;
  color: #111827;
}

.invalid-hint {
  font-size: 14px;
  color: #6b7280;
  text-align: center;
}

.back-btn {
  width: 200px;
  height: 48px;
  background-color: #ffffff;
  color: #6C9BD2;
  font-weight: 600;
  border-radius: 12px;
  display: flex;
  align-items: center;
  justify-content: center;
  border: 1px solid #6C9BD2;
  margin-top: 16px;

  &::after { border: none; }
}
</style>
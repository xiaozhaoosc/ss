<template>
  <view class="apply-page">
    <top-bar title="申请加入家庭" back-btn />

    <view class="content">
      <view class="family-card">
        <view class="family-icon">
          <text class="material-symbols-outlined">family_home</text>
        </view>
        <text class="family-name">{{ inviteInfo?.familyName || '加载中...' }}</text>
        <text class="creator-name">创建者：{{ inviteInfo?.creatorName || '' }}</text>
      </view>

      <view class="warning-section">
        <view class="warning-header">
          <text class="material-symbols-outlined warning-icon">warning</text>
          <text class="warning-title">重要提示</text>
        </view>
        <view class="warning-list">
          <view class="warning-item">
            <text class="warning-dot">1.</text>
            <text class="warning-text">申请提交后，家庭管理员会收到通知进行审核</text>
          </view>
          <view class="warning-item">
            <text class="warning-dot">2.</text>
            <text class="warning-text">审核通过后，您将自动加入该家庭</text>
          </view>
          <view class="warning-item">
            <text class="warning-dot">3.</text>
            <text class="warning-text">您的原家庭（如有）将被禁用</text>
          </view>
        </view>
      </view>

      <button 
        class="submit-btn" 
        :loading="submitting" 
        :disabled="!inviteInfo"
        @click="handleSubmit"
      >
        确认申请加入
      </button>
    </view>
  </view>
</template>

<script setup>
import { ref, onMounted } from 'vue'
import TopBar from '@/components/common/top-bar/top-bar.vue'
import { getInviteInfo, submitJoinRequest } from '@/api/family-invite'

const inviteInfo = ref(null)
const submitting = ref(false)

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
})

function getInviteCodeFromUrl() {
  const pages = getCurrentPages()
  const currentPage = pages[pages.length - 1]
  const options = currentPage.options || {}
  return options.code || ''
}

async function handleSubmit() {
  if (submitting.value || !inviteInfo.value) return
  
  submitting.value = true
  try {
    const res = await submitJoinRequest({ inviteCode: inviteInfo.value.inviteCode })
    if (res.code === 200 || res.code === '200') {
      uni.showToast({ title: '申请已提交', icon: 'success' })
      setTimeout(() => {
        uni.switchTab({ url: '/pages/index/index' })
      }, 1500)
    } else {
      uni.showToast({ title: res.msg || '提交失败', icon: 'none' })
    }
  } catch (e) {
    const errorMsg = e?.msg || e?.message || '提交失败'
    uni.showToast({ title: errorMsg, icon: 'none' })
  } finally {
    submitting.value = false
  }
}
</script>

<style lang="scss" scoped>
.apply-page {
  height: 100vh;
  background-color: #f6f7f8;
}

.content {
  padding: 24px;
  padding-top: 80px;
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

.warning-section {
  background-color: #FEF3C7;
  border-radius: 12px;
  padding: 16px;
  margin-bottom: 32px;
  border: 1px solid #FDE68A;
}

.warning-header {
  display: flex;
  align-items: center;
  gap: 8px;
  margin-bottom: 12px;
}

.warning-icon {
  font-size: 20px;
  color: #D97706;
}

.warning-title {
  font-size: 16px;
  font-weight: 600;
  color: #92400E;
}

.warning-list {
  display: flex;
  flex-direction: column;
  gap: 8px;
}

.warning-item {
  display: flex;
  align-items: flex-start;
  gap: 8px;
}

.warning-dot {
  font-size: 14px;
  color: #92400E;
  font-weight: 500;
}

.warning-text {
  flex: 1;
  font-size: 14px;
  line-height: 1.5;
  color: #78350F;
}

.submit-btn {
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

  &:disabled {
    background-color: #d1d5db;
    box-shadow: none;
  }

  &::after { border: none; }
}
</style>
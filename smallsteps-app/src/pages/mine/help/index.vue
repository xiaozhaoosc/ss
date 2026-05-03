<template>
  <view class="help-page">
    <top-bar title="帮助与反馈" show-back />
    
    <scroll-view scroll-y class="main-content">
      <!-- AI Assistant Banner -->
      <view class="ai-banner" @click="handleToAiAssistant">
        <view class="ai-content">
          <view class="ai-text">
            <text class="ai-title">AI 情感助手</text>
            <text class="ai-desc">育儿压力大？来和温暖的小步聊聊吧</text>
          </view>
          <view class="ai-avatar">
             <image src="https://lh3.googleusercontent.com/aida-public/AB6AXuAJ1cciJ4i8VZa4i84tUg3c73WgpXsHDPWFJTFC1HCyoJaWAw63sCD6sYtGoggTmCxZPkFLdgXZ0jMVUEjuhNaybs-1a06VWI-j7Tv_k-GcxylNpE1U9cjTL6ICQBnyg02gLWhSCCy1SnHe6psYMG-13HPVdTV9vR6odzmSIWG_6kD9m5MrzeKyalS3Ewhx_px4_a3iAVFvHE4SYxL6Z13ZA7UVC9fVC7U29WKKz0G9msv4O4zW9MUm2t6NZ6FOtcNY4-8SHhP3MgM" mode="aspectFill" class="avatar-img" />
          </view>
        </view>
        <view class="ai-footer">
          <text class="ai-tag">7×24h 温暖守护</text>
          <text class="material-symbols-outlined arrow">arrow_forward</text>
        </view>
      </view>

      <!-- FAQ Section -->
      <view class="section">
        <text class="section-title">常见问题</text>
        <view class="faq-list">
          <view v-for="(group, gIdx) in faqList" :key="gIdx" class="faq-group">
            <view class="group-header">
              <text class="material-symbols-outlined icon">{{ group.icon }}</text>
              <text class="group-title">{{ group.title }}</text>
            </view>
            <view class="questions">
              <view v-for="(item, iIdx) in group.questions" :key="iIdx" class="q-item" @click="handleShowDetail(item)">
                <text class="q-text">{{ item.title }}</text>
                <text class="material-symbols-outlined arrow">chevron_right</text>
              </view>
            </view>
          </view>
        </view>
      </view>

      <!-- Feedback Section -->
      <view class="section feedback-section">
        <text class="section-title">意见反馈</text>
        <view class="feedback-card">
          <textarea 
            class="feedback-input" 
            v-model="feedbackContent" 
            placeholder="描述您遇到的问题或建议（不少于10个字）" 
            placeholder-style="color: #9ca3af"
          />
          <view class="image-picker">
            <view class="add-img-btn" @click="handleUploadImage">
              <text class="material-symbols-outlined">add_a_photo</text>
              <text class="add-text">添加图片</text>
            </view>
          </view>
          <button class="submit-btn" :disabled="feedbackContent.length < 10" @click="handleSubmitFeedback">提交反馈</button>
        </view>
      </view>
      
      <view class="spacer"></view>
    </scroll-view>
  </view>
</template>

<script setup>
import { ref } from 'vue'
import TopBar from '@/components/common/top-bar/top-bar.vue'

const feedbackContent = ref('')

const faqList = ref([
  {
    title: '设备连接',
    icon: 'router',
    questions: [
      { title: '如何绑定 StarBuddy 硬件？', content: '开启蓝牙并扫描设备底部二维码即可自动绑定。' },
      { title: '设备掉线了怎么办？', content: '请检查 Wi-Fi 是否正常，或长按设备背部复位键重连。' }
    ]
  },
  {
    title: '任务与激励',
    icon: 'stars',
    questions: [
      { title: '如何设置任务奖励？', content: '在“任务”页面点击“添加”，选择模板或自定义，设置对应星星奖励。' },
      { title: '孩子完成了任务但没收到星星？', content: '请在家长端“待审核”中确认任务完成状态。' }
    ]
  }
])

function handleToAiAssistant() {
  uni.navigateTo({ url: '/pages/mine/help/ai-assistant' })
}

function handleShowDetail(item) {
  uni.showModal({
    title: item.title,
    content: item.content,
    showCancel: false
  })
}

function handleUploadImage() {
  uni.showToast({ title: '演示环境暂不支持图片上传', icon: 'none' })
}

function handleSubmitFeedback() {
  uni.showLoading({ title: '提交中...' })
  setTimeout(() => {
    uni.hideLoading()
    uni.showToast({ title: '反馈已收到，我们会尽快处理！' })
    feedbackContent.value = ''
    setTimeout(() => uni.navigateBack(), 1500)
  }, 1000)
}
</script>

<style lang="scss" scoped>
.help-page {
  height: 100vh;
  background-color: #f6f7f8;
}

.main-content {
  padding: 16px;
  padding-top: 60px;
  height: calc(100vh - 60px);
}

.section {
  margin-bottom: 24px;
}

.section-title {
  font-size: 14px;
  font-weight: 600;
  color: #9ca3af;
  margin-bottom: 12px;
  margin-left: 4px;
}

.ai-banner {
  background: linear-gradient(135deg, #6c9bd2 0%, #a5c2eb 100%);
  border-radius: 20px;
  padding: 20px;
  margin-bottom: 24px;
  box-shadow: 0 8px 25px rgba(108, 155, 210, 0.25);
  position: relative;
  overflow: hidden;
  
  &::before {
    content: '';
    position: absolute;
    top: -20px;
    right: -20px;
    width: 100px;
    height: 100px;
    background: rgba(255, 255, 255, 0.1);
    border-radius: 50%;
  }
}

.ai-content {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-bottom: 16px;
}

.ai-text {
  display: flex;
  flex-direction: column;
  gap: 4px;
}

.ai-title {
  color: white;
  font-size: 20px;
  font-weight: 800;
}

.ai-desc {
  color: rgba(255, 255, 255, 0.9);
  font-size: 13px;
}

.ai-avatar {
  width: 50px;
  height: 50px;
  background: white;
  border-radius: 15px;
  padding: 4px;
  box-shadow: 0 4px 10px rgba(0,0,0,0.1);
  
  .avatar-img { width: 100%; height: 100%; border-radius: 12px; }
}

.ai-footer {
  display: flex;
  justify-content: space-between;
  align-items: center;
  
  .ai-tag {
    background: rgba(255, 255, 255, 0.2);
    color: white;
    padding: 4px 12px;
    border-radius: 20px;
    font-size: 11px;
    font-weight: 600;
    backdrop-filter: blur(4px);
  }
  
  .arrow { color: white; font-size: 18px; }
}

.faq-list {
  display: flex;
  flex-direction: column;
  gap: 16px;
}

.faq-group {
  background-color: #ffffff;
  border-radius: 16px;
  padding: 16px;
  box-shadow: 0 4px 12px rgba(0, 0, 0, 0.03);
}

.group-header {
  display: flex;
  align-items: center;
  gap: 12px;
  margin-bottom: 12px;
  
  .icon { color: #6C9BD2; font-size: 20px; }
  .group-title { font-size: 16px; font-weight: 600; color: #111827; }
}

.questions {
  display: flex;
  flex-direction: column;
}

.q-item {
  display: flex;
  align-items: center;
  justify-content: space-between;
  padding: 12px 0;
  border-top: 1px solid #f3f4f6;
  
  &:active { opacity: 0.7; }
  
  .q-text { font-size: 14px; color: #4b5563; }
  .arrow { color: #d1d5db; font-size: 18px; }
}

.feedback-card {
  background-color: #ffffff;
  border-radius: 16px;
  padding: 16px;
  box-shadow: 0 4px 12px rgba(0, 0, 0, 0.03);
}

.feedback-input {
  width: 100%;
  height: 120px;
  font-size: 14px;
  color: #111827;
  margin-bottom: 16px;
}

.add-img-btn {
  width: 80px;
  height: 80px;
  background-color: #f9fafb;
  border-radius: 12px;
  border: 1px dashed #d1d5db;
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
  color: #9ca3af;
  
  .material-symbols-outlined { font-size: 24px; }
  .add-text { font-size: 10px; margin-top: 4px; }
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
  &[disabled] { opacity: 0.5; background: #9ca3af; }
}

.spacer { height: 100px; }
</style>

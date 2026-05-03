<template>
  <view class="privacy-page">
    <top-bar title="隐私政策" show-back />
    
    <scroll-view scroll-y class="main-content">
      <view class="content-card">
        <view class="header">
          <text class="title">Small Steps 隐私政策</text>
          <text class="date">最近更新日期：2026年5月3日</text>
        </view>
        
        <view class="article">
          <view class="section">
            <text class="h2">1. 我们收集的信息</text>
            <text class="p">为了向您和您的孩子提供核心功能，我们可能收集以下信息：</text>
            <view class="li">
              <text class="dot">·</text>
              <text class="text">账号信息：手机号、头像、昵称。</text>
            </view>
            <view class="li">
              <text class="dot">·</text>
              <text class="text">儿童资料：昵称、年龄、性别（用于生成个性化任务）。</text>
            </view>
            <view class="li">
              <text class="dot">·</text>
              <text class="text">设备数据：StarBuddy 硬件的在线状态、电量等。</text>
            </view>
            <view class="li">
              <text class="dot">·</text>
              <text class="text">互动数据：任务完成记录、情绪语音记录（仅用于 AI 情感分析，不用于广告）。</text>
            </view>
          </view>
          
          <view class="section">
            <text class="h2">2. 信息的使用方式</text>
            <text class="p">我们严格遵守“最小必要”原则：</text>
            <text class="p">所有收集的信息均用于改善 ADHD 儿童的行为干预效果，并在家长授权下进行展示。</text>
          </view>
          
          <view class="section">
            <text class="h2">3. 您的权利</text>
            <text class="p">您可以随时在“账号安全”中申请注销账号，届时我们将永久删除您的所有个人及孩子档案数据。</text>
          </view>
          
          <view class="footer">
            <text class="p">感谢您信任 Small Steps。我们承诺像保护自己的家人一样保护您的隐私。</text>
          </view>
        </view>
      </view>
    </scroll-view>
  </view>
</template>

<script setup>
import TopBar from '@/components/common/top-bar/top-bar.vue'
</script>

<style lang="scss" scoped>
.privacy-page {
  height: 100vh;
  background-color: #f6f7f8;
}

.main-content {
  padding: 16px;
  padding-top: 60px;
  height: calc(100vh - 60px);
}

.content-card {
  background-color: #ffffff;
  border-radius: 20px;
  padding: 24px;
  box-shadow: 0 4px 20px rgba(0, 0, 0, 0.05);
}

.header {
  text-align: center;
  margin-bottom: 32px;
  
  .title {
    font-size: 20px;
    font-weight: 700;
    color: #111827;
    display: block;
    margin-bottom: 8px;
  }
  
  .date {
    font-size: 12px;
    color: #9ca3af;
  }
}

.h2 {
  font-size: 16px;
  font-weight: 700;
  color: #111827;
  margin-bottom: 12px;
  display: block;
}

.p {
  font-size: 14px;
  color: #4b5563;
  line-height: 1.6;
  margin-bottom: 12px;
  display: block;
}

.li {
  display: flex;
  gap: 8px;
  margin-bottom: 8px;
  padding-left: 8px;
  
  .dot {
    color: #6C9BD2;
    font-weight: 700;
  }
  
  .text {
    font-size: 14px;
    color: #4b5563;
    line-height: 1.5;
  }
}

.section {
  margin-bottom: 32px;
}

.footer {
  margin-top: 40px;
  padding-top: 24px;
  border-top: 1px solid #f3f4f6;
  text-align: center;
  
  .p {
    font-style: italic;
    color: #6b7280;
  }
}
</style>

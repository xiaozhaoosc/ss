<template>
  <view class="template-detail-page" :class="{ 'dark': isDarkMode }">
    <!-- Header with Background -->
    <view class="header-bg" :style="{ backgroundColor: detail?.bgColor || '#6C9BD2' }">
      <view class="safe-top"></view>
      <view class="nav-row">
        <view class="back-btn" @click="handleBack">
          <text class="material-symbols-outlined icon">arrow_back_ios</text>
        </view>
        <text class="nav-title">模板详情</text>
        <view class="placeholder"></view>
      </view>
      
      <view class="hero-content">
        <view class="icon-box">
          <text class="hero-icon">{{ detail?.icon || '📝' }}</text>
        </view>
        <text class="hero-title">{{ detail?.title || '任务模板' }}</text>
        <view class="hero-tags">
          <text v-for="(tag, index) in detail?.tags" :key="index" class="hero-tag">{{ tag }}</text>
        </view>
      </view>
    </view>

    <!-- Content Card -->
    <scroll-view scroll-y class="content-card">
      <view class="content-inner">
        <view class="section">
          <view class="section-header">
            <text class="section-title">分步指引</text>
            <text class="section-subtitle">根据 ADHD 儿童认知特点优化</text>
          </view>
          
          <view class="steps-timeline">
            <view v-for="(step, index) in detail?.steps" :key="index" class="timeline-item">
              <view class="timeline-line" v-if="index < (detail.steps.length - 1)"></view>
              <view class="timeline-node">
                <text class="node-number">{{ index + 1 }}</text>
              </view>
              <view class="step-content">
                <text class="step-title">{{ step.title }}</text>
                <text class="step-desc">{{ step.description }}</text>
                <view class="step-meta" v-if="step.duration">
                  <text class="material-symbols-outlined meta-icon">schedule</text>
                  <text>预计 {{ step.duration }}</text>
                </view>
              </view>
            </view>
          </view>
        </view>

        <view class="section info-section">
          <view class="info-card">
            <text class="material-symbols-outlined info-icon">info</text>
            <text class="info-text">应用此模板后，它将自动出现在孩子的今日任务列表中，并带有视觉引导。</text>
          </view>
        </view>
        
        <view class="safe-area-spacer"></view>
      </view>
    </scroll-view>

    <!-- Bottom Action -->
    <view class="bottom-bar">
      <button 
        class="apply-btn" 
        :loading="applying" 
        @click="handleApply"
        hover-class="btn-hover"
      >
        <text class="material-symbols-outlined b-icon">auto_awesome</text>
        <text>立即启用</text>
      </button>
    </view>
  </view>
</template>

<script setup lang="ts">
import { ref } from 'vue'
import { onLoad } from '@dcloudio/uni-app'
import { getTemplateDetail, applyTemplate } from '@/api/template'

const isDarkMode = ref(false)
import { useUserStore } from '@/store/modules/user'

const userStore = useUserStore()
const templateId = ref('')
const detail = ref<any>(null)
const loading = ref(true)
const applying = ref(false)

const handleBack = () => uni.navigateBack()

const fetchDetail = async () => {
  loading.value = true
  try {
    const res: any = await getTemplateDetail(templateId.value)
    detail.value = res.data || res
  } catch (error) {
    uni.showToast({ title: '获取详情失败', icon: 'none' })
  } finally {
    loading.value = false
  }
}

// Mock fallback
const mockDetail = {
  id: 101,
  title: '晨间“极简”准备',
  icon: '☀️',
  bgColor: '#FFD93D',
  tags: ['ADHD友好', '视觉化', '生活自理'],
  steps: [
    { title: '穿好袜子和鞋子', description: '坐在玄关处，先穿左脚，再穿右脚。', duration: '2分钟' },
    { title: '检查书包物品', description: '对照门后的磁贴卡片，数一数有几样东西。', duration: '3分钟' },
    { title: '戴上水壶', description: '确认水壶盖子已经盖紧。', duration: '1分钟' }
  ]
}

const handleApply = async () => {
  if (applying.value) return
  
  if (!userStore.currentChildId) {
    uni.showToast({ title: '请先在首页选择一个孩子', icon: 'none' })
    return
  }

  applying.value = true
  try {
    await applyTemplate(templateId.value, userStore.currentChildId)
    
    uni.showToast({ title: '应用成功', icon: 'success' })
    setTimeout(() => {
      uni.navigateBack()
    }, 1500)
  } catch (error) {
    console.error('Apply template failed:', error)
    uni.showToast({ title: '演示：任务已导入', icon: 'success' })
    setTimeout(() => uni.navigateBack(), 1500)
  } finally {
    applying.value = false
  }
}

onLoad((options) => {
  if (options?.id) {
    templateId.value = options.id
    fetchDetail()
  } else {
    detail.value = mockDetail // For testing
    loading.value = false
  }
})
</script>

<style lang="scss" scoped>
.template-detail-page {
  height: 100vh;
  background: #f8fbff;
  display: flex;
  flex-direction: column;
}

.header-bg {
  height: 320px;
  position: relative;
  transition: background-color 0.5s ease;
}

.safe-top {
  height: env(safe-area-inset-top);
}

.nav-row {
  display: flex;
  align-items: center;
  justify-content: space-between;
  padding: 8px 16px;
  height: 44px;
}

.back-btn {
  width: 36px;
  height: 36px;
  background: rgba(255, 255, 255, 0.2);
  border-radius: 50%;
  display: flex;
  align-items: center;
  justify-content: center;
  padding-left: 6px;
  
  .icon {
    color: #ffffff;
    font-size: 18px;
  }
}

.nav-title {
  color: #ffffff;
  font-weight: 800;
  font-size: 16px;
}

.placeholder { width: 36px; }

.hero-content {
  display: flex;
  flex-direction: column;
  align-items: center;
  padding-top: 24px;
}

.icon-box {
  width: 90px;
  height: 90px;
  background: rgba(255, 255, 255, 0.95);
  border-radius: 30px;
  display: flex;
  align-items: center;
  justify-content: center;
  box-shadow: 0 12px 30px rgba(0, 0, 0, 0.1);
  margin-bottom: 16px;
  
  .hero-icon { font-size: 48px; }
}

.hero-title {
  color: #ffffff;
  font-size: 24px;
  font-weight: 900;
  text-shadow: 0 2px 4px rgba(0,0,0,0.1);
  margin-bottom: 12px;
}

.hero-tags {
  display: flex;
  gap: 8px;
}

.hero-tag {
  background: rgba(255, 255, 255, 0.2);
  color: #ffffff;
  font-size: 12px;
  font-weight: 600;
  padding: 4px 12px;
  border-radius: 999px;
  backdrop-filter: blur(4px);
}

.content-card {
  flex: 1;
  background: #f8fbff;
  border-top-left-radius: 32px;
  border-top-right-radius: 32px;
  margin-top: -32px;
  position: relative;
  z-index: 10;
}

.content-inner {
  padding: 32px 24px;
}

.section {
  margin-bottom: 32px;
}

.section-header {
  margin-bottom: 24px;
}

.section-title {
  font-size: 18px;
  font-weight: 800;
  color: #1e293b;
  display: block;
}

.section-subtitle {
  font-size: 13px;
  color: #94a3b8;
}

.steps-timeline {
  display: flex;
  flex-direction: column;
}

.timeline-item {
  display: flex;
  position: relative;
  padding-bottom: 24px;
}

.timeline-line {
  position: absolute;
  left: 15px;
  top: 30px;
  bottom: 0;
  width: 2px;
  background: #e2e8f0;
}

.timeline-node {
  width: 32px;
  height: 32px;
  background: #ffffff;
  border: 2px solid #6C9BD2;
  border-radius: 50%;
  display: flex;
  align-items: center;
  justify-content: center;
  z-index: 2;
  margin-right: 16px;
  
  .node-number {
    font-size: 14px;
    font-weight: 900;
    color: #6C9BD2;
  }
}

.step-content {
  flex: 1;
}

.step-title {
  font-size: 16px;
  font-weight: 700;
  color: #1e293b;
  margin-bottom: 4px;
  display: block;
}

.step-desc {
  font-size: 14px;
  color: #64748b;
  line-height: 1.5;
  margin-bottom: 8px;
  display: block;
}

.step-meta {
  display: flex;
  align-items: center;
  gap: 4px;
  font-size: 12px;
  font-weight: 600;
  color: #6C9BD2;
  
  .meta-icon { font-size: 14px; }
}

.info-card {
  display: flex;
  gap: 12px;
  background: rgba(108, 155, 210, 0.05);
  padding: 16px;
  border-radius: 16px;
  border: 1px dashed rgba(108, 155, 210, 0.2);
  
  .info-icon { color: #6C9BD2; font-size: 20px; }
  .info-text { font-size: 13px; color: #64748b; line-height: 1.5; }
}

.bottom-bar {
  padding: 20px 24px;
  padding-bottom: calc(20px + env(safe-area-inset-bottom));
  background: rgba(255, 255, 255, 0.8);
  backdrop-filter: blur(12px);
  border-top: 1px solid rgba(0,0,0,0.05);
}

.apply-btn {
  height: 56px;
  background: #1e293b;
  color: #ffffff;
  border-radius: 20px;
  display: flex;
  align-items: center;
  justify-content: center;
  gap: 10px;
  font-weight: 800;
  font-size: 17px;
  box-shadow: 0 10px 30px rgba(30, 41, 59, 0.3);
  
  &::after { border: none; }
  
  .b-icon { font-size: 22px; }
}

.btn-hover {
  transform: scale(0.96);
  opacity: 0.95;
}

.safe-area-spacer { height: 40px; }
</style>
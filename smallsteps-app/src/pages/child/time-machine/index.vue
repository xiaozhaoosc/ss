<template>
  <view class="time-machine-page">
    <!-- Header -->
    <view class="header">
      <view class="top-row">
        <button class="back-btn" @click="handleBack">
          <text class="material-symbols-outlined">arrow_back</text>
        </button>
        <text class="title">时光机信箱</text>
        <view class="spacer"></view>
      </view>
      <text class="subtitle">在这里回顾小步对你的所有鼓励吧！💖</text>
    </view>

    <!-- Content -->
    <scroll-view scroll-y class="content no-scrollbar" @scrolltolower="loadMore">
      <view v-if="interactions.length === 0 && !loading" class="empty-state">
        <view class="empty-icon">⏳</view>
        <text class="empty-text">信箱里还没有信件哦...</text>
        <text class="empty-hint">去“秘密树洞”和小步聊聊天吧！</text>
      </view>

      <view v-else class="interaction-list">
        <view 
          v-for="(item, index) in interactions" 
          :key="item.aiId" 
          class="interaction-card"
          :style="{ animationDelay: (index * 0.1) + 's' }"
        >
          <view class="card-header">
            <view class="time-badge">
              <text class="material-symbols-outlined time-icon">schedule</text>
              <text class="time-text">{{ formatDate(item.interactionTime) }}</text>
            </view>
            <view class="emotion-badge" :class="item.emotionType">
              {{ getEmotionEmoji(item.emotionType) }} {{ item.emotionType || '平静' }}
            </view>
          </view>
          
          <view class="chat-snapshot">
            <view class="msg-bubble user">
              <text class="msg-text">{{ item.userInput }}</text>
            </view>
            <view class="msg-bubble ai">
              <text class="msg-text">{{ item.aiResponse }}</text>
            </view>
          </view>
          
          <view class="card-footer">
            <text class="footer-hint">当时的你很勇敢哦！🌟</text>
          </view>
        </view>
      </view>
      
      <view v-if="loading" class="loading-state">
        <view class="spinner"></view>
        <text>时光机启动中...</text>
      </view>
      
      <view class="bottom-spacer"></view>
    </scroll-view>

    <!-- Child Nav -->
    <child-bottom-nav active="map" />
  </view>
</template>

<script setup lang="ts">
import { ref, onMounted } from 'vue'
import { getRecentInteractions } from '@/api/child'
import { useUserStore } from '@/store/modules/user'
import ChildBottomNav from '@/components/child/child-bottom-nav/child-bottom-nav.vue'

const userStore = useUserStore()
const interactions = ref<any[]>([])
const loading = ref(false)

const handleBack = () => {
  uni.navigateBack()
}

const loadData = async () => {
  if (loading.value) return
  loading.value = true
  try {
    const childId = userStore.id
    if (!childId) return
    const res: any = await getRecentInteractions(childId, 20)
    if (res.data) {
      interactions.value = res.data
    }
  } catch (e) {
    console.error(e)
  } finally {
    loading.value = false
  }
}

const formatDate = (dateStr: string) => {
  if (!dateStr) return ''
  const date = new Date(dateStr)
  return `${date.getMonth() + 1}月${date.getDate()}日 ${date.getHours()}:${String(date.getMinutes()).padStart(2, '0')}`
}

const getEmotionEmoji = (type: string) => {
  const map: Record<string, string> = {
    '开心': '😊',
    '难过': '😢',
    '愤怒': '😠',
    '焦虑': '😰',
    '平静': '😐'
  }
  return map[type] || '✨'
}

const loadMore = () => {
  // Pagination logic if needed
}

onMounted(() => {
  loadData()
})
</script>

<style lang="scss" scoped>
.time-machine-page {
  height: 100vh;
  background-color: #FFF9F5;
  display: flex;
  flex-direction: column;
}

.header {
  padding: 20px;
  padding-top: calc(20px + env(safe-area-inset-top));
  background: linear-gradient(to bottom, #FFEDD5, #FFF9F5);
  
  .top-row {
    display: flex;
    align-items: center;
    justify-content: space-between;
    margin-bottom: 8px;
  }
  
  .back-btn {
    width: 40px;
    height: 40px;
    border-radius: 12px;
    background: white;
    display: flex;
    align-items: center;
    justify-content: center;
    border: none;
    box-shadow: 0 2px 8px rgba(0,0,0,0.05);
    &::after { border: none; }
  }
  
  .title {
    font-size: 20px;
    font-weight: 900;
    color: #9A3412;
  }
  
  .spacer { width: 40px; }
  
  .subtitle {
    font-size: 14px;
    color: #C2410C;
    opacity: 0.8;
  }
}

.content {
  flex: 1;
  padding: 20px;
}

.empty-state {
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
  padding-top: 100px;
  
  .empty-icon { font-size: 64px; margin-bottom: 20px; }
  .empty-text { font-size: 18px; font-weight: 700; color: #9A3412; }
  .empty-hint { font-size: 14px; color: #C2410C; margin-top: 8px; }
}

.interaction-list {
  display: flex;
  flex-direction: column;
  gap: 20px;
}

.interaction-card {
  background: white;
  border-radius: 24px;
  padding: 20px;
  box-shadow: 0 10px 30px rgba(154, 52, 18, 0.05);
  border: 1px solid rgba(154, 52, 18, 0.05);
  animation: slideIn 0.5s ease both;
  
  @keyframes slideIn {
    from { opacity: 0; transform: translateY(20px); }
    to { opacity: 1; transform: translateY(0); }
  }
}

.card-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-bottom: 16px;
}

.time-badge {
  display: flex;
  align-items: center;
  gap: 4px;
  background: #FFF7ED;
  padding: 4px 10px;
  border-radius: 99px;
  
  .time-icon { font-size: 14px; color: #EA580C; }
  .time-text { font-size: 12px; font-weight: 700; color: #EA580C; }
}

.emotion-badge {
  font-size: 12px;
  font-weight: 700;
  padding: 4px 10px;
  border-radius: 99px;
  background: #F1F5F9;
  color: #64748B;
  
  &.开心 { background: #FEF9C3; color: #A16207; }
  &.难过 { background: #DBEAFE; color: #1D4ED8; }
  &.愤怒 { background: #FEE2E2; color: #B91C1C; }
}

.chat-snapshot {
  display: flex;
  flex-direction: column;
  gap: 12px;
  padding: 16px;
  background: #FDFCFB;
  border-radius: 16px;
  border: 1px dashed #FED7AA;
}

.msg-bubble {
  max-width: 90%;
  padding: 10px 14px;
  font-size: 14px;
  line-height: 1.4;
  
  &.user {
    align-self: flex-start;
    background: #FFEDD5;
    color: #9A3412;
    border-radius: 16px 16px 16px 4px;
  }
  
  &.ai {
    align-self: flex-end;
    background: white;
    color: #431407;
    border-radius: 16px 16px 4px 16px;
    box-shadow: 0 2px 8px rgba(0,0,0,0.03);
  }
}

.card-footer {
  margin-top: 16px;
  text-align: right;
  .footer-hint {
    font-size: 12px;
    font-weight: 700;
    color: #FB923C;
    font-style: italic;
  }
}

.loading-state {
  display: flex;
  flex-direction: column;
  align-items: center;
  gap: 12px;
  padding: 40px;
  color: #EA580C;
  font-size: 14px;
  
  .spinner {
    width: 32px;
    height: 32px;
    border: 4px solid #FFEDD5;
    border-top-color: #EA580C;
    border-radius: 50%;
    animation: spin 1s linear infinite;
  }
  
  @keyframes spin { to { transform: rotate(360deg); } }
}

.bottom-spacer { height: 120px; }
.no-scrollbar::-webkit-scrollbar { display: none; }
</style>

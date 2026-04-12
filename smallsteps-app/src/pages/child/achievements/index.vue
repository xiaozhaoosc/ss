<script setup>
import { ref } from 'vue'
import { onShow } from '@dcloudio/uni-app'
import ChildBottomNav from '@/components/child/child-bottom-nav/child-bottom-nav.vue'
import { listChildAchievement } from '@/api/child'
import { useUserStore } from '@/store/modules/user'

const userStore = useUserStore()
const isDarkMode = ref(false)
const achievements = ref([])

const handleBack = () => {
  uni.navigateBack()
}

onShow(() => {
  loadAchievements()
})

const loadAchievements = () => {
  const childId = userStore.id || 1
  listChildAchievement(childId).then(res => {
    const list = res.data || res.rows || []
    achievements.value = list.map(item => ({
      id: item.achievementId,
      title: item.achievementName || '新成就',
      desc: item.description || '完成了一个里程碑',
      date: item.obtainTime ? item.obtainTime.substring(0, 10) : '刚刚'
    }))
  }).catch(err => {
    console.error('Failed to fetch achievements:', err)
  })
}
</script>

<template>
  <view class="achievements-page" :class="{ 'dark': isDarkMode }">
    <view class="header">
      <button class="back-btn" @click="handleBack">
        <text class="material-symbols-outlined icon">arrow_back</text>
      </button>
      <text class="page-title">我的成就</text>
      <view class="spacer"></view>
    </view>

    <scroll-view scroll-y class="main-content">
      <view v-if="achievements.length === 0" class="empty-state">
        <text class="material-symbols-outlined empty-icon">star</text>
        <text class="empty-text">暂无成就</text>
        <text class="empty-desc">完成任务后可以获得成就哦！</text>
      </view>
      
      <view v-else class="achievement-list">
        <view v-for="item in achievements" :key="item.id" class="ach-card">
           <view class="ach-icon"><text class="material-symbols-outlined">military_tech</text></view>
           <view class="ach-info">
             <text class="ach-title">{{ item.title }}</text>
             <text class="ach-desc">{{ item.desc }}</text>
           </view>
           <text class="ach-date">{{ item.date }}</text>
        </view>
      </view>
    </scroll-view>

    <view class="bg-gradient"></view>
    <child-bottom-nav active="home" />
  </view>
</template>

<style lang="scss" scoped>
.achievements-page {
  height: 100vh;
  display: flex;
  flex-direction: column;
  background-color: #8CD0A1;
  position: relative;
  overflow: hidden;

  :deep(.dark) & { background-color: #1e293b; }
}

.bg-gradient {
  position: absolute;
  inset: 0;
  background: linear-gradient(180deg, #8CD0A1 0%, #6CBF8B 100%);
  z-index: 0;
  pointer-events: none;

  :deep(.dark) & { background: linear-gradient(180deg, #1e293b 0%, #101622 100%); }
}

.header {
  display: flex;
  align-items: center;
  justify-content: space-between;
  padding: 24px 16px 16px 16px;
  padding-top: calc(24px + env(safe-area-inset-top));
  position: relative;
  z-index: 10;
}

.back-btn {
  width: 48px;
  height: 48px;
  border-radius: 999px;
  background-color: #ffffff;
  display: flex;
  align-items: center;
  justify-content: center;
  color: #1e293b;
  border: none;
  box-shadow: 0 1px 2px rgba(0,0,0,0.05);

  &::after { border: none; }

  :deep(.dark) & { background-color: #1e293b; color: #fff; }

  &:active { transform: scale(0.95); }
}

.page-title {
  font-size: 20px;
  font-weight: 900;
  color: #0f172a;
  :deep(.dark) & { color: #fff; }
}

.spacer { width: 48px; }

.main-content {
  flex: 1;
  display: flex;
  align-items: center;
  justify-content: center;
  position: relative;
  z-index: 10;
  padding-bottom: calc(88px + env(safe-area-inset-bottom));
}

.empty-state {
  display: flex;
  flex-direction: column;
  align-items: center;
  gap: 16px;
}

.empty-icon {
  font-size: 80px;
  color: #ffffff;
  opacity: 0.6;
}

.empty-text {
  font-size: 24px;
  font-weight: 700;
  color: #ffffff;
}

.empty-desc {
  font-size: 16px;
  color: rgba(255, 255, 255, 0.8);
}

.achievement-list {
  display: flex;
  flex-direction: column;
  gap: 16px;
  padding: 16px;
  width: 100%;
}
.ach-card {
  display: flex;
  align-items: center;
  gap: 16px;
  background: rgba(255, 255, 255, 0.9);
  padding: 16px;
  border-radius: 16px;
  box-shadow: 0 4px 12px rgba(0,0,0,0.05);
}
.ach-icon {
  width: 48px;
  height: 48px;
  border-radius: 50%;
  background: #fef3c7;
  color: #f59e0b;
  display: flex;
  align-items: center;
  justify-content: center;
  .material-symbols-outlined { font-size: 28px; }
}
.ach-info {
  flex: 1;
  display: flex;
  flex-direction: column;
  .ach-title { font-weight: bold; font-size: 16px; color: #1e293b; }
  .ach-desc { font-size: 12px; color: #64748b; margin-top: 4px; }
}
.ach-date { font-size: 12px; color: #94a3b8; }
</style>
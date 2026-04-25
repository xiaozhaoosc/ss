<script setup>
import { ref, computed } from 'vue'
import { onShow } from '@dcloudio/uni-app'
import ChildBottomNav from '@/components/child/child-bottom-nav/child-bottom-nav.vue'
import { listChildAchievement } from '@/api/child'
import { useUserStore } from '@/store/modules/user'

const userStore = useUserStore()
const isDarkMode = ref(false)
const unlockedBadges = ref([])
const stats = ref({
  stars: 0,
  fragments: 0
})

// 预置的所有勋章列表
const ALL_BADGES = [
  { name: '早起鸟', desc: '在早上 8:00 前完成第一项任务', icon: 'early_bird' },
  { name: '恒心大师', desc: '连续 7 天坚持打卡记录', icon: 'consistency_medal' },
  { name: '星光熠熠', desc: '累积获得超过 100 颗星星', icon: 'star_medal' },
  { name: '社交达人', desc: '与 AI 伙伴交流超过 10 次', icon: 'forum' },
  { name: '任务克星', desc: '单日完成 5 个挑战任务', icon: 'task_alt' }
]

const handleBack = () => {
  uni.navigateBack()
}

onShow(() => {
  loadData()
})

const loadData = async () => {
  const childId = userStore.id
  if (!childId) return
  try {
    const res = await listChildAchievement(childId)
    const list = res.data || res.rows || []
    
    // 过滤出勋章
    unlockedBadges.value = list.filter(item => item.type === 'BADGE').map(item => item.name)
    
    // 获取星星和碎片统计 (也可以从 list 中过滤)
    const starItem = list.find(item => item.type === 'STAR')
    const fragmentItem = list.find(item => item.type === 'FRAGMENT')
    
    stats.value.stars = starItem ? starItem.count : 0
    stats.value.fragments = fragmentItem ? fragmentItem.count : 0
    
  } catch (err) {
    console.error('Failed to load achievements:', err)
  }
}

const badgeList = computed(() => {
  return ALL_BADGES.map(badge => ({
    ...badge,
    unlocked: unlockedBadges.value.includes(badge.name)
  }))
})

const getIcon = (iconName) => {
  const map = {
    'early_bird': 'wb_twilight',
    'consistency_medal': 'verified',
    'star_medal': 'stars',
    'forum': 'forum',
    'task_alt': 'task_alt'
  }
  return map[iconName] || 'military_tech'
}
</script>

<template>
  <view class="achievements-page" :class="{ 'dark': isDarkMode }">
    <view class="header">
      <button class="back-btn" @click="handleBack">
        <text class="material-symbols-outlined icon">arrow_back</text>
      </button>
      <text class="page-title">成就奖牌榜</text>
      <view class="spacer"></view>
    </view>

    <!-- Stats Summary -->
    <view class="stats-overview">
      <view class="stat-card">
        <text class="material-symbols-outlined stat-icon star">stars</text>
        <view class="stat-info">
          <text class="stat-val">{{ stats.stars }}</text>
          <text class="stat-label">星星总数</text>
        </view>
      </view>
      <view class="stat-card">
        <text class="material-symbols-outlined stat-icon fragment">category</text>
        <view class="stat-info">
          <text class="stat-val">{{ stats.fragments }}</text>
          <text class="stat-label">勇气碎片</text>
        </view>
      </view>
    </view>

    <scroll-view scroll-y class="main-content">
      <view class="section-title">我的勋章集</view>
      <view class="badge-grid">
        <view 
          v-for="(item, index) in badgeList" 
          :key="index" 
          class="badge-item"
          :class="{ 'locked': !item.unlocked }"
        >
          <view class="badge-icon-wrapper">
             <view class="badge-ring"></view>
             <text class="material-symbols-outlined badge-icon">{{ getIcon(item.icon) }}</text>
             <view v-if="!item.unlocked" class="lock-overlay">
               <text class="material-symbols-outlined">lock</text>
             </view>
          </view>
          <text class="badge-name">{{ item.name }}</text>
          <text class="badge-desc" v-if="item.unlocked">{{ item.desc }}</text>
          <text class="badge-desc" v-else>未达成</text>
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
  background-color: #F8FAFC;
  position: relative;
  overflow: hidden;
}

.bg-gradient {
  position: absolute;
  inset: 0;
  background: linear-gradient(180deg, #F0FDFA 0%, #F8FAFC 100%);
  z-index: 0;
  pointer-events: none;
}

.header {
  display: flex;
  align-items: center;
  justify-content: space-between;
  padding: 16px;
  padding-top: calc(16px + env(safe-area-inset-top));
  position: relative;
  z-index: 10;
}

.back-btn {
  width: 44px;
  height: 44px;
  border-radius: 12px;
  background: white;
  display: flex;
  align-items: center;
  justify-content: center;
  box-shadow: 0 2px 8px rgba(0,0,0,0.05);
  border: none;
  &::after { border: none; }
}

.page-title {
  font-size: 18px;
  font-weight: 800;
  color: #0F172A;
}

.spacer { width: 44px; }

.stats-overview {
  display: flex;
  gap: 12px;
  padding: 0 16px 16px;
  position: relative;
  z-index: 10;
}

.stat-card {
  flex: 1;
  background: white;
  padding: 16px;
  border-radius: 20px;
  display: flex;
  align-items: center;
  gap: 12px;
  box-shadow: 0 4px 12px rgba(0,0,0,0.03);
}

.stat-icon {
  font-size: 32px;
  &.star { color: #EAB308; }
  &.fragment { color: #A855F7; }
}

.stat-info {
  display: flex;
  flex-direction: column;
  .stat-val { font-size: 20px; font-weight: 800; color: #1E293B; line-height: 1; }
  .stat-label { font-size: 11px; color: #64748B; margin-top: 4px; font-weight: 600; }
}

.main-content {
  flex: 1;
  position: relative;
  z-index: 10;
  padding: 0 16px;
}

.section-title {
  font-size: 16px;
  font-weight: 800;
  color: #334155;
  margin-bottom: 16px;
  display: block;
}

.badge-grid {
  display: grid;
  grid-template-columns: repeat(2, 1fr);
  gap: 16px;
  padding-bottom: 120px;
}

.badge-item {
  background: white;
  padding: 20px 12px;
  border-radius: 24px;
  display: flex;
  flex-direction: column;
  align-items: center;
  box-shadow: 0 4px 20px rgba(0,0,0,0.03);
  transition: transform 0.2s;
  
  &.locked {
    filter: grayscale(1);
    opacity: 0.7;
  }
}

.badge-icon-wrapper {
  position: relative;
  width: 80px;
  height: 80px;
  display: flex;
  align-items: center;
  justify-content: center;
  margin-bottom: 12px;
}

.badge-ring {
  position: absolute;
  inset: 0;
  border: 4px dashed #E2E8F0;
  border-radius: 50%;
  .badge-item:not(.locked) & {
    border: 4px solid #FEF08A;
    background: #FEFCE8;
  }
}

.badge-icon {
  font-size: 40px;
  color: #94A3B8;
  z-index: 1;
  .badge-item:not(.locked) & {
    color: #CA8A04;
  }
}

.lock-overlay {
  position: absolute;
  bottom: 0;
  right: 0;
  background: #64748B;
  color: white;
  width: 24px;
  height: 24px;
  border-radius: 50%;
  display: flex;
  align-items: center;
  justify-content: center;
  border: 2px solid white;
  .material-symbols-outlined { font-size: 14px; }
}

.badge-name {
  font-size: 15px;
  font-weight: 800;
  color: #1E293B;
  margin-bottom: 4px;
}

.badge-desc {
  font-size: 11px;
  color: #94A3B8;
  text-align: center;
}
</style>
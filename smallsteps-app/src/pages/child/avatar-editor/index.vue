<template>
  <view class="avatar-editor-page" :class="{ 'dark': isDarkMode }">
    <!-- Header -->
    <view class="header">
      <button class="back-btn" @click="handleBack">
        <text class="material-symbols-outlined icon">arrow_back</text>
      </button>
      <text class="page-title">角色装扮</text>
      <view class="spacer"></view>
    </view>

    <!-- Main Content -->
    <view class="main-content">
      <!-- Character Preview -->
      <view class="preview-area">
        <view class="island-shadow"></view>
        <view class="avatar-box bounce-float">
          <!-- 底图：小机器人 -->
          <image class="avatar-img robot-base" src="/static/images/avatar/robot_default.png" mode="aspectFit" />
          <!-- 顶图：选中的帽子 -->
          <image 
            v-if="selectedHatUrl" 
            class="avatar-img hat-overlay" 
            :class="{ 'bounce-in': animateHat }"
            :src="selectedHatUrl" 
            mode="aspectFit" 
          />
        </view>
      </view>

      <!-- Customization Panel -->
      <view class="panel-area">
        <avatar-item-selector 
          v-model="activeCategory"
          :selected-item-id="selectedItems[activeCategory]"
          :items="currentItems"
          @select="handleItemSelect"
        />
        
        <!-- Save Button -->
        <view class="save-box">
          <button class="save-btn" @click="handleSave">
            <text class="material-symbols-outlined icon">save</text>
            <text>保存</text>
          </button>
        </view>
      </view>
    </view>

    <!-- Background Decoration -->
    <view class="bg-gradient"></view>
    <text class="material-symbols-outlined float-icon star-1">star</text>
    <text class="material-symbols-outlined float-icon star-2">star</text>
    <text class="material-symbols-outlined float-icon cloud-1">cloud</text>

    <!-- Child Nav -->
    <child-bottom-nav active="avatar" />
  </view>
</template>

<script setup>
import { ref, computed, nextTick } from 'vue'
import ChildBottomNav from '@/components/child/child-bottom-nav/child-bottom-nav.vue'
import AvatarItemSelector from '@/components/child/avatar-item-selector/avatar-item-selector.vue'

const isDarkMode = ref(false)
const activeCategory = ref('hats')
const animateHat = ref(true)

// Mock state for selected items
const selectedItems = ref({
  hats: 1,
  colors: 0,
  accessories: 0
})

// Localized item data with local high-quality static assets
const hatItems = [
  { id: 1, name: '棒球帽', image: '/static/images/avatar/hat_baseball.png', locked: false },
  { id: 2, name: '头盔', image: '/static/images/avatar/hat_helmet.png', locked: false },
  { id: 3, name: '海盗帽', image: '/static/images/avatar/hat_pirate.png', locked: false },
  { id: 4, name: '竹蜻蜓', image: '/static/images/avatar/hat_dragonfly.png', locked: false },
  { id: 5, name: '皇冠', image: '/static/images/avatar/hat_crown.png', locked: true }
]

const currentItems = computed(() => {
  if (activeCategory.value === 'hats') return hatItems
  return [] // Returns empty for other categories in this demo
})

// Selected hat image URL computed from current choice
const selectedHatUrl = computed(() => {
  const hatId = selectedItems.value.hats
  const hat = hatItems.find(h => h.id === hatId)
  return hat ? hat.image : ''
})

const handleBack = () => {
  uni.navigateBack()
}

const handleItemSelect = (item) => {
  if (item.locked) {
    uni.showToast({ title: '该物品未解锁', icon: 'none' })
    return
  }
  selectedItems.value[activeCategory.value] = item.id
  
  // Trigger hat dynamic pop animation
  if (activeCategory.value === 'hats') {
    animateHat.value = false
    nextTick(() => {
      animateHat.value = true
    })
  }
}

const handleSave = () => {
  uni.vibrateShort()
  uni.showToast({ title: '装扮保存成功！', icon: 'success' })
}
</script>

<style lang="scss" scoped>
.avatar-editor-page {
  height: 100vh;
  display: flex;
  flex-direction: column;
  background-color: #f6f6f8;
  position: relative;
  overflow: hidden;
  
  :deep(.dark) & { background-color: #101622; }
}

.bg-gradient {
  position: absolute;
  inset: 0;
  background: linear-gradient(180deg, #E0F2FE 0%, #f6f6f8 100%);
  z-index: 0;
  pointer-events: none;
  
  :deep(.dark) & { background: linear-gradient(180deg, #1e293b 0%, #101622 100%); }
}

.float-icon {
  position: absolute;
  pointer-events: none;
  z-index: 0;
  opacity: 0.2;
  animation: float 4s ease-in-out infinite;
  
  &.star-1 { top: 80px; left: 40px; font-size: 36px; color: #2b6cee; }
  &.star-2 { bottom: 30%; left: 25%; font-size: 24px; color: #facc15; }
  &.cloud-1 { top: 160px; right: 40px; font-size: 64px; color: #2b6cee; opacity: 0.1; animation-delay: 1s; }
}

@keyframes float {
  0%, 100% { transform: translateY(0); }
  50% { transform: translateY(-10px); }
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
  flex-direction: column;
  position: relative;
  z-index: 10;
  padding-bottom: 24px;
}

.preview-area {
  flex: 1;
  width: 100%;
  display: flex;
  align-items: center;
  justify-content: center;
  position: relative;
  min-height: 300px;
}

.avatar-box {
  width: 200px;
  height: 200px;
  display: flex;
  align-items: center;
  justify-content: center;
  position: relative;
  z-index: 10;
  
  &.bounce-float { animation: float 4s ease-in-out infinite; }
}

.avatar-img {
  width: 100%;
  height: 100%;
  position: absolute;
}

.robot-base {
  z-index: 1;
}

.hat-overlay {
  z-index: 2;
  top: -20px;
  left: 0;
  width: 100%;
  height: 100%;
  transform-origin: bottom center;
}

.bounce-in {
  animation: hatBounce 0.45s cubic-bezier(0.175, 0.885, 0.32, 1.275) both;
}

@keyframes hatBounce {
  0% {
    transform: translateY(-45px) scale(0.5);
    opacity: 0;
  }
  70% {
    transform: translateY(4px) scale(1.05);
    opacity: 1;
  }
  100% {
    transform: translateY(0) scale(1);
  }
}

.island-shadow {
  position: absolute;
  bottom: 20px;
  width: 160px;
  height: 32px;
  background-color: rgba(0,0,0,0.1);
  border-radius: 999px;
  filter: blur(12px);
  transform: scaleX(1.5);
}

.panel-area {
  width: 100%;
  padding: 0 24px;
  display: flex;
  flex-direction: column;
  gap: 24px;
  padding-bottom: calc(88px + env(safe-area-inset-bottom));
}

.save-box {
  width: 100%;
}

.save-btn {
  width: 100%;
  height: 56px;
  background-color: #2b6cee; // primary
  border-radius: 999px;
  display: flex;
  align-items: center;
  justify-content: center;
  gap: 8px;
  color: #ffffff;
  font-size: 18px;
  font-weight: 700;
  box-shadow: 0 4px 12px rgba(43, 108, 238, 0.3);
  border: none;
  
  &::after { border: none; }
  
  &:active { transform: scale(0.98); }
}
</style>

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
          <image class="avatar-img" :src="currentImage" mode="aspectFit" />
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
import { ref, computed } from 'vue'
import ChildBottomNav from '@/components/child/child-bottom-nav/child-bottom-nav.vue'
import AvatarItemSelector from '@/components/child/avatar-item-selector/avatar-item-selector.vue'

const isDarkMode = ref(false)
const activeCategory = ref('hats')

// Mock state for selected items
const selectedItems = ref({
  hats: 1,
  colors: 0,
  accessories: 0
})

// Mock item data - In real app, this would be computed or fetched
const hatItems = [
  { id: 1, name: '棒球帽', image: 'https://lh3.googleusercontent.com/aida-public/AB6AXuCGb0hPJ1yEggcrGMM7jhMVzxLdWVGFaVtMFSU06VQzpk7Fja155MID9Z1NXqHjBoftUzpC33BKDXDbY3_GaMo0RftONw-fC4XIQ8tBIP4yQKSQwSCZtvdAkr8eVzS_c9tmhUvE1waTvMYxqCpOWxqyKqMpiwqYrybE5m1qDgv9MnI8GhWwbiWAxp8bEZFove6Q7a835ATkDgKiPfWGmM0UWqlxtkK_noYmgZfeaeCvmrKY8gYW60-Ioth-z9hw26U8R5t113SL-IY', locked: false },
  { id: 2, name: '头盔', image: 'https://lh3.googleusercontent.com/aida-public/AB6AXuAPQ1Q_iXRfKzEer3Eix2PvwUmnIKia0SfURR130wL7hYUhR5HDk6iMltpG_Q-BGZcjYnrvMfqAsyUwmUZuM8YBj1I0u_Q_OZBEv4Xpjbc2Kz_ddeALwEMELOZr7P0RQRKmWUcilIlMb7C2c6t8ABh2KBxYHmMBvBQp0oIlf89ygwkodkYfOM9xNaDg9yj4dIJszIk0Cx2bRvqLaIyBQC1okfIFOa_48-TI_RZwYEOfflMr2lC0QRLc1gQruQ0-XLGQZxm7337Tye8', locked: false },
  { id: 3, name: '海盗帽', image: 'https://lh3.googleusercontent.com/aida-public/AB6AXuD_oqOPHEjWV7Y7hXNWraHLdcscsln_NrVC_4wOIOCiK8fhra9DEk9bxjwd3gJFPB6rVVpp5kiwKL_TM0KDQXfpoQvpVA5PUQBS2TKfLlvJWyc0SG29hiP1IcL6SxTjsi6ntUNaCQs9t-uBWH4HDEwWQEud6_2XXjp7s4Q05YP9jjGSv5vV9BIN1t-24oyz8AMO6R1-j0YNwpiRe4dX5reJXWbBblNcwnOxDaATAvy8L5qcv8H0NEU9OFXQEETtoKd4tSWs_D2FG_4', locked: false },
  { id: 4, name: '竹蜻蜓', image: 'https://lh3.googleusercontent.com/aida-public/AB6AXuCuH4FUEONvLDTjTUfzdEJ7MtG0S8UOvohWHPmDE-nK6K2unfujNyWsUcGw_Ce8R_I_J1d-R3Uwbj3V5V3R7xSNwMX-yZqsua-1mSOb3nihsz9UmYmhX63Pa78bfxdeOzSFnZ095bX3ABuC-7ZLW4tWnBGNGY0faKGF0uUnk6DL_ZY5PNEmtHKTyKV_DJKGvkUA4944Aa42j3l8G-M48Hs6rF7E2_Xi7-0VqE17TimDxUv6a2LDsY2dqTy6Z1dd3Tt2gDzdUMaoupU', locked: false },
  { id: 5, name: '皇冠', image: 'https://lh3.googleusercontent.com/aida-public/AB6AXuDNgFuQEdI3ZVf_oLzVP-lQ52VmnyH4GY9TzH9Jea0xYqUa5r7fw5ss3Fc2-Frk-cUschc9G-5-Lv4dsHVD7AkHBoiYFzwHhQPonITMi8LIIjdqoY-kaXLia88hq-c714W1lTQkGdxuGdlBWHS_RmmJNi2txygDR911K8bDitMqOWBDd6Q1Fw3LWgBj0Qx_2vIbQa5QQLC95AzdR4_KOFsG4FsAK415ePqVmozzxNKx0tHaPWxKHbDvBim6EUXGN5RJCwEe8agGvHQ', locked: true }
]

const currentItems = computed(() => {
  if (activeCategory.value === 'hats') return hatItems
  return [] // Returns empty for other categories in this demo
})

// Current Avatar Image based on selection (Mock logic)
// In a real app, this would layer images or use a dynamic SVG/Canvas
const currentImage = computed(() => {
  return 'https://lh3.googleusercontent.com/aida-public/AB6AXuC-gkh44KgB_3ITvIh-AHFFFgbWH2JQFSh9SjavpcwsVlab4H7klttYh0kRXZBtf-9_GkaGVvBhNGQy0CrLpJN-cVlMmWI4saD906MCVBNVYt7tbiRgSK0GWsIowEZ-wr1BQISc8tg3EM-cLKcrHZsr7jN3_LW2oDniMEHCo4nis31sRXgEN6LE6akBtKQKmiTE75VZPZeAijuYbx-g3ajTjDWs51xjmekeSsLggif3J_UfmEePFG2ElXegYNOWeuV3SdCbfqe3nK8'
})

const handleBack = () => {
  uni.navigateBack()
}

const handleItemSelect = (item) => {
  selectedItems.value[activeCategory.value] = item.id
}

const handleSave = () => {
  uni.showToast({ title: '保存成功！', icon: 'success' })
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
  width: 100%;
  height: 100%;
  display: flex;
  align-items: center;
  justify-content: center;
  position: relative;
  z-index: 10;
  
  &.bounce-float { animation: float 4s ease-in-out infinite; }
}

.avatar-img {
  width: 100%;
  height: 80%;
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

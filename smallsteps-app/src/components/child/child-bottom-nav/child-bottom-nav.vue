<template>
  <view class="child-nav-container">
    <!-- Glass Background for Nav -->
    <view class="nav-bg"></view>
    
    <view class="nav-content">
      <!-- The Dashed Path Line -->
      <view class="path-line"></view>
      
      <!-- Nav Items -->
      <view class="nav-items">
        <!-- Shop -->
        <view class="nav-item" :class="{ 'active': active === 'shop' }" hover-class="nav-hover" @click="handleNav('shop')">
          <view class="icon-circle">
            <text class="material-symbols-outlined icon">storefront</text>
          </view>
          <text class="label">Shop</text>
        </view>
        
        <!-- Home -->
        <view class="nav-item" :class="{ 'active': active === 'home' }" hover-class="nav-hover" @click="handleNav('home')">
          <view class="icon-circle home-circle">
            <text class="material-symbols-outlined home-icon">emoji_events</text>
          </view>
          <text class="label" :class="{ 'active-label': active === 'home' }">Home</text>
        </view>
        
        <!-- Time Machine -->
        <view class="nav-item" :class="{ 'active': active === 'map' }" hover-class="nav-hover" @click="handleNav('map')">
          <view class="icon-circle map-circle">
            <text class="material-symbols-outlined map-icon">history</text>
          </view>
          <text class="label">Time</text>
        </view>
      </view>
    </view>
  </view>
</template>

<script setup>
const props = defineProps({
  active: {
    type: String,
    default: 'home'
  }
})

const handleNav = (tab) => {
  uni.vibrateShort()
  if (tab === 'shop') {
    uni.navigateTo({ url: '/pages/child/reward-shop/index' })
    return
  }
  if (tab === 'home') {
    uni.reLaunch({ url: '/pages/child/home/index' })
    return
  }
  if (tab === 'map') {
    uni.navigateTo({ url: '/pages/child/time-machine/index' })
    return
  }
}
</script>

<style lang="scss" scoped>
.child-nav-container {
  position: fixed;
  bottom: 0;
  left: 0;
  width: 100%;
  height: 96px;
  z-index: 50;
}

.nav-bg {
  position: absolute;
  inset: 0;
  background-color: rgba(255, 255, 255, 0.6);
  backdrop-filter: blur(20px);
  border-top-left-radius: 40px;
  border-top-right-radius: 40px;
  border-top: 1px solid rgba(255, 255, 255, 0.5);
  box-shadow: 0 -10px 40px rgba(0, 0, 0, 0.05);
}

.nav-content {
  position: relative;
  height: 100%;
  display: flex;
  align-items: center;
  justify-content: center;
  padding: 0 24px;
}

.path-line {
  position: absolute;
  width: 70%;
  height: 2px;
  background-color: transparent;
  border-bottom: 4px dashed #9ca3af;
  opacity: 0.3;
  top: 50%;
  left: 50%;
  transform: translate(-50%, -50%);
  border-radius: 99px;
}

.nav-items {
  width: 100%;
  max-width: 400px;
  display: flex;
  justify-content: space-between;
  align-items: flex-end;
  position: relative;
  z-index: 10;
  padding-bottom: 16px; 
}

.nav-item {
  display: flex;
  flex-direction: column;
  align-items: center;
  gap: 4px;
  transition: transform 0.2s ease;
  
  &:active { transform: scale(0.95); }
  
  &.locked { opacity: 0.6; transform: scale(0.9); }
  &.active { transform: scale(1.1) translateY(-16px); }
}

.icon-circle {
  width: 48px;
  height: 48px;
  border-radius: 999px;
  background-color: #e5e7eb;
  border: 4px solid #d1d5db;
  display: flex;
  align-items: center;
  justify-content: center;
  position: relative;
  box-shadow: 0 1px 2px rgba(0,0,0,0.1);
  
  .icon { color: #9ca3af; font-size: 24px; }
  
  &.home-circle {
    width: 64px;
    height: 64px;
    background-color: #f48c25;
    border: 6px solid #ffffff;
    box-shadow: 0 4px 12px rgba(244, 140, 37, 0.4);
  }
  
  &.map-circle {
    background-color: #8CD0A1;
    border-color: #ffffff;
    box-shadow: 0 4px 0 rgba(0,0,0,0.1);
  }
}

.lock-badge {
  position: absolute;
  top: -4px;
  right: -4px;
  background-color: #9ca3af;
  border-radius: 999px;
  padding: 2px;
  border: 2px solid #ffffff;
  display: flex;
  
  .lock-icon { font-size: 10px; color: #ffffff; }
}

.home-icon {
  font-size: 32px;
  color: #ffffff;
  font-variation-settings: 'FILL' 1;
}

.map-icon {
  font-size: 24px;
  color: #ffffff;
  font-weight: 700;
}

.label {
  font-size: 12px;
  font-weight: 700;
  color: #6b7280;
  
  &.active-label {
    color: #f48c25;
    background-color: #ffffff;
    padding: 2px 8px;
    border-radius: 999px;
    box-shadow: 0 1px 2px rgba(0,0,0,0.05);
  }
}

.nav-hover {
  transform: scale(0.9);
  opacity: 0.8;
}
</style>

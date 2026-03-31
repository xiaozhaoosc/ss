<template>
  <view class="top-bar" :class="mode + '-mode'">
    <view class="left">
      <view v-if="showBack" class="back-btn" @click="handleBack">
        <text class="icon">←</text>
      </view>
      <slot name="left"></slot>
    </view>
    
    <view class="center">
      <text class="title">{{ title }}</text>
    </view>
    
    <view class="right">
      <slot name="right"></slot>
    </view>
  </view>
</template>

<script setup>
const props = defineProps({
  title: {
    type: String,
    default: ''
  },
  mode: {
    type: String,
    default: 'parent', // 'parent' | 'child'
    validator: (value) => ['parent', 'child'].includes(value)
  },
  showBack: {
    type: Boolean,
    default: false
  }
})

const handleBack = () => {
  uni.navigateBack()
}
</script>

<style lang="scss" scoped>
.top-bar {
  position: fixed;
  top: 0;
  left: 0;
  right: 0;
  height: 44px;
  padding-top: env(safe-area-inset-top);
  display: flex;
  align-items: center;
  justify-content: space-between;
  padding-left: 16px;
  padding-right: 16px;
  z-index: 999;
  
  &.parent-mode {
    background: #ffffff;
    border-bottom: 1px solid #e5e7eb;
    
    .title { color: #111827; }
    .back-btn .icon { color: #6C9BD2; }
  }
  
  &.child-mode {
    background: linear-gradient(135deg, #8CD0A1, #F5D76E);
    
    .title { color: #ffffff; font-weight: 700; }
    .back-btn .icon { color: #ffffff; }
  }
}

.left, .right {
  flex: 1;
  display: flex;
  align-items: center;
}

.right {
  justify-content: flex-end;
}

.center {
  flex: 2;
  display: flex;
  justify-content: center;
  align-items: center;
}

.title {
  font-size: 17px;
  font-weight: 600;
  text-align: center;
}

.back-btn {
  display: flex;
  align-items: center;
  justify-content: center;
  width: 32px;
  height: 32px;
  cursor: pointer;
  
  &:active {
    opacity: 0.7;
  }
  
  .icon {
    font-size: 24px;
    font-weight: bold;
  }
}
</style>

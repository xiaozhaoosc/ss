<template>
  <view class="theme-toggle" @click="toggleTheme">
    <view class="toggle-track" :class="{ dark: isDark }">
      <view class="toggle-thumb">
        <text class="icon">{{ isDark ? '🌙' : '☀️' }}</text>
      </view>
    </view>
  </view>
</template>

<script setup>
import { ref, onMounted } from 'vue'

const isDark = ref(false)

onMounted(() => {
  // 从本地存储恢复主题
  const savedTheme = uni.getStorageSync('theme')
  if (savedTheme) {
    isDark.value = savedTheme === 'dark'
    applyTheme()
  }
})

const toggleTheme = () => {
  isDark.value = !isDark.value
  applyTheme()
  uni.setStorageSync('theme', isDark.value ? 'dark' : 'light')
}

const applyTheme = () => {
  // 在 uni-app 中,需要通过修改根元素的 class 来实现主题切换
  // 这里仅作示例,实际需要配合全局样式
  uni.setStorageSync('theme', isDark.value ? 'dark' : 'light')
}
</script>

<style lang="scss" scoped>
.theme-toggle {
  display: inline-flex;
  cursor: pointer;
}

.toggle-track {
  width: 48px;
  height: 28px;
  background: #e5e7eb;
  border-radius: 14px;
  position: relative;
  transition: background 0.3s ease;
  
  &.dark {
    background: #374151;
    
    .toggle-thumb {
      transform: translateX(20px);
    }
  }
}

.toggle-thumb {
  position: absolute;
  top: 2px;
  left: 2px;
  width: 24px;
  height: 24px;
  background: #ffffff;
  border-radius: 12px;
  display: flex;
  align-items: center;
  justify-content: center;
  transition: transform 0.3s ease;
  box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
  
  .icon {
    font-size: 14px;
  }
}
</style>

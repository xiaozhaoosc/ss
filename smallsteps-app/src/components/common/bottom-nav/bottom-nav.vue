<template>
  <view class="bottom-nav" :class="[mode + '-mode', { 'safe-area': safeArea }]">
    <view 
      v-for="item in navItems" 
      :key="item.path"
      class="nav-item"
      :class="{ active: currentPath === item.path }"
      hover-class="nav-item-hover"
      :hover-stay-time="50"
      @click="handleNavClick(item)"
    >
      <view class="icon-wrapper">
        <template v-if="item.icon.startsWith('/') || item.icon.startsWith('static/')">
          <image 
            class="icon-img" 
            :src="currentPath === item.path ? item.activeIcon : item.icon" 
            mode="aspectFit"
          ></image>
        </template>
        <template v-else>
          <text class="icon">{{ item.icon }}</text>
        </template>
        <view v-if="item.badge" class="badge">{{ item.badge }}</view>
      </view>
      <text class="label">{{ item.label }}</text>
    </view>
  </view>
</template>

<script setup>
import { computed } from 'vue'
import { useUserStore } from '@/store/modules/user'

const props = defineProps({
  mode: {
    type: String,
    default: 'parent', // 'parent' | 'child'
    validator: (value) => ['parent', 'child'].includes(value)
  },
  safeArea: {
    type: Boolean,
    default: true
  }
})

const userStore = useUserStore()

// 当前路径
const currentPath = computed(() => {
  const pages = getCurrentPages()
  if (pages.length) {
    return '/' + pages[pages.length - 1].route
  }
  return ''
})

// 导航项配置
const navItems = computed(() => {
  if (props.mode === 'parent') {
    return [
      { 
        path: '/pages/parent/dashboard/index', 
        icon: '/static/images/tabbar/home.png', 
        activeIcon: '/static/images/tabbar/home_.png',
        label: '首页' 
      },
      { 
        path: '/pages/parent/task-creator/index', 
        icon: '/static/images/tabbar/work.png', 
        activeIcon: '/static/images/tabbar/work_.png',
        label: '任务' 
      },
      { 
        path: '/pages/parent/insights/index', 
        icon: '/static/images/tabbar/setting.png', 
        activeIcon: '/static/images/tabbar/setting_.png',
        label: '洞察' 
      },
      { 
        path: '/pages/parent/profile/index', 
        icon: '/static/images/tabbar/mine.png', 
        activeIcon: '/static/images/tabbar/mine_.png',
        label: '我的', 
        badge: null 
      }
    ]
  } else {
    return [
      { path: '/pages/child/home/index', icon: '🏆', label: '奖杯房' },
      { path: '/pages/child/mission/index', icon: '🎯', label: '任务' },
      { path: '/pages/child/shop/index', icon: '🛒', label: '商店' },
      { path: '/pages/child/achievements/index', icon: '⭐', label: '成就' }
    ]
  }
})

// 导航点击
const handleNavClick = (item) => {
  if (currentPath.value === item.path) return
  
  uni.switchTab({
    url: item.path,
    fail: () => {
      uni.navigateTo({
        url: item.path
      })
    }
  })
}
</script>

<style lang="scss" scoped>
.bottom-nav {
  position: fixed;
  bottom: 0;
  left: 0;
  right: 0;
  display: flex;
  justify-content: space-around;
  align-items: center;
  height: 50px;
  background: #ffffff;
  border-top: 1px solid #e5e7eb;
  z-index: 999;
  
  &.safe-area {
    padding-bottom: env(safe-area-inset-bottom);
  }
  
  // 家长端样式
  &.parent-mode {
    background: #ffffff;
    border-top-color: #e5e7eb;
    
    .nav-item {
      &.active {
        .icon { color: #6C9BD2; }
        .label { color: #6C9BD2; font-weight: 600; }
      }
    }
  }
  
  // 儿童端样式
  &.child-mode {
    background: linear-gradient(to right, #f0fdf4, #fef3c7);
    border-top-color: #8CD0A1;
    
    .nav-item {
      &.active {
        .icon { transform: scale(1.2); }
        .label { color: #8CD0A1; font-weight: 700; }
      }
    }
  }
}

.nav-item {
  flex: 1;
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
  padding: 4px 0;
  cursor: pointer;
  transition: all 0.3s ease;
  
  &:active, &.nav-item-hover {
    opacity: 0.7;
    transform: scale(0.95);
  }
}

.icon-wrapper {
  position: relative;
  margin-bottom: 2px;
}

.icon {
  font-size: 24px;
  transition: transform 0.3s ease;
}

.icon-img {
  width: 24px;
  height: 24px;
  display: block;
  transition: transform 0.3s ease;
}

.badge {
  position: absolute;
  top: -4px;
  right: -8px;
  min-width: 16px;
  height: 16px;
  padding: 0 4px;
  background: #ef4444;
  color: #ffffff;
  font-size: 10px;
  font-weight: bold;
  border-radius: 8px;
  display: flex;
  align-items: center;
  justify-content: center;
}

.label {
  font-size: 10px;
  color: #6b7280;
  transition: all 0.3s ease;
}
</style>

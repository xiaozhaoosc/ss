<template>
  <view class="item-selector">
    <!-- Category Tabs -->
    <view class="tabs-container">
      <view class="tabs-pill">
        <view 
          v-for="tab in tabs" 
          :key="tab.value"
          class="tab-item"
          :class="{ 'active': modelValue === tab.value }"
          @click="handleTabClick(tab.value)"
        >
          <text class="material-symbols-outlined tab-icon">{{ tab.icon }}</text>
          <text class="tab-label">{{ tab.label }}</text>
        </view>
      </view>
    </view>
    
    <!-- Items Carousel -->
    <scroll-view scroll-x class="items-scroll no-scrollbar" :enable-flex="true">
      <view class="items-row">
        <view 
          v-for="item in items" 
          :key="item.id"
          class="item-wrapper"
          @click="handleItemSelect(item)"
        >
          <view 
            class="item-box"
            :class="{ 'selected': selectedItemId === item.id, 'locked': item.locked }"
          >
            <view v-if="selectedItemId === item.id" class="check-badge">
              <text class="material-symbols-outlined check-icon">check</text>
            </view>
            
            <image class="item-img" :src="item.image" mode="aspectFit" />
            
            <view v-if="item.locked" class="lock-overlay">
              <text class="material-symbols-outlined lock-icon">lock</text>
            </view>
          </view>
          <text class="item-name">{{ item.name }}</text>
        </view>
      </view>
    </scroll-view>
  </view>
</template>

<script setup>
import { ref } from 'vue'

const props = defineProps({
  modelValue: { type: String, default: 'hats' }, // activeCategory
  selectedItemId: { type: Number, default: 1 },
  items: { type: Array, default: () => [] }
})

const emit = defineEmits(['update:modelValue', 'select'])

const tabs = [
  { label: '帽子', value: 'hats', icon: 'checkroom' },
  { label: '颜色', value: 'colors', icon: 'palette' },
  { label: '配饰', value: 'accessories', icon: 'backpack' }
]

const handleTabClick = (val) => {
  emit('update:modelValue', val)
}

const handleItemSelect = (item) => {
  if (item.locked) {
    uni.showToast({ title: '该物品未解锁', icon: 'none' })
    return
  }
  emit('select', item)
}
</script>

<style lang="scss" scoped>
.item-selector {
  display: flex;
  flex-direction: column;
  gap: 24px;
}

.tabs-container {
  display: flex;
  justify-content: center;
}

.tabs-pill {
  display: flex;
  background-color: #ffffff;
  border-radius: 999px;
  padding: 6px;
  box-shadow: 0 1px 2px rgba(0,0,0,0.05);
  width: 100%;
  max-width: 320px;
  
  :deep(.dark) & { background-color: #1e293b; }
}

.tab-item {
  flex: 1;
  height: 40px;
  border-radius: 999px;
  display: flex;
  align-items: center;
  justify-content: center;
  gap: 8px;
  color: #64748b;
  transition: all 0.2s ease;
  
  :deep(.dark) & { color: #94a3b8; }
  
  &.active {
    background-color: #2b6cee; // primary
    color: #ffffff;
    box-shadow: 0 2px 4px rgba(43, 108, 238, 0.2);
    font-weight: 700;
  }
  
  &:active { transform: scale(0.95); }
}

.tab-icon { font-size: 20px; }
.tab-label { font-size: 14px; }

.items-scroll {
  width: 100%;
}

.items-row {
  display: flex;
  padding: 0 4px;
  gap: 16px;
}

.item-wrapper {
  display: flex;
  flex-direction: column;
  align-items: center;
  gap: 8px;
  flex-shrink: 0;
}

.item-box {
  position: relative;
  width: 96px;
  height: 96px;
  border-radius: 20px;
  background-color: #ffffff;
  border: 4px solid transparent;
  display: flex;
  align-items: center;
  justify-content: center;
  transition: transform 0.2s ease;
  box-shadow: 0 1px 2px rgba(0,0,0,0.05);
  padding: 8px;
  
  :deep(.dark) & { background-color: #1e293b; }
  
  &:active { transform: scale(0.95); }
  
  &.selected {
    border-color: #2b6cee;
  }
  
  &.locked {
    opacity: 0.6;
  }
}

.check-badge {
  position: absolute;
  top: -8px;
  right: -8px;
  width: 20px;
  height: 20px;
  border-radius: 999px;
  background-color: #2b6cee;
  display: flex;
  align-items: center;
  justify-content: center;
  z-index: 10;
  
  .check-icon { font-size: 14px; color: #ffffff; font-weight: 700; }
}

.item-img {
  width: 100%;
  height: 100%;
}

.lock-overlay {
  position: absolute;
  inset: 0;
  display: flex;
  align-items: center;
  justify-content: center;
  background-color: rgba(0,0,0,0.05);
  border-radius: 16px;
  
  .lock-icon { color: #94a3b8; font-size: 24px; }
}

.item-name {
  font-size: 14px;
  font-weight: 500;
  color: #475569;
  :deep(.dark) & { color: #cbd5e1; }
}

.no-scrollbar::-webkit-scrollbar {
  display: none;
}
</style>

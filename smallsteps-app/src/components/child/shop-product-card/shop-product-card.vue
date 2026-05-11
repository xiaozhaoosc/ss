<template>
  <view class="product-card" hover-class="card-hover" @click="handleCardClick">
    <view class="image-box" :class="bgClass">
      <text v-if="isEmoji" class="emoji-icon">{{ image }}</text>
      <image v-else class="product-img" :src="image" mode="aspectFit" />
      <view class="price-tag">
        <text class="material-symbols-outlined star-icon">star</text>
        <text class="price-val">{{ price }}</text>
      </view>
    </view>
    
    <view class="info">
      <text class="name">{{ name }}</text>
      
      <button 
        class="redeem-btn" 
        hover-class="redeem-hover"
        :class="{ 'disabled': disabled }"
        @click.stop="handleRedeem"
      >
        {{ disabled ? `还差 ${diff} 颗星` : '兑换' }}
      </button>
    </view>
  </view>
</template>

<script setup>
import { computed } from 'vue'

const props = defineProps({
  name: String,
  image: String,
  price: Number,
  userStars: { type: Number, default: 0 },
  bgClass: { type: String, default: 'bg-blue-50' } // Tailwind class mapping if possible, or use custom style
})

const emit = defineEmits(['redeem'])

const isEmoji = computed(() => {
  if (!props.image) return false
  // Basic emoji check: non-ascii or common emoji range
  return /^[\uD800-\uDBFF][\uDC00-\uDFFF]|[\u2600-\u27ff]/.test(props.image) || props.image.length <= 2
})

const disabled = computed(() => props.userStars < props.price)
const diff = computed(() => props.price - props.userStars)

const handleRedeem = () => {
  if (disabled.value) return
  // Add haptic feedback
  uni.vibrateShort()
  emit('redeem')
}

const handleCardClick = () => {
  // Add haptic feedback for card touch
  uni.vibrateShort()
  // Can show details modal
}
</script>

<style lang="scss" scoped>
.product-card {
  background-color: #ffffff;
  border-radius: 24px;
  padding: 12px;
  box-shadow: 0 4px 12px rgba(0,0,0,0.05);
  transition: transform 0.2s ease;
  
  &:active { transform: scale(0.96); }
  
  &.card-hover {
    transform: translateY(-4px) scale(1.02);
    box-shadow: 0 12px 24px rgba(0,0,0,0.1);
  }
  
  :deep(.dark) & { background-color: #1f2937; }
}

.image-box {
  position: relative;
  width: 100%;
  aspect-ratio: 4/3;
  border-radius: 16px;
  overflow: hidden;
  background-color: #f0f9ff; // default fallback
  margin-bottom: 12px;
  
  &.bg-blue-50 { background-color: #eff6ff; }
  &.bg-purple-50 { background-color: #faf5ff; }
  &.bg-pink-50 { background-color: #fdf2f8; }
  &.bg-yellow-50 { background-color: #fefce8; }
  &.bg-green-50 { background-color: #f0fdf4; }
}

.product-img {
  width: 100%;
  height: 100%;
}

.emoji-icon {
  font-size: 48px;
  display: flex;
  align-items: center;
  justify-content: center;
  height: 100%;
  width: 100%;
}

.price-tag {
  position: absolute;
  top: 8px;
  right: 8px;
  background-color: rgba(255, 255, 255, 0.9);
  backdrop-filter: blur(4px);
  padding: 4px 8px;
  border-radius: 999px;
  display: flex;
  align-items: center;
  gap: 4px;
  box-shadow: 0 1px 2px rgba(0,0,0,0.05);
}

.star-icon {
  font-size: 14px;
  color: #F5D76E; // Secondary yellow
  font-variation-settings: 'FILL' 1;
}

.price-val {
  font-size: 12px;
  font-weight: 700;
  color: #111813;
}

.info {
  padding: 0 4px 4px 4px;
}

.name {
  font-size: 18px;
  font-weight: 700;
  color: #111813;
  margin-bottom: 12px;
  display: block;
}

.redeem-btn {
  width: 100%;
  height: 40px;
  border-radius: 12px;
  background-color: rgba(140, 208, 161, 0.1); // primary/10
  color: #8CD0A1; // primary
  font-size: 14px;
  font-weight: 700;
  display: flex;
  align-items: center;
  justify-content: center;
  border: none;
  
  &::after { border: none; }
  
  &:active { background-color: #8CD0A1; color: #fff; }
  
  &.redeem-hover {
    transform: scale(0.96);
    background-color: #8CD0A1 !important;
    color: #ffffff !important;
  }
  
  &.disabled {
    background-color: #f3f4f6;
    color: #9ca3af;
    pointer-events: none;
  }
}
</style>

<template>
  <view class="trophy-jar" :class="{ 'shake': isAnimating }">
    <view class="text-box">
      <text class="label">STARS</text>
      <text class="count">{{ count }}</text>
    </view>
    
    <view class="jar-circle">
      <view class="liquid"></view>
      <text class="material-symbols-outlined star-icon">star</text>
    </view>
  </view>
</template>

<script setup>
import { ref, watch } from 'vue'

const props = defineProps({
  count: { type: Number, default: 0 }
})

const isAnimating = ref(false)

watch(() => props.count, (newVal, oldVal) => {
  if (newVal > oldVal) {
    isAnimating.value = true
    setTimeout(() => {
      isAnimating.value = false
    }, 500)
  }
})
</script>

<style lang="scss" scoped>
.trophy-jar {
  display: flex;
  align-items: center;
  gap: 8px;
  background-color: rgba(255, 255, 255, 0.9);
  backdrop-filter: blur(4px);
  padding: 8px;
  padding-left: 16px;
  border-radius: 999px;
  border: 2px solid #ffffff;
  box-shadow: 0 4px 0 rgba(0,0,0,0.05);
  
  &.shake {
    animation: wiggle 0.5s ease-in-out;
  }
}

.text-box {
  text-align: right;
  display: flex;
  flex-direction: column;
}

.label {
  font-size: 10px;
  font-weight: 700;
  color: #9ca3af;
  letter-spacing: 0.5px;
  line-height: 1;
  margin-bottom: 2px;
}

.count {
  font-size: 20px;
  font-weight: 700;
  color: #f48c25;
  line-height: 1;
}

.jar-circle {
  position: relative;
  width: 40px;
  height: 40px;
  border-radius: 999px;
  background-color: #fef3c7;
  border: 2px solid #facc15;
  overflow: hidden;
  display: flex;
  align-items: center;
  justify-content: center;
}

.liquid {
  position: absolute;
  bottom: 0;
  left: 0;
  right: 0;
  height: 60%;
  background-color: #facc15;
  opacity: 0.5;
}

.star-icon {
  position: relative;
  z-index: 10;
  font-size: 24px;
  color: #ca8a04;
  font-variation-settings: 'FILL' 1;
}

@keyframes wiggle {
  0%, 100% { transform: rotate(-3deg); }
  50% { transform: rotate(3deg); }
}
</style>

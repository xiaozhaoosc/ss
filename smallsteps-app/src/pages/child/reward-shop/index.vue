<template>
  <view class="child-shop-page" :class="{ 'dark': isDarkMode }">
    <!-- Header -->
    <view class="header">
      <view class="top-row">
        <button class="icon-btn" hover-class="btn-hover" @click="handleBack">
          <text class="material-symbols-outlined icon">arrow_back_ios_new</text>
        </button>
        <view class="avatar-circle">
          <image class="avatar-img" :src="avatarUrl" mode="aspectFill" />
        </view>
      </view>
      
      <view class="title-row">
        <view class="text-group">
          <text class="page-title">奖励商店</text>
          <text class="page-subtitle">用星星兑换超棒的礼物！</text>
        </view>
        
        <!-- Gamified Balance Badge -->
        <view class="balance-badge">
          <view class="star-circle bounce">
            <text class="material-symbols-outlined star-icon">star</text>
          </view>
          <view class="balance-info">
            <text class="label">我的星星</text>
            <text class="value">{{ userStore.balance }}</text>
          </view>
          <text class="material-symbols-outlined sparkle">auto_awesome</text>
        </view>
      </view>
    </view>

    <!-- Product Grid -->
    <scroll-view scroll-y class="main-content no-scrollbar">
      <view class="product-grid">
        <shop-product-card 
          v-for="prod in products"
          :key="prod.id"
          :name="prod.name"
          :image="prod.image"
          :price="prod.price"
          :user-stars="userStore.balance"
          :bg-class="prod.bgClass"
          @redeem="handleRedeem(prod)"
        />
      </view>
      <view class="spacer"></view>
    </scroll-view>

    <!-- Child Nav -->
    <child-bottom-nav active="shop" />
  </view>
</template>

<script setup>
import { ref, computed } from 'vue'
import { onLoad, onShow } from '@dcloudio/uni-app'
import ShopProductCard from '@/components/child/shop-product-card/shop-product-card.vue'
import ChildBottomNav from '@/components/child/child-bottom-nav/child-bottom-nav.vue'
import { listReward, redeemReward } from '@/api/reward'
import { useUserStore } from '@/store/modules/user'

const avatarUrl = computed(() => {
  const avatar = userStore.userInfo?.user?.avatar
  if (avatar) return avatar.startsWith('http') ? avatar : import.meta.env.VITE_APP_BASE_API + avatar
  return '/static/images/unnamed.png'
})

const isDarkMode = ref(false)
const userStore = useUserStore()
// stars comes from store
// const stars = ref(100)
const products = ref([])

async function loadData() {
  const childId = userStore.id
  if (!childId) return
  try {
    const res = await listReward({ pageNum: 1, pageSize: 20, status: '0' })
    if (res.rows) {
      products.value = res.rows.map(item => ({
        id: item.rewardId,
        name: item.name,
        price: item.pointsRequired,
        image: item.icon ? (
          item.icon.startsWith('http') ? item.icon : 
          (item.icon.startsWith('/') ? 
            ((import.meta.env.VITE_APP_BASE_API || '').endsWith('/') ? 
              (import.meta.env.VITE_APP_BASE_API + item.icon.slice(1)) : 
              (import.meta.env.VITE_APP_BASE_API + item.icon)
            ) : item.icon)
        ) : 'https://img.icons8.com/fluency/96/gift.png',
        bgClass: 'bg-blue-50' // Random or fixed color
      }))
    }
  } catch (e) {
    console.error(e)
  }
}

onShow(() => {
  if (userStore.id) {
    loadData()
    userStore.fetchBalance()
  }
})

const handleBack = () => {
  uni.vibrateShort()
  uni.navigateBack()
}

const handleRedeem = (prod) => {
  if (!userStore.userInfo?.user?.userId) {
     uni.showToast({ title: '用户未登录', icon: 'error' })
     return
  }
  uni.showModal({
    title: '确认兑换',
    content: `要花费 ${prod.price} 颗星兑换“${prod.name}”吗？`,
    success: (res) => {
      if (res.confirm) {
        if (userStore.balance >= prod.price) {
           uni.showLoading({ title: '兑换中...' })
           redeemReward({ 
              rewardId: prod.id, 
              userId: userStore.userInfo.user.userId 
           }).then(() => {
               uni.hideLoading()
               uni.showToast({ title: '兑换成功！', icon: 'success' })
               // Refresh balance
               userStore.fetchBalance()
           }).catch(() => {
               uni.hideLoading()
           })
        } else {
          uni.showToast({ title: '星星不足', icon: 'error' })
        }
      }
    }
  })
}
</script>

<style lang="scss" scoped>
.child-shop-page {
  height: 100vh;
  display: flex;
  flex-direction: column;
  background-color: #f2f7f4;
  
  :deep(.dark) & { background-color: #151d17; }
}

.header {
  padding: 24px 20px 20px 20px;
  padding-top: calc(24px + env(safe-area-inset-top));
  display: flex;
  flex-direction: column;
  gap: 20px;
}

.top-row {
  display: flex;
  justify-content: space-between;
  align-items: center;
}

.icon-btn {
  width: 40px;
  height: 40px;
  border-radius: 999px;
  background-color: #ffffff;
  display: flex;
  align-items: center;
  justify-content: center;
  color: #5f866c;
  box-shadow: 0 1px 2px rgba(0,0,0,0.05);
  border: none;
  &::after { border: none; }
  
  .icon { font-size: 20px; }
}

.btn-hover {
  transform: scale(0.9);
  background-color: #f0fdf4 !important;
}

.avatar-circle {
  width: 40px;
  height: 40px;
  border-radius: 999px;
  border: 2px solid #ffffff;
  box-shadow: 0 1px 2px rgba(0,0,0,0.05);
  overflow: hidden;
  background-color: rgba(245, 215, 110, 0.3);
}

.avatar-img {
  width: 100%;
  height: 100%;
}

.title-row {
  display: flex;
  justify-content: space-between;
  align-items: center;
}

.text-group .page-title {
  font-size: 28px;
  font-weight: 900;
  color: #111813;
  line-height: 1.2;
  display: block;
}

.text-group .page-subtitle {
  font-size: 14px;
  font-weight: 500;
  color: #5f866c;
  margin-top: 4px;
}

.balance-badge {
  position: relative;
  display: flex;
  align-items: center;
  gap: 8px;
  background-color: #ffffff;
  padding: 8px 16px 8px 12px;
  border-radius: 999px;
  box-shadow: 0 8px 24px -4px rgba(139, 208, 161, 0.2);
  border: 1px solid rgba(140, 208, 161, 0.1);
}

.star-circle {
  width: 40px;
  height: 40px;
  border-radius: 999px;
  background: linear-gradient(135deg, #F5D76E, #fde047);
  display: flex;
  align-items: center;
  justify-content: center;
  box-shadow: inset 0 2px 4px rgba(255,255,255,0.5);
  
  &.bounce { animation: bounce 3s infinite; }
}

@keyframes bounce {
  0%, 100% { transform: translateY(0); }
  50% { transform: translateY(-4px); }
}

.star-icon {
  font-size: 24px;
  color: #ffffff;
  font-variation-settings: 'FILL' 1;
}

.balance-info {
  display: flex;
  flex-direction: column;
}

.label {
  font-size: 10px;
  font-weight: 700;
  color: #5f866c;
  text-transform: uppercase;
  line-height: 1;
}

.value {
  font-size: 20px;
  font-weight: 900;
  color: #111813;
  line-height: 1;
}

.sparkle {
  position: absolute;
  top: -4px;
  right: -4px;
  font-size: 14px;
  color: #F5D76E;
  animation: pulse 2s infinite;
}

.main-content {
  flex: 1;
  padding: 0 20px;
}

.product-grid {
  display: grid;
  grid-template-columns: repeat(2, 1fr);
  gap: 16px;
  padding-bottom: 24px;
}

.spacer {
  height: 120px;
}

.no-scrollbar::-webkit-scrollbar {
  display: none;
}
</style>

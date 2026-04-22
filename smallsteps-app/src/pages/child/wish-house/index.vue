<template>
  <view class="min-h-screen bg-gray-50 p-4">
    <view class="text-xl font-bold mb-4">My Wish House</view>
    <view class="grid grid-cols-2 gap-4">
       <!-- Mock reward list -->
       <view class="bg-white rounded-xl p-4 shadow text-center">
         <view class="text-lg">Go to Zoo</view>
         <view class="text-orange-500 font-bold">50 Stars</view>
         <button class="mt-2 bg-blue-500 text-white rounded-full px-4 py-1" @click="redeem(1)">Redeem</button>
       </view>
    </view>
  </view>
</template>

<script setup>
import { ref } from 'vue'

const redeem = (rewardId) => {
  // Call API to redeem reward
  uni.showToast({ title: 'Request Sent!', icon: 'success' })
}
</script>

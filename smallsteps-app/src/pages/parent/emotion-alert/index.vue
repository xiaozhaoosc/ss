<template>
  <view class="p-4 bg-red-50 rounded-lg border border-red-100 mb-4">
    <view class="text-red-600 font-bold mb-2">AI Alert: High Frustration Detected</view>
    <view class="text-sm text-gray-700">
       Your child failed 2 math tasks and reported feeling angry. 
       Suggestion: "I noticed math was tough today, let's take a 10 minute break and play a game."
    </view>
    <button class="mt-3 bg-red-500 text-white rounded-full text-sm px-4 py-1" @click="markRead">Mark as Read</button>
  </view>
</template>

<script setup>
const markRead = () => {
  // call api to mark as read
  uni.showToast({ title: 'Alert dismissed', icon: 'success' })
}
</script>

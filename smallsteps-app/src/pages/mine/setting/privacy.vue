<template>
  <view class="privacy-page min-h-screen bg-[#f6f7f8]">
    <top-bar title="隐私政策" show-back />
    
    <scroll-view scroll-y class="main-content p-5 pt-20">
      <view class="card bg-white rounded-3xl p-6 shadow-sm">
        <text class="text-xl font-bold mb-4 block text-gray-800">隐私保护指引</text>
        <view class="content space-y-4">
          <text class="text-gray-600 leading-relaxed">
            “小步 (Small Steps)” 深度重视您的个人隐私与孩子的数据安全。我们承诺：
          </text>
          <view class="item p-4 bg-blue-50 rounded-2xl">
            <text class="font-bold text-blue-700 block mb-1">数据加密</text>
            <text class="text-sm text-blue-600">所有行为日志与情绪数据均经过银行级加密存储。</text>
          </view>
          <view class="item p-4 bg-purple-50 rounded-2xl">
            <text class="font-bold text-purple-700 block mb-1">本地优先</text>
            <text class="text-sm text-purple-600">部分语音处理在硬件终端本地完成，不上传至云端。</text>
          </view>
          <text class="text-gray-500 text-sm mt-6 block">
            更新日期：2026年5月8日
          </text>
        </view>
      </view>
    </scroll-view>
  </view>
</template>

<script setup>
import TopBar from '@/components/common/top-bar/top-bar.vue'
</script>

<style lang="scss" scoped>
.privacy-page {
  padding-top: env(safe-area-inset-top);
}
</style>

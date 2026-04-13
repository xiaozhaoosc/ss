<template>
  <view class="min-h-screen bg-gray-50 pb-24 relative">
    <view v-if="loading" class="py-20 text-center text-gray-500">加载中...</view>
    
    <template v-else-if="detail">
      <!-- 头部主题 -->
      <view class="h-48 w-full flex flex-col items-center justify-center text-white relative px-4" :style="{ backgroundColor: detail.bgColor || '#e0e7ff' }">
        <text class="text-5xl mb-2">{{ detail.icon || '📝' }}</text>
        <text class="text-xl font-bold text-center text-gray-800">{{ detail.title }}</text>
      </view>
      
      <!-- 详情与步骤列表 -->
      <view class="p-4 -mt-4 bg-white rounded-t-xl relative z-10 min-h-[50vh]">
        <view class="flex flex-wrap gap-2 mb-6">
          <text v-for="(tag, index) in detail.tags" :key="index" class="text-xs px-3 py-1 bg-gray-100 text-gray-600 rounded-full">
            {{ tag }}
          </text>
        </view>
        
        <view class="mb-4">
          <text class="text-base font-bold text-gray-800">模板步骤 ({{ detail.steps?.length || 0 }})</text>
        </view>
        
        <view class="flex flex-col gap-3">
          <view v-for="(step, index) in detail.steps" :key="index" class="flex gap-3 bg-gray-50 p-3 rounded-lg border border-gray-100">
            <view class="w-6 h-6 flex items-center justify-center bg-blue-100 text-blue-600 rounded-full text-xs font-bold shrink-0">
              {{ index + 1 }}
            </view>
            <view class="flex flex-col">
              <text class="text-sm font-bold text-gray-800">{{ step.title }}</text>
              <text v-if="step.description" class="text-xs text-gray-500 mt-1">{{ step.description }}</text>
              <text v-if="step.duration" class="text-xs text-blue-500 mt-1">预计耗时: {{ step.duration }}</text>
            </view>
          </view>
        </view>
      </view>
      
      <!-- 底部操作栏 -->
      <view class="fixed bottom-0 left-0 w-full p-4 bg-white border-t border-gray-100 pb-safe z-20">
        <button 
          class="w-full bg-blue-500 text-white rounded-full py-3 text-base font-bold flex items-center justify-center shadow-md active:bg-blue-600 transition-colors"
          :disabled="applying"
          @click="handleApply"
        >
          <text v-if="applying">应用中...</text>
          <text v-else>应用此模板至今日</text>
        </button>
      </view>
    </template>
    
    <view v-else class="py-20 text-center text-gray-500">
      模板不存在或已删除
    </view>
  </view>
</template>

<script setup lang="ts">
import { ref } from 'vue'
import { onLoad } from '@dcloudio/uni-app'
import { getTemplateDetail, applyTemplate } from '@/api/template'

const templateId = ref('')
const detail = ref<any>(null)
const loading = ref(true)
const applying = ref(false)

const fetchDetail = async () => {
  loading.value = true
  try {
    const res = await getTemplateDetail(templateId.value)
    detail.value = res.data || res
  } catch (error) {
    uni.showToast({ title: '获取详情失败', icon: 'none' })
  } finally {
    loading.value = false
  }
}

const handleApply = async () => {
  if (applying.value) return
  
  applying.value = true
  try {
    // 假设传递当天的 YYYY-MM-DD
    const today = new Date().toISOString().split('T')[0]
    await applyTemplate(templateId.value, today)
    
    uni.showToast({ title: '应用成功', icon: 'success' })
    setTimeout(() => {
      uni.navigateBack()
    }, 1500)
  } catch (error) {
    uni.showToast({ title: '应用失败，请重试', icon: 'none' })
  } finally {
    applying.value = false
  }
}

onLoad((options) => {
  if (options?.id) {
    templateId.value = options.id
    fetchDetail()
  } else {
    loading.value = false
  }
})
</script>

<style scoped>
.pb-safe {
  padding-bottom: env(safe-area-inset-bottom);
}
</style>
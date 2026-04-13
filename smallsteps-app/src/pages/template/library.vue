<template>
  <view class="min-h-screen bg-gray-50 p-4">
    <view v-if="loading && list.length === 0" class="py-10 text-center text-gray-500">
      加载中...
    </view>
    
    <view v-else-if="list.length === 0" class="py-20 flex flex-col items-center justify-center">
      <text class="text-4xl mb-4">📭</text>
      <text class="text-gray-500 text-sm">暂无可用模板</text>
    </view>
    
    <view v-else class="grid grid-cols-2 gap-4">
      <TemplateCard 
        v-for="item in list" 
        :key="item.id"
        :id="item.id"
        :title="item.title"
        :bg-color="item.bgColor"
        :icon="item.icon"
        :tags="item.tags"
        :step-count="item.stepCount"
        @click="goToDetail"
      />
    </view>
    
    <view v-if="loading && list.length > 0" class="py-4 text-center text-gray-500 text-xs">
      加载更多...
    </view>
    <view v-if="noMore && list.length > 0" class="py-4 text-center text-gray-400 text-xs">
      没有更多了
    </view>
  </view>
</template>

<script setup lang="ts">
import { ref } from 'vue'
import { onLoad, onPullDownRefresh, onReachBottom } from '@dcloudio/uni-app'
import TemplateCard from '@/components/TemplateCard.vue'
import { getTemplateList } from '@/api/template'

const list = ref<any[]>([])
const pageNum = ref(1)
const loading = ref(false)
const noMore = ref(false)

const fetchList = async (isRefresh = false) => {
  if (loading.value || (noMore.value && !isRefresh)) return
  
  if (isRefresh) {
    pageNum.value = 1
    noMore.value = false
  }
  
  loading.value = true
  try {
    const res = await getTemplateList({ pageNum: pageNum.value, pageSize: 10 })
    const data = res.data?.rows || res.data || []
    
    if (isRefresh) {
      list.value = data
    } else {
      list.value = [...list.value, ...data]
    }
    
    if (data.length < 10) {
      noMore.value = true
    } else {
      pageNum.value++
    }
  } catch (error) {
    uni.showToast({ title: '获取数据失败', icon: 'none' })
  } finally {
    loading.value = false
    if (isRefresh) {
      uni.stopPullDownRefresh()
    }
  }
}

const goToDetail = (id: string | number) => {
  uni.navigateTo({
    url: `/pages/template/detail?id=${id}`
  })
}

onLoad(() => {
  fetchList()
})

onPullDownRefresh(() => {
  fetchList(true)
})

onReachBottom(() => {
  fetchList()
})
</script>
<template>
  <view class="template-library-page" :class="{ 'dark': isDarkMode }">
    <top-bar title="ADHD 任务模板" :show-back="true" />

    <view class="search-section">
      <view class="search-bar">
        <text class="material-symbols-outlined search-icon">search</text>
        <input 
          type="text" 
          v-model="searchQuery" 
          placeholder="搜索生活、学习或情绪管理模板..." 
          class="search-input"
          @confirm="handleSearch"
        />
      </view>
    </view>

    <!-- Categories -->
    <scroll-view scroll-x class="category-scroll" show-scrollbar="false">
      <view class="category-list">
        <view 
          v-for="cat in categories" 
          :key="cat.id"
          class="category-item"
          :class="{ 'active': activeCategory === cat.id }"
          @click="activeCategory = cat.id"
        >
          <text>{{ cat.name }}</text>
        </view>
      </view>
    </scroll-view>

    <scroll-view 
      scroll-y 
      class="main-content" 
      @scrolltolower="handleReachBottom"
      refresher-enabled
      :refresher-triggered="refreshing"
      @refresherrefresh="handleRefresh"
    >
      <view class="template-list" v-if="filteredList.length > 0">
        <template-card 
          v-for="item in filteredList" 
          :key="item.id"
          :id="item.id"
          :title="item.title"
          :bg-color="item.bgColor || '#6C9BD2'"
          :icon="item.icon || '📝'"
          :tags="item.tags || []"
          :step-count="item.stepCount || 0"
          :use-count="item.useCount || 0"
          @click="goToDetail"
        />
        
        <view v-if="loading" class="loading-more">
          <text>加载中...</text>
        </view>
        <view v-if="noMore" class="no-more">
          <text>已经到底啦</text>
        </view>
      </view>
      
      <view v-else-if="!loading" class="empty-state">
        <text class="material-symbols-outlined empty-icon">inventory_2</text>
        <text class="empty-text">没找到相关模板</text>
        <button class="request-btn">向专家反馈</button>
      </view>
      
      <view class="safe-area-spacer"></view>
    </scroll-view>
  </view>
</template>

<script setup lang="ts">
import { ref, computed } from 'vue'
import { onLoad } from '@dcloudio/uni-app'
import TopBar from '@/components/common/top-bar/top-bar.vue'
import TemplateCard from '@/components/parent/template-card/template-card.vue'
import { getTemplateList } from '@/api/template'

const isDarkMode = ref(false)
const searchQuery = ref('')
const activeCategory = ref('all')
const loading = ref(false)
const refreshing = ref(false)
const noMore = ref(false)
const pageNum = ref(1)

const categories = [
  { id: 'all', name: '全部' },
  { id: 'daily', name: '生活自理' },
  { id: 'study', name: '高效学习' },
  { id: 'emotion', name: '情绪管理' },
  { id: 'social', name: '社交技巧' }
]

const list = ref<any[]>([])

// Mock fallback if API is empty or fails
const mockTemplates = [
  { id: 101, title: '晨间“极简”准备', icon: '☀️', bgColor: '#FFD93D', tags: ['ADHD友好', '视觉化'], stepCount: 5, category: 'daily', useCount: 1240 },
  { id: 102, title: '放学后任务盒子', icon: '🎒', bgColor: '#6C9BD2', tags: ['过度转场', '结构化'], stepCount: 4, category: 'study', useCount: 856 },
  { id: 103, title: '我的冷静空间', icon: '🧘', bgColor: '#A8E6CF', tags: ['情绪调节', '深呼吸'], stepCount: 3, category: 'emotion', useCount: 2103 },
  { id: 104, title: '睡前“卸载”仪式', icon: '🌙', bgColor: '#4D4D4D', tags: ['睡眠辅助', '无屏幕'], stepCount: 6, category: 'daily', useCount: 567 }
]

const filteredList = computed(() => {
  let result = list.value.length > 0 ? list.value : mockTemplates
  
  if (activeCategory.value !== 'all') {
    result = result.filter(item => item.category === activeCategory.value)
  }
  
  if (searchQuery.value) {
    const q = searchQuery.value.toLowerCase()
    result = result.filter(item => 
      item.title.toLowerCase().includes(q) || 
      item.tags?.some(t => t.toLowerCase().includes(q))
    )
  }
  
  return result
})

const fetchList = async (isRefresh = false) => {
  if (loading.value || (noMore.value && !isRefresh)) return
  
  if (isRefresh) {
    pageNum.value = 1
    noMore.value = false
    refreshing.value = true
  }
  
  loading.value = true
  try {
    const res: any = await getTemplateList({ pageNum: pageNum.value, pageSize: 10 })
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
    console.error('Fetch templates failed:', error)
  } finally {
    loading.value = false
    refreshing.value = false
  }
}

const handleRefresh = () => fetchList(true)
const handleReachBottom = () => fetchList()
const handleSearch = () => fetchList(true)

const goToDetail = (id: string | number) => {
  uni.navigateTo({
    url: `/pages/template/detail?id=${id}`
  })
}

onLoad(() => {
  fetchList()
})
</script>

<style lang="scss" scoped>
.template-library-page {
  height: 100vh;
  background: #f8fbff;
  display: flex;
  flex-direction: column;
  
  :deep(.dark) & {
    background: #0f172a;
  }
}

.search-section {
  padding: 16px;
  padding-top: 88px; // Header height
}

.search-bar {
  display: flex;
  align-items: center;
  background: #ffffff;
  padding: 12px 16px;
  border-radius: 16px;
  border: 1.5px solid rgba(108, 155, 210, 0.1);
  gap: 12px;
  box-shadow: 0 4px 15px rgba(108, 155, 210, 0.05);
  
  .search-icon {
    color: #94a3b8;
    font-size: 22px;
  }
  
  .search-input {
    flex: 1;
    font-size: 15px;
    color: #1e293b;
  }
  
  :deep(.dark) & {
    background: rgba(30, 41, 59, 0.8);
    border-color: rgba(255, 255, 255, 0.1);
    
    .search-input { color: #f1f5f9; }
  }
}

.category-scroll {
  white-space: nowrap;
  padding: 0 16px;
  margin-bottom: 20px;
}

.category-list {
  display: flex;
  gap: 12px;
}

.category-item {
  padding: 8px 20px;
  background: #ffffff;
  border-radius: 12px;
  font-size: 14px;
  font-weight: 700;
  color: #64748b;
  border: 1px solid rgba(108, 155, 210, 0.1);
  transition: all 0.3s ease;
  
  &.active {
    background: #6C9BD2;
    color: #ffffff;
    border-color: #6C9BD2;
    box-shadow: 0 4px 12px rgba(108, 155, 210, 0.25);
  }
  
  :deep(.dark) & {
    background: rgba(30, 41, 59, 0.5);
    border-color: rgba(255, 255, 255, 0.05);
    color: #94a3b8;
    
    &.active {
      background: #6C9BD2;
      color: #ffffff;
    }
  }
}

.main-content {
  flex: 1;
  padding: 0 16px;
}

.template-list {
  display: flex;
  flex-direction: column;
}

.loading-more, .no-more {
  text-align: center;
  padding: 24px;
  font-size: 12px;
  color: #94a3b8;
}

.empty-state {
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
  padding-top: 60px;
  
  .empty-icon {
    font-size: 64px;
    color: #cbd5e1;
    margin-bottom: 16px;
  }
  
  .empty-text {
    font-size: 15px;
    color: #94a3b8;
    margin-bottom: 24px;
  }
}

.request-btn {
  padding: 10px 24px;
  background: #ffffff;
  border: 1.5px solid #6C9BD2;
  color: #6C9BD2;
  font-size: 14px;
  font-weight: 700;
  border-radius: 12px;
  
  &::after { border: none; }
}

.safe-area-spacer {
  height: env(safe-area-inset-bottom);
  margin-bottom: 40px;
}
</style>
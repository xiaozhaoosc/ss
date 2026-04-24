<template>
  <view class="report-page" :class="{ 'dark': isDarkMode }">
    <view class="status-bar-placeholder"></view>
    
    <!-- 顶部导航 -->
    <view class="nav-bar">
      <view class="back-btn" @click="goBack">
        <text class="material-symbols-outlined">arrow_back_ios</text>
      </view>
      <text class="page-title">周度成长报告</text>
      <view class="share-btn">
        <text class="material-symbols-outlined">share</text>
      </view>
    </view>

    <scroll-view scroll-y class="content-scroll">
      <!-- 周期选择 -->
      <view class="period-selector">
        <text class="period-text">本周: 03.23 - 03.29</text>
        <text class="material-symbols-outlined">calendar_month</text>
      </view>

      <!-- 热力图 -->
      <weekly-heatmap :data="heatmapData" />

      <!-- AI 报告 -->
      <weekly-ai-report 
        v-if="aiAnalysis"
        :content="aiAnalysis"
        :task-count="8"
        :emotion-count="12"
      />

      <!-- 底部撑开 -->
      <view class="safe-area-bottom"></view>
    </scroll-view>
  </view>
</template>

<script setup lang="ts">
import { ref } from 'vue'
import { onLoad } from '@dcloudio/uni-app'
import WeeklyHeatmap from '@/components/parent/weekly-heatmap/weekly-heatmap.vue'
import WeeklyAiReport from '@/components/parent/weekly-ai-report/weekly-ai-report.vue'
import { getWeeklyHeatmap, getWeeklyAiAnalysis } from '@/api/parent'

const isDarkMode = ref(false)
const heatmapData = ref<any[]>([])
const aiAnalysis = ref('')
const childId = ref(1)

const goBack = () => uni.navigateBack()

async function loadReport() {
  uni.showLoading({ title: '报告生成中...' })
  try {
    const [heatmapRes, analysisRes]: any = await Promise.all([
      getWeeklyHeatmap(childId.value),
      getWeeklyAiAnalysis(childId.value)
    ])
    
    heatmapData.value = heatmapRes.data || []
    aiAnalysis.value = analysisRes.data || ''
  } catch (e) {
    console.error(e)
  } finally {
    uni.hideLoading()
  }
}

onLoad((options: any) => {
  if (options.cid) childId.value = options.cid
  loadReport()
})
</script>

<style lang="scss" scoped>
.report-page {
  min-height: 100vh;
  background: #f6f7f8;
  
  &.dark { background: #121720; }
}

.status-bar-placeholder {
  height: var(--status-bar-height);
}

.nav-bar {
  display: flex;
  align-items: center;
  justify-content: space-between;
  padding: 12px 16px;
  background: #f6f7f8;
  position: sticky;
  top: 0;
  z-index: 10;
  
  &.dark { background: #121720; }
}

.back-btn, .share-btn {
  width: 40px;
  height: 40px;
  display: flex;
  align-items: center;
  justify-content: center;
  color: #111827;
}

.page-title {
  font-size: 18px;
  font-weight: 700;
  color: #111827;
}

.content-scroll {
  height: calc(100vh - 100px);
}

.period-selector {
  margin: 16px;
  padding: 12px 20px;
  background: #ffffff;
  border-radius: 999px;
  display: flex;
  justify-content: space-between;
  align-items: center;
  box-shadow: 0 2px 8px rgba(0,0,0,0.05);
  
  .period-text {
    font-size: 14px;
    font-weight: 600;
    color: #4b5563;
  }
  
  .material-symbols-outlined {
    font-size: 20px;
    color: #6C9BD2;
  }
}

.safe-area-bottom {
  height: 40px;
}
</style>

<template>
  <div class="app-container home-container bg-[#f4f7fc] min-h-screen">
    <!-- Hero Section -->
    <div class="hero-section mb-6 p-8 rounded-[30px] bg-white shadow-sm overflow-hidden relative">
      <div class="relative z-10 flex items-center justify-between">
        <div>
          <h1 class="text-3xl font-bold text-gray-800">早安, 小步守护者</h1>
          <p class="mt-2 text-gray-500 max-w-lg">今天是守护 ADHD 儿童成长的第 128 天。AI 伴侣已就绪，正在实时监测孩子的专注时长与情绪波动。</p>
          <div class="mt-6 flex gap-3">
            <el-button type="primary" round icon="Plus" class="!px-6">发布新任务</el-button>
            <el-button round icon="VideoPlay" class="!px-6">查看实时状态</el-button>
          </div>
        </div>
        <div class="hidden md:block">
          <img src="https://img.icons8.com/fluency/240/rocket.png" class="w-48 animate-bounce-slow" alt="Hero Icon" />
        </div>
      </div>
      <div class="absolute top-[-50px] right-[-50px] w-64 h-64 bg-blue-50 rounded-full blur-3xl opacity-50"></div>
    </div>

    <!-- Stats Grid -->
    <el-row :gutter="20" class="mb-6">
      <el-col v-for="(stat, index) in topStats" :key="index" :xs="24" :sm="12" :md="6">
        <el-card shadow="never" class="stat-card border-none rounded-[24px] hover:shadow-md transition-shadow">
          <div class="flex items-center justify-between">
            <div :class="`p-3 rounded-[16px] bg-${stat.color}-50 text-${stat.color}-600`">
              <el-icon :size="28"><component :is="stat.icon" /></el-icon>
            </div>
            <div class="text-right">
              <div class="text-gray-400 text-sm mb-1">{{ stat.label }}</div>
              <div class="text-2xl font-bold">{{ stat.value }}</div>
            </div>
          </div>
          <div class="mt-4 flex items-center gap-2">
            <el-progress :percentage="stat.progress" :color="stat.hexColor" :show-text="false" class="flex-1" />
            <span class="text-xs text-gray-400">{{ stat.trend }}</span>
          </div>
        </el-card>
      </el-col>
    </el-row>

    <!-- Charts & Lists -->
    <el-row :gutter="20" class="mb-6">
      <el-col :span="16">
        <el-card shadow="never" class="!border-none rounded-[30px] h-full">
          <template #header>
            <div class="flex justify-between items-center">
              <span class="font-bold text-lg">守护洞察：任务执行与情绪相关性</span>
              <el-select v-model="timeRange" size="small" placeholder="时间范围" class="!w-[100px]">
                <el-option label="本周" value="week" />
                <el-option label="本月" value="month" />
              </el-select>
            </div>
          </template>
          <div ref="mainChartRef" style="height: 400px"></div>
        </el-card>
      </el-col>
      <el-col :span="8">
        <el-card shadow="never" class="!border-none rounded-[30px] h-full">
          <template #header>
            <span class="font-bold text-lg">正在执行中的小步</span>
          </template>
          <div class="timeline-container px-2">
            <el-timeline>
              <el-timeline-item
                v-for="(task, index) in activeTasks"
                :key="index"
                :type="task.type"
                :color="task.color"
                :hollow="task.hollow"
                :timestamp="task.time"
              >
                <div class="flex flex-col gap-1">
                  <span class="font-semibold text-gray-700">{{ task.title }}</span>
                  <span class="text-xs text-gray-400">当前阶段: {{ task.stage }}</span>
                </div>
              </el-timeline-item>
            </el-timeline>
            <el-empty v-if="activeTasks.length === 0" description="没有进行中的任务" :image-size="100" />
          </div>
        </el-card>
      </el-col>
    </el-row>

    <!-- Bottom Row (Achievements & Support) -->
    <el-row :gutter="20">
      <el-col :span="12">
        <el-card shadow="never" class="!border-none rounded-[30px]">
          <template #header>
            <span class="font-bold text-lg">最新成就墙</span>
          </template>
          <div class="flex gap-4 overflow-x-auto py-2 scrollbar-none">
            <div v-for="i in 5" :key="i" class="achievement-item shrink-0 p-4 bg-gray-50 rounded-[20px] w-[140px] text-center hover:bg-yellow-50 transition-colors cursor-pointer">
              <div class="w-16 h-16 mx-auto mb-3 bg-white rounded-full flex items-center justify-center shadow-sm">
                 <img :src="`https://img.icons8.com/bubbles/100/medal-first-place.png`" class="w-10 h-10" />
              </div>
              <div class="font-bold text-sm truncate">专注小达人</div>
              <div class="text-[10px] text-gray-400 mt-1">2024-03-22</div>
            </div>
          </div>
        </el-card>
      </el-col>
      <el-col :span="12">
        <el-card shadow="never" class="!border-none rounded-[30px] bg-gradient-to-r from-indigo-500 to-purple-600 text-white">
          <div class="flex items-center gap-6 p-4">
            <el-icon :size="64" class="opacity-80"><MagicStick /></el-icon>
            <div>
              <h3 class="text-xl font-bold">AI 分步引导优化建议</h3>
              <p class="mt-2 text-indigo-100 opacity-90 text-sm">根据 Leo 最近的情况，建议将“写作业”任务进一步拆解为“整理桌面”、“打开第32页”等具体动作以降低阻碍感。</p>
              <el-button type="success" size="small" class="mt-4 !bg-white !text-indigo-600 border-none font-bold">一键优化所有任务</el-button>
            </div>
          </div>
        </el-card>
      </el-col>
    </el-row>
  </div>
</template>

<script setup lang="ts">
import * as echarts from 'echarts';
import { Collection, Timer, Sunny, Monitor, MagicStick } from '@element-plus/icons-vue';
import { getShadowEmotionTrend } from '@/api/smallsteps/insight';

const mainChartRef = ref();
const timeRange = ref('week');

const topStats = [
  { label: '在线儿童', value: '42', icon: Monitor, color: 'blue', hexColor: '#409EFF', progress: 85, trend: '+12%' },
  { label: '任务完成率', value: '78.5%', icon: Collection, color: 'green', hexColor: '#67C23A', progress: 78, trend: '较昨日 +5%' },
  { label: '平均专注时长', value: '45m', icon: Timer, color: 'orange', hexColor: '#E6A23C', progress: 65, trend: '稳定' },
  { label: '情绪平衡度', value: '优', icon: Sunny, color: 'purple', hexColor: '#B37FEB', progress: 92, trend: '显著改善' }
];

const activeTasks = [
  { title: '晨间洗漱挑战', stage: '刷牙中', time: '10分钟前', type: 'primary', color: '#409EFF', hollow: false },
  { title: '数学口算练习', stage: '准备阶段', time: '正在开始', type: 'success', color: '#67C23A', hollow: true },
  { title: '自主整理书包', stage: '已待命', time: '预计 18:00', type: 'info', color: '#909399', hollow: true }
];

let mainChart: echarts.ECharts | null = null;

onMounted(() => {
  initMainChart();
  loadShadowData();
  window.addEventListener('resize', () => mainChart?.resize());
});

const shadowPoints = ref([]);

async function loadShadowData() {
  // 模拟当前选择的儿童ID，实际项目中应从下拉框或全局状态获取
  const mockChildId = 1;
  try {
    const res = await getShadowEmotionTrend(mockChildId, 7);
    if (res.data) {
      // 将后端返回的 frustrationCount 转换为图表上的散点坐标
      // 这里的坐标是 [x轴索引, 对应的情绪指数值]
      // 为了让预警点浮在折线图上方，我们取当天情绪值 + 0.5
      shadowPoints.value = res.data.map((item, index) => {
        if (item.frustrationCount > 0) {
          return [index, item.avgMood + 0.3, item.frustrationCount];
        }
        return null;
      }).filter(i => i !== null);
      
      updateChartWithShadow();
    }
  } catch (error) {
    console.error('加载影子预警数据失败', error);
  }
}

function updateChartWithShadow() {
  if (!mainChart) return;
  mainChart.setOption({
    series: [
      {}, // 完成量
      {}, // 情绪指数
      {
        name: '影子预警',
        type: 'scatter',
        yAxisIndex: 1,
        symbol: 'path://M12.884 2.532c-.346-.654-1.422-.654-1.768 0l-9 17c-.154.291-.156.639-.005.932.15.293.456.476.789.476h18c.334 0 .639-.183.789-.476.151-.293.149-.641-.005-.932l-9-17zM12 18c-.553 0-1-.447-1-1s.447-1 1-1 1 .447 1 1-.447 1-1 1zm1-3c0 .553-.447 1-1 1s-1-.447-1-1v-5c0-.553.447-1 1-1s1 .447 1 1v5z',
        symbolSize: 20,
        itemStyle: {
          color: '#F56C6C',
          shadowBlur: 10,
          shadowColor: 'rgba(245, 108, 108, 0.5)'
        },
        data: shadowPoints.value,
        tooltip: {
          formatter: (params: any) => {
            return `影子预警: ${params.data[2]} 次躁动点击`;
          }
        }
      }
    ]
  });
}

function initMainChart() {
  if (mainChartRef.value) {
    mainChart = echarts.init(mainChartRef.value);
    mainChart.setOption({
      tooltip: { trigger: 'axis', axisPointer: { type: 'cross' } },
      legend: { data: ['完成量', '情绪指数', '影子预警'], bottom: 0 },
      grid: { left: '3%', right: '4%', bottom: '10%', containLabel: true },
      xAxis: { type: 'category', data: ['周一', '周二', '周三', '周四', '周五', '周六', '周日'], axisLine: { lineStyle: { color: '#eee' } }, axisLabel: { color: '#999' } },
      yAxis: [
        { type: 'value', name: '任务数', splitLine: { lineStyle: { type: 'dashed' } } },
        { type: 'value', name: '评分', min: 0, max: 10, splitLine: { show: false } }
      ],
      series: [
        {
          name: '完成量',
          type: 'bar',
          barWidth: 15,
          itemStyle: { color: '#409EFF', borderRadius: [4, 4, 0, 0] },
          data: [12, 19, 15, 22, 18, 10, 8]
        },
        {
          name: '情绪指数',
          type: 'line',
          yAxisIndex: 1,
          smooth: true,
          symbolSize: 10,
          lineStyle: { width: 4, color: '#67C23A' },
          itemStyle: { color: '#67C23A', borderColor: '#fff', borderWidth: 2 },
          data: [6.5, 7.2, 5.8, 8.5, 8.1, 9.0, 9.2]
        }
      ]
    });
  }
}
</script>

<style scoped lang="scss">
.home-container {
  padding: 30px;
}

.animate-bounce-slow {
  animation: bounce 3s infinite;
}

@keyframes bounce {
  0%, 100% { transform: translateY(0); }
  50% { transform: translateY(-20px); }
}

.stat-card {
  height: 140px;
  display: flex;
  flex-direction: column;
  justify-content: center;
}

.scrollbar-none::-webkit-scrollbar {
  display: none;
}

.timeline-container {
  max-height: 400px;
  overflow-y: auto;
}

:deep(.el-timeline-item__node) {
  box-shadow: 0 0 0 4px rgba(64, 158, 255, 0.1);
}

:deep(.el-card__header) {
  border-bottom: 2px solid #f6f8fb;
  padding: 20px 25px;
}
</style>

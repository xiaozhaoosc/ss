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

    <!-- Top Stats Grid -->
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

    <!-- AI & Growth Insights -->
    <el-row :gutter="20" class="mb-6">
      <!-- AI Intelligence Center -->
      <el-col :span="8" :xs="24">
        <el-card shadow="hover" class="premium-card ai-center-card h-full">
          <template #header>
            <div class="card-header">
              <span class="title"><el-icon><Cpu /></el-icon> AI 智能中心</span>
              <el-tag :type="aiUsage.status" size="small" effect="dark">{{ aiUsage.status === 'warning' ? '负载较高' : '运行良好' }}</el-tag>
            </div>
          </template>
          <div class="ai-stats">
            <div class="stat-item">
              <div class="label">今日消耗 Token</div>
              <div class="value">{{ aiUsage.todayTokens?.toLocaleString() }}</div>
            </div>
            <div class="usage-progress">
              <div class="progress-info">
                <span>今日额度消耗</span>
                <span>{{ aiUsage.usageRate }}%</span>
              </div>
              <el-progress :percentage="aiUsage.usageRate" :color="progressColors" :stroke-width="10" />
            </div>
            <div class="footer-stats">
              <div class="stat-mini">
                <span class="label">预估费用:</span>
                <span class="value">¥{{ aiUsage.todayCost }}</span>
              </div>
              <div class="stat-mini">
                <span class="label">剩余可用:</span>
                <span class="value">{{ aiUsage.remainingQuota?.toLocaleString() }}</span>
              </div>
            </div>
          </div>
        </el-card>
      </el-col>

      <!-- Ability Radar -->
      <el-col :span="8" :xs="24">
        <el-card shadow="hover" class="premium-card radar-card h-full">
          <template #header>
            <div class="card-header">
              <span class="title"><el-icon><Odometer /></el-icon> 潜能开发雷达</span>
            </div>
          </template>
          <div id="abilityRadarChart" style="height: 250px;"></div>
        </el-card>
      </el-col>

      <!-- Behavior Heatmap -->
      <el-col :span="8" :xs="24">
        <el-card shadow="hover" class="premium-card heatmap-card h-full">
          <template #header>
            <div class="card-header">
              <span class="title"><el-icon><Calendar /></el-icon> 行为一致性热力图</span>
            </div>
          </template>
          <div id="habitHeatmapChart" style="height: 250px;"></div>
        </el-card>
      </el-col>
    </el-row>

    <!-- Main Analytics & Task Queue -->
    <el-row :gutter="20">
      <el-col :span="16" :xs="24">
        <el-card shadow="hover" class="premium-card chart-card mb-6">
          <template #header>
            <div class="card-header">
              <span class="title"><el-icon><TrendCharts /></el-icon> 守护洞察：任务执行与情绪相关性</span>
              <el-radio-group v-model="chartTimeRange" size="small">
                <el-radio-button label="7d">近7天</el-radio-button>
                <el-radio-button label="30d">近30天</el-radio-button>
              </el-radio-group>
            </div>
          </template>
          <div ref="mainChartRef" class="main-insight-chart" style="height: 400px"></div>
        </el-card>

        <!-- Achievement Wall -->
        <el-card shadow="hover" class="premium-card achievement-wall">
          <template #header>
            <div class="card-header">
              <span class="title"><el-icon><Trophy /></el-icon> 最新成就墙</span>
              <el-button type="primary" link>查看全部</el-button>
            </div>
          </template>
          <div class="achievement-grid">
            <div v-for="(achievement, index) in latestAchievements" :key="index" class="achievement-item">
              <div class="icon-wrapper">
                <img :src="achievement.icon" :alt="achievement.name" />
              </div>
              <div class="achievement-name">{{ achievement.name }}</div>
              <div class="achievement-date">{{ achievement.date }}</div>
            </div>
          </div>
        </el-card>
      </el-col>

      <el-col :span="8" :xs="24">
        <el-card shadow="hover" class="premium-card task-list-card h-full">
          <template #header>
            <div class="card-header">
              <span class="title"><el-icon><List /></el-icon> 正在执行中的任务</span>
              <el-button type="primary" link>管理</el-button>
            </div>
          </template>
          <div class="task-list">
            <div v-for="task in activeTasks" :key="task.id" class="task-item">
              <el-checkbox v-model="task.completed" />
              <div class="task-content">
                <div class="task-title">{{ task.name }}</div>
                <div class="task-meta">
                  <el-tag size="small" :type="task.type === 'habit' ? 'success' : 'warning'">{{ task.type === 'habit' ? '习惯' : '挑战' }}</el-tag>
                  <span class="time"><el-icon><Timer /></el-icon> {{ task.time }}</span>
                </div>
              </div>
              <div class="reward-points">+{{ task.points }} <el-icon color="#E6A23C"><StarFilled /></el-icon></div>
            </div>
            <el-empty v-if="activeTasks.length === 0" description="暂无进行中的任务" />
          </div>
        </el-card>
      </el-col>
    </el-row>

    <!-- Onboarding Overlay -->
    <OnboardingOverlay v-model="showOnboarding" @complete="handleOnboardingComplete" />
  </div>
</template>

<script setup lang="ts">
import * as echarts from 'echarts';
import { 
  Collection, Timer, Sunny, Monitor, TrendCharts, Trophy, List, StarFilled, Cpu, Odometer, Calendar, Plus, VideoPlay 
} from '@element-plus/icons-vue';
import { getShadowEmotionTrend } from '@/api/smallsteps/insight';
import OnboardingOverlay from '@/components/SmallSteps/OnboardingOverlay.vue';
import achievementMedal from '@/assets/images/achievement-medal.png';

const { proxy } = getCurrentInstance() as any;
const mainChartRef = ref();
const chartTimeRange = ref('7d');
const showOnboarding = ref(false);

const aiUsage = ref({
  todayTokens: 12580,
  todayCost: '0.1258',
  dailyQuota: 100000,
  remainingQuota: 87420,
  usageRate: 12,
  status: 'normal'
});

const progressColors = [
  { color: '#67C23A', percentage: 20 },
  { color: '#E6A23C', percentage: 70 },
  { color: '#F56C6C', percentage: 90 }
];

const topStats = [
  { label: '在线儿童', value: '42', icon: Monitor, color: 'blue', hexColor: '#409EFF', progress: 85, trend: '+12%' },
  { label: '任务完成率', value: '78.5%', icon: Collection, color: 'green', hexColor: '#67C23A', progress: 78, trend: '较昨日 +5%' },
  { label: '平均专注时长', value: '45m', icon: Timer, color: 'orange', hexColor: '#E6A23C', progress: 65, trend: '稳定' },
  { label: '情绪平衡度', value: '优', icon: Sunny, color: 'purple', hexColor: '#B37FEB', progress: 92, trend: '显著改善' }
];

const activeTasks = ref([
  { id: 1, name: '晨间洗漱挑战', type: 'challenge', points: 10, time: '10分钟前', completed: false },
  { id: 2, name: '数学口算练习', type: 'habit', points: 20, time: '正在开始', completed: false },
  { id: 3, name: '自主整理书包', type: 'habit', points: 15, time: '18:00', completed: false }
]);

const latestAchievements = ref([
  { name: '专注小达人', date: '2024-03-22', icon: achievementMedal },
  { name: '早起先锋', date: '2024-03-21', icon: achievementMedal },
  { name: '作业克星', date: '2024-03-20', icon: achievementMedal },
  { name: '情绪小天使', date: '2024-03-19', icon: achievementMedal }
]);

let mainChart: echarts.ECharts | null = null;
let radarChart: echarts.ECharts | null = null;
let heatmapChart: echarts.ECharts | null = null;

onMounted(() => {
  initMainChart();
  initAbilityRadarChart();
  initHabitHeatmapChart();
  loadShadowData();
  window.addEventListener('resize', handleResize);
});

onUnmounted(() => {
  window.removeEventListener('resize', handleResize);
});

const handleResize = () => {
  mainChart?.resize();
  radarChart?.resize();
  heatmapChart?.resize();
};

function handleOnboardingComplete() {
  proxy.$modal.msgSuccess("恭喜获得新手星星包！🌟");
}

const shadowPoints = ref([]);

async function loadShadowData() {
  const mockChildId = 1;
  try {
    const res = await getShadowEmotionTrend(mockChildId, 7);
    if (res?.data) {
      shadowPoints.value = res.data.map((item: any, index: number) => {
        return item.frustrationCount > 0 ? [index, item.avgMood + 0.3, item.frustrationCount] : null;
      }).filter((i: any) => i !== null);
      updateChartWithShadow();
    }
  } catch (error) {
    console.error('加载影子预警数据失败', error);
  }
}

function updateChartWithShadow() {
  if (!mainChart) return;
  mainChart.setOption({
    series: [{}, {}, {
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
        formatter: (params: any) => `影子预警: ${params.data[2]} 次躁动点击`
      }
    }]
  });
}

function initMainChart() {
  if (mainChartRef.value) {
    mainChart = echarts.init(mainChartRef.value);
    mainChart.setOption({
      tooltip: { trigger: 'axis', axisPointer: { type: 'cross' } },
      legend: { data: ['完成量', '情绪指数', '影子预警'], bottom: 0 },
      grid: { left: '3%', right: '4%', bottom: '10%', containLabel: true },
      xAxis: { type: 'category', data: ['周一', '周二', '周三', '周四', '周五', '周六', '周日'], axisLine: { lineStyle: { color: '#eee' } } },
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

function initAbilityRadarChart() {
  const chartDom = document.getElementById('abilityRadarChart');
  if (!chartDom) return;
  radarChart = echarts.init(chartDom);
  radarChart.setOption({
    radar: {
      indicator: [
        { name: '专注力', max: 100 },
        { name: '执行力', max: 100 },
        { name: '创造力', max: 100 },
        { name: '社交', max: 100 },
        { name: '情绪管理', max: 100 },
        { name: '自主学习', max: 100 }
      ],
      shape: 'circle',
      splitNumber: 4,
      axisName: { color: '#909399' },
      splitLine: { lineStyle: { color: 'rgba(0, 0, 0, 0.05)' } },
      splitArea: { show: false }
    },
    series: [{
      name: '能力概览',
      type: 'radar',
      data: [{
        value: [85, 72, 90, 65, 80, 75],
        name: '当前状态',
        areaStyle: { color: 'rgba(64, 158, 255, 0.2)' },
        lineStyle: { color: '#409EFF', width: 2 },
        itemStyle: { color: '#409EFF' }
      }]
    }]
  });
}

function initHabitHeatmapChart() {
  const chartDom = document.getElementById('habitHeatmapChart');
  if (!chartDom) return;
  heatmapChart = echarts.init(chartDom);
  
  const getVirtualData = (year: string) => {
    const date = +echarts.time.parse(year + '-01-01');
    const end = +echarts.time.parse(+year + 1 + '-01-01');
    const dayTime = 3600 * 24 * 1000;
    const data = [];
    for (let time = date; time < end; time += dayTime) {
      data.push([
        echarts.time.format(time, '{yyyy}-{MM}-{dd}', false),
        Math.floor(Math.random() * 1000)
      ]);
    }
    return data;
  };

  const currentYear = new Date().getFullYear().toString();
  heatmapChart.setOption({
    visualMap: {
      show: false, min: 0, max: 1000,
      inRange: { color: ['#EBEDF0', '#9BE9A8', '#40C463', '#30A14E', '#216E39'] }
    },
    calendar: {
      top: 30, left: 30, right: 30,
      cellSize: ['auto', 13], range: currentYear,
      itemStyle: { borderWidth: 0.5, borderColor: '#fff' },
      yearLabel: { show: false },
      monthLabel: { fontSize: 10, nameMap: 'cn' },
      dayLabel: { show: false }
    },
    series: {
      type: 'scatter', coordinateSystem: 'calendar', symbolSize: 8,
      data: getVirtualData(currentYear)
    }
  });
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

.premium-card {
  border-radius: 24px;
  border: none;
  background: #ffffff;
  box-shadow: 0 4px 20px rgba(0, 0, 0, 0.05);
  transition: all 0.3s ease;

  &:hover {
    transform: translateY(-5px);
    box-shadow: 0 8px 30px rgba(0, 0, 0, 0.08);
  }

  .card-header {
    display: flex;
    justify-content: space-between;
    align-items: center;
    
    .title {
      font-size: 16px;
      font-weight: 600;
      color: #303133;
      display: flex;
      align-items: center;
      gap: 8px;
    }
  }
}

.ai-center-card {
  .ai-stats {
    padding: 10px 0;
    .stat-item {
      margin-bottom: 20px;
      .label { font-size: 14px; color: #909399; margin-bottom: 8px; }
      .value { font-size: 28px; font-weight: bold; color: #303133; }
    }
    .usage-progress {
      margin-bottom: 20px;
      .progress-info {
        display: flex; justify-content: space-between;
        font-size: 13px; color: #606266; margin-bottom: 5px;
      }
    }
    .footer-stats {
      display: flex; justify-content: space-between;
      border-top: 1px solid #f2f6fc; padding-top: 15px;
      .stat-mini {
        .label { font-size: 12px; color: #909399; }
        .value { font-size: 14px; font-weight: 500; color: #606266; }
      }
    }
  }
}

.achievement-wall {
  .achievement-grid {
    display: flex; gap: 20px; overflow-x: auto; padding: 10px 0;
    &::-webkit-scrollbar { height: 4px; }
    &::-webkit-scrollbar-thumb { background: #e4e7ed; border-radius: 2px; }
    
    .achievement-item {
      flex: 0 0 100px; text-align: center;
      .icon-wrapper {
        width: 70px; height: 70px; margin: 0 auto 10px;
        background: #f8f9fb; border-radius: 20px;
        display: flex; align-items: center; justify-content: center;
        img { width: 40px; height: 40px; }
      }
      .achievement-name { font-size: 13px; font-weight: 500; color: #303133; }
      .achievement-date { font-size: 11px; color: #909399; }
    }
  }
}

.task-list-card {
  .task-list {
    .task-item {
      display: flex; align-items: center; gap: 12px;
      padding: 12px; border-radius: 12px; background: #f8f9fb;
      margin-bottom: 10px;
      .task-content {
        flex: 1;
        .task-title { font-size: 14px; font-weight: 500; color: #303133; }
        .task-meta { display: flex; align-items: center; gap: 8px; font-size: 12px; color: #909399; }
      }
      .reward-points { font-size: 14px; font-weight: 600; color: #E6A23C; }
    }
  }
}
</style>

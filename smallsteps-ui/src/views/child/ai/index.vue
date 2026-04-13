<template>
  <div class="p-4 bg-[#f6f8fb] min-h-screen">
    <!-- 头部统计卡片 -->
    <el-row :gutter="20" class="mb-5">
      <el-col :span="6">
        <el-card shadow="never" class="stat-card animate__animated animate__fadeIn">
          <div class="flex items-center gap-4">
            <div class="icon-box bg-blue-100 text-blue-600">
              <el-icon :size="24"><ChatDotRound /></el-icon>
            </div>
            <div>
              <div class="text-gray-400 text-sm">今日交互次</div>
              <div class="text-2xl font-bold">{{ stats.todayCount }}</div>
            </div>
          </div>
        </el-card>
      </el-col>
      <el-col :span="6">
        <el-card shadow="never" class="stat-card animate__animated animate__fadeIn" style="animation-delay: 0.1s">
          <div class="flex items-center gap-4">
            <div class="icon-box bg-green-100 text-green-600">
              <el-icon :size="24"><Sunrise /></el-icon>
            </div>
            <div>
              <div class="text-gray-400 text-sm">平均情绪状态</div>
              <div class="text-2xl font-bold text-green-600">{{ stats.avgEmotionLabel }}</div>
            </div>
          </div>
        </el-card>
      </el-col>
      <el-col :span="6">
        <el-card shadow="never" class="stat-card animate__animated animate__fadeIn" style="animation-delay: 0.2s">
          <div class="flex items-center gap-4">
            <div class="icon-box bg-orange-100 text-orange-600">
              <el-icon :size="24"><Bell /></el-icon>
            </div>
            <div>
              <div class="text-gray-400 text-sm">AI 介入次数</div>
              <div class="text-2xl font-bold">{{ stats.interventionCount }}</div>
            </div>
          </div>
        </el-card>
      </el-col>
      <el-col :span="6">
        <el-card shadow="never" class="stat-card animate__animated animate__fadeIn" style="animation-delay: 0.3s">
          <div class="flex items-center gap-4">
            <div class="icon-box bg-purple-100 text-purple-600">
              <el-icon :size="24"><Medal /></el-icon>
            </div>
            <div>
              <div class="text-gray-400 text-sm">情感连接天数</div>
              <div class="text-2xl font-bold">{{ stats.connectionDays }}</div>
            </div>
          </div>
        </el-card>
      </el-col>
    </el-row>

    <!-- 中间图表 -->
    <el-row :gutter="20" class="mb-5">
      <el-col :span="16">
        <el-card class="chart-card !border-none" shadow="hover">
          <template #header>
            <div class="flex justify-between items-center">
              <span class="font-bold text-lg">情绪波动趋势 (7天)</span>
              <el-radio-group v-model="trendType" size="small">
                <el-radio-button label="valence">情绪正负</el-radio-button>
                <el-radio-button label="frequency">交互频率</el-radio-button>
              </el-radio-group>
            </div>
          </template>
          <div ref="trendChartRef" style="height: 350px"></div>
        </el-card>
      </el-col>
      <el-col :span="8">
        <el-card class="chart-card !border-none" shadow="hover">
          <template #header>
            <span class="font-bold text-lg">主要情绪分布</span>
          </template>
          <div ref="pieChartRef" style="height: 350px"></div>
        </el-card>
      </el-col>
    </el-row>

    <!-- 底部交互记录 -->
    <el-card class="!border-none" shadow="hover">
      <template #header>
        <div class="flex justify-between items-center">
          <span class="font-bold text-lg">AI 守护日志</span>
          <el-button link type="primary">查看全部</el-button>
        </div>
      </template>
      
      <el-table :data="interactionLogs" style="width: 100%">
        <el-table-column label="交互时间" prop="createTime" width="180" />
        <el-table-column label="儿童输入" prop="userInput">
          <template #default="scope">
            <div class="chat-bubble user-bubble">{{ scope.row.userInput }}</div>
          </template>
        </el-table-column>
        <el-table-column label="AI 响应" prop="aiResponse">
          <template #default="scope">
            <div class="chat-bubble ai-bubble">{{ scope.row.aiResponse }}</div>
          </template>
        </el-table-column>
        <el-table-column label="即时情绪" width="120" align="center">
          <template #default="scope">
            <el-tag :type="getEmotionType(scope.row.emotionType)" effect="plain">
              {{ getEmotionLabel(scope.row.emotionType) }}
            </el-tag>
          </template>
        </el-table-column>
      </el-table>
    </el-card>
  </div>
</template>

<script setup lang="ts">
import * as echarts from 'echarts';
import { listAI, getEmotionTrend } from '@/api/smallsteps/ai';
import { ChatDotRound, Sunrise, Bell, Medal } from '@element-plus/icons-vue';

const trendChartRef = ref();
const pieChartRef = ref();
const trendType = ref('valence');
const interactionLogs = ref<any[]>([]);
const stats = reactive({
  todayCount: 12,
  avgEmotionLabel: '平静',
  interventionCount: 3,
  connectionDays: 45
});

/** ECharts 实例 */
let trendChart: echarts.ECharts | null = null;
let pieChart: echarts.ECharts | null = null;

onMounted(() => {
  initCharts();
  loadData();
  window.addEventListener('resize', handleResize);
});

onUnmounted(() => {
  window.removeEventListener('resize', handleResize);
});

function handleResize() {
  trendChart?.resize();
  pieChart?.resize();
}

function initCharts() {
  if (trendChartRef.value) {
    trendChart = echarts.init(trendChartRef.value);
    trendChart.setOption({
      tooltip: { trigger: 'axis' },
      xAxis: { type: 'category', data: ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'], boundaryGap: false },
      yAxis: { type: 'value', min: 0, max: 10 },
      series: [{
        data: [5, 6, 4, 8, 7, 5, 9],
        type: 'line',
        smooth: true,
        areaStyle: {
          color: new echarts.graphic.LinearGradient(0, 0, 0, 1, [
            { offset: 0, color: 'rgba(64, 158, 255, 0.3)' },
            { offset: 1, color: 'rgba(64, 158, 255, 0)' }
          ])
        },
        lineStyle: { width: 3, color: '#409EFF' },
        symbol: 'circle',
        symbolSize: 8
      }]
    });
  }

  if (pieChartRef.value) {
    pieChart = echarts.init(pieChartRef.value);
    pieChart.setOption({
      tooltip: { trigger: 'item' },
      legend: { bottom: '5%', left: 'center' },
      series: [
        {
          name: '情绪分布',
          type: 'pie',
          radius: ['40%', '70%'],
          avoidLabelOverlap: false,
          itemStyle: { borderRadius: 10, borderColor: '#fff', borderWidth: 2 },
          label: { show: false },
          emphasis: { label: { show: true, fontSize: 16, fontWeight: 'bold' } },
          data: [
            { value: 1048, name: '平静' },
            { value: 735, name: '开心' },
            { value: 580, name: '烦躁' },
            { value: 484, name: '低落' }
          ]
        }
      ]
    });
  }
}

async function loadData() {
  const res = await listAI({ pageSize: 5 });
  interactionLogs.value = res.rows || [];
}

function getEmotionLabel(type: number) {
  const map: any = {
    1: '大哭', 2: '伤心', 3: '委屈', 4: '平静', 5: '快乐', 6: '兴奋'
  };
  return map[type] || '未知';
}

function getEmotionType(type: number) {
  if (type <= 3) return 'danger';
  if (type === 4) return 'info';
  return 'success';
}
</script>

<style scoped lang="scss">
.stat-card {
  border-radius: 20px;
  .icon-box {
    padding: 12px;
    border-radius: 12px;
  }
}

.chart-card {
  border-radius: 20px;
  background: white;
}

.chat-bubble {
  padding: 8px 12px;
  border-radius: 12px;
  font-size: 13px;
  max-width: 90%;
  line-height: 1.5;
}

.user-bubble {
  background: #f0f2f5;
  color: #333;
}

.ai-bubble {
  background: #e1f3d8;
  color: #67c23a;
}

:deep(.el-card__header) {
  border-bottom: 1px solid #f0f2f5;
}
</style>

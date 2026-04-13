<template>
  <div class="p-4 bg-[#f0f4f8] min-h-screen">
    <el-row :gutter="20">
      <!-- 左侧：成就与概览 -->
      <el-col :span="8">
        <el-card shadow="never" class="mb-5 !border-none rounded-[24px] overflow-hidden profile-card">
          <div class="p-4 text-center">
            <el-avatar :size="80" icon="UserFilled" />
            <h2 class="mt-4 text-xl font-bold">小步学员</h2>
            <div class="mt-2 flex justify-center gap-2">
              <el-tag type="warning" effect="dark" round>LV.4 专注达人</el-tag>
            </div>
            <div class="mt-6 flex justify-around">
              <div>
                <div class="text-gray-400 text-xs">当前积分</div>
                <div class="text-2xl font-bold text-orange-500">{{ currentScore }}</div>
              </div>
              <div>
                <div class="text-gray-400 text-xs">累计获得</div>
                <div class="text-2xl font-bold">{{ totalScore }}</div>
              </div>
            </div>
          </div>
        </el-card>

        <el-card shadow="hover" class="!border-none rounded-[24px]">
          <template #header>
            <div class="flex justify-between items-center">
              <span class="font-bold">成就勋章</span>
              <el-link type="primary" :underline="false">更多</el-link>
            </div>
          </template>
          <div class="grid grid-cols-3 gap-4">
            <div v-for="i in 6" :key="i" class="flex flex-col items-center opacity-80 hover:opacity-100 transition-opacity cursor-pointer">
              <div class="medal-icon shadow-sm" :class="i <= 3 ? 'bg-yellow-100' : 'bg-gray-100 grayscale'">
                <el-icon :size="24" :color="i <= 3 ? '#b8860b' : '#999'"><Medal /></el-icon>
              </div>
              <span class="text-[10px] mt-1 text-gray-500">勋章 {{ i }}</span>
            </div>
          </div>
        </el-card>
      </el-col>

      <!-- 右侧：趋势与日志 -->
      <el-col :span="16">
        <el-card shadow="hover" class="mb-5 !border-none rounded-[24px]">
          <template #header>
            <span class="font-bold">积分获取趋势 (月度)</span>
          </template>
          <div ref="scoreChartRef" style="height: 300px"></div>
        </el-card>

        <el-card shadow="hover" class="!border-none rounded-[24px]">
          <template #header>
            <div class="flex justify-between items-center">
              <span class="font-bold">积分流水明细</span>
              <el-button type="primary" plain size="small" @click="handleAdjust">手动调整</el-button>
            </div>
          </template>
          <el-table :data="scoreLogs" stripe style="width: 100%">
            <el-table-column prop="createTime" label="日期" width="180" />
            <el-table-column prop="sourceType" label="来源">
              <template #default="scope">
                <el-icon class="mr-1"><component :is="getSourceIcon(scope.row.sourceType)" /></el-icon>
                {{ getSourceLabel(scope.row.sourceType) }}
              </template>
            </el-table-column>
            <el-table-column prop="scoreChange" label="变动">
              <template #default="scope">
                <span :class="scope.row.scoreChange > 0 ? 'text-green-500' : 'text-red-500'" class="font-bold">
                  {{ scope.row.scoreChange > 0 ? '+' : '' }}{{ scope.row.scoreChange }}
                </span>
              </template>
            </el-table-column>
            <el-table-column prop="remark" label="备注" show-overflow-tooltip />
          </el-table>
        </el-card>
      </el-col>
    </el-row>

    <!-- 积分调整弹窗 -->
    <el-dialog v-model="adjustOpen" title="手动调整积分" width="400px">
      <el-form :model="adjustForm" label-width="80px">
        <el-form-item label="变动分值">
          <el-input-number v-model="adjustForm.scoreChange" :min="-1000" :max="1000" />
        </el-form-item>
        <el-form-item label="原因备注">
          <el-input v-model="adjustForm.remark" type="textarea" placeholder="请输入调整原因" />
        </el-form-item>
      </el-form>
      <template #footer>
        <el-button @click="adjustOpen = false">取消</el-button>
        <el-button type="primary" @click="submitAdjust">确认调整</el-button>
      </template>
    </el-dialog>
  </div>
</template>

<script setup lang="ts">
import * as echarts from 'echarts';
import { listScore } from '@/api/smallsteps/score';
import { Medal, Star, CollectionTag, Timer } from '@element-plus/icons-vue';

const scoreChartRef = ref();
const currentScore = ref(1280);
const totalScore = ref(5400);
const scoreLogs = ref<any[]>([]);
const adjustOpen = ref(false);
const adjustForm = reactive({
  scoreChange: 0,
  remark: ''
});

let scoreChart: echarts.ECharts | null = null;

onMounted(() => {
  initChart();
  loadLogs();
});

function initChart() {
  if (scoreChartRef.value) {
    scoreChart = echarts.init(scoreChartRef.value);
    scoreChart.setOption({
      tooltip: { trigger: 'axis' },
      grid: { left: '3%', right: '4%', bottom: '3%', containLabel: true },
      xAxis: { type: 'category', data: ['W1', 'W2', 'W3', 'W4'] },
      yAxis: { type: 'value' },
      series: [{
        name: '获得积分',
        type: 'bar',
        barWidth: '20%',
        data: [420, 580, 490, 610],
        itemStyle: {
          color: new echarts.graphic.LinearGradient(0, 0, 0, 1, [
            { offset: 0, color: '#83bff6' },
            { offset: 0.5, color: '#188df0' },
            { offset: 1, color: '#188df0' }
          ]),
          borderRadius: [5, 5, 0, 0]
        }
      }]
    });
  }
}

async function loadLogs() {
  // 模拟数据或请求API
  const res = await listScore({ pageSize: 5 });
  scoreLogs.value = res.rows || [
    { createTime: '2024-03-20 10:00', sourceType: 1, scoreChange: 50, remark: '完成每日早起任务' },
    { createTime: '2024-03-19 15:30', sourceType: 2, scoreChange: -200, remark: '兑换游乐场门票' },
    { createTime: '2024-03-18 20:00', sourceType: 1, scoreChange: 100, remark: '专注学习 45 分钟' }
  ];
}

function getSourceIcon(type: number) {
  const map: any = { 1: Star, 2: CollectionTag, 3: Timer };
  return map[type] || Star;
}

function getSourceLabel(type: number) {
  const map: any = { 1: '任务奖励', 2: '礼品兑换', 3: '成长挑战' };
  return map[type] || '其他';
}

function handleAdjust() {
  adjustOpen.value = true;
}

function submitAdjust() {
  // API 调用
  adjustOpen.value = false;
  ElMessage.success('调整成功');
}
</script>

<style scoped lang="scss">
.profile-card {
  background: white;
  position: relative;
  &::before {
    content: '';
    position: absolute;
    top: 0; left: 0; right: 0; height: 100px;
    background: linear-gradient(135deg, #a1c4fd 0%, #c2e9fb 100%);
  }
}

.medal-icon {
  width: 50px;
  height: 50px;
  border-radius: 50%;
  display: flex;
  align-items: center;
  justify-content: center;
}

:deep(.el-table) {
  --el-table-border-color: transparent;
  background: transparent;
}
</style>

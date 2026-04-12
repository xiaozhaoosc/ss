<template>
  <div class="p-4 bg-gray-50 min-h-screen">
    <div class="text-2xl font-bold mb-6 flex items-center">
      <el-icon class="mr-2 text-yellow-500"><Star /></el-icon>
      我的任务大厅
    </div>

    <el-row :gutter="20">
      <el-col v-for="item in taskList" :key="item.taskId" :xs="24" :sm="12" :md="8" :lg="6" class="mb-4">
        <el-card :body-style="{ padding: '20px' }" class="task-card hover:shadow-lg transition-shadow">
          <div class="flex flex-col items-center text-center">
            <div class="text-5xl mb-4">{{ getTaskIcon(item.icon) }}</div>
            <div class="text-xl font-bold mb-2">{{ item.title }}</div>
            <div class="text-gray-500 text-sm mb-4 h-10 overflow-hidden">{{ item.description }}</div>
            
            <div class="flex items-center justify-between w-full mb-4">
              <span class="text-orange-500 font-bold">
                <el-icon><Coin /></el-icon> {{ item.rewardPoints }} 积分
              </span>
              <el-tag :type="getStatusType(item.status)">{{ getStatusLabel(item.status) }}</el-tag>
            </div>

            <div class="w-full">
              <el-button 
                v-if="item.status === '0'" 
                type="primary" 
                size="large" 
                class="w-full h-14 text-lg font-bold"
                round
                @click="handleStart(item)"
              >
                马上开始!
              </el-button>
              <el-button 
                v-else-if="item.status === '1'" 
                type="success" 
                size="large" 
                class="w-full h-14 text-lg font-bold"
                round
                disabled
              >
                已完成!
              </el-button>
            </div>
          </div>
        </el-card>
      </el-col>
    </el-row>

    <!-- 任务执行对话框 (能量球风格) -->
    <el-dialog v-model="executionOpen" title="专注执行中" width="400px" center :close-on-click-modal="false">
      <div class="flex flex-col items-center py-8">
        <div class="focus-orb animate-pulse bg-blue-400 rounded-full w-32 h-32 mb-6 flex items-center justify-center text-white text-4xl font-bold">
          {{ countdown }}
        </div>
        <div class="text-lg font-bold text-blue-600 mb-2">正在专注: {{ activeTask.title }}</div>
        <div class="text-gray-500 text-sm">硬件灯光已切换为专注模式</div>
      </div>
      <template #footer>
        <el-button type="success" size="large" round class="w-full h-14" @click="handleFinish">我做完了!</el-button>
      </template>
    </el-dialog>
  </div>
</template>

<script setup name="ChildTask" lang="ts">
import { listMyTask, startTask, finishTask } from "@/api/child/task";

const { proxy } = getCurrentInstance() as ComponentInternalInstance;

const taskList = ref<any[]>([]);
const loading = ref(true);
const executionOpen = ref(false);
const activeTask = ref<any>({});
const countdown = ref(30);
let timer: any = null;

function getList() {
  loading.value = true;
  listMyTask({}).then((response: any) => {
    // 假设后端返回的数据在 rows 中，如果不是请根据实际 API 调整
    taskList.value = response.rows || response.data || [];
    loading.value = false;
  });
}

function handleStart(item: any) {
  activeTask.value = item;
  startTask(item.taskId).then(() => {
    executionOpen.value = true;
    startCountdown();
    proxy?.$modal.msgSuccess("加油! 硬件终端已开启专注模式");
  });
}

function startCountdown() {
  countdown.value = 30;
  timer = setInterval(() => {
    if (countdown.value > 0) {
      countdown.value--;
    } else {
      clearInterval(timer);
    }
  }, 1000);
}

function handleFinish() {
  finishTask({ taskId: activeTask.value.taskId }).then(() => {
    clearInterval(timer);
    executionOpen.value = false;
    proxy?.$modal.msgSuccess("太棒了! 你获得积分奖励!");
    getList();
  });
}

function getTaskIcon(icon: string) {
  const icons: any = {
    'brush': '🪥',
    'book': '📚',
    'sport': '⚽',
    'default': '🌟'
  };
  return icons[icon] || icons['default'];
}

function getStatusType(status: string) {
  const types: any = { '0': 'primary', '1': 'success', '2': 'info' };
  return types[status] || 'info';
}

function getStatusLabel(status: string) {
  const labels: any = { '0': '待执行', '1': '已完成', '2': '已过期' };
  return labels[status] || '未知';
}

onMounted(() => {
  getList();
});

onUnmounted(() => {
  if (timer) clearInterval(timer);
});
</script>

<style scoped>
.task-card {
  border-radius: 20px;
  border: 2px solid #e5e7eb;
}
.focus-orb {
  box-shadow: 0 0 30px rgba(96, 165, 250, 0.6);
}
</style>

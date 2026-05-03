<template>
  <div class="p-2">
    <div class="bg-white p-4 rounded shadow">
      <h3>AI 调用日志</h3>
      <el-table :data="logList" v-loading="loading" style="width: 100%">
        <el-table-column label="日志ID" align="center" prop="id" />
        <el-table-column label="场景Key" align="center" prop="sceneKey" />
        <el-table-column label="模型" align="center" prop="modelName" />
        <el-table-column label="耗时(ms)" align="center" prop="costTime" />
        <el-table-column label="状态" align="center" prop="status">
           <template #default="scope">
              <el-tag :type="scope.row.status === '0' ? 'success' : 'danger'">
                {{ scope.row.status === '0' ? '正常' : '失败' }}
              </el-tag>
           </template>
        </el-table-column>
        <el-table-column label="创建时间" align="center" prop="createTime" width="180" />
      </el-table>
    </div>
  </div>
</template>

<script setup name="AiLog">
import { ref, onMounted } from 'vue';
import { listLog } from '@/api/ai/log';

const logList = ref([]);
const loading = ref(true);

const getList = async () => {
  loading.value = true;
  try {
    const res = await listLog();
    logList.value = res.rows || [];
  } finally {
    loading.value = false;
  }
};

onMounted(() => {
  getList();
});
</script>

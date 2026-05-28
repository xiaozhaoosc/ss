<template>
  <div class="app-container">
    <div class="bg-white p-4 rounded shadow">
      <h3 style="margin-bottom: 20px; font-weight: 600; color: #303133;">AI 调用日志</h3>
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

      <pagination
        v-show="total > 0"
        :total="total"
        v-model:page="queryParams.pageNum"
        v-model:limit="queryParams.pageSize"
        @pagination="getList"
      />
    </div>
  </div>
</template>

<script setup name="AiLog">
import { ref, reactive, toRefs, onMounted } from 'vue';
import { listLog } from '@/api/ai/log';

const logList = ref([]);
const loading = ref(true);
const total = ref(0);

const data = reactive({
  queryParams: {
    pageNum: 1,
    pageSize: 10
  }
});

const { queryParams } = toRefs(data);

const getList = async () => {
  loading.value = true;
  try {
    const res = await listLog(queryParams.value);
    logList.value = res.rows || [];
    total.value = res.total || 0;
  } catch (error) {
    console.error("加载AI日志失败", error);
  } finally {
    loading.value = false;
  }
};

onMounted(() => {
  getList();
});
</script>

<style scoped>
.app-container {
  padding: 20px;
}
.bg-white {
  background-color: #ffffff;
}
.p-4 {
  padding: 1.5rem;
}
.rounded {
  border-radius: 8px;
}
.shadow {
  box-shadow: 0 2px 12px 0 rgba(0, 0, 0, 0.05);
}
</style>

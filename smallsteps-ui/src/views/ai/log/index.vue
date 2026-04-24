<template>
  <div class="app-container">
    <el-form :model="queryParams" ref="queryRef" :inline="true" v-show="showSearch">
      <el-form-item label="任务名称" prop="taskName">
        <el-input v-model="queryParams.taskName" placeholder="关联任务名称" clearable @keyup.enter="handleQuery" />
      </el-form-item>
      <el-form-item label="功能类型" prop="funcType">
        <el-select v-model="queryParams.funcType" placeholder="全部" clearable style="width: 140px">
          <el-option label="任务拆解" value="taskBreakdown" />
          <el-option label="情绪分析" value="emotionAnalysis" />
          <el-option label="奖励推荐" value="rewardSuggest" />
        </el-select>
      </el-form-item>
      <el-form-item label="状态" prop="status">
        <el-select v-model="queryParams.status" placeholder="全部" clearable style="width: 120px">
          <el-option label="成功" value="success" />
          <el-option label="失败" value="fail" />
        </el-select>
      </el-form-item>
      <el-form-item>
        <el-button type="primary" icon="Search" @click="handleQuery">搜索</el-button>
        <el-button icon="Refresh" @click="resetQuery">重置</el-button>
      </el-form-item>
    </el-form>

    <el-row :gutter="10" class="mb8">
      <right-toolbar v-model:showSearch="showSearch" @queryTable="getList" />
    </el-row>

    <el-table v-loading="loading" :data="logList">
      <el-table-column label="时间" align="center" prop="createTime" width="180">
        <template #default="scope">
          <span>{{ parseTime(scope.row.createTime) }}</span>
        </template>
      </el-table-column>
      <el-table-column label="功能" align="center" prop="funcType" width="120">
        <template #default="scope">
          <el-tag type="primary">{{ getFuncLabel(scope.row.funcType) }}</el-tag>
        </template>
      </el-table-column>
      <el-table-column label="模型" align="center" prop="modelName" width="150" />
      <el-table-column label="提示词摘要" align="center" prop="promptSummary" :show-overflow-tooltip="true" />
      <el-table-column label="耗时(ms)" align="center" prop="costMs" width="100" />
      <el-table-column label="Token用量" align="center" prop="tokenUsed" width="100" />
      <el-table-column label="状态" align="center" prop="status" width="90">
        <template #default="scope">
          <el-tag :type="scope.row.status === 'success' ? 'success' : 'danger'">
            {{ scope.row.status === 'success' ? '成功' : '失败' }}
          </el-tag>
        </template>
      </el-table-column>
      <el-table-column label="错误信息" align="center" prop="errorMsg" :show-overflow-tooltip="true" width="200" />
    </el-table>

    <pagination v-show="total > 0" :total="total" v-model:page="queryParams.pageNum" v-model:limit="queryParams.pageSize" @pagination="getList" />
  </div>
</template>

<script setup name="AiLog">
const { proxy } = getCurrentInstance();
const logList = ref([]);
const loading = ref(false);
const showSearch = ref(true);
const total = ref(0);

const FUNC_MAP = {
  taskBreakdown: '任务拆解',
  emotionAnalysis: '情绪分析',
  rewardSuggest: '奖励推荐',
};

const data = reactive({
  queryParams: { pageNum: 1, pageSize: 10, taskName: undefined, funcType: undefined, status: undefined }
});
const { queryParams } = toRefs(data);

function getFuncLabel(type) { return FUNC_MAP[type] ?? type; }
function getList() {
  loading.value = true;
  // TODO: 接入后端 AI 日志接口
  loading.value = false;
}
function handleQuery() { queryParams.value.pageNum = 1; getList(); }
function resetQuery() { proxy.resetForm('queryRef'); handleQuery(); }

getList();
</script>

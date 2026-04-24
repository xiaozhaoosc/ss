<template>
  <div class="app-container">
    <!-- 搜索区 -->
    <el-form :model="queryParams" ref="queryRef" :inline="true" v-show="showSearch">
      <el-form-item label="儿童姓名" prop="childName">
        <el-input v-model="queryParams.childName" placeholder="请输入儿童姓名" clearable @keyup.enter="handleQuery" />
      </el-form-item>
      <el-form-item label="情绪类型" prop="moodType">
        <el-select v-model="queryParams.moodType" placeholder="全部" clearable style="width: 140px">
          <el-option label="😊 开心" value="happy" />
          <el-option label="😢 难过" value="sad" />
          <el-option label="😤 生气" value="angry" />
          <el-option label="😰 焦虑" value="anxious" />
          <el-option label="😌 平静" value="calm" />
        </el-select>
      </el-form-item>
      <el-form-item label="记录日期" prop="dateRange">
        <el-date-picker
          v-model="queryParams.dateRange"
          type="daterange"
          range-separator="至"
          start-placeholder="开始日期"
          end-placeholder="结束日期"
          value-format="YYYY-MM-DD"
        />
      </el-form-item>
      <el-form-item>
        <el-button type="primary" icon="Search" @click="handleQuery">搜索</el-button>
        <el-button icon="Refresh" @click="resetQuery">重置</el-button>
      </el-form-item>
    </el-form>

    <el-row :gutter="10" class="mb8">
      <right-toolbar v-model:showSearch="showSearch" @queryTable="getList" />
    </el-row>

    <el-table v-loading="loading" :data="emotionList">
      <el-table-column label="儿童姓名" align="center" prop="childName" />
      <el-table-column label="情绪" align="center" prop="moodType" width="100">
        <template #default="scope">
          <el-tag :type="getMoodTagType(scope.row.moodType)">{{ getMoodLabel(scope.row.moodType) }}</el-tag>
        </template>
      </el-table-column>
      <el-table-column label="情绪强度" align="center" prop="moodValue" width="120">
        <template #default="scope">
          <el-rate :model-value="scope.row.moodValue / 2" disabled show-score />
        </template>
      </el-table-column>
      <el-table-column label="AI分析摘要" align="center" prop="aiSummary" :show-overflow-tooltip="true" />
      <el-table-column label="记录时间" align="center" prop="createTime" width="180">
        <template #default="scope">
          <span>{{ parseTime(scope.row.createTime) }}</span>
        </template>
      </el-table-column>
    </el-table>

    <pagination
      v-show="total > 0"
      :total="total"
      v-model:page="queryParams.pageNum"
      v-model:limit="queryParams.pageSize"
      @pagination="getList"
    />
  </div>
</template>

<script setup name="SmallstepsEmotion">
const { proxy } = getCurrentInstance();

const emotionList = ref([]);
const loading = ref(false);
const showSearch = ref(true);
const total = ref(0);

const data = reactive({
  queryParams: {
    pageNum: 1,
    pageSize: 10,
    childName: undefined,
    moodType: undefined,
    dateRange: undefined,
  }
});
const { queryParams } = toRefs(data);

const MOOD_MAP = {
  happy:   { label: '😊 开心', type: 'success' },
  sad:     { label: '😢 难过', type: 'info' },
  angry:   { label: '😤 生气', type: 'danger' },
  anxious: { label: '😰 焦虑', type: 'warning' },
  calm:    { label: '😌 平静', type: '' },
};

function getMoodLabel(type) { return MOOD_MAP[type]?.label ?? type; }
function getMoodTagType(type) { return MOOD_MAP[type]?.type ?? ''; }

function getList() {
  loading.value = true;
  // TODO: 接入后端 listEmotion 接口
  // listEmotion(queryParams.value).then(res => { emotionList.value = res.rows; total.value = res.total; });
  loading.value = false;
}

function handleQuery() { queryParams.value.pageNum = 1; getList(); }
function resetQuery() { proxy.resetForm('queryRef'); handleQuery(); }

getList();
</script>

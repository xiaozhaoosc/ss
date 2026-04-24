<template>
  <div class="app-container">
    <el-form :model="queryParams" ref="queryRef" :inline="true" v-show="showSearch">
      <el-form-item label="儿童姓名" prop="childName">
        <el-input v-model="queryParams.childName" placeholder="请输入儿童姓名" clearable @keyup.enter="handleQuery" />
      </el-form-item>
      <el-form-item label="状态" prop="status">
        <el-select v-model="queryParams.status" placeholder="全部" clearable style="width: 120px">
          <el-option label="进行中" value="0" />
          <el-option label="已达成" value="1" />
          <el-option label="已过期" value="2" />
        </el-select>
      </el-form-item>
      <el-form-item>
        <el-button type="primary" icon="Search" @click="handleQuery">搜索</el-button>
        <el-button icon="Refresh" @click="resetQuery">重置</el-button>
      </el-form-item>
    </el-form>

    <el-row :gutter="10" class="mb8">
      <el-col :span="1.5">
        <el-button type="primary" plain icon="Plus" @click="handleAdd">新增契约</el-button>
      </el-col>
      <right-toolbar v-model:showSearch="showSearch" @queryTable="getList" />
    </el-row>

    <el-table v-loading="loading" :data="contractList">
      <el-table-column label="契约标题" align="center" prop="title" :show-overflow-tooltip="true" />
      <el-table-column label="儿童" align="center" prop="childName" width="120" />
      <el-table-column label="目标承诺" align="center" prop="content" :show-overflow-tooltip="true" />
      <el-table-column label="奖励" align="center" prop="reward" width="150" />
      <el-table-column label="截止日期" align="center" prop="deadline" width="120" />
      <el-table-column label="状态" align="center" prop="status" width="100">
        <template #default="scope">
          <el-tag :type="getStatusType(scope.row.status)">{{ getStatusLabel(scope.row.status) }}</el-tag>
        </template>
      </el-table-column>
      <el-table-column label="操作" align="center" width="150">
        <template #default="scope">
          <el-button link type="primary" icon="Edit" @click="handleUpdate(scope.row)">修改</el-button>
          <el-button link type="danger" icon="Delete" @click="handleDelete(scope.row)">删除</el-button>
        </template>
      </el-table-column>
    </el-table>

    <pagination v-show="total > 0" :total="total" v-model:page="queryParams.pageNum" v-model:limit="queryParams.pageSize" @pagination="getList" />
  </div>
</template>

<script setup name="SmallstepsContract">
const { proxy } = getCurrentInstance();
const contractList = ref([]);
const loading = ref(false);
const showSearch = ref(true);
const total = ref(0);

const data = reactive({
  queryParams: { pageNum: 1, pageSize: 10, childName: undefined, status: undefined }
});
const { queryParams } = toRefs(data);

function getStatusType(s) { return s === '1' ? 'success' : s === '2' ? 'info' : 'primary'; }
function getStatusLabel(s) { return s === '1' ? '已达成' : s === '2' ? '已过期' : '进行中'; }
function getList() { loading.value = true; /* TODO: listContract */ loading.value = false; }
function handleQuery() { queryParams.value.pageNum = 1; getList(); }
function resetQuery() { proxy.resetForm('queryRef'); handleQuery(); }
function handleAdd() { proxy.$modal.msgWarning('亲子契约功能即将上线'); }
function handleUpdate(row) { proxy.$modal.msgWarning('亲子契约功能即将上线'); }
function handleDelete(row) { proxy.$modal.msgWarning('亲子契约功能即将上线'); }

getList();
</script>

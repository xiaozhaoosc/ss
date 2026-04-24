<template>
  <div class="app-container">
    <el-form :model="queryParams" ref="queryRef" :inline="true" v-show="showSearch">
      <el-form-item label="设备编号" prop="deviceSn">
        <el-input v-model="queryParams.deviceSn" placeholder="请输入设备SN" clearable @keyup.enter="handleQuery" />
      </el-form-item>
      <el-form-item label="绑定状态" prop="bindStatus">
        <el-select v-model="queryParams.bindStatus" placeholder="全部" clearable style="width: 120px">
          <el-option label="已绑定" value="1" />
          <el-option label="未绑定" value="0" />
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

    <el-table v-loading="loading" :data="deviceList">
      <el-table-column label="设备SN" align="center" prop="deviceSn" />
      <el-table-column label="设备型号" align="center" prop="model" />
      <el-table-column label="固件版本" align="center" prop="firmwareVersion" />
      <el-table-column label="绑定儿童" align="center" prop="childName" />
      <el-table-column label="最后上线" align="center" prop="lastOnlineTime" width="180">
        <template #default="scope">
          <span>{{ parseTime(scope.row.lastOnlineTime) }}</span>
        </template>
      </el-table-column>
      <el-table-column label="状态" align="center" prop="bindStatus" width="100">
        <template #default="scope">
          <el-tag :type="scope.row.bindStatus === '1' ? 'success' : 'info'">
            {{ scope.row.bindStatus === '1' ? '已绑定' : '未绑定' }}
          </el-tag>
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

<script setup name="SmallstepsDevice">
const { proxy } = getCurrentInstance();
const deviceList = ref([]);
const loading = ref(false);
const showSearch = ref(true);
const total = ref(0);

const data = reactive({
  queryParams: { pageNum: 1, pageSize: 10, deviceSn: undefined, bindStatus: undefined }
});
const { queryParams } = toRefs(data);

function getList() {
  loading.value = true;
  // TODO: 接入后端 listDevice 接口
  loading.value = false;
}
function handleQuery() { queryParams.value.pageNum = 1; getList(); }
function resetQuery() { proxy.resetForm('queryRef'); handleQuery(); }

getList();
</script>

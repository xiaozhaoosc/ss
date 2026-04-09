<template>
  <div class="app-container">
    <el-form :model="queryParams" ref="queryForm" size="small" :inline="true" v-show="showSearch" label-width="68px">
      <el-form-item label="奖励名称" prop="rewardName">
        <el-input
          v-model="queryParams.rewardName"
          placeholder="请输入奖励名称"
          clearable
          style="width: 200px"
        />
      </el-form-item>
      <el-form-item label="状态" prop="status">
        <el-select
          v-model="queryParams.status"
          placeholder="请选择状态"
          clearable
          style="width: 200px"
        >
          <el-option label="可兑换" value="1" />
          <el-option label="已兑换" value="0" />
        </el-select>
      </el-form-item>
      <el-form-item>
        <el-button type="primary" icon="el-icon-search" size="mini" @click="handleQuery">搜索</el-button>
        <el-button icon="el-icon-refresh" size="mini" @click="resetQuery">重置</el-button>
      </el-form-item>
    </el-form>

    <el-row :gutter="10" class="mb8">
      <el-col :span="1.5">
        <el-button
          type="primary"
          icon="el-icon-download"
          size="mini"
          @click="handleExport"
        >导出</el-button>
      </el-col>
    </el-row>

    <el-table v-loading="loading" :data="rewardList" @selection-change="handleSelectionChange">
      <el-table-column type="selection" width="55" align="center" />
      <el-table-column label="奖励ID" align="center" prop="rewardId" />
      <el-table-column label="奖励名称" align="center" prop="rewardName" />
      <el-table-column label="星星消耗" align="center" prop="starCost" />
      <el-table-column label="库存" align="center" prop="stock" />
      <el-table-column label="状态" align="center" prop="status">
        <template slot-scope="scope">
          <el-tag :type="scope.row.status === '1' ? 'success' : 'danger'">
            {{ scope.row.status === '1' ? '可兑换' : '已兑换' }}
          </el-tag>
        </template>
      </el-table-column>
      <el-table-column label="操作" align="center" class-name="small-padding fixed-width">
        <template slot-scope="scope">
          <el-button
            size="mini"
            type="text"
            icon="el-icon-sold-out"
            @click="handleExchange(scope.row)"
            v-if="scope.row.status === '1'"
          >兑换</el-button>
        </template>
      </el-table-column>
    </el-table>

    <el-pagination
      v-show="total > 0"
      :total="total"
      :page.sync="queryParams.pageNum"
      :limit.sync="queryParams.pageSize"
      @size-change="handleSizeChange"
      @current-change="handleCurrentChange"
    />
  </div>
</template>

<script lang="ts">
import { defineComponent, ref, reactive, computed, onMounted } from 'vue'
import { ElMessage, ElMessageBox } from 'element-plus'
import { listChildReward, exchangeReward } from '@/api/child/reward'

export default defineComponent({
  name: 'ChildReward',
  setup() {
    const { loading, rewardList, total, queryParams, showSearch, handleQuery, resetQuery, handleSizeChange, handleCurrentChange, handleSelectionChange, handleExport, handleExchange, getList } = useChildReward()

    onMounted(() => {
      getList()
    })

    return {
      loading,
      rewardList,
      total,
      queryParams,
      showSearch,
      handleQuery,
      resetQuery,
      handleSizeChange,
      handleCurrentChange,
      handleSelectionChange,
      handleExport,
      handleExchange
    }
  }
})

function useChildReward() {
  const loading = ref(false)
  const queryParams = reactive({
    pageNum: 1,
    pageSize: 10,
    rewardName: '',
    status: ''
  })
  const rewardList = ref<any[]>([])
  const total = ref(0)
  const showSearch = ref(true)

  // 查询列表
  const getList = () => {
    loading.value = true
    listChildReward(queryParams).then(response => {
      rewardList.value = response.rows
      total.value = response.total
      loading.value = false
    })
  }

  // 搜索按钮
  const handleQuery = () => {
    queryParams.pageNum = 1
    getList()
  }

  // 重置按钮
  const resetQuery = () => {
    queryParams.rewardName = ''
    queryParams.status = ''
    handleQuery()
  }

  // 分页
  const handleSizeChange = (size: number) => {
    queryParams.pageSize = size
    getList()
  }

  const handleCurrentChange = (current: number) => {
    queryParams.pageNum = current
    getList()
  }

  // 多选框选中数据
  const multipleSelection = ref<any[]>([])

  const handleSelectionChange = (val: any[]) => {
    multipleSelection.value = val
  }

  // 导出按钮操作
  const handleExport = () => {
    listChildReward(queryParams).then(response => {
      // 导出逻辑
      ElMessage.success('导出成功')
    })
  }

  // 兑换奖励
  const handleExchange = (row: any) => {
    ElMessageBox.confirm('确定要兑换该奖励吗？', '提示', {
      confirmButtonText: '确定',
      cancelButtonText: '取消',
      type: 'warning'
    }).then(() => {
      exchangeReward(row.rewardId).then(response => {
        if (response.code === 200) {
          getList()
          ElMessage.success('奖励兑换成功')
        }
      })
    })
  }

  return {
    loading,
    rewardList,
    total,
    queryParams,
    showSearch,
    handleQuery,
    resetQuery,
    handleSizeChange,
    handleCurrentChange,
    handleSelectionChange,
    handleExport,
    handleExchange,
    getList
  }
}
</script>

<style scoped>
.app-container {
  padding: 10px;
}

.mb8 {
  margin-bottom: 8px;
}

.fixed-width {
  width: 150px;
}
</style>
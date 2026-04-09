<template>
  <div class="app-container">
    <el-form :model="queryParams" ref="queryForm" size="small" :inline="true" v-show="showSearch" label-width="68px">
      <el-form-item label="任务名称" prop="taskName">
        <el-input
          v-model="queryParams.taskName"
          placeholder="请输入任务名称"
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
          <el-option label="待完成" value="0" />
          <el-option label="已完成" value="1" />
          <el-option label="已领取" value="2" />
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

    <el-table v-loading="loading" :data="taskList" @selection-change="handleSelectionChange">
      <el-table-column type="selection" width="55" align="center" />
      <el-table-column label="任务ID" align="center" prop="taskId" />
      <el-table-column label="任务名称" align="center" prop="taskName" />
      <el-table-column label="描述" align="center" prop="description" />
      <el-table-column label="难度" align="center" prop="difficulty" />
      <el-table-column label="星星奖励" align="center" prop="starReward" />
      <el-table-column label="状态" align="center" prop="status">
        <template slot-scope="scope">
          <el-tag :type="getStatusType(scope.row.status)">
            {{ getStatusText(scope.row.status) }}
          </el-tag>
        </template>
      </el-table-column>
      <el-table-column label="操作" align="center" class-name="small-padding fixed-width">
        <template slot-scope="scope">
          <el-button
            size="mini"
            type="text"
            icon="el-icon-check"
            @click="handleComplete(scope.row)"
            v-if="scope.row.status === '0'"
          >完成</el-button>
          <el-button
            size="mini"
            type="text"
            icon="el-icon-sold-out"
            @click="handleClaim(scope.row)"
            v-if="scope.row.status === '1'"
          >领取</el-button>
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
import { listChildTask, completeTask, claimTask } from '@/api/child/task'

export default defineComponent({
  name: 'ChildTask',
  setup() {
    const { loading, taskList, total, queryParams, showSearch, handleQuery, resetQuery, handleSizeChange, handleCurrentChange, handleSelectionChange, handleExport, handleComplete, handleClaim, getList, getStatusType, getStatusText } = useChildTask()

    onMounted(() => {
      getList()
    })

    return {
      loading,
      taskList,
      total,
      queryParams,
      showSearch,
      handleQuery,
      resetQuery,
      handleSizeChange,
      handleCurrentChange,
      handleSelectionChange,
      handleExport,
      handleComplete,
      handleClaim,
      getStatusType,
      getStatusText
    }
  }
})

function useChildTask() {
  const loading = ref(false)
  const queryParams = reactive({
    pageNum: 1,
    pageSize: 10,
    taskName: '',
    status: ''
  })
  const taskList = ref<any[]>([])
  const total = ref(0)
  const showSearch = ref(true)

  // 查询列表
  const getList = () => {
    loading.value = true
    listChildTask(queryParams).then(response => {
      taskList.value = response.rows
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
    queryParams.taskName = ''
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
    listChildTask(queryParams).then(response => {
      // 导出逻辑
      ElMessage.success('导出成功')
    })
  }

  // 完成任务
  const handleComplete = (row: any) => {
    ElMessageBox.confirm('确定要完成该任务吗？', '提示', {
      confirmButtonText: '确定',
      cancelButtonText: '取消',
      type: 'warning'
    }).then(() => {
      completeTask(row.taskId).then(response => {
        if (response.code === 200) {
          getList()
          ElMessage.success('任务完成成功')
        }
      })
    })
  }

  // 领取任务
  const handleClaim = (row: any) => {
    ElMessageBox.confirm('确定要领取该任务奖励吗？', '提示', {
      confirmButtonText: '确定',
      cancelButtonText: '取消',
      type: 'warning'
    }).then(() => {
      claimTask(row.taskId).then(response => {
        if (response.code === 200) {
          getList()
          ElMessage.success('奖励领取成功')
        }
      })
    })
  }

  // 获取状态类型
  const getStatusType = (status: string) => {
    switch (status) {
      case '0':
        return 'info'
      case '1':
        return 'success'
      case '2':
        return 'warning'
      default:
        return 'info'
    }
  }

  // 获取状态文本
  const getStatusText = (status: string) => {
    switch (status) {
      case '0':
        return '待完成'
      case '1':
        return '已完成'
      case '2':
        return '已领取'
      default:
        return '未知'
    }
  }

  return {
    loading,
    taskList,
    total,
    queryParams,
    showSearch,
    handleQuery,
    resetQuery,
    handleSizeChange,
    handleCurrentChange,
    handleSelectionChange,
    handleExport,
    handleComplete,
    handleClaim,
    getList,
    getStatusType,
    getStatusText
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
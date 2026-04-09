<template>
  <div class="app-container">
    <el-form :model="queryParams" ref="queryForm" size="small" :inline="true" v-show="showSearch" label-width="68px">
      <el-form-item label="情绪类型" prop="emotionType">
        <el-input
          v-model="queryParams.emotionType"
          placeholder="请输入情绪类型"
          clearable
          style="width: 200px"
        />
      </el-form-item>
      <el-form-item label="开始时间" prop="beginTime">
        <el-date-picker
          v-model="queryParams.beginTime"
          type="date"
          placeholder="选择开始时间"
          value-format="YYYY-MM-DD"
          style="width: 200px"
        />
      </el-form-item>
      <el-form-item label="结束时间" prop="endTime">
        <el-date-picker
          v-model="queryParams.endTime"
          type="date"
          placeholder="选择结束时间"
          value-format="YYYY-MM-DD"
          style="width: 200px"
        />
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
          icon="el-icon-plus"
          size="mini"
          @click="handleAdd"
        >记录情绪</el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button
          type="primary"
          icon="el-icon-download"
          size="mini"
          @click="handleExport"
        >导出</el-button>
      </el-col>
    </el-row>

    <el-table v-loading="loading" :data="emotionList" @selection-change="handleSelectionChange">
      <el-table-column type="selection" width="55" align="center" />
      <el-table-column label="情绪ID" align="center" prop="emotionId" />
      <el-table-column label="情绪类型" align="center" prop="emotionType" />
      <el-table-column label="情绪等级" align="center" prop="emotionLevel" />
      <el-table-column label="触发因素" align="center" prop="trigger" />
      <el-table-column label="记录时间" align="center" prop="createdAt" width="180" />
    </el-table>

    <el-pagination
      v-show="total > 0"
      :total="total"
      :page.sync="queryParams.pageNum"
      :limit.sync="queryParams.pageSize"
      @size-change="handleSizeChange"
      @current-change="handleCurrentChange"
    />

    <!-- 记录情绪对话框 -->
    <el-dialog :title="title" :visible.sync="open" width="500px" append-to-body>
      <el-form ref="form" :model="form" :rules="rules" label-width="80px">
        <el-form-item label="情绪类型" prop="emotionType">
          <el-input v-model="form.emotionType" placeholder="请输入情绪类型" />
        </el-form-item>
        <el-form-item label="情绪等级" prop="emotionLevel">
          <el-input v-model="form.emotionLevel" type="number" placeholder="请输入情绪等级" />
        </el-form-item>
        <el-form-item label="触发因素" prop="trigger">
          <el-input v-model="form.trigger" placeholder="请输入触发因素" />
        </el-form-item>
      </el-form>
      <div slot="footer" class="dialog-footer">
        <el-button type="primary" @click="submitForm">确定</el-button>
        <el-button @click="cancel">取消</el-button>
      </div>
    </el-dialog>
  </div>
</template>

<script lang="ts">
import { defineComponent, ref, reactive, computed, onMounted } from 'vue'
import { ElMessage } from 'element-plus'
import { listChildEmotion, recordEmotion } from '@/api/child/emotion'

export default defineComponent({
  name: 'ChildEmotion',
  setup() {
    const { loading, open, title, form, emotionList, total, queryParams, showSearch, rules, handleAdd, submitForm, cancel, handleQuery, resetQuery, handleSizeChange, handleCurrentChange, handleSelectionChange, handleExport, getList } = useChildEmotion()

    onMounted(() => {
      getList()
    })

    return {
      loading,
      open,
      title,
      form,
      emotionList,
      total,
      queryParams,
      showSearch,
      rules,
      handleAdd,
      submitForm,
      cancel,
      handleQuery,
      resetQuery,
      handleSizeChange,
      handleCurrentChange,
      handleSelectionChange,
      handleExport
    }
  }
})

function useChildEmotion() {
  const loading = ref(false)
  const open = ref(false)
  const title = ref('')
  const form = reactive({
    emotionType: '',
    emotionLevel: 0,
    trigger: ''
  })
  const queryParams = reactive({
    pageNum: 1,
    pageSize: 10,
    emotionType: '',
    beginTime: '',
    endTime: ''
  })
  const emotionList = ref<any[]>([])
  const total = ref(0)
  const showSearch = ref(true)

  const rules = reactive({
    emotionType: [{ required: true, message: '请输入情绪类型', trigger: 'blur' }],
    emotionLevel: [{ required: true, message: '请输入情绪等级', trigger: 'blur' }],
    trigger: [{ required: true, message: '请输入触发因素', trigger: 'blur' }]
  })

  // 查询列表
  const getList = () => {
    loading.value = true
    listChildEmotion(queryParams).then(response => {
      emotionList.value = response.rows
      total.value = response.total
      loading.value = false
    })
  }

  // 新增按钮操作
  const handleAdd = () => {
    resetForm()
    open.value = true
    title.value = '记录情绪'
  }

  // 提交按钮
  const submitForm = () => {
    const formEl = document.querySelector('.el-form') as any
    formEl.validate((valid: boolean) => {
      if (valid) {
        recordEmotion(form).then(response => {
          if (response.code === 200) {
            open.value = false
            getList()
            ElMessage.success('情绪记录成功')
          }
        })
      }
    })
  }

  // 取消按钮
  const cancel = () => {
    open.value = false
    resetForm()
  }

  // 重置表单
  const resetForm = () => {
    form.emotionType = ''
    form.emotionLevel = 0
    form.trigger = ''
  }

  // 搜索按钮
  const handleQuery = () => {
    queryParams.pageNum = 1
    getList()
  }

  // 重置按钮
  const resetQuery = () => {
    queryParams.emotionType = ''
    queryParams.beginTime = ''
    queryParams.endTime = ''
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
    listChildEmotion(queryParams).then(response => {
      // 导出逻辑
      ElMessage.success('导出成功')
    })
  }

  return {
    loading,
    open,
    title,
    form,
    emotionList,
    total,
    queryParams,
    showSearch,
    rules,
    handleAdd,
    submitForm,
    cancel,
    handleQuery,
    resetQuery,
    handleSizeChange,
    handleCurrentChange,
    handleSelectionChange,
    handleExport,
    getList,
    resetForm
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
<template>
  <div class="app-container">
    <el-form :model="queryParams" ref="queryForm" size="small" :inline="true" v-show="showSearch" label-width="68px">
      <el-form-item label="儿童ID" prop="childId">
        <el-input
          v-model="queryParams.childId"
          placeholder="请输入儿童ID"
          clearable
          style="width: 200px"
        />
      </el-form-item>
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
          v-hasPermi="['smallsteps:emotion:add']"
        >新增</el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button
          type="success"
          icon="el-icon-download"
          size="mini"
          @click="handleExport"
          v-hasPermi="['smallsteps:emotion:export']"
        >导出</el-button>
      </el-col>
    </el-row>

    <el-table v-loading="loading" :data="emotionList" @selection-change="handleSelectionChange">
      <el-table-column type="selection" width="55" align="center" />
      <el-table-column label="情绪ID" align="center" prop="emotionId" />
      <el-table-column label="儿童ID" align="center" prop="childId" />
      <el-table-column label="情绪类型" align="center" prop="emotionType" />
      <el-table-column label="情绪等级" align="center" prop="emotionLevel" />
      <el-table-column label="触发因素" align="center" prop="trigger" />
      <el-table-column label="创建时间" align="center" prop="createdAt" width="180" />
      <el-table-column label="操作" align="center" class-name="small-padding fixed-width">
        <template slot-scope="scope">
          <el-button
            size="mini"
            type="text"
            icon="el-icon-edit"
            @click="handleUpdate(scope.row)"
            v-hasPermi="['smallsteps:emotion:edit']"
          >修改</el-button>
          <el-button
            size="mini"
            type="text"
            icon="el-icon-delete"
            @click="handleDelete(scope.row)"
            v-hasPermi="['smallsteps:emotion:remove']"
          >删除</el-button>
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

    <!-- 添加或修改情绪记录对话框 -->
    <el-dialog :title="title" :visible.sync="open" width="500px" append-to-body>
      <el-form ref="form" :model="form" :rules="rules" label-width="80px">
        <el-form-item label="儿童ID" prop="childId">
          <el-input v-model="form.childId" placeholder="请输入儿童ID" />
        </el-form-item>
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
import { listEmotion, getEmotion, addEmotion, updateEmotion, delEmotion, exportEmotion } from '@/api/smallsteps/emotion'
import { Emotion } from '@/api/smallsteps/types'

export default defineComponent({
  name: 'Emotion',
  setup() {
    const { loading, dialogVisible, form, open, title, queryParams, pagination, resetForm, handleAdd, handleUpdate, handleDelete, handleSubmit, submitForm, cancel, handleQuery, resetQuery, handleSizeChange, handleCurrentChange, handleSelectionChange, handleExport, getList } = useEmotion()

    onMounted(() => {
      getList()
    })

    return {
      loading,
      dialogVisible,
      form,
      open,
      title,
      queryParams,
      pagination,
      resetForm,
      handleAdd,
      handleUpdate,
      handleDelete,
      handleSubmit,
      submitForm,
      cancel,
      handleQuery,
      resetQuery,
      handleSizeChange,
      handleCurrentChange,
      handleSelectionChange,
      handleExport,
      getList
    }
  }
})

function useEmotion() {
  const loading = ref(false)
  const open = ref(false)
  const title = ref('')
  const single = ref(true)
  const multiple = ref(false)
  const form = reactive<Emotion>({
    emotionId: 0,
    childId: 0,
    emotionType: '',
    emotionLevel: 0,
    trigger: '',
    createdAt: ''
  })
  const queryParams = reactive({
    pageNum: 1,
    pageSize: 10,
    childId: '',
    emotionType: '',
    beginTime: '',
    endTime: ''
  })
  const emotionList = ref<any[]>([])
  const total = ref(0)
  const userOptions = ref<any[]>([])
  const roles = ref<any[]>([])
  const deptOptions = ref<any[]>([])
  const dialogVisible = ref(false)
  const pagination = reactive({
    currentPage: 1,
    pageSize: 10,
    total: 0
  })
  const showSearch = ref(true)

  const rules = reactive({
    childId: [{ required: true, message: '请输入儿童ID', trigger: 'blur' }],
    emotionType: [{ required: true, message: '请输入情绪类型', trigger: 'blur' }],
    emotionLevel: [{ required: true, message: '请输入情绪等级', trigger: 'blur' }]
  })

  // 查询列表
  const getList = () => {
    loading.value = true
    listEmotion(queryParams).then(response => {
      emotionList.value = response.rows
      total.value = response.total
      loading.value = false
    })
  }

  // 新增按钮操作
  const handleAdd = () => {
    resetForm()
    open.value = true
    title.value = '新增情绪记录'
  }

  // 修改按钮操作
  const handleUpdate = (row: any) => {
    resetForm()
    getEmotion(row.emotionId).then(response => {
      form.emotionId = response.emotionId
      form.childId = response.childId
      form.emotionType = response.emotionType
      form.emotionLevel = response.emotionLevel
      form.trigger = response.trigger
      open.value = true
      title.value = '修改情绪记录'
    })
  }

  // 提交按钮
  const submitForm = () => {
    const formEl = document.querySelector('.el-form') as any
    formEl.validate((valid: boolean) => {
      if (valid) {
        if (form.emotionId !== undefined && form.emotionId !== null && form.emotionId !== 0) {
          updateEmotion(form).then(response => {
            if (response.code === 200) {
              open.value = false
              getList()
              ElMessage.success('修改成功')
            }
          })
        } else {
          addEmotion(form).then(response => {
            if (response.code === 200) {
              open.value = false
              getList()
              ElMessage.success('新增成功')
            }
          })
        }
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
    form.emotionId = 0
    form.childId = 0
    form.emotionType = ''
    form.emotionLevel = 0
    form.trigger = ''
    form.createdAt = ''
  }

  // 搜索按钮
  const handleQuery = () => {
    queryParams.pageNum = 1
    getList()
  }

  // 重置按钮
  const resetQuery = () => {
    queryParams.childId = ''
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

  // 删除按钮操作
  const handleDelete = (row: any) => {
    ElMessageBox.confirm('确定要删除该情绪记录吗？', '提示', {
      confirmButtonText: '确定',
      cancelButtonText: '取消',
      type: 'warning'
    }).then(() => {
      delEmotion(row.emotionId).then(response => {
        if (response.code === 200) {
          getList()
          ElMessage.success('删除成功')
        }
      })
    })
  }

  // 导出按钮操作
  const handleExport = () => {
    exportEmotion(queryParams).then(response => {
      const blob = new Blob([response.data], { type: 'application/vnd.ms-excel' })
      const url = URL.createObjectURL(blob)
      const link = document.createElement('a')
      link.href = url
      link.setAttribute('download', '情绪记录.xlsx')
      document.body.appendChild(link)
      link.click()
    })
  }

  // 提交按钮
  const handleSubmit = () => {
    submitForm()
  }

  return {
    loading,
    dialogVisible,
    form,
    open,
    title,
    queryParams,
    emotionList,
    total,
    userOptions,
    roles,
    deptOptions,
    pagination,
    showSearch,
    rules,
    multipleSelection,
    getList,
    handleAdd,
    handleUpdate,
    handleDelete,
    handleSubmit,
    submitForm,
    cancel,
    handleQuery,
    resetQuery,
    handleSizeChange,
    handleCurrentChange,
    handleSelectionChange,
    handleExport,
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
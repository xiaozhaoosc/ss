<template>
  <div class="app-container">
    <el-form :model="queryParams" ref="queryForm" size="small" :inline="true" v-show="showSearch" label-width="68px">
      <el-form-item label="标题" prop="title">
        <el-input
          v-model="queryParams.title"
          placeholder="请输入标题"
          clearable
          style="width: 200px"
        />
      </el-form-item>
      <el-form-item label="分类" prop="category">
        <el-input
          v-model="queryParams.category"
          placeholder="请输入分类"
          clearable
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
          v-hasPermi="['smallsteps:knowledge:add']"
        >新增</el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button
          type="success"
          icon="el-icon-download"
          size="mini"
          @click="handleExport"
          v-hasPermi="['smallsteps:knowledge:export']"
        >导出</el-button>
      </el-col>
    </el-row>

    <el-table v-loading="loading" :data="knowledgeList" @selection-change="handleSelectionChange">
      <el-table-column type="selection" width="55" align="center" />
      <el-table-column label="知识库ID" align="center" prop="knowledgeId" />
      <el-table-column label="标题" align="center" prop="title" />
      <el-table-column label="分类" align="center" prop="category" />
      <el-table-column label="创建时间" align="center" prop="createdAt" width="180" />
      <el-table-column label="操作" align="center" class-name="small-padding fixed-width">
        <template slot-scope="scope">
          <el-button
            size="mini"
            type="text"
            icon="el-icon-edit"
            @click="handleUpdate(scope.row)"
            v-hasPermi="['smallsteps:knowledge:edit']"
          >修改</el-button>
          <el-button
            size="mini"
            type="text"
            icon="el-icon-delete"
            @click="handleDelete(scope.row)"
            v-hasPermi="['smallsteps:knowledge:remove']"
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

    <!-- 添加或修改知识库对话框 -->
    <el-dialog :title="title" :visible.sync="open" width="600px" append-to-body>
      <el-form ref="form" :model="form" :rules="rules" label-width="80px">
        <el-form-item label="标题" prop="title">
          <el-input v-model="form.title" placeholder="请输入标题" />
        </el-form-item>
        <el-form-item label="分类" prop="category">
          <el-input v-model="form.category" placeholder="请输入分类" />
        </el-form-item>
        <el-form-item label="内容" prop="content">
          <el-input v-model="form.content" type="textarea" placeholder="请输入内容" :rows="5" />
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
import { listKnowledge, getKnowledge, addKnowledge, updateKnowledge, delKnowledge, exportKnowledge } from '@/api/smallsteps/knowledge'
import { Knowledge } from '@/api/smallsteps/types'

export default defineComponent({
  name: 'Knowledge',
  setup() {
    const { loading, dialogVisible, form, open, title, queryParams, pagination, resetForm, handleAdd, handleUpdate, handleDelete, handleSubmit, submitForm, cancel, handleQuery, resetQuery, handleSizeChange, handleCurrentChange, handleSelectionChange, handleExport, getList } = useKnowledge()

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

function useKnowledge() {
  const loading = ref(false)
  const open = ref(false)
  const title = ref('')
  const single = ref(true)
  const multiple = ref(false)
  const form = reactive<Knowledge>({
    knowledgeId: 0,
    title: '',
    content: '',
    category: '',
    createdAt: '',
    updatedAt: ''
  })
  const queryParams = reactive({
    pageNum: 1,
    pageSize: 10,
    title: '',
    category: ''
  })
  const knowledgeList = ref<any[]>([])
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
    title: [{ required: true, message: '请输入标题', trigger: 'blur' }],
    content: [{ required: true, message: '请输入内容', trigger: 'blur' }],
    category: [{ required: true, message: '请输入分类', trigger: 'blur' }]
  })

  // 查询列表
  const getList = () => {
    loading.value = true
    listKnowledge(queryParams).then(response => {
      knowledgeList.value = response.rows
      total.value = response.total
      loading.value = false
    })
  }

  // 新增按钮操作
  const handleAdd = () => {
    resetForm()
    open.value = true
    title.value = '新增知识库'
  }

  // 修改按钮操作
  const handleUpdate = (row: any) => {
    resetForm()
    getKnowledge(row.knowledgeId).then(response => {
      form.knowledgeId = response.knowledgeId
      form.title = response.title
      form.content = response.content
      form.category = response.category
      open.value = true
      title.value = '修改知识库'
    })
  }

  // 提交按钮
  const submitForm = () => {
    const formEl = document.querySelector('.el-form') as any
    formEl.validate((valid: boolean) => {
      if (valid) {
        if (form.knowledgeId !== undefined && form.knowledgeId !== null && form.knowledgeId !== 0) {
          updateKnowledge(form).then(response => {
            if (response.code === 200) {
              open.value = false
              getList()
              ElMessage.success('修改成功')
            }
          })
        } else {
          addKnowledge(form).then(response => {
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
    form.knowledgeId = 0
    form.title = ''
    form.content = ''
    form.category = ''
    form.createdAt = ''
    form.updatedAt = ''
  }

  // 搜索按钮
  const handleQuery = () => {
    queryParams.pageNum = 1
    getList()
  }

  // 重置按钮
  const resetQuery = () => {
    queryParams.title = ''
    queryParams.category = ''
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
    ElMessageBox.confirm('确定要删除该知识库吗？', '提示', {
      confirmButtonText: '确定',
      cancelButtonText: '取消',
      type: 'warning'
    }).then(() => {
      delKnowledge(row.knowledgeId).then(response => {
        if (response.code === 200) {
          getList()
          ElMessage.success('删除成功')
        }
      })
    })
  }

  // 导出按钮操作
  const handleExport = () => {
    exportKnowledge(queryParams).then(response => {
      const blob = new Blob([response.data], { type: 'application/vnd.ms-excel' })
      const url = URL.createObjectURL(blob)
      const link = document.createElement('a')
      link.href = url
      link.setAttribute('download', '知识库.xlsx')
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
    knowledgeList,
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
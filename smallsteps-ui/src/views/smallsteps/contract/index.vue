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
      <el-form-item label="家长ID" prop="parentId">
        <el-input
          v-model="queryParams.parentId"
          placeholder="请输入家长ID"
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
          <el-option label="生效" value="1" />
          <el-option label="失效" value="0" />
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
          icon="el-icon-plus"
          size="mini"
          @click="handleAdd"
          v-hasPermi="['smallsteps:contract:add']"
        >新增</el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button
          type="success"
          icon="el-icon-download"
          size="mini"
          @click="handleExport"
          v-hasPermi="['smallsteps:contract:export']"
        >导出</el-button>
      </el-col>
    </el-row>

    <el-table v-loading="loading" :data="contractList" @selection-change="handleSelectionChange">
      <el-table-column type="selection" width="55" align="center" />
      <el-table-column label="契约ID" align="center" prop="contractId" />
      <el-table-column label="儿童ID" align="center" prop="childId" />
      <el-table-column label="家长ID" align="center" prop="parentId" />
      <el-table-column label="状态" align="center" prop="status">
        <template slot-scope="scope">
          <el-tag :type="scope.row.status === '1' ? 'success' : 'danger'">
            {{ scope.row.status === '1' ? '生效' : '失效' }}
          </el-tag>
        </template>
      </el-table-column>
      <el-table-column label="创建时间" align="center" prop="createdAt" width="180" />
      <el-table-column label="操作" align="center" class-name="small-padding fixed-width">
        <template slot-scope="scope">
          <el-button
            size="mini"
            type="text"
            icon="el-icon-edit"
            @click="handleUpdate(scope.row)"
            v-hasPermi="['smallsteps:contract:edit']"
          >修改</el-button>
          <el-button
            size="mini"
            type="text"
            icon="el-icon-delete"
            @click="handleDelete(scope.row)"
            v-hasPermi="['smallsteps:contract:remove']"
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

    <!-- 添加或修改亲子契约对话框 -->
    <el-dialog :title="title" :visible.sync="open" width="600px" append-to-body>
      <el-form ref="form" :model="form" :rules="rules" label-width="80px">
        <el-form-item label="儿童ID" prop="childId">
          <el-input v-model="form.childId" placeholder="请输入儿童ID" />
        </el-form-item>
        <el-form-item label="家长ID" prop="parentId">
          <el-input v-model="form.parentId" placeholder="请输入家长ID" />
        </el-form-item>
        <el-form-item label="契约内容" prop="content">
          <el-input v-model="form.content" type="textarea" placeholder="请输入契约内容" :rows="5" />
        </el-form-item>
        <el-form-item label="状态" prop="status">
          <el-select v-model="form.status" placeholder="请选择状态">
            <el-option label="生效" value="1" />
            <el-option label="失效" value="0" />
          </el-select>
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
import { listContract, getContract, addContract, updateContract, delContract, exportContract } from '@/api/smallsteps/contract'
import { Contract } from '@/api/smallsteps/types'

export default defineComponent({
  name: 'Contract',
  setup() {
    const { loading, dialogVisible, form, open, title, queryParams, pagination, resetForm, handleAdd, handleUpdate, handleDelete, handleSubmit, submitForm, cancel, handleQuery, resetQuery, handleSizeChange, handleCurrentChange, handleSelectionChange, handleExport, getList } = useContract()

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

function useContract() {
  const loading = ref(false)
  const open = ref(false)
  const title = ref('')
  const single = ref(true)
  const multiple = ref(false)
  const form = reactive<Contract>({
    contractId: 0,
    childId: 0,
    parentId: 0,
    content: '',
    status: '1',
    createdAt: '',
    updatedAt: ''
  })
  const queryParams = reactive({
    pageNum: 1,
    pageSize: 10,
    childId: '',
    parentId: '',
    status: ''
  })
  const contractList = ref<any[]>([])
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
    parentId: [{ required: true, message: '请输入家长ID', trigger: 'blur' }],
    content: [{ required: true, message: '请输入契约内容', trigger: 'blur' }],
    status: [{ required: true, message: '请选择状态', trigger: 'blur' }]
  })

  // 查询列表
  const getList = () => {
    loading.value = true
    listContract(queryParams).then(response => {
      contractList.value = response.rows
      total.value = response.total
      loading.value = false
    })
  }

  // 新增按钮操作
  const handleAdd = () => {
    resetForm()
    open.value = true
    title.value = '新增亲子契约'
  }

  // 修改按钮操作
  const handleUpdate = (row: any) => {
    resetForm()
    getContract(row.contractId).then(response => {
      form.contractId = response.contractId
      form.childId = response.childId
      form.parentId = response.parentId
      form.content = response.content
      form.status = response.status
      open.value = true
      title.value = '修改亲子契约'
    })
  }

  // 提交按钮
  const submitForm = () => {
    const formEl = document.querySelector('.el-form') as any
    formEl.validate((valid: boolean) => {
      if (valid) {
        if (form.contractId !== undefined && form.contractId !== null && form.contractId !== 0) {
          updateContract(form).then(response => {
            if (response.code === 200) {
              open.value = false
              getList()
              ElMessage.success('修改成功')
            }
          })
        } else {
          addContract(form).then(response => {
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
    form.contractId = 0
    form.childId = 0
    form.parentId = 0
    form.content = ''
    form.status = '1'
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
    queryParams.childId = ''
    queryParams.parentId = ''
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

  // 删除按钮操作
  const handleDelete = (row: any) => {
    ElMessageBox.confirm('确定要删除该亲子契约吗？', '提示', {
      confirmButtonText: '确定',
      cancelButtonText: '取消',
      type: 'warning'
    }).then(() => {
      delContract(row.contractId).then(response => {
        if (response.code === 200) {
          getList()
          ElMessage.success('删除成功')
        }
      })
    })
  }

  // 导出按钮操作
  const handleExport = () => {
    exportContract(queryParams).then(response => {
      const blob = new Blob([response.data], { type: 'application/vnd.ms-excel' })
      const url = URL.createObjectURL(blob)
      const link = document.createElement('a')
      link.href = url
      link.setAttribute('download', '亲子契约.xlsx')
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
    contractList,
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
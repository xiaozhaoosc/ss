<template>
  <div class="app-container">
    <el-form :model="queryParams" ref="queryRef" :inline="true" v-show="showSearch">
      <el-form-item label="知识标题" prop="title">
        <el-input
          v-model="queryParams.title"
          placeholder="请输入知识标题"
          clearable
          style="width: 200px"
          @keyup.enter="handleQuery"
        />
      </el-form-item>
      <el-form-item label="关键词" prop="keywords">
        <el-input
          v-model="queryParams.keywords"
          placeholder="请输入关键词"
          clearable
          style="width: 200px"
          @keyup.enter="handleQuery"
        />
      </el-form-item>
      <el-form-item label="状态" prop="status">
        <el-select v-model="queryParams.status" placeholder="知识状态" clearable style="width: 160px">
          <el-option label="正常" value="0" />
          <el-option label="停用" value="1" />
        </el-select>
      </el-form-item>
      <el-form-item>
        <el-button type="primary" icon="Search" @click="handleQuery">搜索</el-button>
        <el-button icon="Refresh" @click="resetQuery">重置</el-button>
      </el-form-item>
    </el-form>

    <el-row :gutter="10" class="mb8">
      <el-col :span="1.5">
        <el-button
          type="primary"
          plain
          icon="Plus"
          @click="handleAdd"
          v-hasPermi="['ai:knowledge:add']"
        >新增</el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button
          type="success"
          plain
          icon="Edit"
          :disabled="single"
          @click="handleUpdate"
          v-hasPermi="['ai:knowledge:edit']"
        >修改</el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button
          type="danger"
          plain
          icon="Delete"
          :disabled="multiple"
          @click="handleDelete"
          v-hasPermi="['ai:knowledge:remove']"
        >删除</el-button>
      </el-col>
      <right-toolbar v-model:showSearch="showSearch" @queryTable="getList"></right-toolbar>
    </el-row>

    <el-table v-loading="loading" :data="knowledgeList" @selection-change="handleSelectionChange">
      <el-table-column type="selection" width="55" align="center" />
      <el-table-column label="编号" align="center" prop="id" width="80" />
      <el-table-column label="知识标题" align="center" prop="title" :show-overflow-tooltip="true" />
      <el-table-column label="类型" align="center" prop="contentType" width="120">
        <template #default="scope">
          <el-tag>{{ scope.row.contentType || 'TEXT' }}</el-tag>
        </template>
      </el-table-column>
      <el-table-column label="内容概要" align="center" prop="content" :show-overflow-tooltip="true" />
      <el-table-column label="关键词" align="center" prop="keywords" :show-overflow-tooltip="true" />
      <el-table-column label="状态" align="center" prop="status" width="100">
        <template #default="scope">
          <el-tag :type="scope.row.status === '0' ? 'success' : 'danger'">
            {{ scope.row.status === '0' ? '正常' : '停用' }}
          </el-tag>
        </template>
      </el-table-column>
      <el-table-column label="操作" align="center" width="260" class-name="small-padding fixed-width">
        <template #default="scope">
          <el-button link type="primary" icon="Refresh" @click="handleSync(scope.row)" v-hasPermi="['ai:knowledge:sync']">同步向量库</el-button>
          <el-button link type="primary" icon="Edit" @click="handleUpdate(scope.row)" v-hasPermi="['ai:knowledge:edit']">修改</el-button>
          <el-button link type="primary" icon="Delete" @click="handleDelete(scope.row)" v-hasPermi="['ai:knowledge:remove']">删除</el-button>
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

    <!-- 添加或修改知识库对话框 -->
    <el-dialog :title="dialogTitle" v-model="open" width="750px" append-to-body>
      <el-form ref="knowledgeRef" :model="form" :rules="rules" label-width="100px">
        <el-form-item label="知识标题" prop="title">
          <el-input v-model="form.title" placeholder="请输入知识标题" />
        </el-form-item>
        <el-form-item label="内容类型" prop="contentType">
          <el-radio-group v-model="form.contentType">
            <el-radio label="TEXT">普通文本</el-radio>
            <el-radio label="MARKDOWN">Markdown</el-radio>
          </el-radio-group>
        </el-form-item>
        <el-form-item label="知识内容" prop="content">
          <el-input v-model="form.content" type="textarea" :rows="12" placeholder="请输入知识详细内容、规则、指导方针等" />
        </el-form-item>
        <el-form-item label="关键词" prop="keywords">
          <el-input v-model="form.keywords" placeholder="请输入关键词，多个用逗号分隔" />
        </el-form-item>
        <el-form-item label="状态">
          <el-radio-group v-model="form.status">
            <el-radio label="0">正常</el-radio>
            <el-radio label="1">停用</el-radio>
          </el-radio-group>
        </el-form-item>
        <el-form-item label="备注" prop="remark">
          <el-input v-model="form.remark" type="textarea" placeholder="请输入备注内容" />
        </el-form-item>
      </el-form>
      <template #footer>
        <div class="dialog-footer">
          <el-button type="primary" @click="submitForm">确 定</el-button>
          <el-button @click="cancel">取 消</el-button>
        </div>
      </template>
    </el-dialog>
  </div>
</template>

<script setup name="AiKnowledge">
import { ref, reactive, toRefs, getCurrentInstance } from 'vue';
import { listKnowledge, getKnowledge, delKnowledge, addKnowledge, updateKnowledge, syncKnowledge } from "@/api/ai/knowledge";

const { proxy } = getCurrentInstance();

const queryRef = ref();
const knowledgeRef = ref();

const knowledgeList = ref([]);
const open = ref(false);
const loading = ref(true);
const showSearch = ref(true);
const ids = ref([]);
const single = ref(true);
const multiple = ref(true);
const total = ref(0);
const dialogTitle = ref("");

const data = reactive({
  form: {},
  queryParams: {
    pageNum: 1,
    pageSize: 10,
    title: undefined,
    keywords: undefined,
    status: undefined
  },
  rules: {
    title: [{ required: true, message: "知识标题不能为空", trigger: "blur" }],
    content: [{ required: true, message: "知识内容不能为空", trigger: "blur" }],
  }
});

const { queryParams, form, rules } = toRefs(data);

function getList() {
  loading.value = true;
  listKnowledge(queryParams.value).then(response => {
    knowledgeList.value = response.rows || [];
    total.value = response.total || 0;
    loading.value = false;
  }).catch(() => {
    knowledgeList.value = [];
    total.value = 0;
    loading.value = false;
  });
}

function cancel() {
  open.value = false;
  reset();
}

function reset() {
  form.value = {
    id: undefined,
    title: undefined,
    contentType: "TEXT",
    content: undefined,
    keywords: undefined,
    status: "0",
    remark: undefined
  };
  knowledgeRef.value?.resetFields();
}

function handleQuery() {
  queryParams.value.pageNum = 1;
  getList();
}

function resetQuery() {
  queryRef.value?.resetFields();
  handleQuery();
}

function handleSelectionChange(selection) {
  ids.value = selection.map(item => item.id);
  single.value = selection.length !== 1;
  multiple.value = !selection.length;
}

function handleAdd() {
  reset();
  open.value = true;
  dialogTitle.value = "添加知识库内容";
}

function handleUpdate(row) {
  reset();
  const id = row.id || ids.value[0];
  getKnowledge(id).then(response => {
    form.value = response.data;
    open.value = true;
    dialogTitle.value = "修改知识库内容";
  });
}

function submitForm() {
  knowledgeRef.value.validate(valid => {
    if (valid) {
      if (form.value.id !== undefined) {
        updateKnowledge(form.value).then(response => {
          proxy.$modal.msgSuccess("修改成功");
          open.value = false;
          getList();
        });
      } else {
        addKnowledge(form.value).then(response => {
          proxy.$modal.msgSuccess("新增成功");
          open.value = false;
          getList();
        });
      }
    }
  });
}

function handleDelete(row) {
  const knowledgeIds = row.id || ids.value;
  proxy.$modal.confirm('是否确认删除编号为"' + knowledgeIds + '"的数据项？').then(function() {
    return delKnowledge(knowledgeIds);
  }).then(() => {
    getList();
    proxy.$modal.msgSuccess("删除成功");
  }).catch(() => {});
}

function handleSync(row) {
  syncKnowledge(row.id).then(() => {
    proxy.$modal.msgSuccess("向量库同步请求已发送成功");
  });
}

getList();
</script>

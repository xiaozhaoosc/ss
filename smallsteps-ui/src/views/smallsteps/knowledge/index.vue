<template>
  <div class="app-container">
    <el-form :model="queryParams" ref="queryRef" :inline="true" v-show="showSearch">
      <el-form-item label="标题" prop="title">
        <el-input v-model="queryParams.title" placeholder="请输入文章标题" clearable @keyup.enter="handleQuery" />
      </el-form-item>
      <el-form-item label="分类" prop="category">
        <el-select v-model="queryParams.category" placeholder="全部" clearable style="width: 150px">
          <el-option label="ADHD知识" value="adhd" />
          <el-option label="情绪管理" value="emotion" />
          <el-option label="习惯养成" value="habit" />
          <el-option label="家长指南" value="parent" />
        </el-select>
      </el-form-item>
      <el-form-item>
        <el-button type="primary" icon="Search" @click="handleQuery">搜索</el-button>
        <el-button icon="Refresh" @click="resetQuery">重置</el-button>
      </el-form-item>
    </el-form>

    <el-row :gutter="10" class="mb8">
      <el-col :span="1.5">
        <el-button type="primary" plain icon="Plus" @click="handleAdd">新增</el-button>
      </el-col>
      <right-toolbar v-model:showSearch="showSearch" @queryTable="getList" />
    </el-row>

    <el-table v-loading="loading" :data="knowledgeList">
      <el-table-column label="标题" align="center" prop="title" :show-overflow-tooltip="true" />
      <el-table-column label="分类" align="center" prop="category" width="120">
        <template #default="scope">
          <el-tag>{{ getCategoryLabel(scope.row.category) }}</el-tag>
        </template>
      </el-table-column>
      <el-table-column label="作者" align="center" prop="author" width="120" />
      <el-table-column label="阅读量" align="center" prop="viewCount" width="100" />
      <el-table-column label="发布时间" align="center" prop="publishTime" width="180">
        <template #default="scope">
          <span>{{ parseTime(scope.row.publishTime) }}</span>
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

<script setup name="SmallstepsKnowledge">
const { proxy } = getCurrentInstance();
const knowledgeList = ref([]);
const loading = ref(false);
const showSearch = ref(true);
const total = ref(0);

const CATEGORY_MAP = { adhd: 'ADHD知识', emotion: '情绪管理', habit: '习惯养成', parent: '家长指南' };

const data = reactive({
  queryParams: { pageNum: 1, pageSize: 10, title: undefined, category: undefined }
});
const { queryParams } = toRefs(data);

function getCategoryLabel(cat) { return CATEGORY_MAP[cat] ?? cat; }
function getList() { loading.value = true; /* TODO: listKnowledge */ loading.value = false; }
function handleQuery() { queryParams.value.pageNum = 1; getList(); }
function resetQuery() { proxy.resetForm('queryRef'); handleQuery(); }
function handleAdd() { proxy.$modal.msgWarning('知识学堂功能即将上线'); }
function handleUpdate(row) { proxy.$modal.msgWarning('知识学堂功能即将上线'); }
function handleDelete(row) { proxy.$modal.msgWarning('知识学堂功能即将上线'); }

getList();
</script>

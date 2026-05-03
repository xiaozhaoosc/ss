<template>
  <div class="app-container">
    <el-form :model="queryParams" ref="queryRef" :inline="true" v-show="showSearch">
      <el-form-item label="场景Key" prop="sceneKey">
        <el-input
          v-model="queryParams.sceneKey"
          placeholder="请输入场景Key"
          clearable
          style="width: 200px"
          @keyup.enter="handleQuery"
        />
      </el-form-item>
      <el-form-item label="路由策略" prop="strategy">
        <el-select v-model="queryParams.strategy" placeholder="请选择策略" clearable style="width: 200px">
          <el-option label="优先级排序" value="PRIORITY_LEVEL" />
          <el-option label="最低价格优先" value="LOWEST_PRICE" />
          <el-option label="轮询负载均衡" value="ROUND_ROBIN" />
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
          v-hasPermi="['ai:route:add']"
        >新增</el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button
          type="success"
          plain
          icon="Edit"
          :disabled="single"
          @click="handleUpdate"
          v-hasPermi="['ai:route:edit']"
        >修改</el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button
          type="danger"
          plain
          icon="Delete"
          :disabled="multiple"
          @click="handleDelete"
          v-hasPermi="['ai:route:remove']"
        >删除</el-button>
      </el-col>
      <right-toolbar v-model:showSearch="showSearch" @queryTable="getList"></right-toolbar>
    </el-row>

    <el-table v-loading="loading" :data="routeList" @selection-change="handleSelectionChange">
      <el-table-column type="selection" width="55" align="center" />
      <el-table-column label="场景Key" align="center" prop="sceneKey" />
      <el-table-column label="路由策略" align="center" prop="strategy">
        <template #default="scope">
          <el-tag v-if="scope.row.strategy === 'PRIORITY_LEVEL'">优先级排序</el-tag>
          <el-tag v-else-if="scope.row.strategy === 'LOWEST_PRICE'" type="success">最低价格优先</el-tag>
          <el-tag v-else type="info">{{ scope.row.strategy }}</el-tag>
        </template>
      </el-table-column>
      <el-table-column label="默认模型" align="center" prop="defaultModelId">
        <template #default="scope">
          <span>{{ getModelName(scope.row.defaultModelId) }} ({{ scope.row.defaultModelId }})</span>
        </template>
      </el-table-column>
      <el-table-column label="创建时间" align="center" prop="createTime" width="180">
        <template #default="scope">
          <span>{{ parseTime(scope.row.createTime) }}</span>
        </template>
      </el-table-column>
      <el-table-column label="操作" align="center" class-name="small-padding fixed-width">
        <template #default="scope">
          <el-button link type="primary" icon="Edit" @click="handleUpdate(scope.row)" v-hasPermi="['ai:route:edit']">修改</el-button>
          <el-button link type="primary" icon="Delete" @click="handleDelete(scope.row)" v-hasPermi="['ai:route:remove']">删除</el-button>
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

    <!-- 添加或修改路由对话框 -->
    <el-dialog :title="title" v-model="open" width="600px" append-to-body>
      <el-form ref="routeRef" :model="form" :rules="rules" label-width="100px">
        <el-form-item label="场景Key" prop="sceneKey">
          <el-input v-model="form.sceneKey" placeholder="如 default_scene, emotion_analysis" :disabled="form.id !== undefined" />
        </el-form-item>
        <el-form-item label="路由策略" prop="strategy">
          <el-select v-model="form.strategy" placeholder="请选择策略" style="width: 100%">
            <el-option label="优先级排序" value="PRIORITY_LEVEL" />
            <el-option label="最低价格优先" value="LOWEST_PRICE" />
            <el-option label="轮询负载均衡" value="ROUND_ROBIN" />
          </el-select>
        </el-form-item>
        <el-form-item label="默认模型" prop="defaultModelId">
          <el-select v-model="form.defaultModelId" placeholder="请选择默认模型" style="width: 100%" clearable>
            <el-option
              v-for="item in modelOptions"
              :key="item.id"
              :label="item.name"
              :value="item.id"
            />
          </el-select>
        </el-form-item>
        <el-form-item label="扩展配置" prop="configJson">
          <el-input v-model="form.configJson" type="textarea" placeholder='请输入JSON配置, 如 {"fallbackModels": [2001, 2002]}' rows="4" />
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

<script setup name="AiRoute">
import { listRoute, getRoute, delRoute, addRoute, updateRoute } from "@/api/ai/route";
import { listModel } from "@/api/ai/model";

const { proxy } = getCurrentInstance();

const routeList = ref([]);
const open = ref(false);
const loading = ref(true);
const showSearch = ref(true);
const ids = ref([]);
const single = ref(true);
const multiple = ref(true);
const total = ref(0);
const title = ref("");
const modelOptions = ref([]);

const queryRef = ref();
const routeRef = ref();

const data = reactive({
  form: {},
  queryParams: {
    pageNum: 1,
    pageSize: 10,
    sceneKey: undefined,
    strategy: undefined
  },
  rules: {
    sceneKey: [{ required: true, message: "场景Key不能为空", trigger: "blur" }],
    strategy: [{ required: true, message: "路由策略不能为空", trigger: "change" }]
  }
});

const { queryParams, form, rules } = toRefs(data);

function getList() {
  loading.value = true;
  listRoute(queryParams.value).then(response => {
    routeList.value = response.rows;
    total.value = response.total;
    loading.value = false;
  });
}

/** 查询所有模型用于下拉框 */
function getModelOptions() {
  listModel({ pageSize: 100 }).then(response => {
    modelOptions.value = response.rows;
  });
}

function getModelName(modelId) {
  const model = modelOptions.value.find(item => item.id === modelId);
  return model ? model.name : '未知模型';
}

function cancel() {
  open.value = false;
  reset();
}

function reset() {
  form.value = {
    sceneKey: undefined,
    strategy: "PRIORITY_LEVEL",
    defaultModelId: undefined,
    configJson: undefined
  };
  routeRef.value?.resetFields();
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
  ids.value = selection.map(item => item.sceneKey);
  single.value = selection.length != 1;
  multiple.value = !selection.length;
}

function handleAdd() {
  reset();
  open.value = true;
  title.value = "添加路由策略";
}

function handleUpdate(row) {
  reset();
  const sceneKey = row.sceneKey || ids.value[0];
  getRoute(sceneKey).then(response => {
    form.value = response.data;
    open.value = true;
    title.value = "修改路由策略";
  });
}

function submitForm() {
  routeRef.value.validate(valid => {
    if (valid) {
      // 路由以 sceneKey 作为标识，这里通过判断是否有创建时间或其他方式区分新增修改较复杂，
      // 通常在 Controller 侧 handle
      // 由于是 @TableId sceneKey，我们根据业务逻辑判断
      // 这里简单处理：如果是在修改模式打开的，调用 update
      if (title.value.indexOf("修改") !== -1) {
        updateRoute(form.value).then(response => {
          proxy.$modal.msgSuccess("修改成功");
          open.value = false;
          getList();
        });
      } else {
        addRoute(form.value).then(response => {
          proxy.$modal.msgSuccess("新增成功");
          open.value = false;
          getList();
        });
      }
    }
  });
}

function handleDelete(row) {
  const sceneKeys = row.sceneKey || ids.value;
  proxy.$modal.confirm('是否确认删除场景Key为"' + sceneKeys + '"的数据项？').then(function() {
    return delRoute(sceneKeys);
  }).then(() => {
    getList();
    proxy.$modal.msgSuccess("删除成功");
  }).catch(() => {});
}

getList();
getModelOptions();
</script>

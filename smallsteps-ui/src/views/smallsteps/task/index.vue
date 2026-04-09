<template>
  <div class="p-2">
    <transition :enter-active-class="proxy?.animate.searchAnimate.enter" :leave-active-class="proxy?.animate.searchAnimate.leave">
      <div v-show="showSearch" class="mb-[10px]">
        <el-card shadow="hover">
          <el-form ref="queryFormRef" :model="queryParams" :inline="true">
            <el-form-item label="任务标题" prop="title">
              <el-input v-model="queryParams.title" placeholder="请输入任务标题" clearable @keyup.enter="handleQuery" />
            </el-form-item>
            <el-form-item label="任务状态" prop="status">
              <el-select v-model="queryParams.status" placeholder="任务状态" clearable>
                <el-option label="进行中" value="0" />
                <el-option label="已完成" value="1" />
                <el-option label="已过期" value="2" />
              </el-select>
            </el-form-item>
            <el-form-item>
              <el-button type="primary" icon="Search" @click="handleQuery">搜索</el-button>
              <el-button icon="Refresh" @click="resetQuery">重置</el-button>
            </el-form-item>
          </el-form>
        </el-card>
      </div>
    </transition>

    <el-card shadow="hover">
      <template #header>
        <el-row :gutter="10">
          <el-col :span="1.5">
            <el-button v-has-permi="['parent:task:add']" type="primary" plain icon="Plus" @click="handleAdd">新增任务</el-button>
          </el-col>
          <el-col :span="1.5">
            <el-button v-has-permi="['parent:task:edit']" type="success" plain :disabled="single" icon="Edit" @click="handleUpdate">修改</el-button>
          </el-col>
          <el-col :span="1.5">
            <el-button v-has-permi="['parent:task:remove']" type="danger" plain :disabled="multiple" icon="Delete" @click="handleDelete">删除</el-button>
          </el-col>
          <right-toolbar v-model:show-search="showSearch" @query-table="getList"></right-toolbar>
        </el-row>
      </template>

      <el-table v-loading="loading" :data="taskList" @selection-change="handleSelectionChange">
        <el-table-column type="selection" width="55" align="center" />
        <el-table-column label="任务编号" align="center" prop="taskId" />
        <el-table-column label="标题" align="center" prop="title" :show-overflow-tooltip="true" />
        <el-table-column label="难度" align="center" prop="difficulty">
          <template #default="scope">
            <el-rate v-model="scope.row.difficulty" disabled />
          </template>
        </el-table-column>
        <el-table-column label="支架强度" align="center" prop="promptLevel">
          <template #default="scope">
            <el-tag :type="scope.row.promptLevel > 3 ? 'danger' : 'success'">
              LV.{{ scope.row.promptLevel }}
            </el-tag>
          </template>
        </el-table-column>
        <el-table-column label="奖励积分" align="center" prop="rewardPoints" />
        <el-table-column label="状态" align="center" prop="status">
          <template #default="scope">
            <el-tag :type="scope.row.status === '0' ? 'primary' : (scope.row.status === '1' ? 'success' : 'info')">
              {{ scope.row.status === '0' ? '进行中' : (scope.row.status === '1' ? '已完成' : '已过期') }}
            </el-tag>
          </template>
        </el-table-column>
        <el-table-column label="操作" align="center" width="180">
          <template #default="scope">
            <el-button v-has-permi="['parent:task:edit']" link type="primary" icon="Edit" @click="handleUpdate(scope.row)">修改</el-button>
            <el-button v-has-permi="['parent:task:remove']" link type="primary" icon="Delete" @click="handleDelete(scope.row)">删除</el-button>
          </template>
        </el-table-column>
      </el-table>

      <pagination
        v-show="total > 0"
        v-model:page="queryParams.pageNum"
        v-model:limit="queryParams.pageSize"
        :total="total"
        @pagination="getList"
      />
    </el-card>

    <!-- 添加或修改对话框 -->
    <el-dialog v-model="open" :title="title" width="600px" append-to-body>
      <el-form ref="taskFormRef" :model="form" :rules="rules" label-width="100px">
        <el-form-item label="任务标题" prop="title">
          <el-input v-model="form.title" placeholder="请输入任务标题" />
        </el-form-item>
        <el-form-item label="任务描述" prop="description">
          <el-input v-model="form.description" type="textarea" placeholder="请输入任务描述" />
        </el-form-item>
        <el-row>
          <el-col :span="12">
            <el-form-item label="难度等级" prop="difficulty">
              <el-rate v-model="form.difficulty" :max="5" />
            </el-form-item>
          </el-col>
          <el-col :span="12">
            <el-form-item label="辅助强度" prop="promptLevel">
              <el-select v-model="form.promptLevel" placeholder="请选择">
                <el-option label="弱 (仅提醒)" :value="1" />
                <el-option label="中 (分步引导)" :value="3" />
                <el-option label="强 (全程督导)" :value="5" />
              </el-select>
            </el-form-item>
          </el-col>
        </el-row>
        <el-row>
          <el-col :span="12">
            <el-form-item label="奖励积分" prop="rewardPoints">
              <el-input-number v-model="form.rewardPoints" :min="0" />
            </el-form-item>
          </el-col>
          <el-col :span="12">
            <el-form-item label="循环类型" prop="cycleType">
              <el-select v-model="form.cycleType" placeholder="请选择">
                <el-option label="单次" :value="0" />
                <el-option label="每日" :value="1" />
                <el-option label="每周" :value="2" />
              </el-select>
            </el-form-item>
          </el-col>
        </el-row>
        <el-divider content-position="center">硬件交互配置 (ESP32)</el-divider>
        <el-row>
          <el-col :span="12">
            <el-form-item label="光语代码" prop="lightEffect">
              <el-input v-model="form.lightEffect" placeholder="如: BREATH_BLUE" />
            </el-form-item>
          </el-col>
          <el-col :span="12">
            <el-form-item label="音频索引" prop="audioEffect">
              <el-input v-model="form.audioEffect" placeholder="如: 001" />
            </el-form-item>
          </el-col>
        </el-row>
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

<script setup name="ParentTask" lang="ts">
import { listTask, getTask, deleteTask, addTask, updateTask } from "@/api/smallsteps/task";

const { proxy } = getCurrentInstance() as ComponentInternalInstance;

const taskList = ref<any[]>([]);
const open = ref(false);
const loading = ref(true);
const showSearch = ref(true);
const ids = ref<Array<string | number>>([]);
const single = ref(true);
const multiple = ref(true);
const total = ref(0);
const title = ref("");

const data = reactive<any>({
  form: {},
  queryParams: {
    pageNum: 1,
    pageSize: 10,
    title: undefined,
    status: undefined
  },
  rules: {
    title: [{ required: true, message: "任务标题不能为空", trigger: "blur" }],
    rewardPoints: [{ required: true, message: "奖励积分不能为空", trigger: "blur" }]
  }
});

const { queryParams, form, rules } = toRefs(data);

/** 查询列表 */
function getList() {
  loading.value = true;
  listTask(queryParams.value).then((response: any) => {
    taskList.value = response.rows;
    total.value = response.total;
    loading.value = false;
  });
}

/** 取消按钮 */
function cancel() {
  open.value = false;
  reset();
}

/** 表单重置 */
function reset() {
  form.value = {
    taskId: undefined,
    title: undefined,
    description: undefined,
    difficulty: 1,
    promptLevel: 1,
    cycleType: 0,
    rewardPoints: 10,
    lightEffect: "DEFAULT",
    audioEffect: "001",
    status: "0"
  };
  proxy?.resetForm("taskFormRef");
}

/** 搜索按钮操作 */
function handleQuery() {
  queryParams.value.pageNum = 1;
  getList();
}

/** 重置按钮操作 */
function resetQuery() {
  proxy?.resetForm("queryFormRef");
  handleQuery();
}

/** 多选框选中数据 */
function handleSelectionChange(selection: any[]) {
  ids.value = selection.map(item => item.taskId);
  single.value = selection.length != 1;
  multiple.value = !selection.length;
}

/** 新增按钮操作 */
function handleAdd() {
  reset();
  open.value = true;
  title.value = "添加家长任务";
}

/** 修改按钮操作 */
function handleUpdate(row?: any) {
  reset();
  const taskId = row?.taskId || ids.value[0];
  getTask(taskId).then(response => {
    form.value = response.data;
    open.value = true;
    title.value = "修改家长任务";
  });
}

/** 提交按钮 */
function submitForm() {
  proxy?.$refs["taskFormRef"].validate((valid: boolean) => {
    if (valid) {
      if (form.value.taskId != undefined) {
        updateTask(form.value).then(response => {
          proxy?.$modal.msgSuccess("修改成功");
          open.value = false;
          getList();
        });
      } else {
        addTask(form.value).then(response => {
          proxy?.$modal.msgSuccess("新增成功");
          open.value = false;
          getList();
        });
      }
    }
  });
}

/** 删除按钮操作 */
function handleDelete(row?: any) {
  const taskIds = row?.taskId || ids.value;
  proxy?.$modal.confirm('是否确认删除任务编号为"' + taskIds + '"的数据项？').then(function() {
    return deleteTask(taskIds);
  }).then(() => {
    getList();
    proxy?.$modal.msgSuccess("删除成功");
  }).catch(() => {});
}

getList();
</script>

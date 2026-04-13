<template>
  <div class="p-2">
    <transition :enter-active-class="proxy?.animate.searchAnimate.enter" :leave-active-class="proxy?.animate.searchAnimate.leave">
      <div v-show="showSearch" class="mb-[20px]">
        <el-card shadow="hover" class="search-card border-none bg-opacity-80 backdrop-blur-sm">
          <el-form ref="queryFormRef" :model="queryParams" :inline="true">
            <el-form-item label="任务标题" prop="title">
              <el-input v-model="queryParams.title" placeholder="请输入任务标题" clearable @keyup.enter="handleQuery" class="!w-[240px]" />
            </el-form-item>
            <el-form-item label="任务状态" prop="status">
              <el-select v-model="queryParams.status" placeholder="任务状态" clearable class="!w-[160px]">
                <el-option label="进行中" value="0" />
                <el-option label="已完成" value="1" />
                <el-option label="已过期" value="2" />
              </el-select>
            </el-form-item>
            <el-form-item>
              <el-button type="primary" icon="Search" @click="handleQuery" class="gradient-btn">搜索</el-button>
              <el-button icon="Refresh" @click="resetQuery">重置</el-button>
            </el-form-item>
          </el-form>
        </el-card>
      </div>
    </transition>

    <div class="mb-[15px] flex items-center justify-between">
      <div class="flex gap-2">
        <el-button v-has-permi="['parent:task:add']" type="primary" icon="Plus" @click="handleAdd" class="action-btn">新增任务</el-button>
        <el-button v-has-permi="['parent:task:remove']" type="danger" plain :disabled="multiple" icon="Delete" @click="handleDelete">批量删除</el-button>
      </div>
      <right-toolbar v-model:show-search="showSearch" @query-table="getList"></right-toolbar>
    </div>

    <div v-loading="loading">
      <el-row :gutter="20" class="task-gallery">
        <el-col v-for="(item, index) in taskList" :key="item.taskId" :xs="24" :sm="12" :md="8" :lg="6">
          <el-card 
            class="task-card mb-[20px] transition-all hover:-translate-y-1 hover:shadow-xl border-none animate__animated animate__fadeInUp"
            :style="{ 'animation-delay': (index * 0.05) + 's' }"
            shadow="always"
          >
            <template #header>
              <div class="flex items-center justify-between">
                <span class="font-bold text-lg truncate flex-1 pr-2" :title="item.title">{{ item.title }}</span>
                <el-tag :type="getStatusType(item.status)" effect="dark" round size="small">
                  {{ getStatusLabel(item.status) }}
                </el-tag>
              </div>
            </template>
            
            <div class="task-body py-2">
              <p class="text-sm text-gray-500 mb-3 h-[40px] line-clamp-2">{{ item.description || '暂无描述' }}</p>
              
              <div class="flex items-center justify-between mb-2">
                <span class="text-xs text-gray-400">难度系数</span>
                <el-rate v-model="item.difficulty" disabled size="small" />
              </div>
              
              <div class="flex items-center justify-between mb-2">
                <span class="text-xs text-gray-400">支架强度</span>
                <el-tag :type="item.promptLevel > 3 ? 'danger' : 'success'" size="small" effect="plain">
                  LV.{{ item.promptLevel }}
                </el-tag>
              </div>

              <div class="flex items-center justify-between">
                <span class="text-xs text-gray-400">奖励积分</span>
                <span class="text-orange-500 font-bold font-mono">+{{ item.rewardPoints }}</span>
              </div>
            </div>

            <div class="task-footer mt-4 pt-4 border-t border-gray-100 flex justify-end gap-2">
              <el-tooltip content="编辑" placement="top">
                <el-button v-has-permi="['parent:task:edit']" circle icon="Edit" @click="handleUpdate(item)" />
              </el-tooltip>
              <el-tooltip content="删除" placement="top">
                <el-button v-has-permi="['parent:task:remove']" circle type="danger" plain icon="Delete" @click="handleDelete(item)" />
              </el-tooltip>
            </div>
          </el-card>
        </el-col>
      </el-row>
      
      <div v-if="taskList.length === 0" class="flex flex-col items-center justify-center py-20 bg-white rounded-lg shadow-sm">
        <el-empty description="暂无发布任务" />
      </div>

      <pagination
        v-show="total > 0"
        v-model:page="queryParams.pageNum"
        v-model:limit="queryParams.pageSize"
        :total="total"
        @pagination="getList"
      />
    </div>

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

/** 获取状态类型 */
function getStatusType(status: string) {
  switch (status) {
    case '0': return 'primary';
    case '1': return 'success';
    case '2': return 'info';
    default: return 'info';
  }
}

/** 获取状态标签 */
function getStatusLabel(status: string) {
  switch (status) {
    case '0': return '进行中';
    case '1': return '已完成';
    case '2': return '已过期';
    default: return '未知';
  }
}

getList();
</script>

<style scoped lang="scss">
.search-card {
  background: linear-gradient(135deg, rgba(255, 255, 255, 0.9) 0%, rgba(240, 248, 255, 0.9) 100%);
  border-radius: 16px;
  box-shadow: 0 8px 32px rgba(31, 38, 135, 0.07);
}

.gradient-btn {
  background: linear-gradient(90deg, #4facfe 0%, #00f2fe 100%);
  border: none;
  &:hover {
    opacity: 0.9;
    transform: scale(1.02);
  }
}

.action-btn {
  border-radius: 10px;
  font-weight: bold;
}

.task-card {
  border-radius: 20px;
  overflow: hidden;
  transition: all 0.3s cubic-bezier(0.25, 0.8, 0.25, 1);
  
  :deep(.el-card__header) {
    background: #fdfdfd;
    border-bottom: 1px solid #f0f0f0;
    padding: 15px 20px;
  }
  
  &:hover {
    box-shadow: 0 15px 35px rgba(0, 0, 0, 0.1);
  }
}

.task-gallery {
  padding: 10px 0;
}

.line-clamp-2 {
  display: -webkit-box;
  -webkit-line-clamp: 2;
  -webkit-box-orient: vertical;
  overflow: hidden;
}

/* 针对 ADHD 的温馨提示：使用圆润的边框和非侵入式的动画 */
:deep(.el-rate__icon) {
  margin-right: 2px;
}
</style>

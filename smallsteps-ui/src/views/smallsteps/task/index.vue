<template>
  <div class="p-2">
    <el-row :gutter="20">
      <el-col :lg="20" :xs="24">
        <transition :enter-active-class="proxy?.animate.searchAnimate.enter" :leave-active-class="proxy?.animate.searchAnimate.leave">
          <div v-show="showSearch" class="mb-[10px]">
            <el-card shadow="hover">
              <el-form ref="queryFormRef" :model="queryParams" :inline="true">
                <el-form-item label="任务名称" prop="taskName">
                  <el-input v-model="queryParams.taskName" placeholder="请输入任务名称" clearable @keyup.enter="handleQuery" />
                </el-form-item>
                
                <el-form-item label="儿童ID" prop="childId">
                  <el-input v-model="queryParams.childId" placeholder="请输入儿童ID" clearable @keyup.enter="handleQuery" />
                </el-form-item>

                <el-form-item label="状态" prop="status">
                  <el-select v-model="queryParams.status" placeholder="状态" clearable>
                    <el-option label="启用" value="1" />
                    <el-option label="禁用" value="0" />
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
                <el-button v-has-permi="['smallsteps:task:add']" type="primary" plain icon="Plus" @click="handleAdd()">新增</el-button>
              </el-col>
              <el-col :span="1.5">
                <el-button v-has-permi="['smallsteps:task:edit']" type="success" plain :disabled="single" icon="Edit" @click="handleUpdate()">
                  修改
                </el-button>
              </el-col>
              <el-col :span="1.5">
                <el-button v-has-permi="['smallsteps:task:remove']" type="danger" plain :disabled="multiple" icon="Delete" @click="handleDelete()">
                  删除
                </el-button>
              </el-col>
              <el-col :span="1.5">
                <el-dropdown class="mt-[1px]">
                  <el-button plain type="info">
                    更多
                    <el-icon class="el-icon--right"><arrow-down /></el-icon
                  ></el-button>
                  <template #dropdown>
                    <el-dropdown-menu>
                      <el-dropdown-item v-if="checkPermi(['smallsteps:task:export'])" icon="Download" @click="handleExport">导出数据</el-dropdown-item>
                    </el-dropdown-menu>
                  </template>
                </el-dropdown>
              </el-col>
              <right-toolbar v-model:show-search="showSearch" :columns="columns" :search="true" @query-table="getList"></right-toolbar>
            </el-row>
          </template>

          <el-table v-loading="loading" border :data="taskList" @selection-change="handleSelectionChange">
            <el-table-column type="selection" width="50" align="center" />
            <el-table-column v-if="columns[0].visible" key="taskId" label="任务ID" align="center" prop="taskId" />
            <el-table-column v-if="columns[1].visible" key="taskName" label="任务名称" align="center" prop="taskName" :show-overflow-tooltip="true" />
            <el-table-column v-if="columns[2].visible" key="childId" label="儿童ID" align="center" prop="childId" />
            <el-table-column v-if="columns[3].visible" key="starReward" label="星星奖励" align="center" prop="starReward" />
            <el-table-column v-if="columns[4].visible" key="difficulty" label="难度" align="center" prop="difficulty" />
            <el-table-column v-if="columns[5].visible" key="status" label="状态" align="center">
              <template #default="scope">
                <span>{{ scope.row.status === '1' ? '启用' : '禁用' }}</span>
              </template>
            </el-table-column>
            <el-table-column v-if="columns[6].visible" label="创建时间" align="center" prop="createdAt" width="160">
              <template #default="scope">
                <span>{{ scope.row.createdAt }}</span>
              </template>
            </el-table-column>

            <el-table-column label="操作" fixed="right" width="180" class-name="small-padding fixed-width">
              <template #default="scope">
                <el-tooltip content="修改" placement="top">
                  <el-button v-hasPermi="['smallsteps:task:edit']" link type="primary" icon="Edit" @click="handleUpdate(scope.row)"></el-button>
                </el-tooltip>
                <el-tooltip content="删除" placement="top">
                  <el-button v-hasPermi="['smallsteps:task:remove']" link type="primary" icon="Delete" @click="handleDelete(scope.row)"></el-button>
                </el-tooltip>
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
      </el-col>
    </el-row>

    <!-- 添加或修改任务对话框 -->
    <el-dialog ref="formDialogRef" v-model="dialog.visible" :title="dialog.title" width="600px" append-to-body @close="closeDialog">
      <el-form ref="taskFormRef" :model="form" :rules="rules" label-width="80px">
        <el-row>
          <el-col :span="12">
            <el-form-item label="任务名称" prop="taskName">
              <el-input v-model="form.taskName" placeholder="请输入任务名称" maxlength="30" />
            </el-form-item>
          </el-col>
          <el-col :span="12">
            <el-form-item label="儿童ID" prop="childId">
              <el-input v-model="form.childId" placeholder="请输入儿童ID" />
            </el-form-item>
          </el-col>
        </el-row>
        <el-row>
          <el-col :span="12">
            <el-form-item label="星星奖励">
              <el-input v-model="form.starReward" type="number" placeholder="请输入星星奖励" />
            </el-form-item>
          </el-col>
          <el-col :span="12">
            <el-form-item label="难度">
              <el-input v-model="form.difficulty" type="number" placeholder="请输入难度" />
            </el-form-item>
          </el-col>
        </el-row>
        <el-row>
          <el-col :span="12">
            <el-form-item label="状态">
              <el-select v-model="form.status" placeholder="请选择">
                <el-option label="启用" value="1"></el-option>
                <el-option label="禁用" value="0"></el-option>
              </el-select>
            </el-form-item>
          </el-col>
        </el-row>
        <el-row>
          <el-col :span="24">
            <el-form-item label="描述">
              <el-input v-model="form.description" type="textarea" placeholder="请输入任务描述"></el-input>
            </el-form-item>
          </el-col>
        </el-row>
      </el-form>
      <template #footer>
        <div class="dialog-footer">
          <el-button type="primary" @click="submitForm">确 定</el-button>
          <el-button @click="cancel()">取 消</el-button>
        </div>
      </template>
    </el-dialog>
  </div>
</template>

<script setup name="Task" lang="ts">
import { listTask, getTask, addTask, updateTask, delTask, exportTask } from '@/api/smallsteps/task';
import { Task } from '@/api/smallsteps/types';
import { checkPermi } from '@/utils/permission';

const router = useRouter();
const { proxy } = getCurrentInstance() as ComponentInternalInstance;
const taskList = ref<Task[]>();
const loading = ref(true);
const showSearch = ref(true);
const ids = ref<Array<number | string>>([]);
const single = ref(true);
const multiple = ref(true);
const total = ref(0);
// 列显隐信息
const columns = ref<FieldOption[]>([
  { key: 0, label: `任务ID`, visible: true, children: [] },
  { key: 1, label: `任务名称`, visible: true, children: [] },
  { key: 2, label: `儿童ID`, visible: true, children: [] },
  { key: 3, label: `星星奖励`, visible: true, children: [] },
  { key: 4, label: `难度`, visible: true, children: [] },
  { key: 5, label: `状态`, visible: true, children: [] },
  { key: 6, label: `创建时间`, visible: true, children: [] }
]);

const queryFormRef = ref<ElFormInstance>();
const taskFormRef = ref<ElFormInstance>();
const formDialogRef = ref<ElDialogInstance>();

const dialog = reactive<DialogOption>({
  visible: false,
  title: ''
});

const initFormData: Task = {
  taskId: 0,
  childId: 0,
  taskName: '',
  description: '',
  difficulty: 0,
  starReward: 0,
  status: '0',
  createdAt: '',
  updatedAt: ''
};

const initData = {
  form: { ...initFormData },
  queryParams: {
    pageNum: 1,
    pageSize: 10,
    taskName: '',
    childId: '',
    status: ''
  },
  rules: {
    taskName: [{ required: true, message: '任务名称不能为空', trigger: 'blur' }],
    childId: [{ required: true, message: '儿童ID不能为空', trigger: 'blur' }]
  }
};
const data = reactive(initData);

const { queryParams, form, rules } = toRefs(data);

/** 查询任务列表 */
const getList = async () => {
  loading.value = true;
  const res = await listTask(queryParams.value);
  loading.value = false;
  taskList.value = res.rows;
  total.value = res.total;
};

/** 搜索按钮操作 */
const handleQuery = () => {
  queryParams.value.pageNum = 1;
  getList();
};
/** 重置按钮操作 */
const resetQuery = () => {
  queryFormRef.value?.resetFields();
  queryParams.value.pageNum = 1;
  handleQuery();
};

/** 删除按钮操作 */
const handleDelete = async (row?: Task) => {
  const taskIds = row?.taskId || ids.value;
  const [err] = await to(proxy?.$modal.confirm('是否确认删除任务编号为"' + taskIds + '"的数据项？') as any);
  if (!err) {
    await delTask(taskIds as number);
    await getList();
    proxy?.$modal.msgSuccess('删除成功');
  }
};

/** 选择条数  */
const handleSelectionChange = (selection: Task[]) => {
  ids.value = selection.map((item) => item.taskId);
  single.value = selection.length != 1;
  multiple.value = !selection.length;
};

/** 导出按钮操作 */
const handleExport = () => {
  proxy?.download(
    'smallsteps/task/export',
    {
      ...queryParams.value
    },
    `task_${new Date().getTime()}.xlsx`
  );
};

/** 重置操作表单 */
const reset = () => {
  form.value = { ...initFormData };
  taskFormRef.value?.resetFields();
};
/** 取消按钮 */
const cancel = () => {
  dialog.visible = false;
  reset();
};

/** 新增按钮操作 */
const handleAdd = async () => {
  reset();
  dialog.visible = true;
  dialog.title = '新增任务';
};

/** 修改按钮操作 */
const handleUpdate = async (row?: Task) => {
  reset();
  const taskId = row?.taskId || ids.value[0];
  const res = await getTask(taskId as number);
  dialog.visible = true;
  dialog.title = '修改任务';
  Object.assign(form.value, res);
};

/** 提交按钮 */
const submitForm = () => {
  taskFormRef.value?.validate(async (valid: boolean) => {
    if (valid) {
      if (form.value.taskId && form.value.taskId !== 0) {
        await updateTask(form.value);
      } else {
        await addTask(form.value);
      }
      proxy?.$modal.msgSuccess('操作成功');
      dialog.visible = false;
      await getList();
    }
  });
};

/**
 * 关闭任务弹窗
 */
const closeDialog = () => {
  dialog.visible = false;
  reset();
};
onMounted(() => {
  getList(); // 初始化列表数据
});
</script>

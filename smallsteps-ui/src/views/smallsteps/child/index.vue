<template>
  <div class="p-2">
    <el-row :gutter="20">
      <el-col :lg="20" :xs="24">
        <transition :enter-active-class="proxy?.animate.searchAnimate.enter" :leave-active-class="proxy?.animate.searchAnimate.leave">
          <div v-show="showSearch" class="mb-[10px]">
            <el-card shadow="hover">
              <el-form ref="queryFormRef" :model="queryParams" :inline="true">
                <el-form-item label="儿童姓名" prop="childName">
                  <el-input v-model="queryParams.childName" placeholder="请输入儿童姓名" clearable @keyup.enter="handleQuery" />
                </el-form-item>
                
                <el-form-item label="家长ID" prop="parentId">
                  <el-input v-model="queryParams.parentId" placeholder="请输入家长ID" clearable @keyup.enter="handleQuery" />
                </el-form-item>

                <el-form-item label="性别" prop="gender">
                  <el-select v-model="queryParams.gender" placeholder="性别" clearable>
                    <el-option label="男" value="0" />
                    <el-option label="女" value="1" />
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
                <el-button v-has-permi="['smallsteps:child:add']" type="primary" plain icon="Plus" @click="handleAdd()">新增</el-button>
              </el-col>
              <el-col :span="1.5">
                <el-button v-has-permi="['smallsteps:child:edit']" type="success" plain :disabled="single" icon="Edit" @click="handleUpdate()">
                  修改
                </el-button>
              </el-col>
              <el-col :span="1.5">
                <el-button v-has-permi="['smallsteps:child:remove']" type="danger" plain :disabled="multiple" icon="Delete" @click="handleDelete()">
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
                      <el-dropdown-item v-if="checkPermi(['smallsteps:child:export'])" icon="Download" @click="handleExport">导出数据</el-dropdown-item>
                    </el-dropdown-menu>
                  </template>
                </el-dropdown>
              </el-col>
              <right-toolbar v-model:show-search="showSearch" :columns="columns" :search="true" @query-table="getList"></right-toolbar>
            </el-row>
          </template>

          <el-table v-loading="loading" border :data="childList" @selection-change="handleSelectionChange">
            <el-table-column type="selection" width="50" align="center" />
            <el-table-column v-if="columns[0].visible" key="childId" label="儿童ID" align="center" prop="childId" />
            <el-table-column v-if="columns[1].visible" key="nickname" label="儿童昵称" align="center" prop="nickname" :show-overflow-tooltip="true" />
            <el-table-column v-if="columns[2].visible" key="parentId" label="家长ID" align="center" prop="parentId" />
            <el-table-column v-if="columns[3].visible" key="gender" label="性别" align="center">
              <template #default="scope">
                <span>{{ scope.row.gender === '0' ? '男' : '女' }}</span>
              </template>
            </el-table-column>
            <el-table-column v-if="columns[4].visible" key="age" label="年龄" align="center" prop="age" />
            <el-table-column v-if="columns[5].visible" key="birthday" label="生日" align="center" prop="birthday" />
            <el-table-column v-if="columns[6].visible" label="创建时间" align="center" prop="createdAt" width="160">
              <template #default="scope">
                <span>{{ scope.row.createdAt }}</span>
              </template>
            </el-table-column>

            <el-table-column label="操作" fixed="right" width="180" class-name="small-padding fixed-width">
              <template #default="scope">
                <el-tooltip content="修改" placement="top">
                  <el-button v-hasPermi="['smallsteps:child:edit']" link type="primary" icon="Edit" @click="handleUpdate(scope.row)"></el-button>
                </el-tooltip>
                <el-tooltip content="删除" placement="top">
                  <el-button v-hasPermi="['smallsteps:child:remove']" link type="primary" icon="Delete" @click="handleDelete(scope.row)"></el-button>
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

    <!-- 添加或修改儿童对话框 -->
    <el-dialog ref="formDialogRef" v-model="dialog.visible" :title="dialog.title" width="600px" append-to-body @close="closeDialog">
      <el-form ref="childFormRef" :model="form" :rules="rules" label-width="80px">
        <el-row>
          <el-col :span="12">
            <el-form-item label="儿童姓名" prop="childName">
              <el-input v-model="form.childName" placeholder="请输入儿童姓名" maxlength="30" />
            </el-form-item>
          </el-col>
          <el-col :span="12">
            <el-form-item label="家长ID" prop="parentId">
              <el-input v-model="form.parentId" placeholder="请输入家长ID" />
            </el-form-item>
          </el-col>
        </el-row>
        <el-row>
          <el-col :span="12">
            <el-form-item label="性别">
              <el-select v-model="form.gender" placeholder="请选择">
                <el-option label="男" value="0"></el-option>
                <el-option label="女" value="1"></el-option>
              </el-select>
            </el-form-item>
          </el-col>
          <el-col :span="12">
            <el-form-item label="年龄">
              <el-input v-model="form.age" type="number" placeholder="请输入年龄" />
            </el-form-item>
          </el-col>
        </el-row>
        <el-row>
          <el-col :span="12">
            <el-form-item label="生日">
              <el-date-picker v-model="form.birthday" type="date" placeholder="请选择生日" />
            </el-form-item>
          </el-col>
          <el-col :span="12">
            <el-form-item label="头像">
              <el-input v-model="form.avatar" placeholder="请输入头像URL" />
            </el-form-item>
          </el-col>
        </el-row>
        <el-row>
          <el-col :span="12">
            <el-form-item label="昵称">
              <el-input v-model="form.nickname" placeholder="请输入昵称" />
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

<script setup name="Child" lang="ts">
import { listChild, getChild, addChild, updateChild, delChild, exportChild } from '@/api/smallsteps/child';
import { Child } from '@/api/smallsteps/types';
import { checkPermi } from '@/utils/permission';

const router = useRouter();
const { proxy } = getCurrentInstance() as ComponentInternalInstance;
const childList = ref<Child[]>();
const loading = ref(true);
const showSearch = ref(true);
const ids = ref<Array<number | string>>([]);
const single = ref(true);
const multiple = ref(true);
const total = ref(0);
// 列显隐信息
const columns = ref<FieldOption[]>([
  { key: 0, label: `儿童ID`, visible: true, children: [] },
  { key: 1, label: `儿童昵称`, visible: true, children: [] },
  { key: 2, label: `家长ID`, visible: true, children: [] },
  { key: 3, label: `性别`, visible: true, children: [] },
  { key: 4, label: `年龄`, visible: true, children: [] },
  { key: 5, label: `生日`, visible: true, children: [] },
  { key: 6, label: `创建时间`, visible: true, children: [] }
]);

const queryFormRef = ref<ElFormInstance>();
const childFormRef = ref<ElFormInstance>();
const formDialogRef = ref<ElDialogInstance>();

const dialog = reactive<DialogOption>({
  visible: false,
  title: ''
});

const initFormData: Child = {
  childId: 0,
  parentId: 0,
  childName: '',
  gender: '0',
  age: 0,
  birthday: '',
  avatar: '',
  nickname: '',
  createdAt: '',
  updatedAt: ''
};

const initData = {
  form: { ...initFormData },
  queryParams: {
    pageNum: 1,
    pageSize: 10,
    childName: '',
    parentId: '',
    gender: ''
  },
  rules: {
    childName: [{ required: true, message: '儿童姓名不能为空', trigger: 'blur' }],
    parentId: [{ required: true, message: '家长ID不能为空', trigger: 'blur' }]
  }
};
const data = reactive(initData);

const { queryParams, form, rules } = toRefs(data);

/** 查询儿童列表 */
const getList = async () => {
  loading.value = true;
  const res = await listChild(queryParams.value);
  loading.value = false;
  childList.value = res.rows;
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
const handleDelete = async (row?: Child) => {
  const childIds = row?.childId || ids.value;
  const [err] = await to(proxy?.$modal.confirm('是否确认删除儿童编号为"' + childIds + '"的数据项？') as any);
  if (!err) {
    await delChild(childIds as number);
    await getList();
    proxy?.$modal.msgSuccess('删除成功');
  }
};

/** 选择条数  */
const handleSelectionChange = (selection: Child[]) => {
  ids.value = selection.map((item) => item.childId);
  single.value = selection.length != 1;
  multiple.value = !selection.length;
};

/** 导出按钮操作 */
const handleExport = () => {
  proxy?.download(
    'smallsteps/child/export',
    {
      ...queryParams.value
    },
    `child_${new Date().getTime()}.xlsx`
  );
};

/** 重置操作表单 */
const reset = () => {
  form.value = { ...initFormData };
  childFormRef.value?.resetFields();
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
  dialog.title = '新增儿童';
};

/** 修改按钮操作 */
const handleUpdate = async (row?: Child) => {
  reset();
  const childId = row?.childId || ids.value[0];
  const res = await getChild(childId as number);
  dialog.visible = true;
  dialog.title = '修改儿童';
  Object.assign(form.value, res);
};

/** 提交按钮 */
const submitForm = () => {
  childFormRef.value?.validate(async (valid: boolean) => {
    if (valid) {
      if (form.value.childId && form.value.childId !== 0) {
        await updateChild(form.value);
      } else {
        await addChild(form.value);
      }
      proxy?.$modal.msgSuccess('操作成功');
      dialog.visible = false;
      await getList();
    }
  });
};

/**
 * 关闭儿童弹窗
 */
const closeDialog = () => {
  dialog.visible = false;
  reset();
};
onMounted(() => {
  getList(); // 初始化列表数据
});
</script>

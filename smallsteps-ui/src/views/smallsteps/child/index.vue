<template>
  <div class="app-container">
    <el-form :model="queryParams" ref="queryRef" :inline="true" v-show="showSearch" label-width="68px">
      <el-form-item label="姓名" prop="nickname">
        <el-input
          v-model="queryParams.nickname"
          placeholder="请输入儿童姓名"
          clearable
          @keyup.enter="handleQuery"
        />
      </el-form-item>
      <el-form-item label="家庭" prop="parentId">
        <el-tree-select
          v-model="queryParams.parentId"
          :data="deptOptions"
          :props="{ value: 'deptId', label: 'deptName', children: 'children' }"
          value-key="deptId"
          placeholder="请选择家庭"
          check-strictly
        />
      </el-form-item>
      <el-form-item label="性别" prop="gender">
        <el-select v-model="queryParams.gender" placeholder="儿童性别" clearable>
          <el-option label="男" value="0" />
          <el-option label="女" value="1" />
          <el-option label="未知" value="2" />
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
          v-hasPermi="['ss:child:add']"
        >新增</el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button
          type="success"
          plain
          icon="Edit"
          :disabled="single"
          @click="handleUpdate"
          v-hasPermi="['ss:child:edit']"
        >修改</el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button
          type="danger"
          plain
          icon="Delete"
          :disabled="multiple"
          @click="handleDelete"
          v-hasPermi="['ss:child:remove']"
        >删除</el-button>
      </el-col>
      <right-toolbar v-model:showSearch="showSearch" @queryTable="getList"></right-toolbar>
    </el-row>

    <el-table v-loading="loading" :data="childList" @selection-change="handleSelectionChange">
      <el-table-column type="selection" width="55" align="center" />
      <el-table-column label="儿童ID" align="center" prop="id" />
      <el-table-column label="姓名" align="center" prop="nickname" />
      <el-table-column label="出生日期" align="center" prop="birthday" width="180">
        <template #default="scope">
          <span>{{ parseTime(scope.row.birthday, '{y}-{m}-{d}') }}</span>
        </template>
      </el-table-column>
      <el-table-column label="性别" align="center" prop="gender">
        <template #default="scope">
          <dict-tag :options="ss_child_sex" :value="scope.row.gender" />
        </template>
      </el-table-column>
      <el-table-column label="状态" align="center" prop="status">
        <template #default="scope">
          <dict-tag :options="sys_normal_disable" :value="scope.row.status" />
        </template>
      </el-table-column>
      <el-table-column label="备注" align="center" prop="remark" :show-overflow-tooltip="true" />
      <el-table-column label="操作" align="center" class-name="small-padding fixed-width">
        <template #default="scope">
          <el-button link type="primary" icon="Edit" @click="handleUpdate(scope.row)" v-hasPermi="['ss:child:edit']">修改</el-button>
          <el-button link type="primary" icon="Delete" @click="handleDelete(scope.row)" v-hasPermi="['ss:child:remove']">删除</el-button>
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

    <!-- 添加或修改儿童信息对话框 -->
    <el-dialog :title="title" v-model="open" width="500px" append-to-body>
      <el-form ref="childRef" :model="form" :rules="rules" label-width="80px">
        <el-form-item label="家庭" prop="parentId">
          <el-tree-select
            v-model="form.parentId"
            :data="deptOptions"
            :props="{ value: 'deptId', label: 'deptName', children: 'children' }"
            value-key="deptId"
            placeholder="请选择家庭"
            check-strictly
          />
        </el-form-item>
        <el-form-item label="姓名" prop="nickname">
          <el-input v-model="form.nickname" placeholder="请输入儿童姓名" />
        </el-form-item>
        <el-form-item label="出生日期" prop="birthday">
          <el-date-picker clearable
            v-model="form.birthday"
            type="date"
            value-format="YYYY-MM-DD"
            placeholder="请选择出生日期">
          </el-date-picker>
        </el-form-item>
        <el-form-item label="性别" prop="gender">
          <el-radio-group v-model="form.gender">
            <el-radio label="0">男</el-radio>
            <el-radio label="1">女</el-radio>
            <el-radio label="2">未知</el-radio>
          </el-radio-group>
        </el-form-item>
        <el-form-item label="状态" prop="status">
          <el-radio-group v-model="form.status">
            <el-radio
              v-for="dict in sys_normal_disable"
              :key="dict.value"
              :label="dict.value"
            >{{ dict.label }}</el-radio>
          </el-radio-group>
        </el-form-item>
        <el-form-item label="备注" prop="remark">
          <el-input v-model="form.remark" type="textarea" placeholder="请输入内容" />
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

<script setup name="Child">
import { listChild, getChild, delChild, addChild, updateChild } from "@/api/smallsteps/child";
import { listDept } from "@/api/system/dept";

const { proxy } = getCurrentInstance();
const { sys_normal_disable } = proxy.useDict("sys_normal_disable");

// 表单 ref（替代 proxy.resetForm，避免全局属性未注册问题）
const childRef = ref(null);
const queryRef = ref(null);

// 自定义性别字典，如果系统没有，可以在此处mock或在后台配置
const ss_child_sex = ref([
  { label: "男", value: "0", elTagType: "primary" },
  { label: "女", value: "1", elTagType: "danger" },
  { label: "未知", value: "2", elTagType: "info" }
]);

const childList = ref([]);
const open = ref(false);
const loading = ref(true);
const showSearch = ref(true);
const ids = ref([]);
const single = ref(true);
const multiple = ref(true);
const total = ref(0);
const title = ref("");
const deptOptions = ref([]);

const data = reactive({
  form: {},
  queryParams: {
    pageNum: 1,
    pageSize: 10,
    nickname: null,
    parentId: null,
    gender: null,
    status: null,
  },
  rules: {
    parentId: [{ required: true, message: "家庭不能为空", trigger: "blur" }],
    nickname: [{ required: true, message: "姓名不能为空", trigger: "blur" }],
  }
});

const { queryParams, form, rules } = toRefs(data);

/** 查询儿童信息列表 */
function getList() {
  loading.value = true;
  listChild(queryParams.value).then(response => {
    childList.value = response.rows || response.data; // 兼容不同返回格式
    total.value = response.total || (response.data ? response.data.length : 0);
    loading.value = false;
  });
}

/** 查询部门下拉树结构 */
function getTreeSelect() {
  listDept().then(response => {
    deptOptions.value = proxy.handleTree(response.data, "deptId");
  });
};

// 取消按钮
function cancel() {
  open.value = false;
  reset();
}

// 表单重置
function reset() {
  form.value = {
    id: null,
    parentId: null,
    nickname: null,
    birthday: null,
    gender: "0",
    avatar: null,
    status: "0",
    delFlag: null,
    createBy: null,
    createTime: null,
    updateBy: null,
    updateTime: null,
    remark: null
  };
  childRef.value?.resetFields();
}

/** 搜索按钮操作 */
function handleQuery() {
  queryParams.value.pageNum = 1;
  getList();
}

/** 重置按钮操作 */
function resetQuery() {
  queryRef.value?.resetFields();
  handleQuery();
}

// 多选框选中数据
function handleSelectionChange(selection) {
  ids.value = selection.map(item => item.id);
  single.value = selection.length != 1;
  multiple.value = !selection.length;
}

/** 新增按钮操作 */
function handleAdd() {
  reset();
  getTreeSelect();
  open.value = true;
  title.value = "添加儿童信息";
}

/** 修改按钮操作 */
function handleUpdate(row) {
  reset();
  getTreeSelect();
  const childId = row.id || ids.value;
  getChild(childId).then(response => {
    form.value = response.data;
    open.value = true;
    title.value = "修改儿童信息";
  });
}

/** 提交按钮 */
function submitForm() {
  childRef.value.validate(valid => {
    if (valid) {
      if (form.value.id != null) {
        updateChild(form.value).then(response => {
          proxy.$modal.msgSuccess("修改成功");
          open.value = false;
          getList();
        });
      } else {
        addChild(form.value).then(response => {
          proxy.$modal.msgSuccess("新增成功");
          open.value = false;
          getList();
        });
      }
    }
  });
}

/** 删除按钮操作 */
function handleDelete(row) {
  const childIds = row.id || ids.value;
  proxy.$modal.confirm('是否确认删除儿童信息编号为"' + childIds + '"的数据项？').then(function() {
    return delChild(childIds);
  }).then(() => {
    getList();
    proxy.$modal.msgSuccess("删除成功");
  }).catch(() => {});
}

getList();
getTreeSelect();
</script>

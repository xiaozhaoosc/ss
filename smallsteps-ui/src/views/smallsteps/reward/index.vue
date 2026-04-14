<template>
  <div class="p-2">
    <el-card shadow="hover">
      <template #header>
        <el-row :gutter="10">
          <el-col :span="1.5">
            <el-button v-has-permi="['parent:reward:add']" type="primary" plain icon="Plus" @click="handleAdd">新增奖励</el-button>
          </el-col>
          <right-toolbar v-model:show-search="showSearch" @query-table="getList"></right-toolbar>
        </el-row>
      </template>

      <el-table v-loading="loading" :data="rewardList">
        <el-table-column label="奖励编号" align="center" prop="rewardId" />
        <el-table-column label="奖励名称" align="center" prop="name" />
        <el-table-column label="所需积分" align="center" prop="pointsRequired">
          <template #default="scope">
            <el-tag type="warning">{{ scope.row.pointsRequired }} pts</el-tag>
          </template>
        </el-table-column>
        <el-table-column label="库存" align="center" prop="stock">
          <template #default="scope">
            {{ scope.row.stock === -1 ? '无限' : scope.row.stock }}
          </template>
        </el-table-column>
        <el-table-column label="状态" align="center" prop="status">
          <template #default="scope">
            <el-switch
              v-model="scope.row.status"
              active-value="0"
              inactive-value="1"
              @change="handleStatusChange(scope.row)"
            />
          </template>
        </el-table-column>
        <el-table-column label="操作" align="center" width="150">
          <template #default="scope">
            <el-button v-has-permi="['parent:reward:edit']" link type="primary" icon="Edit" @click="handleUpdate(scope.row)">修改</el-button>
            <el-button v-has-permi="['parent:reward:remove']" link type="primary" icon="Delete" @click="handleDelete(scope.row)">删除</el-button>
          </template>
        </el-table-column>
      </el-table>
    </el-card>

    <!-- 对话框 -->
    <el-dialog v-model="open" :title="title" width="500px" append-to-body>
      <el-form ref="rewardFormRef" :model="form" :rules="rules" label-width="100px">
        <el-form-item label="奖励名称" prop="name">
          <el-input v-model="form.name" placeholder="请输入奖励名称" />
        </el-form-item>
        <el-form-item label="所需积分" prop="pointsRequired">
          <el-input-number v-model="form.pointsRequired" :min="1" />
        </el-form-item>
        <el-form-item label="库存数量" prop="stock">
          <el-input-number v-model="form.stock" :min="-1" />
          <div class="help-block">-1 代表无限量</div>
        </el-form-item>
        <el-form-item label="奖励图标" prop="icon">
          <el-input v-model="form.icon" placeholder="请输入图标代码" />
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

<script setup name="ParentReward" lang="ts">
import { listReward, getReward, deleteReward, addReward, updateReward } from "@/api/smallsteps/reward";

const { proxy } = getCurrentInstance() as ComponentInternalInstance;

const rewardFormRef = ref<ElFormInstance>();

const rewardList = ref<any[]>([]);
const open = ref(false);
const loading = ref(true);
const showSearch = ref(true);
const title = ref("");

const data = reactive<any>({
  form: {},
  rules: {
    name: [{ required: true, message: "奖励名称不能为空", trigger: "blur" }],
    pointsRequired: [{ required: true, message: "所需积分不能为空", trigger: "blur" }]
  }
});

const { form, rules } = toRefs(data);

function getList() {
  loading.value = true;
  listReward({}).then((response: any) => {
    rewardList.value = response.rows;
    loading.value = false;
  });
}

function reset() {
  form.value = {
    rewardId: undefined,
    name: undefined,
    pointsRequired: 100,
    stock: -1,
    icon: undefined,
    status: "0"
  };
  rewardFormRef.value?.resetFields();
}

function handleAdd() {
  reset();
  open.value = true;
  title.value = "添加奖励项";
}

function handleUpdate(row: any) {
  reset();
  getReward(row.rewardId).then(response => {
    form.value = response.data;
    open.value = true;
    title.value = "修改奖励项";
  });
}

function submitForm() {
  rewardFormRef.value?.validate((valid: boolean) => {
    if (valid) {
      if (form.value.rewardId != undefined) {
        updateReward(form.value).then(() => {
          proxy?.$modal.msgSuccess("修改成功");
          open.value = false;
          getList();
        });
      } else {
        addReward(form.value).then(() => {
          proxy?.$modal.msgSuccess("新增成功");
          open.value = false;
          getList();
        });
      }
    }
  });
}

function handleStatusChange(row: any) {
  updateReward(row).then(() => {
    proxy?.$modal.msgSuccess("状态更新成功");
  });
}

function handleDelete(row: any) {
  proxy?.$modal.confirm('确认删除奖励"' + row.name + '"吗？').then(function() {
    return deleteReward(row.rewardId);
  }).then(() => {
    getList();
    proxy?.$modal.msgSuccess("删除成功");
  });
}

function cancel() {
  open.value = false;
  reset();
}

getList();
</script>

<template>
  <div class="p-2">
    <!-- 检索面板 -->
    <el-card shadow="hover" class="mb-2">
      <el-form :model="queryParams" ref="queryFormRef" :inline="true">
        <el-form-item label="反馈状态" prop="status">
          <el-select v-model="queryParams.status" placeholder="选择状态" clearable style="width: 160px">
            <el-option label="未处理" value="0" />
            <el-option label="已处理" value="1" />
          </el-select>
        </el-form-item>
        <el-form-item label="反馈内容" prop="content">
          <el-input
            v-model="queryParams.content"
            placeholder="搜索反馈内容"
            clearable
            style="width: 200px"
            @keyup.enter="handleQuery"
          />
        </el-form-item>
        <el-form-item>
          <el-button type="primary" icon="Search" @click="handleQuery">搜索</el-button>
          <el-button icon="Refresh" @click="resetQuery">重置</el-button>
        </el-form-item>
      </el-form>
    </el-card>

    <!-- 数据表格 -->
    <el-card shadow="hover">
      <template #header>
        <div class="card-header">
          <span>用户意见与反馈列表</span>
          <right-toolbar v-model:show-search="showSearch" @query-table="getList"></right-toolbar>
        </div>
      </template>

      <el-table v-loading="loading" :data="feedbackList">
        <el-table-column label="反馈编号" align="center" prop="feedbackId" width="100" />
        
        <el-table-column label="反馈用户" align="center" width="180">
          <template #default="scope">
            <div class="user-info">
              <el-avatar 
                :size="32" 
                :src="getUserAvatar(scope.row.userAvatar)" 
                class="mr-2"
              />
              <span class="user-nickname">{{ scope.row.userNickName || scope.row.createBy || '匿名家长' }}</span>
            </div>
          </template>
        </el-table-column>
        
        <el-table-column label="反馈内容" align="left" prop="content" :show-overflow-tooltip="true" />
        
        <el-table-column label="附带图片" align="center" width="220">
          <template #default="scope">
            <div v-if="scope.row.imgUrls" class="image-gallery">
              <el-image
                v-for="(img, idx) in splitImages(scope.row.imgUrls)"
                :key="idx"
                :src="img"
                :preview-src-list="[img]"
                preview-teleported
                fit="cover"
                class="gallery-thumb"
              />
            </div>
            <span v-else class="text-muted">无图片</span>
          </template>
        </el-table-column>
        
        <el-table-column label="反馈状态" align="center" prop="status" width="120">
          <template #default="scope">
            <el-tag v-if="scope.row.status === '0'" type="danger" effect="light">未处理</el-tag>
            <el-tag v-else type="success" effect="light">已处理</el-tag>
          </template>
        </el-table-column>

        <el-table-column label="处理备注" align="center" prop="remark" :show-overflow-tooltip="true" />

        <el-table-column label="提交时间" align="center" prop="createTime" width="180" />

        <el-table-column label="操作" align="center" width="120" fixed="right">
          <template #default="scope">
            <el-button 
              v-if="scope.row.status === '0'"
              v-has-permi="['smallsteps:feedback:edit']" 
              link 
              type="primary" 
              icon="Check" 
              @click="handleProcess(scope.row)"
            >
              标记处理
            </el-button>
            <span v-else class="text-completed">已归档</span>
          </template>
        </el-table-column>
      </el-table>
    </el-card>

    <!-- 反馈意见处理弹窗 -->
    <el-dialog v-model="open" title="意见反馈处理确认" width="500px" append-to-body>
      <el-form ref="feedbackFormRef" :model="form" :rules="rules" label-width="80px">
        <el-form-item label="反馈内容">
          <div class="feedback-preview">{{ currentContent }}</div>
        </el-form-item>
        <el-form-item label="处理备注" prop="remark">
          <el-input 
            v-model="form.remark" 
            type="textarea" 
            :rows="3" 
            placeholder="请输入针对该意见的处理备注或客服回复..." 
          />
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

<script setup name="SystemFeedback" lang="ts">
import { ref, reactive, getCurrentInstance } from 'vue'
import type { ComponentInternalInstance } from 'vue'
import { ElForm, ElMessage } from 'element-plus'
import { listFeedback, processFeedback } from '@/api/smallsteps/feedback'

const { proxy } = getCurrentInstance() as ComponentInternalInstance;
const queryFormRef = ref<InstanceType<typeof ElForm>>();
const feedbackFormRef = ref<InstanceType<typeof ElForm>>();

const loading = ref(false);
const showSearch = ref(true);
const feedbackList = ref<any[]>([]);
const open = ref(false);
const currentContent = ref('');

const queryParams = reactive({
  status: undefined,
  content: undefined
});

const form = ref({
  feedbackId: undefined as number | undefined,
  remark: ''
});

const rules = reactive({
  remark: [
    { required: true, message: '请输入处理备注', trigger: 'blur' }
  ]
});

// 获取反馈列表
async function getList() {
  loading.value = true;
  try {
    const res: any = await listFeedback(queryParams);
    feedbackList.value = res.rows || [];
  } catch (e) {
    console.error(e);
  } finally {
    loading.value = false;
  }
}

// 搜索查询
function handleQuery() {
  getList();
}

// 重置查询
function resetQuery() {
  queryParams.status = undefined;
  queryParams.content = undefined;
  getList();
}

// 弹出处理对话框
function handleProcess(row: any) {
  form.value.feedbackId = row.feedbackId;
  form.value.remark = '';
  currentContent.value = row.content;
  open.value = true;
}

// 关闭对话框
function cancel() {
  open.value = false;
}

// 提交处理
function submitForm() {
  feedbackFormRef.value?.validate(async (valid) => {
    if (valid) {
      try {
        await processFeedback(form.value);
        ElMessage.success("反馈处理成功");
        open.value = false;
        getList();
      } catch (e) {
        console.error(e);
      }
    }
  });
}

// 切分多图
function splitImages(urls: string): string[] {
  if (!urls) return [];
  return urls.split(',').filter(u => u.trim() !== '');
}

// 获取真实头像地址
function getUserAvatar(avatar: string): string {
  if (avatar) {
    return avatar.startsWith('http') ? avatar : (import.meta.env.VITE_APP_BASE_API + avatar);
  }
  return 'https://cube.elemecdn.com/3/7c/3ea6beec64369c2642b92c6726f1epng.png';
}

getList();
</script>

<style lang="scss" scoped>
.card-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  font-weight: bold;
}

.user-info {
  display: flex;
  align-items: center;
  justify-content: center;
  
  .user-nickname {
    font-size: 14px;
    color: #303133;
    font-weight: 500;
  }
}

.image-gallery {
  display: flex;
  justify-content: center;
  gap: 6px;
  flex-wrap: wrap;
}

.gallery-thumb {
  width: 40px;
  height: 40px;
  border-radius: 6px;
  border: 1px solid #e4e7ed;
  cursor: pointer;
  transition: transform 0.2s ease;
  
  &:hover {
    transform: scale(1.08);
  }
}

.feedback-preview {
  background-color: #f5f7fa;
  padding: 8px 12px;
  border-radius: 8px;
  border-left: 4px solid #6C9BD2;
  color: #606266;
  font-size: 13px;
  line-height: 1.6;
  max-height: 120px;
  overflow-y: auto;
  word-break: break-all;
}

.text-muted {
  color: #c0c4cc;
  font-size: 13px;
}

.text-completed {
  color: #67c23a;
  font-size: 13px;
  font-weight: 500;
}
</style>

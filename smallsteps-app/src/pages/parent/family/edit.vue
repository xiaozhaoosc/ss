<template>
  <view class="edit-page">
    <top-bar title="编辑档案" back-btn />
    
    <view class="content" v-if="!loading">
      <!-- Avatar Section -->
      <view class="avatar-section" @click="handleChangeAvatar">
        <view class="avatar-wrapper">
          <image 
            class="avatar" 
            :src="form.avatarUrl || 'https://lh3.googleusercontent.com/aida-public/AB6AXuAJ1cciJ4i8VZa4i84tUg3c73WgpXsHDPWFJTFC1HCyoJaWAw63sCD6sYtGoggTmCxZPkFLdgXZ0jMVUEjuhNaybs-1a06VWI-j7Tv_k-GcxylNpE1U9cjTL6ICQBnyg02gLWhSCCy1SnHe6psYMG-13HPVdTV9vR6odzmSIWG_6kD9m5MrzeKyalS3Ewhx_px4_a3iAVFvHE4SYxL6Z13ZA7UVC9fVC7U29WKKz0G9msv4O4zW9MUm2t6NZ6FOtcNY4-8SHhP3MgM'" 
            mode="aspectFill" 
          />
          <view class="camera-btn">
            <text class="material-symbols-outlined">photo_camera</text>
          </view>
        </view>
        <text class="avatar-tip">点击更换头像</text>
      </view>

      <!-- Form Section -->
      <view class="form-card">
        <view class="form-item">
          <text class="label">孩子昵称</text>
          <input 
            v-model="form.nickname" 
            class="input" 
            placeholder="请输入昵称" 
          />
        </view>

        <view class="form-item">
          <text class="label">性别</text>
          <view class="gender-selector">
            <view 
              class="gender-option" 
              :class="{ active: form.gender === '0' }" 
              @click="form.gender = '0'"
            >
              <text class="material-symbols-outlined">male</text>
              <text>男孩</text>
            </view>
            <view 
              class="gender-option" 
              :class="{ active: form.gender === '1' }" 
              @click="form.gender = '1'"
            >
              <text class="material-symbols-outlined">female</text>
              <text>女孩</text>
            </view>
          </view>
        </view>

        <view class="form-item">
          <text class="label">出生日期</text>
          <picker mode="date" :value="form.birthday" @change="handleDateChange">
            <view class="picker-box">
              <text :class="{ 'placeholder': !form.birthday }">
                {{ form.birthday || '请选择日期' }}
              </text>
              <text class="material-symbols-outlined arrow">chevron_right</text>
            </view>
          </picker>
        </view>

        <view class="form-item no-border">
          <text class="label">孩子状况 / 备注</text>
          <textarea 
            v-model="form.remark" 
            class="textarea" 
            placeholder="例如：ADHD 注意力不集中，喜欢恐龙..." 
            auto-height
          />
        </view>
      </view>

      <view class="action-section">
        <button class="save-btn" :loading="saving" @click="handleSave">
          保存修改
        </button>
        <button class="delete-btn" @click="handleDelete">
          删除档案
        </button>
      </view>
    </view>

    <!-- Skeleton/Loading -->
    <view class="loading-state" v-else>
      <text class="loading-text">加载中...</text>
    </view>
  </view>
</template>

<script setup>
import { ref, onMounted } from 'vue'
import TopBar from '@/components/common/top-bar/top-bar.vue'
import { getChild, updateChild } from '@/api/child'

const id = ref('')
const loading = ref(true)
const saving = ref(false)

const form = ref({
  id: '',
  nickname: '',
  gender: '0',
  birthday: '',
  avatarUrl: '',
  remark: ''
})

const fetchDetail = async () => {
  loading.value = true
  try {
    const res = await getChild(id.value)
    if (res.code === 200) {
      form.value = {
        ...res.data,
        gender: String(res.data.gender || '0')
      }
    }
  } catch (e) {
    console.error('Fetch child detail failed:', e)
  } finally {
    loading.value = false
  }
}

const handleDateChange = (e) => {
  form.value.birthday = e.detail.value
}

const handleChangeAvatar = () => {
  uni.chooseImage({
    count: 1,
    success: (res) => {
      // 模拟上传逻辑
      uni.showLoading({ title: '正在上传...' })
      setTimeout(() => {
        form.value.avatarUrl = res.tempFilePaths[0]
        uni.hideLoading()
      }, 1000)
    }
  })
}

const handleSave = async () => {
  if (!form.value.nickname) {
    return uni.showToast({ title: '请输入昵称', icon: 'none' })
  }
  
  saving.value = true
  try {
    const res = await updateChild(form.value)
    if (res.code === 200 || res.code === '200') {
      uni.showToast({ title: '保存成功', icon: 'success' })
      setTimeout(() => {
        uni.navigateBack()
      }, 1500)
    }
  } catch (e) {
    console.error('[Page Debug] Update failed details:', e)
    if (!e?._isBusinessError) {
      const errorMsg = e?.msg || e?.message || (typeof e === 'string' ? e : '保存失败')
      uni.showToast({ title: errorMsg, icon: 'none' })
    }
  } finally {
    saving.value = false
  }
}

const handleDelete = () => {
  uni.showModal({
    title: '危险操作',
    content: '确定要删除此档案吗？此操作不可恢复。',
    confirmColor: '#ef4444',
    success: (res) => {
      if (res.confirm) {
        uni.showToast({ title: '演示环境，暂不支持删除', icon: 'none' })
      }
    }
  })
}

onMounted(() => {
  // 获取 URL 参数
  const pages = getCurrentPages()
  const currentPage = pages[pages.length - 1]
  id.value = currentPage.options?.id
  if (id.value) {
    fetchDetail()
  } else {
    loading.value = false
  }
})
</script>

<style lang="scss" scoped>
.edit-page {
  min-height: 100vh;
  background-color: #f8fafc;
}

.content {
  padding: 24px;
  padding-top: 100px;
}

.avatar-section {
  display: flex;
  flex-direction: column;
  align-items: center;
  margin-bottom: 32px;
}

.avatar-wrapper {
  position: relative;
  width: 100px;
  height: 100px;
  margin-bottom: 12px;
}

.avatar {
  width: 100%;
  height: 100%;
  border-radius: 50%;
  border: 4px solid #ffffff;
  box-shadow: 0 4px 12px rgba(0, 0, 0, 0.08);
}

.camera-btn {
  position: absolute;
  right: 0;
  bottom: 0;
  width: 32px;
  height: 32px;
  background-color: #6C9BD2;
  border-radius: 50%;
  display: flex;
  align-items: center;
  justify-content: center;
  color: #ffffff;
  border: 2px solid #ffffff;
  
  .material-symbols-outlined {
    font-size: 18px;
  }
}

.avatar-tip {
  font-size: 13px;
  color: #6b7280;
}

.form-card {
  background-color: #ffffff;
  border-radius: 20px;
  padding: 8px 20px;
  box-shadow: 0 4px 12px rgba(0, 0, 0, 0.02);
  margin-bottom: 32px;
}

.form-item {
  padding: 20px 0;
  border-bottom: 1px solid #f1f5f9;
  
  &.no-border { border-bottom: none; }
}

.label {
  display: block;
  font-size: 14px;
  font-weight: 600;
  color: #1e293b;
  margin-bottom: 12px;
}

.input {
  width: 100%;
  font-size: 16px;
  color: #334155;
}

.gender-selector {
  display: flex;
  gap: 16px;
}

.gender-option {
  flex: 1;
  height: 48px;
  display: flex;
  align-items: center;
  justify-content: center;
  gap: 8px;
  background-color: #f8fafc;
  border: 1px solid #e2e8f0;
  border-radius: 12px;
  color: #64748b;
  font-size: 14px;
  transition: all 0.2s;
  
  .material-symbols-outlined { font-size: 20px; }
  
  &.active {
    background-color: rgba(108, 155, 210, 0.1);
    border-color: #6C9BD2;
    color: #6C9BD2;
    font-weight: 600;
  }
}

.picker-box {
  display: flex;
  align-items: center;
  justify-content: space-between;
  
  text { font-size: 16px; color: #334155; }
  .placeholder { color: #94a3b8; }
  .arrow { color: #94a3b8; font-size: 20px; }
}

.textarea {
  width: 100%;
  min-height: 80px;
  font-size: 15px;
  color: #334155;
  line-height: 1.6;
}

.action-section {
  display: flex;
  flex-direction: column;
  gap: 16px;
}

.save-btn {
  width: 100%;
  height: 54px;
  background-color: #6C9BD2;
  color: #ffffff;
  font-weight: 700;
  border-radius: 16px;
  display: flex;
  align-items: center;
  justify-content: center;
  box-shadow: 0 8px 16px rgba(108, 155, 210, 0.25);
  border: none;
  &::after { border: none; }
}

.delete-btn {
  width: 100%;
  height: 54px;
  background-color: transparent;
  color: #ef4444;
  font-size: 14px;
  display: flex;
  align-items: center;
  justify-content: center;
  border: none;
  &::after { border: none; }
}

.loading-state {
  height: 100vh;
  display: flex;
  align-items: center;
  justify-content: center;
}

.loading-text { color: #94a3b8; font-size: 14px; }
</style>

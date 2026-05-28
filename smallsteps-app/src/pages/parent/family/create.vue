<template>
  <view class="create-child-page">
    <top-bar title="创建孩子档案" back-btn />
    
    <view class="content" v-if="!loading">
      <!-- Header Info -->
      <view class="header-info">
        <view class="header-title-row">
          <text class="title">创建新档案</text>
          <text class="bind-link" @click="handleToBind">绑定已有账号</text>
        </view>
        <text class="subtitle">为您的孩子创建一个专属账号</text>
      </view>

      <!-- Form Card -->
      <view class="form-card">
        <!-- Username -->
        <view class="form-item">
          <text class="label">孩子账号</text>
          <view class="input-box">
            <text class="material-symbols-outlined icon">person</text>
            <input 
              v-model="form.username" 
              class="input" 
              placeholder="设置孩子的登录账号" 
              placeholder-style="color: #9ca3af"
            />
          </view>
          <text class="tip-text">建议使用孩子的名字拼音或昵称</text>
        </view>

        <!-- Password -->
        <view class="form-item">
          <text class="label">初始密码</text>
          <view class="input-box">
            <text class="material-symbols-outlined icon">lock</text>
            <input 
              v-model="form.password" 
              type="password"
              class="input" 
              placeholder="设置登录密码" 
              placeholder-style="color: #9ca3af"
            />
          </view>
          <text class="tip-text">请妥善保管并告知孩子</text>
        </view>

        <!-- Nickname -->
        <view class="form-item">
          <text class="label">孩子昵称</text>
          <view class="input-box">
            <text class="material-symbols-outlined icon">baby</text>
            <input 
              v-model="form.nickname" 
              class="input" 
              placeholder="孩子的昵称或小名" 
              placeholder-style="color: #9ca3af"
            />
          </view>
        </view>

        <!-- Gender -->
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

        <!-- Birthday -->
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

        <!-- Remark -->
        <view class="form-item no-border">
          <text class="label">备注（选填）</text>
          <textarea 
            v-model="form.remark" 
            class="textarea" 
            placeholder="例如：ADHD 注意力不集中，喜欢恐龙..." 
            placeholder-style="color: #9ca3af"
            auto-height
          />
        </view>
      </view>

      <!-- Preview Section -->
      <view class="preview-card">
        <text class="preview-title">创建后孩子将获得</text>
        <view class="preview-items">
          <view class="preview-item">
            <text class="material-symbols-outlined">gamepad</text>
            <text class="preview-text">专属游戏化任务体验</text>
          </view>
          <view class="preview-item">
            <text class="material-symbols-outlined">gift</text>
            <text class="preview-text">可兑换奖励商店物品</text>
          </view>
          <view class="preview-item">
            <text class="material-symbols-outlined">trending_up</text>
            <text class="preview-text">个人成长数据追踪</text>
          </view>
        </view>
      </view>

      <button 
        class="create-btn" 
        :loading="creating" 
        :disabled="!canSubmit"
        @click="handleCreate"
      >
        创建账号
      </button>
    </view>

    <!-- Loading State -->
    <view class="loading-state" v-else>
      <text class="loading-text">加载中...</text>
    </view>
  </view>
</template>

<script setup>
import { ref, computed } from 'vue'
import TopBar from '@/components/common/top-bar/top-bar.vue'
import { createChild } from '@/api/child'

const loading = ref(false)
const creating = ref(false)

const form = ref({
  username: '',
  password: '',
  nickname: '',
  gender: '0',
  birthday: '',
  remark: ''
})

const canSubmit = computed(() => {
  return form.value.username && form.value.password && form.value.nickname
})

const handleDateChange = (e) => {
  form.value.birthday = e.detail.value
}

const handleCreate = async () => {
  if (!form.value.username) {
    return uni.showToast({ title: '请输入账号', icon: 'none' })
  }
  if (!form.value.password) {
    return uni.showToast({ title: '请输入密码', icon: 'none' })
  }
  if (form.value.password.length < 6) {
    return uni.showToast({ title: '密码至少6位', icon: 'none' })
  }
  if (!form.value.nickname) {
    return uni.showToast({ title: '请输入昵称', icon: 'none' })
  }

  creating.value = true
  try {
    const res = await createChild(form.value)
    if (res.code === 200 || res.code === '200') {
      uni.showModal({
        title: '创建成功',
        content: `孩子账号 "${form.value.username}" 创建成功！请记住密码并告知孩子。`,
        showCancel: false,
        confirmText: '好的',
        success: () => {
          uni.navigateBack()
        }
      })
    } else {
      uni.showToast({ title: res.msg || '创建失败', icon: 'none' })
    }
  } catch (e) {
    console.error('[Page Debug] Create child failed:', e)
    if (!e?._isBusinessError) {
      const errorMsg = e?.msg || e?.message || (typeof e === 'string' ? e : '创建失败')
      uni.showToast({ title: errorMsg, icon: 'none' })
    }
  } finally {
    creating.value = false
  }
}

const handleToBind = () => {
  uni.navigateTo({ url: '/pages/parent/family/bind' })
}
</script>

<style lang="scss" scoped>
.create-child-page {
  min-height: 100vh;
  background-color: #f8fafc;
}

.content {
  padding: 24px;
  padding-top: 100px;
}

.header-info {
  margin-bottom: 32px;
  
  .header-title-row {
    display: flex;
    justify-content: space-between;
    align-items: flex-end;
    margin-bottom: 8px;
  }
  
  .title {
    font-size: 24px;
    font-weight: 700;
    color: #111827;
  }
  
  .bind-link {
    font-size: 14px;
    color: #6C9BD2;
    font-weight: 600;
    text-decoration: underline;
  }
  
  .subtitle {
    font-size: 14px;
    color: #6b7280;
  }
}

.form-card {
  background-color: #ffffff;
  border-radius: 20px;
  padding: 8px 20px;
  box-shadow: 0 4px 12px rgba(0, 0, 0, 0.02);
  margin-bottom: 24px;
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

.input-box {
  display: flex;
  align-items: center;
  gap: 12px;
  padding: 14px 16px;
  background-color: #f8fafc;
  border-radius: 12px;
  border: 1px solid #e2e8f0;
  transition: border-color 0.2s;
  
  &:focus-within {
    border-color: #6C9BD2;
    background-color: #ffffff;
  }
}

.icon {
  color: #9ca3af;
  font-size: 20px;
}

.input {
  flex: 1;
  font-size: 16px;
  color: #334155;
}

.tip-text {
  display: block;
  font-size: 12px;
  color: #9ca3af;
  margin-top: 8px;
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
  padding: 14px 16px;
  background-color: #f8fafc;
  border-radius: 12px;
  
  text { font-size: 16px; color: #334155; }
  .placeholder { color: #9ca3af; }
  .arrow { color: #9ca3af; font-size: 20px; }
}

.textarea {
  width: 100%;
  min-height: 80px;
  padding: 14px 16px;
  background-color: #f8fafc;
  border-radius: 12px;
  font-size: 15px;
  color: #334155;
  line-height: 1.6;
}

.preview-card {
  background: linear-gradient(135deg, rgba(108, 155, 210, 0.08) 0%, rgba(140, 208, 161, 0.08) 100%);
  border-radius: 20px;
  padding: 24px;
  margin-bottom: 40px;
}

.preview-title {
  display: block;
  font-size: 14px;
  font-weight: 600;
  color: #374151;
  margin-bottom: 16px;
}

.preview-items {
  display: flex;
  flex-wrap: wrap;
  gap: 12px;
}

.preview-item {
  display: flex;
  align-items: center;
  gap: 8px;
  padding: 10px 16px;
  background-color: #ffffff;
  border-radius: 20px;
  
  .material-symbols-outlined {
    font-size: 18px;
    color: #6C9BD2;
  }
  
  .preview-text {
    font-size: 13px;
    color: #4b5563;
  }
}

.create-btn {
  width: 100%;
  height: 54px;
  background: linear-gradient(135deg, #6C9BD2 0%, #5A8AC2 100%);
  color: #ffffff;
  font-weight: 700;
  border-radius: 16px;
  display: flex;
  align-items: center;
  justify-content: center;
  box-shadow: 0 8px 20px rgba(108, 155, 210, 0.3);
  border: none;
  
  &::after { border: none; }
  
  &:disabled {
    background: #d1d5db;
    box-shadow: none;
  }
}

.loading-state {
  height: 100vh;
  display: flex;
  align-items: center;
  justify-content: center;
}

.loading-text { color: #94a3b8; font-size: 14px; }
</style>
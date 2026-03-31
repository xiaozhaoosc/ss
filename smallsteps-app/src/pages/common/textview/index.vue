<template>
  <view>
    <uni-card class="view-title" :title="title">
      <text class="uni-body view-content">{{ content }}</text>
    </uni-card>
  </view>
</template>

<script>
  import { userAgreement, privacyPolicy } from '@/utils/agreements'

  export default {
    data() {
      return {
        title: '',
        content: ''
      }
    },
    onLoad(options) {
      this.title = options.title || ''
      
      // Support passing direct content or a key for local storage
      if (options.key) {
        if (options.key === 'userAgreement') {
          this.content = userAgreement
          this.title = this.title || '用户协议'
        } else if (options.key === 'privacyPolicy') {
          this.content = privacyPolicy
          this.title = this.title || '隐私政策'
        }
      } else {
        this.content = options.content || ''
      }
      
      uni.setNavigationBarTitle({
        title: this.title
      })
    }
  }
</script>

<style scoped>
  page {
    background-color: #ffffff;
  }

  .view-title {
    font-weight: bold;
  }

  .view-content {
    font-size: 26rpx;
    padding: 12px 5px 0;
    color: #333;
    line-height: 24px;
    font-weight: normal;
  }
</style>

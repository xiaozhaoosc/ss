<script setup>
  import config from './config'
  import { getToken } from '@/utils/auth'
  import { useConfigStore } from '@/store'
  import { useUserStore } from '@/store/modules/user'
  import { getCurrentInstance } from "vue"
  import { onLaunch } from '@dcloudio/uni-app'

  const { proxy } = getCurrentInstance()
  const userStore = useUserStore()

  onLaunch(() => {
    initApp()
  })

  // 初始化应用
  function initApp() {
    // 初始化应用配置
    initConfig()
    
    // 强制隐藏原生 TabBar (针对 H5 模式下自定义 TabBar 的冲突)
    //#ifdef H5
    uni.hideTabBar()
    //#endif

    // 检查用户登录状态
    //#ifdef H5
    checkLogin()
    //#endif
  }

  function initConfig() {
    useConfigStore().setConfig(config)
  }

  async function checkLogin() {
    if (!getToken()) {
      uni.reLaunch({ url: '/pages/login/index' })
    } else {
      // 如果有 token 但没有用户信息，说明是刷新页面，需要重新获取
      userStore.restoreFromStorage()
      if (!userStore.userInfo) {
        try {
          await userStore.getUserInfo()
        } catch (e) {
          console.error('恢复用户信息失败:', e)
        }
      }
    }
  }
</script>

<style lang="scss">
  @import '@/static/scss/index.scss';
</style>

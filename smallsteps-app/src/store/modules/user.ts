import { defineStore } from 'pinia'
import { login, getInfo } from '@/api/login'
import { getScore } from '@/api/reward'
import { getToken, setToken, removeToken, getClientId, setClientId, removeClientId } from '@/utils/auth'

interface UserState {
  userInfo: any
  token: string | null
  clientId: string | null
  role: 'parent' | 'child'
  balance: number
}

export const useUserStore = defineStore('user', {
  state: (): UserState => ({
    userInfo: null,
    token: null,
    clientId: null,
    role: 'parent',
    balance: 0
  }),

  getters: {
    isLoggedIn: (state): boolean => !!state.token,
    isParent: (state): boolean => state.role === 'parent',
    isChild: (state): boolean => state.role === 'child'
  },

  actions: {
    setUserInfo(userInfo: any) {
      this.userInfo = userInfo
    },

    updateToken(token: string) {
      this.token = token
      setToken(token)
    },

    updateClientId(clientId: string) {
      this.clientId = clientId
      setClientId(clientId)
    },

    updateRole(role: 'parent' | 'child') {
      this.role = role
      uni.setStorageSync('role', role)
    },

    login(loginData: any) {
      return new Promise<void>((resolve, reject) => {
        login(loginData).then(async (res: any) => {
          const data = res.data
          this.updateToken(data.access_token)
          this.updateClientId(loginData.clientId)
          
          // 登录成功后立即获取用户信息
          try {
            await this.getUserInfo()
            resolve()
          } catch (e) {
            reject(e)
          }
        }).catch((error: any) => {
          reject(error)
        })
      })
    },

    getUserInfo() {
      return new Promise<void>((resolve, reject) => {
        getInfo().then((res: any) => {
          const data = res.data
          this.setUserInfo(data)
          
          // 确定角色类型 (优先基于 user_type: 3-儿童, 2-家长)
          const userType = data.user?.userType
          const roles = data.roles || []
          
          if (userType === '3' || userType === 3 || roles.includes('child')) {
            this.updateRole('child')
          } else {
            this.updateRole('parent')
          }
          resolve()
        }).catch((error: any) => {
          reject(error)
        })
      })
    },

    logOut() {
      this.userInfo = null
      this.token = null
      this.clientId = null
      removeToken()
      removeClientId()
      uni.removeStorageSync('role')
    },

    restoreFromStorage() {
      const token = getToken()
      const clientId = getClientId()
      const role = uni.getStorageSync('role')
      if (token) this.token = token
      if (clientId) this.clientId = clientId
      if (role) this.role = role as 'parent' | 'child'
    },

    async fetchBalance() {
      if (this.userInfo && this.userInfo.user) {
        try {
          const res: any = await getScore(this.userInfo.user.userId)
          if (res.data) {
            this.balance = res.data.balance || 0
          }
        } catch (e) {
          console.error('Fetch balance failed', e)
        }
      }
    }
  }
})

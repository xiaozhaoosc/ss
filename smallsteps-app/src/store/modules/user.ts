import { defineStore } from 'pinia'
import { login, getInfo } from '@/api/login'
import { getScore } from '@/api/reward'
import { getTotalStars } from '@/api/child'
import { getToken, setToken, removeToken, getClientId, setClientId, removeClientId } from '@/utils/auth'

interface UserState {
  userInfo: any
  token: string | null
  clientId: string | null
  role: 'parent' | 'child'
  balance: number
  currentChildId: number | null
}

export const useUserStore = defineStore('user', {
  state: (): UserState => ({
    userInfo: null,
    token: null,
    clientId: null,
    role: 'parent',
    balance: 0,
    currentChildId: null
  }),

  getters: {
    isLoggedIn: (state): boolean => !!state.token,
    isParent: (state): boolean => state.role === 'parent',
    isChild: (state): boolean => state.role === 'child',
    userId: (state): number | string | null => state.userInfo?.user?.userId || null,
    id: (state): number | string | null => state.userInfo?.user?.userId || null
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

    setCurrentChildId(id: number | null) {
      this.currentChildId = id
      if (id) {
        uni.setStorageSync('currentChildId', id)
      } else {
        uni.removeStorageSync('currentChildId')
      }
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
          
          // 确定角色类型 (1-家长, 2-儿童)
          const userType = String(data.user?.userType)
          const roles = data.roles || []
          
          if (userType === '2' || roles.includes('child')) {
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
      return new Promise<void>((resolve) => {
        this.userInfo = null
        this.token = null
        this.clientId = null
        removeToken()
        removeClientId()
        uni.removeStorageSync('role')
        resolve()
      })
    },

    logout() {
      return this.logOut();
    },

    restoreFromStorage() {
      const token = getToken()
      const clientId = getClientId()
      const role = uni.getStorageSync('role')
      if (token) this.token = token
      if (clientId) this.clientId = clientId
      if (role) this.role = role as 'parent' | 'child'
      
      const currentChildId = uni.getStorageSync('currentChildId')
      if (currentChildId) this.currentChildId = Number(currentChildId)
    },

    async fetchBalance() {
      if (this.userInfo && this.userInfo.user) {
        try {
          const userId = this.userInfo.user.userId
          let res: any
          if (this.role === 'child') {
            res = await getTotalStars(userId)
          } else {
            res = await getScore(userId)
          }
          
          if (res.data) {
            // Check for different response structures
            this.balance = res.data.balance !== undefined ? res.data.balance : (res.data.totalStars !== undefined ? res.data.totalStars : (typeof res.data === 'number' ? res.data : 0))
          }
        } catch (e) {
          console.error('Fetch balance failed', e)
        }
      }
    }
  }
})

import { useUserStore } from '@/store/modules/user'

// Base URL configuration
// In H5 dev, we often use proxy. In App, we need full URL.
// Since we are migrating to H5 first, we can use '/dev-api' which matches proxy.
// For production or App, this should be configurable.
const BASE_URL = import.meta.env.VITE_APP_BASE_API || '/dev-api'

const request = (options: any) => {
    return new Promise((resolve, reject) => {
        const userStore = useUserStore()

        // Headers processing
        const header = {
            'Content-Type': 'application/json;charset=utf-8',
            ...options.header
        }

        // Token injection
        if (userStore.token) {
            header['Authorization'] = 'Bearer ' + userStore.token
            header['clientid'] = import.meta.env.VITE_APP_CLIENT_ID || 'e5cd7e4891bf95d1d19206ce24a7b32e' // Default RuoYi Client ID
        }

        uni.request({
            url: BASE_URL + options.url,
            method: options.method || 'GET',
            data: options.data,
            header: header,
            success: (res: any) => {
                const code = res.data.code || 200
                const msg = res.data.msg || '系统未知错误，请反馈给管理员'

                // Success
                if (code === 200) {
                    resolve(res.data)
                }
                // Token expired / Invalid
                else if (code === 401) {
                    uni.showToast({ title: '登录状态已过期，请重新登录', icon: 'none' })
                    userStore.logout()
                    setTimeout(() => {
                        uni.reLaunch({ url: '/pages/login/index' })
                    }, 1500)
                    reject('Invalid Token')
                }
                // Other errors
                else {
                    uni.showToast({ title: msg, icon: 'none' })
                    reject(res.data)
                }
            },
            fail: (err) => {
                console.error('Network Error:', err)
                uni.showToast({ title: '网络请求失败', icon: 'none' })
                reject(err)
            }
        })
    })
}

export default request

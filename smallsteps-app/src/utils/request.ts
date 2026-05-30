import config from '@/config'
import { useUserStore } from '@/store/modules/user'
import errorCode from '@/utils/errorCode'
import { toast, showConfirm, tansParams } from '@/utils/common'
import { encryptRequest } from '@/utils/crypto'
import { getToken, getClientId } from '@/utils/auth' // 引入 Auth 工具

// 从 config.js 获取基础路径
const baseUrl = config.baseUrl

/**
 * Small Steps 统一请求工具 (TypeScript 版)
 * 修复：对齐 App-Token 存储 Key
 */
const request = (options: any): Promise<any> => {
    return new Promise((resolve, reject) => {
        const userStore = useUserStore()

        // 1. 设置默认 Header
        const header: any = {
            'Content-Type': 'application/json;charset=utf-8',
            ...options.header
        }

        // 2. Token 与 ClientId 注入 (修复点：使用 getToken 保证 Key 对齐)
        const token = getToken() || userStore.token
        if (token && !(options.header && options.header.isToken === false)) {
            header['Authorization'] = 'Bearer ' + token
        }
        
        // 自动注入 clientid (优先使用存储中的)
        const storageClientId = getClientId() || userStore.clientId
        header['clientid'] = storageClientId || import.meta.env.VITE_APP_CLIENT_ID || 'e5cd7e4891bf95d1d19206ce24a7b32e'

        // 3. 处理加密请求 (API 级别加密)
        if (options.encrypt && options.data) {
            const { encryptedData, encryptedKey } = encryptRequest(options.data)
            header['encrypt-key'] = encryptedKey
            options.data = encryptedData
        }

        // 4. 处理 GET 参数序列化
        let url = (options.baseUrl || baseUrl) + options.url
        
        // 移除多余的连续斜杠（如 /prod-api//system/... -> /prod-api/system/...），保留协议部分的双斜杠
        if (url.includes('://')) {
            const protocolIndex = url.indexOf('://') + 3
            url = url.substring(0, protocolIndex) + url.substring(protocolIndex).replace(/\/+/g, '/')
        } else {
            url = url.replace(/\/+/g, '/')
        }

        if (options.params) {
            url += (url.indexOf('?') === -1 ? '?' : '&') + tansParams(options.params)
            url = url.slice(0, -1)
        }

        // 5. [诊断] 打印请求日志
        console.log(`%c[SS_API_TRACE] 🚀 Request: ${options.method || 'GET'} ${url}`, 'color: #3b82f6; font-weight: bold; background: #eff6ff; padding: 2px 4px;')

        uni.request({
            url: url,
            method: options.method || 'GET',
            data: options.data,
            header: header,
            timeout: options.timeout || 120000,
            success: (res: any) => {
                const { statusCode, data: rawData } = res
                
                let data = rawData
                // 核心诊断：处理后端返回的“混杂字符串”（如 "500 {JSON}"）
                if (typeof data === 'string') {
                    const jsonMatch = data.match(/\{[\s\S]*\}/)
                    if (jsonMatch) {
                        try { data = JSON.parse(jsonMatch[0]) } catch (e) {
                            console.warn('[SS_API_TRACE] JSON Parse failed', e)
                        }
                    }
                }

                data = data || {}
                const code = data.code || statusCode
                const msg = data.msg || data.message || (errorCode as any)[code] || (statusCode === 200 ? '' : `服务器异常(${statusCode})`)

                // 200: 业务成功
                if (code === 200 || code === '200') {
                    resolve(data)
                    return
                }

                // 401: 登录失效
                if (code === 401) {
                    userStore.logOut()
                    showConfirm('登录状态已过期，请重新登录').then((confirmRes: any) => {
                        if (confirmRes.confirm) uni.reLaunch({ url: '/pages/login/index' })
                    })
                    reject({ code, msg, _isBusinessError: true })
                    return
                }

                // 错误处理：对于 500 或长消息，使用 Modal 强提醒（防截断）
                console.error(`%c[SS_API_TRACE] ❌ Business Error [${code}]: ${msg}`, 'color: #ef4444; font-weight: bold;')
                if (statusCode === 500 || (msg && msg.length > 15)) {
                    uni.showModal({
                        title: '系统提示',
                        content: msg || '系统操作失败',
                        showCancel: false,
                        confirmText: '知道了'
                    })
                } else {
                    uni.showToast({ title: msg || '操作失败', icon: 'none', duration: 2000 })
                }
                
                reject({ code, msg, _isBusinessError: true })
            },
            fail: (err) => {
                console.error(`%c[SS_API_TRACE] 📡 Network Fail:`, 'color: #f59e0b;', err)
                uni.showToast({ title: '网络连接失败', icon: 'none' })
                reject({ code: -1, msg: '网络异常', detail: err })
            }
        })
    })
}

export default request

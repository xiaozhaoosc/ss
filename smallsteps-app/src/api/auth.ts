import request from '@/utils/request'

export interface LoginBody {
    clientId?: string
    grantType?: string
    tenantId?: string
    code?: string
    uuid?: string
    // If user/pass login is supported (RuoYi often uses username/password in body too for 'password' grant type)
    username?: string
    password?: string
}

export interface LoginVo {
    access_token: string
    token_type: string
    expires_in: number
    client_id: string
    openid?: string
}

export interface UserInfo {
    user: any
    roles: string[]
    permissions: string[]
}

// Login
export function login(data: LoginBody) {
    const params = {
        clientId: '428a8310cd442757ae699df5d894f051', // App clientId
        grantType: 'password', // Default
        ...data
    }
    return request({
        url: '/auth/login',
        method: 'POST',
        data: params,
        encrypt: true  // 启用加密
    })
}

// Logout
export function logout() {
    return request({
        url: '/auth/logout',
        method: 'POST'
    })
}

// Get Captcha Image
export function getCodeImg() {
    return request({
        url: '/auth/code',
        method: 'GET',
        timeout: 20000
    })
}

// Get User Info (Typical RuoYi endpoint, need to verify if AuthController has it or SystemUserController)
// AuthController doesn't seem to have getUserInfo. RuoYi-Vue-Plus usually has /system/user/getInfo
export function getInfo() {
    return request({
        url: '/system/user/getInfo',
        method: 'GET'
    })
}

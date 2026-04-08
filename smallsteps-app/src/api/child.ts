import request from '@/utils/request'

export interface ChildTask {
    taskId?: number
    userId?: number
    title?: string
    description?: string
    status?: string
    rewardPoints?: number
    voiceFeedback?: string
    lightEffect?: string
}

export interface ChildAchievement {
    achievementId?: number
    userId?: number
    achievementName?: string
    description?: string
    shardCount?: number
    starCount?: number
    status?: string
    obtainTime?: string
    rewardInfo?: string
}

export interface ChildAI {
    responseText?: string
    voiceResponse?: string
    emotionResult?: string
    suggestion?: string
    sceneType?: string
    timestamp?: string
}

// 儿童任务执行相关 API

// NFC 刷卡签到
export function nfcSignin(nfcId: string, taskId: number) {
    return request({
        url: '/child/task/nfc/signin',
        method: 'POST',
        params: { nfcId, taskId }
    })
}

// 更新任务状态
export function updateTaskStatus(data: { taskId: number; status: string; userId?: number }) {
    return request({
        url: '/child/task/status',
        method: 'PUT',
        data: data
    })
}

// 获取任务列表
export function getChildTaskList(userId: number) {
    return request({
        url: '/child/task/list',
        method: 'GET',
        params: { userId }
    })
}

// 获取任务详情
export function getChildTask(taskId: number) {
    return request({
        url: `/child/task/${taskId}`,
        method: 'GET'
    })
}

// 儿童成就系统相关 API

// 收集勇气碎片
export function collectCourageShard(userId: number, shardCount: number) {
    return request({
        url: '/child/achievement/collect',
        method: 'POST',
        params: { userId, shardCount }
    })
}

// 查询星星余额
export function getStarsBalance(userId: number) {
    return request({
        url: '/child/achievement/stars',
        method: 'GET',
        params: { userId }
    })
}

// 兑换奖励
export function exchangeReward(data: { userId: number; starCount: number; rewardId?: number; rewardName: string }) {
    return request({
        url: '/child/achievement/exchange',
        method: 'POST',
        data: data
    })
}

// 查询成就列表
export function getAchievementList(userId: number) {
    return request({
        url: '/child/achievement/list',
        method: 'GET',
        params: { userId }
    })
}

// 获取成就详情
export function getAchievement(achievementId: number) {
    return request({
        url: `/child/achievement/${achievementId}`,
        method: 'GET'
    })
}

// 儿童 AI 伴侣相关 API

// 语音互动
export function chatWithAI(data: { userId: number; textInput: string; sceneType?: string }) {
    return request({
        url: '/child/ai/chat',
        method: 'POST',
        data: data
    })
}

// 情绪识别
export function recognizeEmotion(data: { userId: number; emotionState: string; sceneType?: string }) {
    return request({
        url: '/child/ai/emotion',
        method: 'POST',
        data: data
    })
}

// 个性化建议
export function getAISuggestion(userId: number) {
    return request({
        url: '/child/ai/suggestion',
        method: 'GET',
        params: { userId }
    })
}

// 家长成长观察相关 API

// 获取情绪日报
export function getEmotionDaily(userId: number, date: string) {
    return request({
        url: '/parent/growth/emotion/daily',
        method: 'GET',
        params: { userId, date }
    })
}

// 获取能力雷达图
export function getAbilityRadar(userId: number, period: string) {
    return request({
        url: '/parent/growth/ability/radar',
        method: 'GET',
        params: { userId, period }
    })
}

// 获取成长轨迹
export function getGrowthTrack(userId: number, startDate: string, endDate: string) {
    return request({
        url: '/parent/growth/track',
        method: 'GET',
        params: { userId, startDate, endDate }
    })
}

// 记录情绪状态
export function recordEmotion(data: { userId: number; date: string; emotionState: string; emotionScore: number; observation?: string }) {
    return request({
        url: '/parent/growth/emotion/record',
        method: 'POST',
        data: data
    })
}

// 家长辅助工具相关 API

// 获取情绪急救包配置
export function getEmotionFirstAid(userId: number) {
    return request({
        url: '/parent/tool/emotion/first-aid',
        method: 'GET',
        params: { userId }
    })
}

// 更新情绪急救包配置
export function updateEmotionFirstAid(data: { userId: number; firstAidConfig: string }) {
    return request({
        url: '/parent/tool/emotion/first-aid',
        method: 'PUT',
        data: data
    })
}

// 获取家长指南
export function getParentGuide(type: string) {
    return request({
        url: '/parent/tool/guide',
        method: 'GET',
        params: { type }
    })
}

// 获取亲子契约模板
export function getContractTemplate() {
    return request({
        url: '/parent/tool/contract/template',
        method: 'GET'
    })
}

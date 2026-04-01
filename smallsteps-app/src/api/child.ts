import request from '@/utils/request'

export interface ChildTask {
    taskId?: number
    childId?: number
    taskName?: string
    description?: string
    status?: string
    difficulty?: number
    rewardStars?: number
    startTime?: string
    endTime?: string
    completeTime?: string
}

export interface ChildAchievement {
    achievementId?: number
    childId?: number
    achievementName?: string
    description?: string
    type?: string
    quantity?: number
    obtainTime?: string
}

export interface ChildAI {
    aiId?: number
    childId?: number
    userInput?: string
    aiResponse?: string
    interactionTime?: string
    emotionType?: string
}

// 儿童任务相关API
export function listChildTask(childTask: ChildTask) {
    return request({
        url: '/child/task/list',
        method: 'GET',
        params: childTask
    })
}

export function getChildTask(taskId: number) {
    return request({
        url: '/child/task/info/' + taskId,
        method: 'GET'
    })
}

export function addChildTask(data: ChildTask) {
    return request({
        url: '/child/task/add',
        method: 'POST',
        data: data
    })
}

export function updateChildTask(data: ChildTask) {
    return request({
        url: '/child/task/edit',
        method: 'PUT',
        data: data
    })
}

export function deleteChildTask(taskId: number) {
    return request({
        url: '/child/task/remove/' + taskId,
        method: 'DELETE'
    })
}

export function deleteChildTaskBatch(taskIds: number[]) {
    return request({
        url: '/child/task/remove/batch',
        method: 'DELETE',
        data: taskIds
    })
}

export function startTask(taskId: number, childId: number) {
    return request({
        url: '/child/task/start',
        method: 'POST',
        params: { taskId, childId }
    })
}

export function completeTask(taskId: number, childId: number) {
    return request({
        url: '/child/task/complete',
        method: 'POST',
        params: { taskId, childId }
    })
}

export function failTask(taskId: number, childId: number) {
    return request({
        url: '/child/task/fail',
        method: 'POST',
        params: { taskId, childId }
    })
}

export function getPendingTasks(childId: number) {
    return request({
        url: '/child/task/pending/' + childId,
        method: 'GET'
    })
}

export function getCurrentTask(childId: number) {
    return request({
        url: '/child/task/current/' + childId,
        method: 'GET'
    })
}

export function nfcCheckIn(nfcId: string, childId: number) {
    return request({
        url: '/child/task/nfc/checkin',
        method: 'POST',
        params: { nfcId, childId }
    })
}

// 儿童成就相关API
export function listChildAchievement(childId: number) {
    return request({
        url: '/child/achievement/list',
        method: 'GET',
        params: { childId }
    })
}

export function getChildAchievement(achievementId: number) {
    return request({
        url: '/child/achievement/info/' + achievementId,
        method: 'GET'
    })
}

export function rewardStars(childId: number, stars: number) {
    return request({
        url: '/child/achievement/reward/stars',
        method: 'POST',
        params: { childId, stars }
    })
}

export function rewardCourageFragments(childId: number, fragments: number) {
    return request({
        url: '/child/achievement/reward/courage',
        method: 'POST',
        params: { childId, fragments }
    })
}

export function exchangeReward(childId: number, rewardId: number) {
    return request({
        url: '/child/achievement/exchange',
        method: 'POST',
        params: { childId, rewardId }
    })
}

export function getAchievementStats(childId: number) {
    return request({
        url: '/child/achievement/stats/' + childId,
        method: 'GET'
    })
}

export function getTotalStars(childId: number) {
    return request({
        url: '/child/achievement/stars/' + childId,
        method: 'GET'
    })
}

export function getTotalCourageFragments(childId: number) {
    return request({
        url: '/child/achievement/courage/' + childId,
        method: 'GET'
    })
}

// 儿童AI相关API
export function chatWithAI(childId: number, userInput: string) {
    return request({
        url: '/child/ai/chat',
        method: 'POST',
        params: { childId, userInput }
    })
}

export function getRecentInteractions(childId: number, limit: number = 10) {
    return request({
        url: '/child/ai/recent',
        method: 'GET',
        params: { childId, limit }
    })
}

export function getEmotionTrend(childId: number, days: number = 7) {
    return request({
        url: '/child/ai/emotion/trend',
        method: 'GET',
        params: { childId, days }
    })
}

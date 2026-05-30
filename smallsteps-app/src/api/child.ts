import request from '@/utils/request'
import config from '@/config'

export const getBaseUrl = () => config.baseUrl

export interface ChildTask {
    taskId?: number | string
    childId?: number | string
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

export function getChildTask(taskId: number | string) {
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

export function deleteChildTask(taskId: number | string) {
    return request({
        url: '/child/task/remove/' + taskId,
        method: 'DELETE'
    })
}

export function deleteChildTaskBatch(taskIds: (number | string)[]) {
    return request({
        url: '/child/task/remove/batch',
        method: 'DELETE',
        data: taskIds
    })
}

export function startTask(taskId: number | string, childId: number | string) {
    return request({
        url: '/child/task/start',
        method: 'POST',
        params: { taskId, childId }
    })
}

export function completeTask(taskId: number | string, childId: number | string, proof?: string) {
    return request({
        url: '/child/task/complete',
        method: 'POST',
        data: { taskId, childId, proof }
    })
}

export function failTask(taskId: number | string, childId: number | string) {
    return request({
        url: '/child/task/fail',
        method: 'POST',
        params: { taskId, childId }
    })
}

export function getPendingTasks(childId: number | string) {
    return request({
        url: '/child/task/pending/' + childId,
        method: 'GET'
    })
}

export function getCurrentTask(childId: number | string) {
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

export function getStreak(childId: number) {
    return request({
        url: '/child/achievement/streak/' + childId,
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
        url: '/child/ai/emotion/trend/' + childId,
        method: 'GET',
        params: { days }
    })
}

export function getAbilityRadar(childId: number | string) {
    return request({
        url: `/parent/insight/ability/radar/${childId}`,
        method: 'GET'
    })
}

export function getShadowEmotionTrend(childId: number | string, days: number = 7) {
    return request({
        url: `/parent/insight/emotion/shadow-trend/${childId}`,
        method: 'GET',
        params: { days }
    })
}

// 查询儿童列表
export function listChildren(query: any) {
  return request({
    url: '/ss/child/list',
    method: 'get',
    params: query
  })
}

// 获取儿童详细信息
export function getChild(id: string | number) {
  return request({
    url: '/ss/child/' + id,
    method: 'get'
  })
}

// 修改儿童信息
export function updateChild(data: any) {
  return request({
    url: '/ss/child',
    method: 'put',
    data: data
  })
}

// 家长创建孩子账号
export function createChild(data: any) {
    return request({
        url: '/parent/family/create-child',
        method: 'post',
        data: data
    })
}

// 情绪提交相关API
export function submitEmotion(data: { childId: number, moodLevel: number, moodType: string, description: string }) {
    return request({
        url: '/child/emotion/submit',
        method: 'POST',
        data: data
    })
}

// 删除儿童信息
export function deleteChild(id: string | number) {
    return request({
        url: '/ss/child/' + id,
        method: 'delete'
    })
}

// 获取儿童积分流水（分页）
export function getScoreHistory(childId: string | number, params: { pageNum: number, pageSize: number }) {
    return request({
        url: `/child/task/score/history/${childId}`,
        method: 'GET',
        params
    })
}

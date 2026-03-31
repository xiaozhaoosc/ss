import request from '@/utils/request'

export interface ParentReward {
    rewardId?: number
    userId?: number
    name: string
    pointsRequired?: number
    stock?: number // -1 infinite
    icon?: string
    status?: string // '0' normal
    createTime?: string
    updateTime?: string
}

export interface RewardQuery {
    pageNum?: number
    pageSize?: number
    name?: string
    status?: string
}

// List
export function listReward(query: RewardQuery) {
    return request({
        url: '/parent/reward/list',
        method: 'GET',
        params: query
    })
}

// Get
export function getReward(rewardId: number) {
    return request({
        url: '/parent/reward/' + rewardId,
        method: 'GET'
    })
}

// Add
export function addReward(data: ParentReward) {
    return request({
        url: '/parent/reward',
        method: 'POST',
        data: data
    })
}

// Update
export function updateReward(data: ParentReward) {
    return request({
        url: '/parent/reward',
        method: 'PUT',
        data: data
    })
}

// Delete
export function delReward(rewardIds: number | number[]) {
    return request({
        url: '/parent/reward/' + rewardIds,
        method: 'DELETE'
    })
}

// Redeem
export function redeemReward(data: { rewardId: number, userId: number }) {
    return request({
        url: '/parent/reward/redeem',
        method: 'POST',
        data: data
    })
}

// Get Score
export function getScore(userId: number) {
    return request({
        url: '/parent/reward/score/' + userId,
        method: 'GET'
    })
}

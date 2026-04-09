import request from '@/utils/request'
import { Reward } from '@/api/smallsteps/types'

// 查询奖励列表
export function listReward(query: any) {
  return request({
    url: '/smallsteps/reward/list',
    method: 'get',
    params: query
  })
}

// 查询奖励详细
export function getReward(rewardId: number) {
  return request({
    url: '/smallsteps/reward/' + rewardId,
    method: 'get'
  })
}

// 新增奖励
export function addReward(data: Reward) {
  return request({
    url: '/smallsteps/reward',
    method: 'post',
    data: data
  })
}

// 修改奖励
export function updateReward(data: Reward) {
  return request({
    url: '/smallsteps/reward',
    method: 'put',
    data: data
  })
}

// 删除奖励
export function delReward(rewardId: number) {
  return request({
    url: '/smallsteps/reward/' + rewardId,
    method: 'delete'
  })
}

// 导出奖励
export function exportReward(query: any) {
  return request({
    url: '/smallsteps/reward/export',
    method: 'get',
    params: query
  })
}
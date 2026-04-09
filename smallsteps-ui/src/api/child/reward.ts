import request from '@/utils/request'

// 查询儿童奖励列表
export function listChildReward(query: any) {
  return request({
    url: '/child/reward/list',
    method: 'get',
    params: query
  })
}

// 兑换奖励
export function exchangeReward(rewardId: number) {
  return request({
    url: '/child/reward/exchange/' + rewardId,
    method: 'put'
  })
}

// 查询奖励详情
export function getChildReward(rewardId: number) {
  return request({
    url: '/child/reward/' + rewardId,
    method: 'get'
  })
}
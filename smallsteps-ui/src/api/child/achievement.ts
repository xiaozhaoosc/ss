import request from '@/utils/request'

// 查询儿童成就列表
export function listChildAchievement(query: any) {
  return request({
    url: '/child/achievement/list',
    method: 'get',
    params: query
  })
}

// 查询成就详情
export function getChildAchievement(achievementId: number) {
  return request({
    url: '/child/achievement/' + achievementId,
    method: 'get'
  })
}

// 领取成就
export function claimAchievement(achievementId: number) {
  return request({
    url: '/child/achievement/claim/' + achievementId,
    method: 'put'
  })
}
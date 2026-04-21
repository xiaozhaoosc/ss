import request from '@/utils/request';

// 兑换奖励
export function exchangeReward(childId: string | number, stars: number, rewardName: string) {
  return request({
    url: '/child/achievement/exchange',
    method: 'post',
    params: { childId, stars, rewardName }
  });
}

// 获取成就统计
export function achievementStats(childId: string | number) {
  return request({
    url: '/child/achievement/stats/' + childId,
    method: 'get'
  });
}

// 获取星星总数
export function totalStars(childId: string | number) {
  return request({
    url: '/child/achievement/stars/' + childId,
    method: 'get'
  });
}

// 获取勇气碎片总数
export function totalCourageFragments(childId: string | number) {
  return request({
    url: '/child/achievement/fragments/' + childId,
    method: 'get'
  });
}

// 获取连击天数
export function streak(childId: string | number) {
  return request({
    url: '/child/achievement/streak/' + childId,
    method: 'get'
  });
}

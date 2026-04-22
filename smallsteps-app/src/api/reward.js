import request from '@/utils/request'
export function redeemReward(data) {
  return request({ url: '/child/reward/redeem', method: 'post', data })
}

import request from '@/utils/request';

// 查询奖励管理列表
export function listReward(query: any) {
  return request({
    url: '/parent/reward/list',
    method: 'get',
    params: query
  });
}

// 查询奖励详细
export function getReward(rewardId: string | number) {
  return request({
    url: '/parent/reward/' + rewardId,
    method: 'get'
  });
}

// 新增奖励
export function addReward(data: any) {
  return request({
    url: '/parent/reward',
    method: 'post',
    data: data
  });
}

// 修改奖励
export function updateReward(data: any) {
  return request({
    url: '/parent/reward',
    method: 'put',
    data: data
  });
}

// 删除奖励
export function deleteReward(rewardId: string | number | (string | number)[]) {
  return request({
    url: '/parent/reward/' + rewardId,
    method: 'delete'
  });
}

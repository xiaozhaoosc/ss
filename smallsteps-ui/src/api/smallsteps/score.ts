import request from '@/utils/request';

// 查询积分记录列表
export function listScore(query: any) {
  return request({
    url: '/child/score/list',
    method: 'get',
    params: query
  });
}

// 查询积分详情
export function getScore(scoreId: string | number) {
  return request({
    url: '/child/score/' + scoreId,
    method: 'get'
  });
}

// 获取用户当前积分汇总
export function getUserScore(userId: string | number) {
  return request({
    url: '/child/score/user/' + userId,
    method: 'get'
  });
}

// 手动调整积分
export function adjustScore(data: any) {
  return request({
    url: '/child/score/adjust',
    method: 'post',
    data: data
  });
}

import request from '@/utils/request';

// 查询系统意见反馈列表 (Web 后台使用)
export function listFeedback(query: any) {
  return request({
    url: '/parent/feedback/list',
    method: 'get',
    params: query
  });
}

// 处理意见反馈 (Web 后台使用)
export function processFeedback(data: any) {
  return request({
    url: '/parent/feedback/status',
    method: 'put',
    data: data
  });
}

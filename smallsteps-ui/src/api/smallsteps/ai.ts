import request from '@/utils/request';

// 查询AI交互记录列表
export function listAI(query: any) {
  return request({
    url: '/child/ai/list',
    method: 'get',
    params: query
  });
}

// 获取情绪趋势数据
export function getEmotionTrend(childId: string | number, days: number = 7) {
  return request({
    url: '/child/ai/emotion/trend/' + childId,
    method: 'get',
    params: { days }
  });
}

// 获取最近的对话流
export function getRecentChats(childId: string | number, limit: number = 20) {
  return request({
    url: '/child/ai/recent/' + childId,
    method: 'get',
    params: { limit }
  });
}

// 获取单条交互详情
export function getAIDetail(aiId: string | number) {
  return request({
    url: '/child/ai/info/' + aiId,
    method: 'get'
  });
}

import request from '@/utils/request';

// 查询AI路由策略列表
export function listRoute(query: any) {
  return request({
    url: '/system/ai/route/list',
    method: 'get',
    params: query
  });
}

// 获取AI路由策略详细信息
export function getRoute(sceneKey: string) {
  return request({
    url: '/system/ai/route/' + sceneKey,
    method: 'get'
  });
}

// 新增AI路由策略
export function addRoute(data: any) {
  return request({
    url: '/system/ai/route',
    method: 'post',
    data: data
  });
}

// 修改AI路由策略
export function updateRoute(data: any) {
  return request({
    url: '/system/ai/route',
    method: 'put',
    data: data
  });
}

// 删除AI路由策略
export function delRoute(sceneKey: string | string[]) {
  return request({
    url: '/system/ai/route/' + sceneKey,
    method: 'delete'
  });
}

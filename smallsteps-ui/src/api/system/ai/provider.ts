import request from '@/utils/request';

// 查询AI供应商配置列表
export function listProvider(query: any) {
  return request({
    url: '/system/ai/provider/list',
    method: 'get',
    params: query
  });
}

// 查询AI供应商所有列表 (不分页)
export function listAllProvider() {
  return request({
    url: '/system/ai/provider/list',
    method: 'get'
  });
}

// 获取AI供应商配置详细信息
export function getProvider(id: string | number) {
  return request({
    url: '/system/ai/provider/' + id,
    method: 'get'
  });
}

// 新增AI供应商配置
export function addProvider(data: any) {
  return request({
    url: '/system/ai/provider',
    method: 'post',
    data: data
  });
}

// 修改AI供应商配置
export function updateProvider(data: any) {
  return request({
    url: '/system/ai/provider',
    method: 'put',
    data: data
  });
}

// 删除AI供应商配置
export function delProvider(id: string | number | (string | number)[]) {
  return request({
    url: '/system/ai/provider/' + id,
    method: 'delete'
  });
}

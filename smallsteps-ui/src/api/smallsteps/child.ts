import request from '@/utils/request';

// 查询儿童管理列表
export function listChild(query: any) {
  return request({
    url: '/ss/child/list',
    method: 'get',
    params: query
  });
}

// 查询儿童详细
export function getChild(id: string | number) {
  return request({
    url: '/ss/child/' + id,
    method: 'get'
  });
}

// 新增儿童
export function addChild(data: any) {
  return request({
    url: '/ss/child',
    method: 'post',
    data: data
  });
}

// 修改儿童
export function updateChild(data: any) {
  return request({
    url: '/ss/child',
    method: 'put',
    data: data
  });
}

// 删除儿童
export function delChild(id: string | number | (string | number)[]) {
  return request({
    url: '/ss/child/' + id,
    method: 'delete'
  });
}

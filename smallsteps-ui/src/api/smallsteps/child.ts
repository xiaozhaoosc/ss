import request from '@/utils/request';

// 查询儿童管理列表
export function listChild(query: any) {
  return request({
    url: '/parent/child/list',
    method: 'get',
    params: query
  });
}

// 查询儿童详细
export function getChild(childId: string | number) {
  return request({
    url: '/parent/child/' + childId,
    method: 'get'
  });
}

// 新增儿童
export function addChild(data: any) {
  return request({
    url: '/parent/child',
    method: 'post',
    data: data
  });
}

// 修改儿童
export function updateChild(data: any) {
  return request({
    url: '/parent/child',
    method: 'put',
    data: data
  });
}

// 删除儿童
export function deleteChild(childId: string | number | (string | number)[]) {
  return request({
    url: '/parent/child/' + childId,
    method: 'delete'
  });
}

import request from '@/utils/request'

// 查询儿童信息列表
export function listChild(query) {
  return request({
    url: '/ss/child/list',
    method: 'get',
    params: query
  })
}

// 查询儿童信息详细
export function getChild(childId) {
  return request({
    url: '/ss/child/' + childId,
    method: 'get'
  })
}

// 新增儿童信息
export function addChild(data) {
  return request({
    url: '/ss/child',
    method: 'post',
    data: data
  })
}

// 修改儿童信息
export function updateChild(data) {
  return request({
    url: '/ss/child',
    method: 'put',
    data: data
  })
}

// 删除儿童信息
export function delChild(childId) {
  return request({
    url: '/ss/child/' + childId,
    method: 'delete'
  })
}

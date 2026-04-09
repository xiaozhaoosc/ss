import request from '@/utils/request'
import { Child } from '@/api/smallsteps/types'

// 查询儿童列表
export function listChild(query: any) {
  return request({
    url: '/smallsteps/child/list',
    method: 'get',
    params: query
  })
}

// 查询儿童详细
export function getChild(childId: number) {
  return request({
    url: '/smallsteps/child/' + childId,
    method: 'get'
  })
}

// 新增儿童
export function addChild(data: Child) {
  return request({
    url: '/smallsteps/child',
    method: 'post',
    data: data
  })
}

// 修改儿童
export function updateChild(data: Child) {
  return request({
    url: '/smallsteps/child',
    method: 'put',
    data: data
  })
}

// 删除儿童
export function delChild(childId: number) {
  return request({
    url: '/smallsteps/child/' + childId,
    method: 'delete'
  })
}

// 导出儿童
export function exportChild(query: any) {
  return request({
    url: '/smallsteps/child/export',
    method: 'get',
    params: query
  })
}
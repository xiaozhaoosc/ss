import request from '@/utils/request'
import { Task } from '@/api/smallsteps/types'

// 查询任务列表
export function listTask(query: any) {
  return request({
    url: '/smallsteps/task/list',
    method: 'get',
    params: query
  })
}

// 查询任务详细
export function getTask(taskId: number) {
  return request({
    url: '/smallsteps/task/' + taskId,
    method: 'get'
  })
}

// 新增任务
export function addTask(data: Task) {
  return request({
    url: '/smallsteps/task',
    method: 'post',
    data: data
  })
}

// 修改任务
export function updateTask(data: Task) {
  return request({
    url: '/smallsteps/task',
    method: 'put',
    data: data
  })
}

// 删除任务
export function delTask(taskId: number) {
  return request({
    url: '/smallsteps/task/' + taskId,
    method: 'delete'
  })
}

// 导出任务
export function exportTask(query: any) {
  return request({
    url: '/smallsteps/task/export',
    method: 'get',
    params: query
  })
}
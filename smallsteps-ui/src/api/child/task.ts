import request from '@/utils/request'

// 查询儿童任务列表
export function listChildTask(query: any) {
  return request({
    url: '/child/task/list',
    method: 'get',
    params: query
  })
}

// 查询任务详细
export function getChildTask(taskId: number) {
  return request({
    url: '/child/task/' + taskId,
    method: 'get'
  })
}

// 完成任务
export function completeTask(taskId: number) {
  return request({
    url: '/child/task/complete/' + taskId,
    method: 'put'
  })
}

// 领取任务
export function claimTask(taskId: number) {
  return request({
    url: '/child/task/claim/' + taskId,
    method: 'put'
  })
}
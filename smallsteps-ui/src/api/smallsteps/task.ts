import request from '@/utils/request';

// 查询家长任务发布列表
export function listTask(query: any) {
  return request({
    url: '/parent/task/list',
    method: 'get',
    params: query
  });
}

// 查询家长任务发布详细
export function getTask(taskId: string | number) {
  return request({
    url: '/parent/task/' + taskId,
    method: 'get'
  });
}

// 新增家长任务发布
export function addTask(data: any) {
  return request({
    url: '/parent/task',
    method: 'post',
    data: data
  });
}

// 修改家长任务发布
export function updateTask(data: any) {
  return request({
    url: '/parent/task',
    method: 'put',
    data: data
  });
}

// 删除家长任务发布
export function deleteTask(taskId: string | number | (string | number)[]) {
  return request({
    url: '/parent/task/' + taskId,
    method: 'delete'
  });
}

// 任务拆解 (ADHD 特有逻辑)
export function splitTask(taskId: string | number, subTasks: any[]) {
  return request({
    url: '/parent/task/split/' + taskId,
    method: 'post',
    data: subTasks
  });
}

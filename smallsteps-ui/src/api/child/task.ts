import request from '@/utils/request';

// 查询我的任务列表
export function listMyTask(query: any) {
  return request({
    url: '/child/task/list',
    method: 'get',
    params: query
  });
}

// 开始执行任务 (ADHD 触发硬件反馈)
export function startTask(taskId: string | number) {
  return request({
    url: '/child/task/start',
    method: 'post',
    params: { taskId }
  });
}

// 提交任务证明
export function finishTask(data: any) {
  return request({
    url: '/child/task/finish',
    method: 'post',
    data: data
  });
}

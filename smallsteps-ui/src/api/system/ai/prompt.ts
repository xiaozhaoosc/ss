import request from '@/utils/request';
import { AxiosPromise } from 'axios';

// 查询AI提示词模板列表
export function listPrompt(query: any): AxiosPromise<any> {
  return request({
    url: '/system/ai/prompt/list',
    method: 'get',
    params: query
  });
}

// 查询AI提示词模板详细
export function getPrompt(id: string | number): AxiosPromise<any> {
  return request({
    url: '/system/ai/prompt/' + id,
    method: 'get'
  });
}

// 新增AI提示词模板
export function addPrompt(data: any): AxiosPromise<any> {
  return request({
    url: '/system/ai/prompt',
    method: 'post',
    data: data
  });
}

// 修改AI提示词模板
export function updatePrompt(data: any): AxiosPromise<any> {
  return request({
    url: '/system/ai/prompt',
    method: 'put',
    data: data
  });
}

// 删除AI提示词模板
export function delPrompt(id: string | number | (string | number)[]): AxiosPromise<any> {
  return request({
    url: '/system/ai/prompt/' + id,
    method: 'delete'
  });
}

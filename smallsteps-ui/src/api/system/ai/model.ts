import request from '@/utils/request';
import { AxiosPromise } from 'axios';

// 查询AI模型配置列表
export function listModel(query: any): AxiosPromise<any> {
  return request({
    url: '/system/ai/model/list',
    method: 'get',
    params: query
  });
}

// 查询AI模型配置详细
export function getModel(id: string | number): AxiosPromise<any> {
  return request({
    url: '/system/ai/model/' + id,
    method: 'get'
  });
}

// 新增AI模型配置
export function addModel(data: any): AxiosPromise<any> {
  return request({
    url: '/system/ai/model',
    method: 'post',
    data: data
  });
}

// 修改AI模型配置
export function updateModel(data: any): AxiosPromise<any> {
  return request({
    url: '/system/ai/model',
    method: 'put',
    data: data
  });
}

// 删除AI模型配置
export function delModel(id: string | number | (string | number)[]): AxiosPromise<any> {
  return request({
    url: '/system/ai/model/' + id,
    method: 'delete'
  });
}

import request from '@/utils/request';
import { AxiosPromise } from 'axios';

// 查询AI知识库列表
export function listKnowledge(query: any): AxiosPromise<any> {
  return request({
    url: '/system/ai/knowledge/list',
    method: 'get',
    params: query
  });
}

// 查询AI知识库详细
export function getKnowledge(id: string | number): AxiosPromise<any> {
  return request({
    url: '/system/ai/knowledge/' + id,
    method: 'get'
  });
}

// 新增AI知识库
export function addKnowledge(data: any): AxiosPromise<any> {
  return request({
    url: '/system/ai/knowledge',
    method: 'post',
    data: data
  });
}

// 修改AI知识库
export function updateKnowledge(data: any): AxiosPromise<any> {
  return request({
    url: '/system/ai/knowledge',
    method: 'put',
    data: data
  });
}

// 删除AI知识库
export function delKnowledge(id: string | number | (string | number)[]): AxiosPromise<any> {
  return request({
    url: '/system/ai/knowledge/' + id,
    method: 'delete'
  });
}

// 同步AI知识库到向量库
export function syncKnowledge(id: string | number): AxiosPromise<any> {
  return request({
    url: `/system/ai/knowledge/${id}/sync`,
    method: 'post'
  });
}

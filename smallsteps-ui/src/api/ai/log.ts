import request from '@/utils/request';
import { AxiosPromise } from 'axios';

// 查询AI调用日志列表
export function listLog(query: any): AxiosPromise<any> {
  return request({
    url: '/system/ai/log/list',
    method: 'get',
    params: query
  });
}

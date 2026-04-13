import request from '@/utils/request'

export interface TemplateParams {
  pageNum?: number;
  pageSize?: number;
  category?: string;
}

export function getTemplateList(params: TemplateParams) {
  return request({
    url: '/template/list',
    method: 'get',
    data: params
  })
}

export function getTemplateDetail(id: string | number) {
  return request({
    url: `/template/detail/${id}`,
    method: 'get'
  })
}

export function applyTemplate(id: string | number, targetDate: string) {
  return request({
    url: '/template/apply',
    method: 'post',
    data: { id, targetDate }
  })
}
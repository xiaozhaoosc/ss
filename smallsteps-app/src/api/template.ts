import request from '@/utils/request'

export interface TemplateParams {
  pageNum?: number;
  pageSize?: number;
  category?: string;
  title?: string;
}

/**
 * 获取模板列表
 */
export function getTemplateList(params: TemplateParams) {
  return request({
    url: '/parent/template/list',
    method: 'get',
    params: params
  })
}

/**
 * 获取模板详情
 */
export function getTemplateDetail(id: string | number) {
  return request({
    url: `/parent/template/${id}`,
    method: 'get'
  })
}

/**
 * 从模板导入任务
 */
export function applyTemplate(templateId: string | number, childId: string | number) {
  return request({
    url: `/parent/template/import/${templateId}`,
    method: 'post',
    params: { childId }
  })
}
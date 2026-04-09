import request from '@/utils/request'
import { Knowledge } from '@/api/smallsteps/types'

// 查询知识库列表
export function listKnowledge(query: any) {
  return request({
    url: '/smallsteps/knowledge/list',
    method: 'get',
    params: query
  })
}

// 查询知识库详细
export function getKnowledge(knowledgeId: number) {
  return request({
    url: '/smallsteps/knowledge/' + knowledgeId,
    method: 'get'
  })
}

// 新增知识库
export function addKnowledge(data: Knowledge) {
  return request({
    url: '/smallsteps/knowledge',
    method: 'post',
    data: data
  })
}

// 修改知识库
export function updateKnowledge(data: Knowledge) {
  return request({
    url: '/smallsteps/knowledge',
    method: 'put',
    data: data
  })
}

// 删除知识库
export function delKnowledge(knowledgeId: number) {
  return request({
    url: '/smallsteps/knowledge/' + knowledgeId,
    method: 'delete'
  })
}

// 导出知识库
export function exportKnowledge(query: any) {
  return request({
    url: '/smallsteps/knowledge/export',
    method: 'get',
    params: query
  })
}
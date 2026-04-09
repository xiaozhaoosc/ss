import request from '@/utils/request'
import { Emotion } from '@/api/smallsteps/types'

// 查询情绪记录列表
export function listEmotion(query: any) {
  return request({
    url: '/smallsteps/emotion/list',
    method: 'get',
    params: query
  })
}

// 查询情绪记录详细
export function getEmotion(emotionId: number) {
  return request({
    url: '/smallsteps/emotion/' + emotionId,
    method: 'get'
  })
}

// 新增情绪记录
export function addEmotion(data: Emotion) {
  return request({
    url: '/smallsteps/emotion',
    method: 'post',
    data: data
  })
}

// 修改情绪记录
export function updateEmotion(data: Emotion) {
  return request({
    url: '/smallsteps/emotion',
    method: 'put',
    data: data
  })
}

// 删除情绪记录
export function delEmotion(emotionId: number) {
  return request({
    url: '/smallsteps/emotion/' + emotionId,
    method: 'delete'
  })
}

// 导出情绪记录
export function exportEmotion(query: any) {
  return request({
    url: '/smallsteps/emotion/export',
    method: 'get',
    params: query
  })
}
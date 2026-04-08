import request from '@/utils/request'
import type { ParentGrowth, ParentTool } from './types'

// 家长成长观察相关 API

// 获取情绪日报
export function getEmotionDaily(userId: number, date: string) {
  return request({
    url: '/parent/growth/emotion/daily',
    method: 'GET',
    params: { userId, date }
  })
}

// 获取能力雷达图
export function getAbilityRadar(userId: number, period: string) {
  return request({
    url: '/parent/growth/ability/radar',
    method: 'GET',
    params: { userId, period }
  })
}

// 获取成长轨迹
export function getGrowthTrack(userId: number, startDate: string, endDate: string) {
  return request({
    url: '/parent/growth/track',
    method: 'GET',
    params: { userId, startDate, endDate }
  })
}

// 记录情绪状态
export function recordEmotion(data: { userId: number; date: string; emotionState: string; emotionScore: number; observation?: string }) {
  return request({
    url: '/parent/growth/emotion/record',
    method: 'POST',
    data: data
  })
}

// 家长辅助工具相关 API

// 获取情绪急救包配置
export function getEmotionFirstAid(userId: number) {
  return request({
    url: '/parent/tool/emotion/first-aid',
    method: 'GET',
    params: { userId }
  })
}

// 更新情绪急救包配置
export function updateEmotionFirstAid(data: { userId: number; firstAidConfig: string }) {
  return request({
    url: '/parent/tool/emotion/first-aid',
    method: 'PUT',
    data: data
  })
}

// 获取家长指南
export function getParentGuide(type: string) {
  return request({
    url: '/parent/tool/guide',
    method: 'GET',
    params: { type }
  })
}

// 获取亲子契约模板
export function getContractTemplate() {
  return request({
    url: '/parent/tool/contract/template',
    method: 'GET'
  })
}

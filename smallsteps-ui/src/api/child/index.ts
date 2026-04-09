import request from '@/utils/request';
import type { ChildTask, ChildAchievement, ChildAI } from './types';

// 儿童任务执行相关 API

// NFC 刷卡签到
export function nfcSignin(nfcId: string, taskId: number) {
  return request({
    url: '/child/task/nfc/signin',
    method: 'POST',
    params: { nfcId, taskId }
  });
}

// 更新任务状态
export function updateTaskStatus(data: { taskId: number; status: string; userId?: number }) {
  return request({
    url: '/child/task/status',
    method: 'PUT',
    data: data
  });
}

// 获取任务列表
export function getChildTaskList(userId: number) {
  return request({
    url: '/child/task/list',
    method: 'GET',
    params: { userId }
  });
}

// 获取任务详情
export function getChildTask(taskId: number) {
  return request({
    url: `/child/task/${taskId}`,
    method: 'GET'
  });
}

// 儿童成就系统相关 API

// 收集勇气碎片
export function collectCourageShard(userId: number, shardCount: number) {
  return request({
    url: '/child/achievement/collect',
    method: 'POST',
    params: { userId, shardCount }
  });
}

// 查询星星余额
export function getStarsBalance(userId: number) {
  return request({
    url: '/child/achievement/stars',
    method: 'GET',
    params: { userId }
  });
}

// 兑换奖励
export function exchangeReward(data: { userId: number; starCount: number; rewardId?: number; rewardName: string }) {
  return request({
    url: '/child/achievement/exchange',
    method: 'POST',
    data: data
  });
}

// 查询成就列表
export function getAchievementList(userId: number) {
  return request({
    url: '/child/achievement/list',
    method: 'GET',
    params: { userId }
  });
}

// 获取成就详情
export function getAchievement(achievementId: number) {
  return request({
    url: `/child/achievement/${achievementId}`,
    method: 'GET'
  });
}

// 儿童 AI 伴侣相关 API

// 语音互动
export function chatWithAI(data: { userId: number; textInput: string; sceneType?: string }) {
  return request({
    url: '/child/ai/chat',
    method: 'POST',
    data: data
  });
}

// 情绪识别
export function recognizeEmotion(data: { userId: number; emotionState: string; sceneType?: string }) {
  return request({
    url: '/child/ai/emotion',
    method: 'POST',
    data: data
  });
}

// 个性化建议
export function getAISuggestion(userId: number) {
  return request({
    url: '/child/ai/suggestion',
    method: 'GET',
    params: { userId }
  });
}

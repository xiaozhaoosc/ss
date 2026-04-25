import request from '@/utils/request';

/**
 * 获取孩子任务完成情况
 */
export function getTaskStatus(childId: number | string) {
  return request({
    url: `/parent/insight/task/status/${childId}`,
    method: 'get'
  });
}

/**
 * 获取能力雷达图
 */
export function getAbilityRadar(childId: number | string) {
  return request({
    url: `/parent/insight/ability/radar/${childId}`,
    method: 'get'
  });
}

/**
 * 获取AI观察者建议
 */
export function getSummaryInsight(childId: number | string) {
  return request({
    url: `/parent/insight/summary/${childId}`,
    method: 'get'
  });
}

/**
 * 获取执行时间轴
 */
export function getTimeline(childId: number | string) {
  return request({
    url: `/parent/insight/timeline/${childId}`,
    method: 'get'
  });
}

/**
 * 获取情绪趋势
 */
export function getEmotionTrend(childId: number | string, days = 7) {
  return request({
    url: `/parent/insight/emotion/trend/${childId}`,
    method: 'get',
    params: { days }
  });
}

/**
 * 获取周情绪/表现热力图
 */
export function getWeeklyHeatmap(childId: number | string) {
  return request({
    url: `/parent/insight/weekly/heatmap/${childId}`,
    method: 'get'
  });
}

/**
 * 获取周深度AI分析报告
 */
export function getWeeklyAiAnalysis(childId: number) {
  return request({
    url: '/parent/insight/weekly/analysis',
    method: 'get',
    params: { childId }
  })
}

// 获取奖励兑换列表
export function getRedemptionList(query: any) {
  return request({
    url: '/parent/reward/redemption/list',
    method: 'get',
    params: query
  })
}

// 批准奖励兑换
export function approveRedemption(redemptionId: number) {
  return request({
    url: `/parent/reward/redemption/approve/${redemptionId}`,
    method: 'post'
  })
}

// 拒绝奖励兑换
export function rejectRedemption(redemptionId: number) {
  return request({
    url: `/parent/reward/redemption/reject/${redemptionId}`,
    method: 'post'
  })
}
// 删除任务执行记录
export function deleteExecutionRecord(id: number | string) {
  return request({
    url: `/child/task/remove/${id}`,
    method: 'delete'
  })
}

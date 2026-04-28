import request from '@/utils/request';

// 获取影子观察者情绪趋势
export function getShadowEmotionTrend(childId: number | string, days: number = 7) {
  return request({
    url: `/parent/insight/emotion/shadow-trend/${childId}`,
    method: 'get',
    params: { days }
  });
}

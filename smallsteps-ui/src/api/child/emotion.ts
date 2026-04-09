import request from '@/utils/request'

// 查询儿童情绪记录列表
export function listChildEmotion(query: any) {
  return request({
    url: '/child/emotion/list',
    method: 'get',
    params: query
  })
}

// 记录情绪
export function recordEmotion(data: any) {
  return request({
    url: '/child/emotion/record',
    method: 'post',
    data: data
  })
}

// 查询情绪详情
export function getChildEmotion(emotionId: number) {
  return request({
    url: '/child/emotion/' + emotionId,
    method: 'get'
  })
}
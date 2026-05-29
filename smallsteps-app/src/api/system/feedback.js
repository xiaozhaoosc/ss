import request from '@/utils/request'

// 提交意见反馈
export function addFeedback(data) {
  return request({
    url: '/parent/feedback',
    method: 'post',
    data: data
  })
}

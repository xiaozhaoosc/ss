import request from '@/utils/request'

// 查询家庭成员列表
export function getFamilyMembers() {
  return request({
    url: '/parent/family/members',
    method: 'get'
  })
}

// 绑定儿童
export function bindChild(data: { userName: string }) {
  return request({
    url: '/parent/family/bind-child',
    method: 'post',
    data: data
  })
}

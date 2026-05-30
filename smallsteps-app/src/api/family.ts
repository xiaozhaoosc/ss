import request from '@/utils/request'

// 查询家庭成员列表
export function getFamilyMembers() {
  return request({
    url: '/parent/family/members',
    method: 'get'
  })
}

// 查询家庭家长列表
export function getFamilyParents() {
  return request({
    url: '/parent/family/parents',
    method: 'get'
  })
}

// 查询家庭儿童列表
export function getFamilyChildren() {
  return request({
    url: '/parent/family/children',
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

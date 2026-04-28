import request from '@/utils/request'

export function generateInviteCode() {
  return request({
    url: '/parent/family/invite/generate',
    method: 'post'
  })
}

export function validateInviteCode(code: string) {
  return request({
    url: '/parent/family/invite/validate',
    method: 'get',
    params: { code }
  })
}

export function getInviteInfo(code: string) {
  return request({
    url: '/family/invite/info',
    method: 'get',
    params: { code }
  })
}

export function submitJoinRequest(data: { inviteCode: string }) {
  return request({
    url: '/family/join-request',
    method: 'post',
    data
  })
}

export function getPendingRequests() {
  return request({
    url: '/parent/family/invite/requests',
    method: 'get'
  })
}

export function approveRequest(id: number) {
  return request({
    url: `/parent/family/invite/request/${id}/approve`,
    method: 'post'
  })
}

export function rejectRequest(id: number) {
  return request({
    url: `/parent/family/invite/request/${id}/reject`,
    method: 'post'
  })
}

export function getMyRequests() {
  return request({
    url: '/family/my-requests',
    method: 'get'
  })
}
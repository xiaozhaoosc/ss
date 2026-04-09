import request from '@/utils/request'
import { Contract } from '@/api/smallsteps/types'

// 查询亲子契约列表
export function listContract(query: any) {
  return request({
    url: '/smallsteps/contract/list',
    method: 'get',
    params: query
  })
}

// 查询亲子契约详细
export function getContract(contractId: number) {
  return request({
    url: '/smallsteps/contract/' + contractId,
    method: 'get'
  })
}

// 新增亲子契约
export function addContract(data: Contract) {
  return request({
    url: '/smallsteps/contract',
    method: 'post',
    data: data
  })
}

// 修改亲子契约
export function updateContract(data: Contract) {
  return request({
    url: '/smallsteps/contract',
    method: 'put',
    data: data
  })
}

// 删除亲子契约
export function delContract(contractId: number) {
  return request({
    url: '/smallsteps/contract/' + contractId,
    method: 'delete'
  })
}

// 导出亲子契约
export function exportContract(query: any) {
  return request({
    url: '/smallsteps/contract/export',
    method: 'get',
    params: query
  })
}
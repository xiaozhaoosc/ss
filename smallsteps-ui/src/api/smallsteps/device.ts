import request from '@/utils/request'
import { Device } from '@/api/smallsteps/types'

// 查询设备列表
export function listDevice(query: any) {
  return request({
    url: '/smallsteps/device/list',
    method: 'get',
    params: query
  })
}

// 查询设备详细
export function getDevice(deviceId: number) {
  return request({
    url: '/smallsteps/device/' + deviceId,
    method: 'get'
  })
}

// 新增设备
export function addDevice(data: Device) {
  return request({
    url: '/smallsteps/device',
    method: 'post',
    data: data
  })
}

// 修改设备
export function updateDevice(data: Device) {
  return request({
    url: '/smallsteps/device',
    method: 'put',
    data: data
  })
}

// 删除设备
export function delDevice(deviceId: number) {
  return request({
    url: '/smallsteps/device/' + deviceId,
    method: 'delete'
  })
}

// 导出设备
export function exportDevice(query: any) {
  return request({
    url: '/smallsteps/device/export',
    method: 'get',
    params: query
  })
}
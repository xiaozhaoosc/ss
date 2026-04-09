import request from '@/utils/request';

// 查询设备管理列表
export function listDevice(query: any) {
  return request({
    url: '/parent/device/list',
    method: 'get',
    params: query
  });
}

// 绑定设备
export function bindDevice(data: any) {
  return request({
    url: '/parent/device/bind',
    method: 'post',
    data: data
  });
}

// 解绑设备
export function unbindDevice(deviceId: string | number) {
  return request({
    url: '/parent/device/unbind/' + deviceId,
    method: 'post'
  });
}

// 发送指令到硬件 (MQTT 触发测试)
export function sendCommand(deviceId: string | number, command: string) {
  return request({
    url: '/parent/device/command',
    method: 'post',
    data: { deviceId, command }
  });
}

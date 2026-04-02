/**
 * BLE 管理器
 * 封装 uni-app 的蓝牙 API，提供简洁的接口
 * 临时注释掉 ESP32 相关功能
 */

/*
class BLEManager {
    constructor() {
        this.deviceId = null
        this.serviceId = '0000FFF0-0000-1000-8000-00805F9B34FB'
        this.characteristics = {}
        this.connected = false
    }

    /**
     * 初始化蓝牙适配器
     */
    async init() {
        return new Promise((resolve, reject) => {
            uni.openBluetoothAdapter({
                success: () => {
                    console.log('[BLE] 蓝牙适配器初始化成功')
                    resolve()
                },
                fail: (error) => {
                    console.error('[BLE] 蓝牙适配器初始化失败:', error)
                    reject(error)
                }
            })
        })
    }

    /**
     * 扫描设备
     * @param {number} duration - 扫描时长（毫秒）
     * @returns {Promise<Array>} 设备列表
     */
    async scan(duration = 10000) {
        const devices = []
        const deviceMap = new Map()

        return new Promise((resolve, reject) => {
            // 开始扫描
            uni.startBluetoothDevicesDiscovery({
                allowDuplicatesKey: false,
                success: () => {
                    console.log('[BLE] 开始扫描设备')

                    // 监听设备发现
                    uni.onBluetoothDeviceFound((res) => {
                        res.devices.forEach(device => {
                            if (device.name && !deviceMap.has(device.deviceId)) {
                                deviceMap.set(device.deviceId, device)
                                devices.push(device)
                            }
                        })
                    })

                    // 设置扫描超时
                    setTimeout(() => {
                        uni.stopBluetoothDevicesDiscovery()
                        console.log(`[BLE] 扫描完成，发现 ${devices.length} 个设备`)
                        resolve(devices)
                    }, duration)
                },
                fail: (error) => {
                    console.error('[BLE] 开始扫描失败:', error)
                    reject(error)
                }
            })
        })
    }

    /**
     * 连接设备
     * @param {string} deviceId - 设备 ID
     */
    async connect(deviceId) {
        this.deviceId = deviceId

        // 创建连接
        await new Promise((resolve, reject) => {
            uni.createBLEConnection({
                deviceId,
                success: () => {
                    console.log('[BLE] 连接成功')
                    this.connected = true
                    resolve()
                },
                fail: (error) => {
                    console.error('[BLE] 连接失败:', error)
                    reject(error)
                }
            })
        })

        // 获取服务
        await this.getServices()

        // 获取特征值
        await this.getCharacteristics()

        // 启用通知
        await this.enableNotifications()
    }

    /**
     * 断开连接
     */
    async disconnect() {
        if (!this.deviceId) return

        return new Promise((resolve) => {
            uni.closeBLEConnection({
                deviceId: this.deviceId,
                success: () => {
                    console.log('[BLE] 断开连接')
                    this.connected = false
                    this.deviceId = null
                    this.characteristics = {}
                    resolve()
                },
                fail: () => {
                    resolve()
                }
            })
        })
    }

    /**
     * 获取服务
     */
    async getServices() {
        return new Promise((resolve, reject) => {
            uni.getBLEDeviceServices({
                deviceId: this.deviceId,
                success: (res) => {
                    console.log('[BLE] 获取服务成功:', res.services.length)
                    resolve(res.services)
                },
                fail: (error) => {
                    console.error('[BLE] 获取服务失败:', error)
                    reject(error)
                }
            })
        })
    }

    /**
     * 获取特征值
     */
    async getCharacteristics() {
        return new Promise((resolve, reject) => {
            uni.getBLEDeviceCharacteristics({
                deviceId: this.deviceId,
                serviceId: this.serviceId,
                success: (res) => {
                    console.log('[BLE] 获取特征值成功:', res.characteristics.length)

                    // 保存特征值
                    res.characteristics.forEach(char => {
                        const shortUuid = char.uuid.substring(4, 8).toLowerCase()
                        this.characteristics[shortUuid] = char
                    })

                    resolve(res.characteristics)
                },
                fail: (error) => {
                    console.error('[BLE] 获取特征值失败:', error)
                    reject(error)
                }
            })
        })
    }

    /**
     * 启用通知
     */
    async enableNotifications() {
        const statusChar = this.characteristics['fff6']
        if (!statusChar) return

        return new Promise((resolve, reject) => {
            uni.notifyBLECharacteristicValueChange({
                deviceId: this.deviceId,
                serviceId: this.serviceId,
                characteristicId: statusChar.uuid,
                state: true,
                success: () => {
                    console.log('[BLE] 启用通知成功')

                    // 监听特征值变化
                    uni.onBLECharacteristicValueChange((res) => {
                        console.log('[BLE] 特征值变化:', res)
                    })

                    resolve()
                },
                fail: (error) => {
                    console.error('[BLE] 启用通知失败:', error)
                    reject(error)
                }
            })
        })
    }

    /**
     * 读取特征值
     * @param {string} charId - 特征值 ID（简写，如 'fff1'）
     * @returns {Promise<string>} 读取的值
     */
    async readCharacteristic(charId) {
        const char = this.characteristics[charId]
        if (!char) {
            throw new Error(`特征值 ${charId} 不存在`)
        }

        return new Promise((resolve, reject) => {
            uni.readBLECharacteristicValue({
                deviceId: this.deviceId,
                serviceId: this.serviceId,
                characteristicId: char.uuid,
                success: () => {
                    // 需要在 onBLECharacteristicValueChange 中获取值
                    const handler = (res) => {
                        if (res.characteristicId === char.uuid) {
                            const value = this.ab2str(res.value)
                            uni.offBLECharacteristicValueChange(handler)
                            resolve(value)
                        }
                    }
                    uni.onBLECharacteristicValueChange(handler)
                },
                fail: (error) => {
                    console.error(`[BLE] 读取特征值 ${charId} 失败:`, error)
                    reject(error)
                }
            })
        })
    }

    /**
     * 写入特征值
     * @param {string} charId - 特征值 ID（简写，如 'fff1'）
     * @param {string|number} value - 要写入的值
     */
    async writeCharacteristic(charId, value) {
        const char = this.characteristics[charId]
        if (!char) {
            throw new Error(`特征值 ${charId} 不存在`)
        }

        let buffer
        if (typeof value === 'number') {
            // 数字类型（如端口号）
            buffer = new ArrayBuffer(2)
            new DataView(buffer).setUint16(0, value, true)
        } else {
            // 字符串类型
            buffer = this.str2ab(value)
        }

        return new Promise((resolve, reject) => {
            uni.writeBLECharacteristicValue({
                deviceId: this.deviceId,
                serviceId: this.serviceId,
                characteristicId: char.uuid,
                value: buffer,
                success: () => {
                    console.log(`[BLE] 写入特征值 ${charId} 成功`)
                    resolve()
                },
                fail: (error) => {
                    console.error(`[BLE] 写入特征值 ${charId} 失败:`, error)
                    reject(error)
                }
            })
        })
    }

    /**
     * 字符串转 ArrayBuffer
     */
    str2ab(str) {
        const buffer = new ArrayBuffer(str.length)
        const dataView = new DataView(buffer)
        for (let i = 0; i < str.length; i++) {
            dataView.setUint8(i, str.charCodeAt(i))
        }
        return buffer
    }

    /**
     * ArrayBuffer 转字符串
     */
    ab2str(buffer) {
        const dataView = new DataView(buffer)
        let str = ''
        for (let i = 0; i < dataView.byteLength; i++) {
            str += String.fromCharCode(dataView.getUint8(i))
        }
        return str
    }
}
*/

// 临时替代实现，返回模拟数据
class BLEManager {
    constructor() {
        console.log('[BLE] 临时替代实现，返回模拟数据')
    }

    async init() {
        console.log('[BLE] 模拟初始化成功')
        return Promise.resolve()
    }

    async scan(duration = 10000) {
        console.log('[BLE] 模拟扫描设备')
        return Promise.resolve([
            {
                deviceId: 'mock-device-1',
                name: 'SmallSteps Device',
                RSSI: -45
            }
        ])
    }

    async connect(deviceId) {
        console.log('[BLE] 模拟连接设备:', deviceId)
        return Promise.resolve()
    }

    async disconnect() {
        console.log('[BLE] 模拟断开连接')
        return Promise.resolve()
    }

    async getServices() {
        console.log('[BLE] 模拟获取服务')
        return Promise.resolve([])
    }

    async getCharacteristics() {
        console.log('[BLE] 模拟获取特征值')
        return Promise.resolve([])
    }

    async enableNotifications() {
        console.log('[BLE] 模拟启用通知')
        return Promise.resolve()
    }

    async readCharacteristic(charId) {
        console.log('[BLE] 模拟读取特征值:', charId)
        return Promise.resolve('mock-value')
    }

    async writeCharacteristic(charId, value) {
        console.log('[BLE] 模拟写入特征值:', charId, value)
        return Promise.resolve()
    }
}

export default BLEManager

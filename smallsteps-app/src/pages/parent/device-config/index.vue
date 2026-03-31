<template>
  <view class="device-config-page">
    <!-- 顶部导航栏 -->
    <view class="custom-navbar">
      <view class="navbar-content">
        <view class="navbar-left" @click="goBack">
          <text class="icon-back">←</text>
        </view>
        <view class="navbar-title">设备配置</view>
        <view class="navbar-right"></view>
      </view>
    </view>

    <!-- 主内容区 -->
    <view class="content">
      <!-- 步骤指示器 -->
      <view class="steps">
        <view class="step" :class="{ active: currentStep >= 1, completed: currentStep > 1 }">
          <view class="step-number">1</view>
          <text class="step-text">扫描设备</text>
        </view>
        <view class="step-line" :class="{ active: currentStep > 1 }"></view>
        <view class="step" :class="{ active: currentStep >= 2, completed: currentStep > 2 }">
          <view class="step-number">2</view>
          <text class="step-text">配置参数</text>
        </view>
        <view class="step-line" :class="{ active: currentStep > 2 }"></view>
        <view class="step" :class="{ active: currentStep >= 3 }">
          <view class="step-number">3</view>
          <text class="step-text">完成</text>
        </view>
      </view>

      <!-- 步骤 1: 扫描设备 -->
      <view v-if="currentStep === 1" class="step-content">
        <view class="scan-section">
          <view class="scan-icon">📡</view>
          <text class="scan-title">扫描附近的小步设备</text>
          
          <button 
            class="btn-primary" 
            :disabled="isScanning"
            @click="startScan"
          >
            {{ isScanning ? '扫描中...' : '开始扫描' }}
          </button>

          <!-- 设备列表 -->
          <view v-if="devices.length > 0" class="device-list">
            <view 
              v-for="device in devices" 
              :key="device.deviceId"
              class="device-item"
              @click="selectDevice(device)"
            >
              <view class="device-info">
                <text class="device-name">{{ device.name }}</text>
                <text class="device-id">{{ device.deviceId }}</text>
              </view>
              <view class="device-signal">
                <text class="signal-icon">📶</text>
                <text class="signal-text">{{ getSignalStrength(device.RSSI) }}</text>
              </view>
            </view>
          </view>

          <view v-else-if="isScanning" class="scanning-tip">
            <text>正在搜索设备...</text>
          </view>
        </view>
      </view>

      <!-- 步骤 2: 配置参数 -->
      <view v-if="currentStep === 2" class="step-content">
        <view class="config-section">
          <view class="config-header">
            <text class="config-device-name">{{ selectedDevice.name }}</text>
            <text class="config-status" :class="connectionStatus">
              {{ connectionStatusText }}
            </text>
          </view>

          <!-- WiFi 配置 -->
          <view class="config-group">
            <text class="group-title">WiFi 配置</text>
            <view class="form-item">
              <text class="label">WiFi 名称</text>
              <input 
                class="input" 
                v-model="config.wifi.ssid" 
                placeholder="请输入 WiFi 名称"
              />
            </view>
            <view class="form-item">
              <text class="label">WiFi 密码</text>
              <input 
                class="input" 
                v-model="config.wifi.password" 
                type="password"
                placeholder="请输入 WiFi 密码"
              />
            </view>
          </view>

          <!-- MQTT 配置 -->
          <view class="config-group">
            <text class="group-title">MQTT 配置</text>
            <view class="form-item">
              <text class="label">服务器地址</text>
              <input 
                class="input" 
                v-model="config.mqtt.broker" 
                placeholder="mqtt.smallsteps.com"
              />
            </view>
            <view class="form-item">
              <text class="label">端口</text>
              <input 
                class="input" 
                v-model.number="config.mqtt.port" 
                type="number"
                placeholder="1883"
              />
            </view>
            <view class="form-item">
              <text class="label">设备 ID</text>
              <input 
                class="input" 
                v-model="config.mqtt.deviceId" 
                placeholder="esp32_001"
              />
            </view>
          </view>

          <!-- 操作按钮 -->
          <view class="action-buttons">
            <button class="btn-secondary" @click="goBack">返回</button>
            <button 
              class="btn-primary" 
              :disabled="isSaving || !isFormValid"
              @click="saveConfig"
            >
              {{ isSaving ? '保存中...' : '保存配置' }}
            </button>
          </view>
        </view>
      </view>

      <!-- 步骤 3: 完成 -->
      <view v-if="currentStep === 3" class="step-content">
        <view class="success-section">
          <view class="success-icon">✅</view>
          <text class="success-title">配置成功！</text>
          <text class="success-message">设备将在 3 秒后自动重启并连接网络</text>
          
          <view class="config-summary">
            <view class="summary-item">
              <text class="summary-label">WiFi:</text>
              <text class="summary-value">{{ config.wifi.ssid }}</text>
            </view>
            <view class="summary-item">
              <text class="summary-label">MQTT:</text>
              <text class="summary-value">{{ config.mqtt.broker }}</text>
            </view>
            <view class="summary-item">
              <text class="summary-label">设备 ID:</text>
              <text class="summary-value">{{ config.mqtt.deviceId }}</text>
            </view>
          </view>

          <button class="btn-primary" @click="finish">完成</button>
        </view>
      </view>
    </view>
  </view>
</template>

<script>
import BLEManager from '@/utils/ble-manager.js'

export default {
  data() {
    return {
      currentStep: 1,
      isScanning: false,
      isSaving: false,
      devices: [],
      selectedDevice: null,
      connectionStatus: 'disconnected',
      config: {
        wifi: {
          ssid: '',
          password: ''
        },
        mqtt: {
          broker: 'mqtt.smallsteps.com',
          port: 1883,
          deviceId: 'esp32_001'
        }
      },
      bleManager: null
    }
  },
  
  computed: {
    connectionStatusText() {
      const statusMap = {
        'disconnected': '未连接',
        'connecting': '连接中...',
        'connected': '已连接',
        'error': '连接失败'
      }
      return statusMap[this.connectionStatus] || '未知'
    },
    
    isFormValid() {
      return this.config.wifi.ssid && 
             this.config.wifi.password && 
             this.config.mqtt.broker && 
             this.config.mqtt.deviceId
    }
  },
  
  onLoad() {
    this.bleManager = new BLEManager()
    this.bleManager.init()
  },
  
  onUnload() {
    if (this.bleManager) {
      this.bleManager.disconnect()
    }
  },
  
  methods: {
    // 开始扫描设备
    async startScan() {
      this.isScanning = true
      this.devices = []
      
      try {
        const devices = await this.bleManager.scan(10000) // 扫描 10 秒
        this.devices = devices.filter(d => d.name && d.name.includes('SmallSteps'))
        
        if (this.devices.length === 0) {
          uni.showToast({
            title: '未找到设备',
            icon: 'none'
          })
        }
      } catch (error) {
        console.error('扫描失败:', error)
        uni.showToast({
          title: '扫描失败',
          icon: 'none'
        })
      } finally {
        this.isScanning = false
      }
    },
    
    // 选择设备
    async selectDevice(device) {
      this.selectedDevice = device
      this.connectionStatus = 'connecting'
      
      try {
        await this.bleManager.connect(device.deviceId)
        this.connectionStatus = 'connected'
        this.currentStep = 2
        
        // 读取当前配置
        await this.loadCurrentConfig()
      } catch (error) {
        console.error('连接失败:', error)
        this.connectionStatus = 'error'
        uni.showToast({
          title: '连接失败',
          icon: 'none'
        })
      }
    },
    
    // 加载当前配置
    async loadCurrentConfig() {
      try {
        const wifiSsid = await this.bleManager.readCharacteristic('fff1')
        const mqttBroker = await this.bleManager.readCharacteristic('fff3')
        const deviceId = await this.bleManager.readCharacteristic('fff5')
        
        if (wifiSsid) this.config.wifi.ssid = wifiSsid
        if (mqttBroker) this.config.mqtt.broker = mqttBroker
        if (deviceId) this.config.mqtt.deviceId = deviceId
      } catch (error) {
        console.error('读取配置失败:', error)
      }
    },
    
    // 保存配置
    async saveConfig() {
      if (!this.isFormValid) {
        uni.showToast({
          title: '请填写完整信息',
          icon: 'none'
        })
        return
      }
      
      this.isSaving = true
      
      try {
        // 写入 WiFi 配置
        await this.bleManager.writeCharacteristic('fff1', this.config.wifi.ssid)
        await this.bleManager.writeCharacteristic('fff2', this.config.wifi.password)
        
        // 写入 MQTT 配置
        await this.bleManager.writeCharacteristic('fff3', this.config.mqtt.broker)
        await this.bleManager.writeCharacteristic('fff4', this.config.mqtt.port)
        await this.bleManager.writeCharacteristic('fff5', this.config.mqtt.deviceId)
        
        // 发送保存命令
        await this.bleManager.writeCharacteristic('fff7', 'save')
        
        // 等待保存完成
        await this.waitForSaveComplete()
        
        this.currentStep = 3
      } catch (error) {
        console.error('保存失败:', error)
        uni.showToast({
          title: '保存失败',
          icon: 'none'
        })
      } finally {
        this.isSaving = false
      }
    },
    
    // 等待保存完成
    async waitForSaveComplete() {
      return new Promise((resolve, reject) => {
        const checkStatus = async () => {
          try {
            const status = await this.bleManager.readCharacteristic('fff6')
            const statusObj = JSON.parse(status)
            
            if (statusObj.status === 'success') {
              resolve()
            } else if (statusObj.status === 'error') {
              reject(new Error(statusObj.message))
            } else {
              setTimeout(checkStatus, 1000)
            }
          } catch (error) {
            reject(error)
          }
        }
        
        checkStatus()
      })
    },
    
    // 获取信号强度
    getSignalStrength(rssi) {
      if (rssi > -50) return '强'
      if (rssi > -70) return '中'
      return '弱'
    },
    
    // 返回
    goBack() {
      if (this.currentStep > 1) {
        this.currentStep--
      } else {
        uni.navigateBack()
      }
    },
    
    // 完成
    finish() {
      if (this.bleManager) {
        this.bleManager.disconnect()
      }
      uni.navigateBack()
    }
  }
}
</script>

<style scoped>
.device-config-page {
  min-height: 100vh;
  background: #f5f7fa;
}

/* 自定义导航栏 */
.custom-navbar {
  background: #fff;
  padding-top: var(--status-bar-height);
}

.navbar-content {
  display: flex;
  align-items: center;
  justify-content: space-between;
  height: 44px;
  padding: 0 16px;
}

.navbar-left, .navbar-right {
  width: 60px;
}

.icon-back {
  font-size: 24px;
  color: #333;
}

.navbar-title {
  font-size: 17px;
  font-weight: 600;
  color: #333;
}

/* 内容区 */
.content {
  padding: 20px 16px;
}

/* 步骤指示器 */
.steps {
  display: flex;
  align-items: center;
  justify-content: center;
  margin-bottom: 30px;
  padding: 20px;
  background: #fff;
  border-radius: 12px;
}

.step {
  display: flex;
  flex-direction: column;
  align-items: center;
  gap: 8px;
}

.step-number {
  width: 32px;
  height: 32px;
  border-radius: 50%;
  background: #e5e7eb;
  color: #9ca3af;
  display: flex;
  align-items: center;
  justify-content: center;
  font-size: 14px;
  font-weight: 600;
  transition: all 0.3s;
}

.step.active .step-number {
  background: #6C9BD2;
  color: #fff;
}

.step.completed .step-number {
  background: #10b981;
  color: #fff;
}

.step-text {
  font-size: 12px;
  color: #9ca3af;
}

.step.active .step-text {
  color: #333;
  font-weight: 500;
}

.step-line {
  width: 60px;
  height: 2px;
  background: #e5e7eb;
  margin: 0 8px;
  transition: all 0.3s;
}

.step-line.active {
  background: #6C9BD2;
}

/* 步骤内容 */
.step-content {
  background: #fff;
  border-radius: 12px;
  padding: 24px;
}

/* 扫描部分 */
.scan-section {
  display: flex;
  flex-direction: column;
  align-items: center;
  gap: 20px;
}

.scan-icon {
  font-size: 64px;
}

.scan-title {
  font-size: 18px;
  font-weight: 600;
  color: #333;
}

.device-list {
  width: 100%;
  margin-top: 20px;
}

.device-item {
  display: flex;
  align-items: center;
  justify-content: space-between;
  padding: 16px;
  background: #f9fafb;
  border-radius: 8px;
  margin-bottom: 12px;
}

.device-info {
  display: flex;
  flex-direction: column;
  gap: 4px;
}

.device-name {
  font-size: 16px;
  font-weight: 500;
  color: #333;
}

.device-id {
  font-size: 12px;
  color: #9ca3af;
}

.device-signal {
  display: flex;
  align-items: center;
  gap: 4px;
}

.signal-icon {
  font-size: 16px;
}

.signal-text {
  font-size: 12px;
  color: #6b7280;
}

.scanning-tip {
  color: #9ca3af;
  font-size: 14px;
}

/* 配置部分 */
.config-section {
  display: flex;
  flex-direction: column;
  gap: 24px;
}

.config-header {
  display: flex;
  align-items: center;
  justify-content: space-between;
  padding-bottom: 16px;
  border-bottom: 1px solid #e5e7eb;
}

.config-device-name {
  font-size: 18px;
  font-weight: 600;
  color: #333;
}

.config-status {
  font-size: 14px;
  padding: 4px 12px;
  border-radius: 12px;
}

.config-status.connected {
  background: #d1fae5;
  color: #065f46;
}

.config-status.connecting {
  background: #fef3c7;
  color: #92400e;
}

.config-group {
  display: flex;
  flex-direction: column;
  gap: 16px;
}

.group-title {
  font-size: 16px;
  font-weight: 600;
  color: #333;
}

.form-item {
  display: flex;
  flex-direction: column;
  gap: 8px;
}

.label {
  font-size: 14px;
  color: #6b7280;
}

.input {
  padding: 12px;
  background: #f9fafb;
  border: 1px solid #e5e7eb;
  border-radius: 8px;
  font-size: 14px;
}

.action-buttons {
  display: flex;
  gap: 12px;
  margin-top: 8px;
}

/* 成功部分 */
.success-section {
  display: flex;
  flex-direction: column;
  align-items: center;
  gap: 20px;
}

.success-icon {
  font-size: 64px;
}

.success-title {
  font-size: 20px;
  font-weight: 600;
  color: #333;
}

.success-message {
  font-size: 14px;
  color: #6b7280;
  text-align: center;
}

.config-summary {
  width: 100%;
  background: #f9fafb;
  border-radius: 8px;
  padding: 16px;
  margin-top: 8px;
}

.summary-item {
  display: flex;
  justify-content: space-between;
  padding: 8px 0;
  border-bottom: 1px solid #e5e7eb;
}

.summary-item:last-child {
  border-bottom: none;
}

.summary-label {
  font-size: 14px;
  color: #6b7280;
}

.summary-value {
  font-size: 14px;
  font-weight: 500;
  color: #333;
}

/* 按钮 */
.btn-primary, .btn-secondary {
  flex: 1;
  padding: 14px 24px;
  border-radius: 8px;
  font-size: 16px;
  font-weight: 500;
  border: none;
}

.btn-primary {
  background: #6C9BD2;
  color: #fff;
}

.btn-primary[disabled] {
  background: #d1d5db;
  color: #9ca3af;
}

.btn-secondary {
  background: #f3f4f6;
  color: #374151;
}
</style>

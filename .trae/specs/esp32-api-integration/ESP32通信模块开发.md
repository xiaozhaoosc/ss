# ESP32 通信模块开发文档

## 1. 概述

本文档定义了 Small Steps 项目中 ESP32 硬件终端的通信模块开发方案，包括 MQTT 通信、设备认证、数据加密和网络异常处理等功能。

## 2. 技术栈

- **开发语言**: MicroPython
- **MQTT 客户端**: umqtt.simple
- **网络管理**: network
- **加密库**: hashlib, ubinascii
- **存储**: json, ujson

## 3. 模块结构

```
esp32/
├── mqtt_client.py       # MQTT 客户端模块
├── network_manager.py   # 网络管理模块
├── auth_manager.py      # 认证管理模块
├── data_manager.py      # 数据管理模块
├── config_manager.py    # 配置管理模块
└── main.py              # 主程序
```

## 4. 核心模块实现

### 4.1 网络管理模块 (network_manager.py)

```python
import network
import time

class NetworkManager:
    def __init__(self, ssid, password):
        self.ssid = ssid
        self.password = password
        self.wlan = network.WLAN(network.STA_IF)
    
    def connect(self):
        """连接到 WiFi 网络"""
        self.wlan.active(True)
        if not self.wlan.isconnected():
            print('Connecting to WiFi...')
            self.wlan.connect(self.ssid, self.password)
            # 等待连接
            max_wait = 10
            while max_wait > 0:
                if self.wlan.status() < 0 or self.wlan.status() >= 3:
                    break
                max_wait -= 1
                print('Waiting for connection...')
                time.sleep(1)
        
        if self.wlan.isconnected():
            print('Connected to WiFi')
            print('Network config:', self.wlan.ifconfig())
            return True
        else:
            print('WiFi connection failed')
            return False
    
    def is_connected(self):
        """检查网络连接状态"""
        return self.wlan.isconnected()
    
    def reconnect(self):
        """重新连接网络"""
        if not self.is_connected():
            return self.connect()
        return True
```

### 4.2 认证管理模块 (auth_manager.py)

```python
import urequests
import json

class AuthManager:
    def __init__(self, device_id, api_url):
        self.device_id = device_id
        self.api_url = api_url
        self.auth_info = None
    
    def register(self, device_type, mac_address, firmware_version):
        """设备注册"""
        url = f"{self.api_url}/api/device/register"
        data = {
            "device_id": self.device_id,
            "device_type": device_type,
            "mac_address": mac_address,
            "firmware_version": firmware_version
        }
        
        try:
            response = urequests.post(url, json=data)
            if response.status_code == 200:
                self.auth_info = response.json()['data']
                print('Device registered successfully')
                return True
            else:
                print('Registration failed:', response.text)
                return False
        except Exception as e:
            print('Registration error:', e)
            return False
    
    def login(self, password):
        """设备登录"""
        url = f"{self.api_url}/api/device/login"
        data = {
            "device_id": self.device_id,
            "password": password
        }
        
        try:
            response = urequests.post(url, json=data)
            if response.status_code == 200:
                self.auth_info = response.json()['data']
                print('Device logged in successfully')
                return True
            else:
                print('Login failed:', response.text)
                return False
        except Exception as e:
            print('Login error:', e)
            return False
    
    def get_auth_info(self):
        """获取认证信息"""
        return self.auth_info
```

### 4.3 MQTT 客户端模块 (mqtt_client.py)

```python
from umqtt.simple import MQTTClient
import json
import time

class MQTTClientWrapper:
    def __init__(self, client_id, server, port=1883, user=None, password=None, keepalive=60):
        self.client_id = client_id
        self.server = server
        self.port = port
        self.user = user
        self.password = password
        self.keepalive = keepalive
        self.client = None
        self.connected = False
    
    def connect(self):
        """连接到 MQTT Broker"""
        try:
            self.client = MQTTClient(
                client_id=self.client_id,
                server=self.server,
                port=self.port,
                user=self.user,
                password=self.password,
                keepalive=self.keepalive
            )
            self.client.connect()
            self.connected = True
            print('MQTT connected successfully')
            return True
        except Exception as e:
            print('MQTT connection failed:', e)
            self.connected = False
            return False
    
    def publish(self, topic, message):
        """发布消息"""
        if not self.connected:
            if not self.connect():
                return False
        
        try:
            if isinstance(message, dict):
                message = json.dumps(message)
            self.client.publish(topic, message)
            return True
        except Exception as e:
            print('Publish error:', e)
            self.connected = False
            return False
    
    def subscribe(self, topic, callback):
        """订阅主题"""
        if not self.connected:
            if not self.connect():
                return False
        
        try:
            self.client.set_callback(callback)
            self.client.subscribe(topic)
            return True
        except Exception as e:
            print('Subscribe error:', e)
            self.connected = False
            return False
    
    def check_msg(self):
        """检查消息"""
        if not self.connected:
            if not self.connect():
                return False
        
        try:
            self.client.check_msg()
            return True
        except Exception as e:
            print('Check message error:', e)
            self.connected = False
            return False
    
    def disconnect(self):
        """断开连接"""
        try:
            if self.client:
                self.client.disconnect()
            self.connected = False
            print('MQTT disconnected')
        except Exception as e:
            print('Disconnect error:', e)
    
    def is_connected(self):
        """检查连接状态"""
        return self.connected
```

### 4.4 数据管理模块 (data_manager.py)

```python
import json
import time

class DataManager:
    def __init__(self, device_id):
        self.device_id = device_id
    
    def create_status_message(self, battery, signal_strength, is_online, current_task, progress, temperature=None, humidity=None):
        """创建设备状态消息"""
        message = {
            "device_id": self.device_id,
            "timestamp": int(time.time() * 1000),
            "status": {
                "battery": battery,
                "signal_strength": signal_strength,
                "is_online": is_online,
                "current_task": current_task,
                "progress": progress
            }
        }
        
        if temperature is not None or humidity is not None:
            message["sensors"] = {}
            if temperature is not None:
                message["sensors"]["temperature"] = temperature
            if humidity is not None:
                message["sensors"]["humidity"] = humidity
        
        return message
    
    def create_response_message(self, command_id, status, message):
        """创建设备响应消息"""
        return {
            "device_id": self.device_id,
            "timestamp": int(time.time() * 1000),
            "command_id": command_id,
            "status": status,
            "message": message
        }
    
    def parse_command(self, message):
        """解析命令消息"""
        try:
            if isinstance(message, bytes):
                message = message.decode('utf-8')
            return json.loads(message)
        except Exception as e:
            print('Parse command error:', e)
            return None
```

### 4.5 配置管理模块 (config_manager.py)

```python
import json
import os

class ConfigManager:
    def __init__(self, config_file='config.json'):
        self.config_file = config_file
        self.config = {}
        self.load_config()
    
    def load_config(self):
        """加载配置"""
        try:
            with open(self.config_file, 'r') as f:
                self.config = json.load(f)
        except Exception as e:
            print('Load config error:', e)
            # 使用默认配置
            self.config = {
                "wifi": {
                    "ssid": "",
                    "password": ""
                },
                "api": {
                    "url": "http://api.example.com"
                },
                "device": {
                    "id": "",
                    "type": "esp32",
                    "mac_address": "",
                    "firmware_version": "1.0.0"
                },
                "mqtt": {
                    "broker": "",
                    "client_id": "",
                    "username": "",
                    "password": ""
                }
            }
    
    def save_config(self):
        """保存配置"""
        try:
            with open(self.config_file, 'w') as f:
                json.dump(self.config, f)
            return True
        except Exception as e:
            print('Save config error:', e)
            return False
    
    def get(self, key, default=None):
        """获取配置"""
        keys = key.split('.')
        value = self.config
        for k in keys:
            if k in value:
                value = value[k]
            else:
                return default
        return value
    
    def set(self, key, value):
        """设置配置"""
        keys = key.split('.')
        config = self.config
        for k in keys[:-1]:
            if k not in config:
                config[k] = {}
            config = config[k]
        config[keys[-1]] = value
        return self.save_config()
```

### 4.6 主程序 (main.py)

```python
import time
from network_manager import NetworkManager
from auth_manager import AuthManager
from mqtt_client import MQTTClientWrapper
from data_manager import DataManager
from config_manager import ConfigManager

# 加载配置
config = ConfigManager()

# 初始化网络管理器
wifi_ssid = config.get('wifi.ssid')
wifi_password = config.get('wifi.password')
network_manager = NetworkManager(wifi_ssid, wifi_password)

# 初始化数据管理器
device_id = config.get('device.id')
data_manager = DataManager(device_id)

# 初始化认证管理器
api_url = config.get('api.url')
auth_manager = AuthManager(device_id, api_url)

# 初始化 MQTT 客户端
mqtt_broker = config.get('mqtt.broker')
mqtt_client_id = config.get('mqtt.client_id')
mqtt_username = config.get('mqtt.username')
mqtt_password = config.get('mqtt.password')
mqtt_client = MQTTClientWrapper(
    client_id=mqtt_client_id,
    server=mqtt_broker,
    user=mqtt_username,
    password=mqtt_password
)

# 命令回调函数
def command_callback(topic, message):
    print('Received command:', topic, message)
    # 解析命令
    command = data_manager.parse_command(message)
    if command:
        # 处理命令
        command_id = command.get('command_id', 'unknown')
        command_type = command.get('command')
        
        # 执行命令
        if command_type == 'start_task':
            # 开始任务
            task_id = command.get('task_id')
            print(f'Starting task: {task_id}')
            # 发送响应
            response = data_manager.create_response_message(
                command_id, "success", f"Task {task_id} started"
            )
            mqtt_client.publish(f"devices/{device_id}/response", response)
        elif command_type == 'stop_task':
            # 停止任务
            task_id = command.get('task_id')
            print(f'Stopping task: {task_id}')
            # 发送响应
            response = data_manager.create_response_message(
                command_id, "success", f"Task {task_id} stopped"
            )
            mqtt_client.publish(f"devices/{device_id}/response", response)

# 主循环
def main():
    # 连接网络
    if not network_manager.connect():
        print('Network connection failed, exiting')
        return
    
    # 登录设备
    if not auth_manager.login(config.get('mqtt.password')):
        print('Device login failed, exiting')
        return
    
    # 更新 MQTT 配置
    auth_info = auth_manager.get_auth_info()
    if auth_info:
        config.set('mqtt.broker', auth_info.get('mqtt_broker'))
        config.set('mqtt.client_id', auth_info.get('client_id'))
        config.set('mqtt.username', auth_info.get('username'))
        config.set('mqtt.password', auth_info.get('password'))
    
    # 连接 MQTT
    if not mqtt_client.connect():
        print('MQTT connection failed, exiting')
        return
    
    # 订阅命令主题
    mqtt_client.subscribe(f"devices/{device_id}/commands", command_callback)
    
    # 主循环
    while True:
        # 检查网络连接
        if not network_manager.is_connected():
            print('Network disconnected, reconnecting...')
            network_manager.reconnect()
        
        # 检查 MQTT 连接
        if not mqtt_client.is_connected():
            print('MQTT disconnected, reconnecting...')
            mqtt_client.connect()
            # 重新订阅
            mqtt_client.subscribe(f"devices/{device_id}/commands", command_callback)
        
        # 发送设备状态
        status_message = data_manager.create_status_message(
            battery=85,
            signal_strength=75,
            is_online=True,
            current_task="task_001",
            progress=50,
            temperature=25.5,
            humidity=45
        )
        mqtt_client.publish(f"devices/{device_id}/status", status_message)
        
        # 检查 MQTT 消息
        mqtt_client.check_msg()
        
        # 等待
        time.sleep(10)

if __name__ == '__main__':
    main()
```

## 5. 功能测试

### 5.1 网络连接测试

- **测试目标**: 验证网络连接功能
- **测试步骤**:
  1. 配置正确的 WiFi 信息
  2. 运行网络连接测试
  3. 验证连接状态

### 5.2 设备认证测试

- **测试目标**: 验证设备注册和登录功能
- **测试步骤**:
  1. 运行设备注册测试
  2. 运行设备登录测试
  3. 验证认证信息获取

### 5.3 MQTT 通信测试

- **测试目标**: 验证 MQTT 连接和消息收发功能
- **测试步骤**:
  1. 运行 MQTT 连接测试
  2. 测试消息发布
  3. 测试消息订阅

### 5.4 网络异常处理测试

- **测试目标**: 验证网络异常时的重连机制
- **测试步骤**:
  1. 运行正常连接
  2. 模拟网络中断
  3. 恢复网络
  4. 验证自动重连

## 6. 性能优化

### 6.1 资源优化

- **内存使用**: 使用轻量级库，避免内存泄漏
- **CPU 使用**: 优化循环和睡眠时间
- **网络使用**: 减少不必要的网络请求

### 6.2 可靠性优化

- **重连机制**: 实现指数退避重连
- **错误处理**: 完善异常捕获和处理
- **心跳机制**: 定期发送心跳消息

### 6.3 安全性优化

- **数据加密**: 实现数据传输加密
- **认证安全**: 保护认证信息
- **防重放攻击**: 实现消息 timestamp 验证

## 7. 部署与更新

### 7.1 初始部署

1. 烧录 MicroPython 固件
2. 上传代码文件
3. 配置 WiFi 和 API 信息
4. 启动设备

### 7.2 固件更新

1. 通过 MQTT 下发更新指令
2. 设备下载新固件
3. 验证固件完整性
4. 刷写固件并重启

## 8. 故障排查

### 8.1 常见问题

| 问题 | 可能原因 | 解决方案 |
|------|----------|----------|
| 网络连接失败 | WiFi 信息错误 | 检查 WiFi 配置 |
| 认证失败 | 设备未注册 | 重新注册设备 |
| MQTT 连接失败 | Broker 地址错误 | 检查 MQTT 配置 |
| 消息发送失败 | 网络不稳定 | 实现重试机制 |

### 8.2 日志记录

- 实现详细的日志记录
- 支持远程日志上传
- 提供故障诊断工具

## 9. 总结

ESP32 通信模块的开发是 Small Steps 项目的重要组成部分，通过实现 MQTT 通信、设备认证、数据加密和网络异常处理等功能，确保了设备与后端 API 服务的稳定通信。本方案考虑了 ESP32 的资源限制，采用了轻量级的实现方式，同时保证了系统的可靠性和安全性。
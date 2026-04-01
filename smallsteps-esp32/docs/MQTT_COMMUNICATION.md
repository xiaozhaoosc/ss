# MQTT 通信指南

## 概述

Small Steps ESP32 设备通过 MQTT 协议与服务器进行通信，实现任务同步、状态更新、配置管理等功能。

## MQTT 配置

### 服务器配置

在 `config.py` 文件中配置 MQTT 服务器信息：

```python
# MQTT 服务器配置
MQTT_BROKER = "mqtt.example.com"
MQTT_PORT = 1883
MQTT_USERNAME = "smallsteps"
MQTT_PASSWORD = "password"
MQTT_CLIENT_ID = "esp32_" + ubinascii.hexlify(machine.unique_id()).decode()
```

### 主题结构

设备使用以下 MQTT 主题进行通信：

#### 设备订阅的主题

- **smallsteps/device/{device_id}/tasks**：接收任务信息
- **smallsteps/device/{device_id}/config**：接收配置更新
- **smallsteps/device/{device_id}/commands**：接收控制命令

#### 设备发布的主题

- **smallsteps/device/{device_id}/status**：发布设备状态
- **smallsteps/device/{device_id}/task_progress**：发布任务进度
- **smallsteps/device/{device_id}/events**：发布设备事件

## 消息格式

### 任务消息

**订阅主题**：`smallsteps/device/{device_id}/tasks`

**消息格式**：

```json
{
  "task_id": "1",
  "task_name": "完成作业",
  "task_desc": "完成数学作业",
  "steps": [
    {
      "step_id": "1",
      "step_name": "准备课本",
      "step_desc": "拿出数学课本和练习本"
    },
    {
      "step_id": "2",
      "step_name": "完成第一题",
      "step_desc": "解决课本第10页的第一题"
    }
  ],
  "reward_points": 10,
  "deadline": "2024-01-01T18:00:00"
}
```

### 配置消息

**订阅主题**：`smallsteps/device/{device_id}/config`

**消息格式**：

```json
{
  "focus_duration": 25,
  "break_duration": 5,
  "led_brightness": 80,
  "volume": 70,
  "auto_connect": true
}
```

### 命令消息

**订阅主题**：`smallsteps/device/{device_id}/commands`

**消息格式**：

```json
{
  "command": "start_focus",
  "params": {
    "duration": 30
  }
}
```

### 状态消息

**发布主题**：`smallsteps/device/{device_id}/status`

**消息格式**：

```json
{
  "status": "online",
  "battery": 80,
  "wifi_signal": -65,
  "current_task": "1",
  "current_step": "2"
}
```

### 任务进度消息

**发布主题**：`smallsteps/device/{device_id}/task_progress`

**消息格式**：

```json
{
  "task_id": "1",
  "step_id": "2",
  "status": "completed",
  "progress": 67,
  "timestamp": "2024-01-01T12:30:00"
}
```

### 事件消息

**发布主题**：`smallsteps/device/{device_id}/events`

**消息格式**：

```json
{
  "event_type": "nfc_scan",
  "data": {
    "tag_id": "12345678",
    "action": "start_task",
    "task_id": "1"
  },
  "timestamp": "2024-01-01T12:00:00"
}
```

## 通信流程

### 设备启动流程

1. 设备启动并连接到 Wi-Fi
2. 初始化 MQTT 客户端
3. 连接到 MQTT 服务器
4. 订阅设备相关主题
5. 发布设备上线状态
6. 请求同步任务和配置

### 任务同步流程

1. 服务器向设备发送任务消息
2. 设备接收任务消息并解析
3. 设备将任务存储到本地
4. 设备更新任务状态并发布进度
5. 服务器接收任务进度并更新数据库

### 配置更新流程

1. 服务器向设备发送配置消息
2. 设备接收配置消息并解析
3. 设备更新本地配置
4. 设备重启以应用新配置（如果需要）

### 命令执行流程

1. 服务器向设备发送命令消息
2. 设备接收命令消息并解析
3. 设备执行相应命令
4. 设备发布命令执行结果

## 离线处理

设备支持离线工作模式：

1. **任务缓存**：将任务存储到本地，离线时仍可执行
2. **进度存储**：将任务进度存储到本地
3. **重连同步**：重新连接后同步任务进度和状态

## 安全措施

1. **认证**：使用用户名和密码进行 MQTT 认证
2. **加密**：使用 TLS 加密 MQTT 连接
3. **设备标识**：使用设备唯一 ID 作为客户端 ID
4. **消息验证**：验证消息格式和内容

## 故障排除

### 连接问题

- **症状**：设备无法连接到 MQTT 服务器
- **解决方案**：
  1. 检查网络连接
  2. 检查 MQTT 服务器地址和端口
  3. 检查用户名和密码
  4. 检查防火墙设置

### 消息丢失

- **症状**：设备发送的消息服务器未收到，或服务器发送的消息设备未收到
- **解决方案**：
  1. 检查网络稳定性
  2. 检查 MQTT 主题是否正确
  3. 检查消息格式是否正确
  4. 启用 MQTT 遗嘱消息

### 重复消息

- **症状**：设备收到重复的消息
- **解决方案**：
  1. 实现消息去重机制
  2. 使用 QoS 1 或 QoS 2 确保消息可靠传递

## 代码示例

### 初始化 MQTT 客户端

```python
from umqtt.simple import MQTTClient
import ubinascii
import machine

# 生成客户端 ID
client_id = "esp32_" + ubinascii.hexlify(machine.unique_id()).decode()

# 创建 MQTT 客户端
client = MQTTClient(
    client_id,
    MQTT_BROKER,
    port=MQTT_PORT,
    user=MQTT_USERNAME,
    password=MQTT_PASSWORD
)

# 设置回调函数
client.set_callback(sub_cb)

# 连接到 MQTT 服务器
client.connect()

# 订阅主题
client.subscribe(b"smallsteps/device/{}/tasks".format(device_id))
client.subscribe(b"smallsteps/device/{}/config".format(device_id))
client.subscribe(b"smallsteps/device/{}/commands".format(device_id))
```

### 发布消息

```python
import json

# 发布设备状态
def publish_status():
    status = {
        "status": "online",
        "battery": get_battery_level(),
        "wifi_signal": get_wifi_signal(),
        "current_task": current_task_id,
        "current_step": current_step_id
    }
    client.publish(
        b"smallsteps/device/{}/status".format(device_id),
        json.dumps(status)
    )

# 发布任务进度
def publish_task_progress(task_id, step_id, status, progress):
    progress_data = {
        "task_id": task_id,
        "step_id": step_id,
        "status": status,
        "progress": progress,
        "timestamp": get_current_time()
    }
    client.publish(
        b"smallsteps/device/{}/task_progress".format(device_id),
        json.dumps(progress_data)
    )
```

### 订阅回调

```python
import json

def sub_cb(topic, msg):
    topic_str = topic.decode()
    msg_str = msg.decode()
    
    print("Received message on topic:", topic_str)
    print("Message:", msg_str)
    
    # 处理任务消息
    if "tasks" in topic_str:
        handle_task_message(msg_str)
    
    # 处理配置消息
    elif "config" in topic_str:
        handle_config_message(msg_str)
    
    # 处理命令消息
    elif "commands" in topic_str:
        handle_command_message(msg_str)

def handle_task_message(msg_str):
    try:
        task_data = json.loads(msg_str)
        # 处理任务数据
        save_task(task_data)
        print("Task received and saved:", task_data["task_name"])
    except Exception as e:
        print("Error handling task message:", e)

def handle_config_message(msg_str):
    try:
        config_data = json.loads(msg_str)
        # 处理配置数据
        update_config(config_data)
        print("Config updated")
    except Exception as e:
        print("Error handling config message:", e)

def handle_command_message(msg_str):
    try:
        command_data = json.loads(msg_str)
        # 处理命令
        execute_command(command_data)
        print("Command executed:", command_data["command"])
    except Exception as e:
        print("Error handling command message:", e)
```

## 最佳实践

1. **保持连接**：定期发送心跳消息，确保连接稳定
2. **错误处理**：实现完善的错误处理机制
3. **消息格式**：使用 JSON 格式，确保消息结构清晰
4. **主题设计**：使用层次化的主题结构，便于管理
5. **QoS 选择**：根据消息重要性选择合适的 QoS 级别
6. **离线支持**：实现离线缓存和重连机制
7. **安全性**：使用 TLS 加密和强密码认证

## 参考资料

- [MQTT 协议规范](https://mqtt.org/mqtt-specification/)
- [MicroPython MQTT 文档](https://docs.micropython.org/en/latest/esp32/quickref.html#mqtt)
- [MQTT 最佳实践](https://www.hivemq.com/blog/mqtt-best-practices/)

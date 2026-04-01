# API 接口设计文档

## 1. 接口概述

本文档定义了 Small Steps 项目中与 ESP32 硬件终端相关的 API 接口设计，包括设备认证、状态上报、任务指令下发等功能。

## 2. 技术栈

- **框架**: Spring Boot
- **MQTT Broker**: EMQ X
- **数据库**: PostgreSQL
- **认证**: JWT

## 3. API 接口设计

### 3.1 设备认证接口

#### 3.1.1 设备注册

- **URL**: `/api/device/register`
- **方法**: POST
- **请求体**:
  ```json
  {
    "device_id": "esp32-001",
    "device_type": "esp32",
    "mac_address": "00:11:22:33:44:55",
    "firmware_version": "1.0.0"
  }
  ```
- **响应**:
  ```json
  {
    "code": 200,
    "message": "success",
    "data": {
      "device_id": "esp32-001",
      "client_id": "esp32-001",
      "username": "esp32-001",
      "password": "random_password",
      "mqtt_broker": "mqtt://broker.example.com:1883"
    }
  }
  ```

#### 3.1.2 设备登录

- **URL**: `/api/device/login`
- **方法**: POST
- **请求体**:
  ```json
  {
    "device_id": "esp32-001",
    "password": "random_password"
  }
  ```
- **响应**:
  ```json
  {
    "code": 200,
    "message": "success",
    "data": {
      "token": "jwt_token",
      "expires_in": 86400,
      "mqtt_broker": "mqtt://broker.example.com:1883",
      "client_id": "esp32-001",
      "username": "esp32-001",
      "password": "random_password"
    }
  }
  ```

### 3.2 设备状态接口

#### 3.2.1 设备状态上报

- **URL**: `/api/device/status`
- **方法**: POST
- **请求体**:
  ```json
  {
    "device_id": "esp32-001",
    "timestamp": 1717248000000,
    "status": {
      "battery": 85,
      "signal_strength": 75,
      "is_online": true,
      "current_task": "task_001",
      "progress": 50
    },
    "sensors": {
      "temperature": 25.5,
      "humidity": 45
    }
  }
  ```
- **响应**:
  ```json
  {
    "code": 200,
    "message": "success",
    "data": {
      "status": "received"
    }
  }
  ```

### 3.3 任务管理接口

#### 3.3.1 下发任务指令

- **URL**: `/api/device/task`
- **方法**: POST
- **请求体**:
  ```json
  {
    "device_id": "esp32-001",
    "command": "start_task",
    "task_id": "task_002",
    "task_data": {
      "name": "完成作业",
      "steps": [
        "准备课本和笔记本",
        "完成数学作业",
        "完成语文作业",
        "检查作业"
      ],
      "duration": 30,
      "reward": "10 积分"
    }
  }
  ```
- **响应**:
  ```json
  {
    "code": 200,
    "message": "success",
    "data": {
      "status": "sent"
    }
  }
  ```

#### 3.3.2 获取设备任务列表

- **URL**: `/api/device/tasks/{device_id}`
- **方法**: GET
- **响应**:
  ```json
  {
    "code": 200,
    "message": "success",
    "data": {
      "tasks": [
        {
          "task_id": "task_001",
          "name": "完成作业",
          "status": "in_progress",
          "progress": 50,
          "created_at": "2026-04-01T00:00:00Z"
        },
        {
          "task_id": "task_002",
          "name": "整理书包",
          "status": "pending",
          "progress": 0,
          "created_at": "2026-04-01T00:00:00Z"
        }
      ]
    }
  }
  ```

### 3.4 MQTT 主题设计

#### 3.4.1 设备状态上报主题
- **主题**: `devices/{device_id}/status`
- **方向**: 设备 → 服务器
- **消息格式**: 同设备状态上报接口

#### 3.4.2 任务指令下发主题
- **主题**: `devices/{device_id}/commands`
- **方向**: 服务器 → 设备
- **消息格式**: 同任务指令下发接口

#### 3.4.3 设备响应主题
- **主题**: `devices/{device_id}/response`
- **方向**: 设备 → 服务器
- **消息格式**:
  ```json
  {
    "device_id": "esp32-001",
    "timestamp": 1717248000000,
    "command_id": "cmd_001",
    "status": "success",
    "message": "任务已开始"
  }
  ```

## 4. 认证与安全

### 4.1 设备认证

1. **设备注册**: 设备首次连接时，通过 API 注册获取认证信息
2. **设备登录**: 设备每次启动时，通过 API 登录获取 MQTT 连接信息和 JWT token
3. **MQTT 认证**: 使用设备 ID 和密码进行 MQTT 连接认证
4. **API 认证**: 使用 JWT token 进行 API 接口认证

### 4.2 数据安全

1. **TLS 加密**: MQTT 连接使用 TLS 加密
2. **数据加密**: 敏感数据传输前进行加密
3. **访问控制**: 基于设备 ID 的访问控制
4. **审计日志**: 记录设备操作日志

## 5. 错误处理

### 5.1 错误码定义

| 错误码 | 描述 |
|--------|------|
| 400 | 请求参数错误 |
| 401 | 认证失败 |
| 403 | 权限不足 |
| 404 | 设备不存在 |
| 500 | 服务器内部错误 |

### 5.2 错误响应格式

```json
{
  "code": 401,
  "message": "认证失败",
  "data": null
}
```

## 6. 实现建议

1. **模块化设计**: 将设备管理、任务管理等功能模块化
2. **异步处理**: 使用消息队列处理设备状态和任务指令
3. **缓存机制**: 使用 Redis 缓存设备状态和认证信息
4. **监控告警**: 实现设备在线状态监控和异常告警
5. **日志记录**: 详细记录设备操作和系统事件

## 7. 测试计划

1. **单元测试**: 测试各个 API 接口的功能
2. **集成测试**: 测试设备与 API 的集成
3. **性能测试**: 测试系统在多设备并发情况下的性能
4. **安全测试**: 测试系统的安全性和防护能力
5. **可靠性测试**: 测试系统在网络异常情况下的可靠性
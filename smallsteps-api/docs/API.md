# API 文档

## 认证接口

### 登录

**请求方式：** POST
**请求地址：** `/login`
**请求参数：**

| 参数名 | 类型 | 必填 | 描述 |
|--------|------|------|------|
| username | string | 是 | 用户名 |
| password | string | 是 | 密码 |
| code | string | 是 | 验证码 |
| uuid | string | 是 | 验证码UUID |

**返回示例：**

```json
{
  "code": 200,
  "msg": "操作成功",
  "data": {
    "token": "xxx",
    "user": {
      "userId": 1,
      "username": "admin",
      "nickName": "管理员",
      "avatar": "xxx"
    }
  }
}
```

### 注册

**请求方式：** POST
**请求地址：** `/register`
**请求参数：**

| 参数名 | 类型 | 必填 | 描述 |
|--------|------|------|------|
| username | string | 是 | 用户名 |
| password | string | 是 | 密码 |
| nickname | string | 是 | 昵称 |
| mobile | string | 是 | 手机号 |
| code | string | 是 | 验证码 |

**返回示例：**

```json
{
  "code": 200,
  "msg": "操作成功",
  "data": {
    "userId": 1
  }
}
```

## 任务管理接口

### 创建任务

**请求方式：** POST
**请求地址：** `/task/create`
**请求参数：**

| 参数名 | 类型 | 必填 | 描述 |
|--------|------|------|------|
| taskName | string | 是 | 任务名称 |
| taskDesc | string | 是 | 任务描述 |
| childId | long | 是 | 儿童ID |
| steps | array | 是 | 任务步骤 |
| rewardPoints | int | 是 | 奖励积分 |
| deadline | string | 否 | 截止时间 |

**返回示例：**

```json
{
  "code": 200,
  "msg": "操作成功",
  "data": {
    "taskId": 1
  }
}
```

### 获取任务列表

**请求方式：** GET
**请求地址：** `/task/list`
**请求参数：**

| 参数名 | 类型 | 必填 | 描述 |
|--------|------|------|------|
| childId | long | 否 | 儿童ID |
| status | int | 否 | 任务状态 |
| pageNum | int | 是 | 页码 |
| pageSize | int | 是 | 每页大小 |

**返回示例：**

```json
{
  "code": 200,
  "msg": "操作成功",
  "data": {
    "total": 10,
    "rows": [
      {
        "taskId": 1,
        "taskName": "完成作业",
        "taskDesc": "完成数学作业",
        "status": 1,
        "rewardPoints": 10,
        "createTime": "2024-01-01 12:00:00"
      }
    ]
  }
}
```

### 更新任务状态

**请求方式：** PUT
**请求地址：** `/task/updateStatus`
**请求参数：**

| 参数名 | 类型 | 必填 | 描述 |
|--------|------|------|------|
| taskId | long | 是 | 任务ID |
| status | int | 是 | 任务状态 |

**返回示例：**

```json
{
  "code": 200,
  "msg": "操作成功"
}
```

## 奖励系统接口

### 配置奖励

**请求方式：** POST
**请求地址：** `/reward/config`
**请求参数：**

| 参数名 | 类型 | 必填 | 描述 |
|--------|------|------|------|
| rewardName | string | 是 | 奖励名称 |
| points | int | 是 | 所需积分 |
| description | string | 是 | 奖励描述 |
| imageUrl | string | 否 | 奖励图片 |

**返回示例：**

```json
{
  "code": 200,
  "msg": "操作成功",
  "data": {
    "rewardId": 1
  }
}
```

### 兑换奖励

**请求方式：** POST
**请求地址：** `/reward/exchange`
**请求参数：**

| 参数名 | 类型 | 必填 | 描述 |
|--------|------|------|------|
| childId | long | 是 | 儿童ID |
| rewardId | long | 是 | 奖励ID |

**返回示例：**

```json
{
  "code": 200,
  "msg": "操作成功"
}
```

### 获取积分记录

**请求方式：** GET
**请求地址：** `/reward/scoreHistory`
**请求参数：**

| 参数名 | 类型 | 必填 | 描述 |
|--------|------|------|------|
| childId | long | 是 | 儿童ID |
| pageNum | int | 是 | 页码 |
| pageSize | int | 是 | 每页大小 |

**返回示例：**

```json
{
  "code": 200,
  "msg": "操作成功",
  "data": {
    "total": 5,
    "rows": [
      {
        "id": 1,
        "childId": 1,
        "points": 10,
        "type": "task",
        "description": "完成作业",
        "createTime": "2024-01-01 12:00:00"
      }
    ]
  }
}
```

## 设备管理接口

### 注册设备

**请求方式：** POST
**请求地址：** `/device/register`
**请求参数：**

| 参数名 | 类型 | 必填 | 描述 |
|--------|------|------|------|
| deviceId | string | 是 | 设备ID |
| deviceName | string | 是 | 设备名称 |
| childId | long | 是 | 儿童ID |

**返回示例：**

```json
{
  "code": 200,
  "msg": "操作成功",
  "data": {
    "deviceId": "xxx"
  }
}
```

### 获取设备状态

**请求方式：** GET
**请求地址：** `/device/status`
**请求参数：**

| 参数名 | 类型 | 必填 | 描述 |
|--------|------|------|------|
| deviceId | string | 是 | 设备ID |

**返回示例：**

```json
{
  "code": 200,
  "msg": "操作成功",
  "data": {
    "deviceId": "xxx",
    "status": "online",
    "battery": 80,
    "lastOnline": "2024-01-01 12:00:00"
  }
}
```

### 配置设备

**请求方式：** PUT
**请求地址：** `/device/config`
**请求参数：**

| 参数名 | 类型 | 必填 | 描述 |
|--------|------|------|------|
| deviceId | string | 是 | 设备ID |
| config | object | 是 | 设备配置 |

**返回示例：**

```json
{
  "code": 200,
  "msg": "操作成功"
}
```

## AI 服务接口

### 任务拆解

**请求方式：** POST
**请求地址：** `/ai/taskBreakdown`
**请求参数：**

| 参数名 | 类型 | 必填 | 描述 |
|--------|------|------|------|
| taskName | string | 是 | 任务名称 |
| taskDesc | string | 是 | 任务描述 |
| childAge | int | 是 | 儿童年龄 |

**返回示例：**

```json
{
  "code": 200,
  "msg": "操作成功",
  "data": {
    "steps": [
      {
        "stepName": "准备课本",
        "stepDesc": "拿出数学课本和练习本"
      },
      {
        "stepName": "完成第一题",
        "stepDesc": "解决课本第10页的第一题"
      }
    ]
  }
}
```

### 情绪分析

**请求方式：** POST
**请求地址：** `/ai/emotionAnalysis`
**请求参数：**

| 参数名 | 类型 | 必填 | 描述 |
|--------|------|------|------|
| childId | long | 是 | 儿童ID |
| content | string | 是 | 分析内容 |

**返回示例：**

```json
{
  "code": 200,
  "msg": "操作成功",
  "data": {
    "emotion": "焦虑",
    "level": 3,
    "suggestion": "建议家长给予鼓励，帮助孩子分解任务"
  }
}
```

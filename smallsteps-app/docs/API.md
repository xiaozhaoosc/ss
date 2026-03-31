# API 文档

## 认证接口

### 登录

**请求方式：** POST
**请求地址：** `/api/auth/login`
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
      "avatar": "xxx",
      "userType": "parent" // parent 或 child
    }
  }
}
```

### 注册

**请求方式：** POST
**请求地址：** `/api/auth/register`
**请求参数：**

| 参数名 | 类型 | 必填 | 描述 |
|--------|------|------|------|
| username | string | 是 | 用户名 |
| password | string | 是 | 密码 |
| nickname | string | 是 | 昵称 |
| mobile | string | 是 | 手机号 |
| code | string | 是 | 验证码 |
| userType | string | 是 | 用户类型（parent 或 child） |

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

## 任务接口

### 获取任务列表

**请求方式：** GET
**请求地址：** `/api/task/list`
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
        "createTime": "2024-01-01 12:00:00",
        "steps": [
          {
            "stepId": 1,
            "stepName": "准备课本",
            "stepDesc": "拿出数学课本和练习本",
            "status": 1
          }
        ]
      }
    ]
  }
}
```

### 创建任务

**请求方式：** POST
**请求地址：** `/api/task/create`
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

### 更新任务状态

**请求方式：** PUT
**请求地址：** `/api/task/updateStatus`
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

### 更新步骤状态

**请求方式：** PUT
**请求地址：** `/api/task/updateStepStatus`
**请求参数：**

| 参数名 | 类型 | 必填 | 描述 |
|--------|------|------|------|
| stepId | long | 是 | 步骤ID |
| status | int | 是 | 步骤状态 |

**返回示例：**

```json
{
  "code": 200,
  "msg": "操作成功"
}
```

## 奖励接口

### 获取奖励列表

**请求方式：** GET
**请求地址：** `/api/reward/list`
**请求参数：**

| 参数名 | 类型 | 必填 | 描述 |
|--------|------|------|------|
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
        "rewardId": 1,
        "rewardName": "玩具车",
        "points": 100,
        "description": "一辆精美的玩具车",
        "imageUrl": "xxx"
      }
    ]
  }
}
```

### 兑换奖励

**请求方式：** POST
**请求地址：** `/api/reward/exchange`
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
**请求地址：** `/api/reward/scoreHistory`
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
    "total": 10,
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

## 设备接口

### 获取设备列表

**请求方式：** GET
**请求地址：** `/api/device/list`
**请求参数：**

| 参数名 | 类型 | 必填 | 描述 |
|--------|------|------|------|
| childId | long | 否 | 儿童ID |

**返回示例：**

```json
{
  "code": 200,
  "msg": "操作成功",
  "data": [
    {
      "deviceId": "xxx",
      "deviceName": "Small Steps 设备",
      "childId": 1,
      "status": "online",
      "battery": 80,
      "lastOnline": "2024-01-01 12:00:00"
    }
  ]
}
```

### 注册设备

**请求方式：** POST
**请求地址：** `/api/device/register`
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

### 配置设备

**请求方式：** PUT
**请求地址：** `/api/device/config`
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

## 情绪分析接口

### 获取情绪记录

**请求方式：** GET
**请求地址：** `/api/emotion/list`
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
        "emotion": "焦虑",
        "level": 3,
        "suggestion": "建议家长给予鼓励",
        "createTime": "2024-01-01 12:00:00"
      }
    ]
  }
}
```

### 分析情绪

**请求方式：** POST
**请求地址：** `/api/emotion/analyze`
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

## 儿童信息接口

### 获取儿童信息

**请求方式：** GET
**请求地址：** `/api/child/info`
**请求参数：**

| 参数名 | 类型 | 必填 | 描述 |
|--------|------|------|------|
| childId | long | 是 | 儿童ID |

**返回示例：**

```json
{
  "code": 200,
  "msg": "操作成功",
  "data": {
    "childId": 1,
    "childName": "小明",
    "age": 8,
    "avatar": "xxx",
    "totalPoints": 100,
    "completedTasks": 20,
    "trophies": [
      {
        "trophyId": 1,
        "name": "第一次完成任务",
        "description": "完成了第一个任务",
        "icon": "xxx"
      }
    ]
  }
}
```

### 更新儿童信息

**请求方式：** PUT
**请求地址：** `/api/child/update`
**请求参数：**

| 参数名 | 类型 | 必填 | 描述 |
|--------|------|------|------|
| childId | long | 是 | 儿童ID |
| childName | string | 否 | 儿童姓名 |
| age | int | 否 | 年龄 |
| avatar | string | 否 | 头像 |

**返回示例：**

```json
{
  "code": 200,
  "msg": "操作成功"
}
```

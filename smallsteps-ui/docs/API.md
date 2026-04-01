# API 文档

## 认证接口

### 登录

**请求方式：** POST
**请求地址：** `/api/login`
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
      "roles": ["admin"]
    }
  }
}
```

### 退出登录

**请求方式：** POST
**请求地址：** `/api/logout`
**请求参数：** 无

**返回示例：**

```json
{
  "code": 200,
  "msg": "操作成功"
}
```

## 用户管理接口

### 获取用户列表

**请求方式：** GET
**请求地址：** `/api/system/user/list`
**请求参数：**

| 参数名 | 类型 | 必填 | 描述 |
|--------|------|------|------|
| pageNum | int | 是 | 页码 |
| pageSize | int | 是 | 每页大小 |
| username | string | 否 | 用户名 |
| status | string | 否 | 状态 |
| deptId | long | 否 | 部门ID |

**返回示例：**

```json
{
  "code": 200,
  "msg": "操作成功",
  "data": {
    "total": 10,
    "rows": [
      {
        "userId": 1,
        "username": "admin",
        "nickName": "管理员",
        "email": "admin@example.com",
        "phonenumber": "13800138000",
        "status": "0",
        "deptId": 1,
        "createTime": "2024-01-01 12:00:00"
      }
    ]
  }
}
```

### 添加用户

**请求方式：** POST
**请求地址：** `/api/system/user/add`
**请求参数：**

| 参数名 | 类型 | 必填 | 描述 |
|--------|------|------|------|
| username | string | 是 | 用户名 |
| password | string | 是 | 密码 |
| nickName | string | 是 | 昵称 |
| email | string | 否 | 邮箱 |
| phonenumber | string | 否 | 手机号 |
| deptId | long | 是 | 部门ID |
| roleIds | array | 是 | 角色ID列表 |

**返回示例：**

```json
{
  "code": 200,
  "msg": "操作成功"
}
```

### 编辑用户

**请求方式：** PUT
**请求地址：** `/api/system/user/edit`
**请求参数：**

| 参数名 | 类型 | 必填 | 描述 |
|--------|------|------|------|
| userId | long | 是 | 用户ID |
| username | string | 是 | 用户名 |
| nickName | string | 是 | 昵称 |
| email | string | 否 | 邮箱 |
| phonenumber | string | 否 | 手机号 |
| deptId | long | 是 | 部门ID |
| roleIds | array | 是 | 角色ID列表 |
| status | string | 是 | 状态 |

**返回示例：**

```json
{
  "code": 200,
  "msg": "操作成功"
}
```

### 删除用户

**请求方式：** DELETE
**请求地址：** `/api/system/user/remove`
**请求参数：**

| 参数名 | 类型 | 必填 | 描述 |
|--------|------|------|------|
| userIds | string | 是 | 用户ID列表，多个ID用逗号分隔 |

**返回示例：**

```json
{
  "code": 200,
  "msg": "操作成功"
}
```

## 设备管理接口

### 获取设备列表

**请求方式：** GET
**请求地址：** `/api/device/list`
**请求参数：**

| 参数名 | 类型 | 必填 | 描述 |
|--------|------|------|------|
| pageNum | int | 是 | 页码 |
| pageSize | int | 是 | 每页大小 |
| deviceId | string | 否 | 设备ID |
| deviceName | string | 否 | 设备名称 |
| status | string | 否 | 状态 |
| childId | long | 否 | 儿童ID |

**返回示例：**

```json
{
  "code": 200,
  "msg": "操作成功",
  "data": {
    "total": 5,
    "rows": [
      {
        "deviceId": "xxx",
        "deviceName": "Small Steps 设备",
        "childId": 1,
        "childName": "小明",
        "status": "online",
        "battery": 80,
        "lastOnline": "2024-01-01 12:00:00",
        "createTime": "2024-01-01 00:00:00"
      }
    ]
  }
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

### 设备状态

**请求方式：** GET
**请求地址：** `/api/device/status`
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
    "wifiSignal": -65,
    "currentTask": "1",
    "lastOnline": "2024-01-01 12:00:00"
  }
}
```

## 任务管理接口

### 获取任务模板列表

**请求方式：** GET
**请求地址：** `/api/task/template/list`
**请求参数：**

| 参数名 | 类型 | 必填 | 描述 |
|--------|------|------|------|
| pageNum | int | 是 | 页码 |
| pageSize | int | 是 | 每页大小 |
| templateName | string | 否 | 模板名称 |

**返回示例：**

```json
{
  "code": 200,
  "msg": "操作成功",
  "data": {
    "total": 10,
    "rows": [
      {
        "templateId": 1,
        "templateName": "完成作业",
        "templateDesc": "完成学校布置的作业",
        "steps": [
          {
            "stepName": "准备课本",
            "stepDesc": "拿出课本和练习本"
          },
          {
            "stepName": "完成作业",
            "stepDesc": "认真完成作业"
          }
        ],
        "rewardPoints": 10,
        "createTime": "2024-01-01 12:00:00"
      }
    ]
  }
}
```

### 创建任务模板

**请求方式：** POST
**请求地址：** `/api/task/template/create`
**请求参数：**

| 参数名 | 类型 | 必填 | 描述 |
|--------|------|------|------|
| templateName | string | 是 | 模板名称 |
| templateDesc | string | 是 | 模板描述 |
| steps | array | 是 | 任务步骤 |
| rewardPoints | int | 是 | 奖励积分 |

**返回示例：**

```json
{
  "code": 200,
  "msg": "操作成功",
  "data": {
    "templateId": 1
  }
}
```

### 获取任务列表

**请求方式：** GET
**请求地址：** `/api/task/list`
**请求参数：**

| 参数名 | 类型 | 必填 | 描述 |
|--------|------|------|------|
| pageNum | int | 是 | 页码 |
| pageSize | int | 是 | 每页大小 |
| taskName | string | 否 | 任务名称 |
| childId | long | 否 | 儿童ID |
| status | int | 否 | 任务状态 |

**返回示例：**

```json
{
  "code": 200,
  "msg": "操作成功",
  "data": {
    "total": 20,
    "rows": [
      {
        "taskId": 1,
        "taskName": "完成作业",
        "childId": 1,
        "childName": "小明",
        "status": 1,
        "rewardPoints": 10,
        "createTime": "2024-01-01 12:00:00",
        "deadline": "2024-01-01 18:00:00"
      }
    ]
  }
}
```

## 奖励管理接口

### 获取奖励列表

**请求方式：** GET
**请求地址：** `/api/reward/list`
**请求参数：**

| 参数名 | 类型 | 必填 | 描述 |
|--------|------|------|------|
| pageNum | int | 是 | 页码 |
| pageSize | int | 是 | 每页大小 |
| rewardName | string | 否 | 奖励名称 |

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
        "imageUrl": "xxx",
        "createTime": "2024-01-01 12:00:00"
      }
    ]
  }
}
```

### 配置奖励

**请求方式：** POST
**请求地址：** `/api/reward/config`
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

### 获取积分记录

**请求方式：** GET
**请求地址：** `/api/reward/scoreHistory`
**请求参数：**

| 参数名 | 类型 | 必填 | 描述 |
|--------|------|------|------|
| pageNum | int | 是 | 页码 |
| pageSize | int | 是 | 每页大小 |
| childId | long | 否 | 儿童ID |
| type | string | 否 | 类型 |

**返回示例：**

```json
{
  "code": 200,
  "msg": "操作成功",
  "data": {
    "total": 15,
    "rows": [
      {
        "id": 1,
        "childId": 1,
        "childName": "小明",
        "points": 10,
        "type": "task",
        "description": "完成作业",
        "createTime": "2024-01-01 12:00:00"
      }
    ]
  }
}
```

## 数据分析接口

### 获取数据大盘

**请求方式：** GET
**请求地址：** `/api/analysis/dashboard`
**请求参数：** 无

**返回示例：**

```json
{
  "code": 200,
  "msg": "操作成功",
  "data": {
    "totalUsers": 100,
    "totalChildren": 80,
    "totalDevices": 60,
    "totalTasks": 500,
    "completedTasks": 400,
    "activeDevices": 50,
    "avgCompletionRate": 80
  }
}
```

### 用户活跃度分析

**请求方式：** GET
**请求地址：** `/api/analysis/userActivity`
**请求参数：**

| 参数名 | 类型 | 必填 | 描述 |
|--------|------|------|------|
| startDate | string | 是 | 开始日期 |
| endDate | string | 是 | 结束日期 |

**返回示例：**

```json
{
  "code": 200,
  "msg": "操作成功",
  "data": [
    {
      "date": "2024-01-01",
      "activeUsers": 50,
      "newUsers": 5
    },
    {
      "date": "2024-01-02",
      "activeUsers": 55,
      "newUsers": 3
    }
  ]
}
```

### 任务完成情况分析

**请求方式：** GET
**请求地址：** `/api/analysis/taskCompletion`
**请求参数：**

| 参数名 | 类型 | 必填 | 描述 |
|--------|------|------|------|
| startDate | string | 是 | 开始日期 |
| endDate | string | 是 | 结束日期 |

**返回示例：**

```json
{
  "code": 200,
  "msg": "操作成功",
  "data": [
    {
      "date": "2024-01-01",
      "totalTasks": 20,
      "completedTasks": 16,
      "completionRate": 80
    },
    {
      "date": "2024-01-02",
      "totalTasks": 25,
      "completedTasks": 22,
      "completionRate": 88
    }
  ]
}
```

## Prompt 管理接口

### 获取 Prompt 模板列表

**请求方式：** GET
**请求地址：** `/api/prompt/list`
**请求参数：**

| 参数名 | 类型 | 必填 | 描述 |
|--------|------|------|------|
| pageNum | int | 是 | 页码 |
| pageSize | int | 是 | 每页大小 |
| templateName | string | 否 | 模板名称 |
| type | string | 否 | 模板类型 |

**返回示例：**

```json
{
  "code": 200,
  "msg": "操作成功",
  "data": {
    "total": 10,
    "rows": [
      {
        "templateId": 1,
        "templateName": "任务拆解",
        "type": "task_breakdown",
        "content": "将任务拆解为小步骤...",
        "createTime": "2024-01-01 12:00:00"
      }
    ]
  }
}
```

### 创建 Prompt 模板

**请求方式：** POST
**请求地址：** `/api/prompt/create`
**请求参数：**

| 参数名 | 类型 | 必填 | 描述 |
|--------|------|------|------|
| templateName | string | 是 | 模板名称 |
| type | string | 是 | 模板类型 |
| content | string | 是 | 模板内容 |

**返回示例：**

```json
{
  "code": 200,
  "msg": "操作成功",
  "data": {
    "templateId": 1
  }
}
```

### 测试 Prompt 模板

**请求方式：** POST
**请求地址：** `/api/prompt/test`
**请求参数：**

| 参数名 | 类型 | 必填 | 描述 |
|--------|------|------|------|
| templateId | long | 是 | 模板ID |
| params | object | 是 | 模板参数 |

**返回示例：**

```json
{
  "code": 200,
  "msg": "操作成功",
  "data": {
    "result": "拆解后的任务步骤..."
  }
}
```

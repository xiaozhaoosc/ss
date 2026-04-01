# 详细设计文档

## 1. 概述

### 1.1 文档目的
本文档详细描述 Small Steps 系统的具体实现细节，包括前端、后端、硬件和 AI 中台的详细设计，为开发人员提供明确的实现指导。

### 1.2 术语定义
| 术语 | 解释 |
|------|------|
| ADHD | 注意力缺陷多动障碍 (Attention Deficit Hyperactivity Disorder) |
| CBT | 认知行为疗法 (Cognitive Behavioral Therapy) |
| MQTT | 消息队列遥测传输 (Message Queuing Telemetry Transport) |
| ESP32 | 一款由 Espressif 开发的低功耗 Wi-Fi 和蓝牙微控制器 |
| JWT | JSON Web Token，用于身份验证和授权 |
| ST7735 | 一种彩色 TFT LCD 控制器 |
| WS2812B | 一种智能控制 LED 灯珠 |
| NFC | 近场通信 (Near Field Communication) |
| DFPlayer | 一种 MP3 播放器模块 |

## 2. 前端详细设计

### 2.1 移动应用设计

#### 2.1.1 技术栈
- **框架**：UniApp X (Vue3 + UTS)
- **样式**：Tailwind CSS
- **状态管理**：Pinia
- **路由**：UniApp 路由
- **网络请求**：Axios

#### 2.1.2 目录结构
```
smallsteps-app/
├── src/
│   ├── api/             # API 接口
│   ├── components/      # 组件
│   │   ├── child/       # 儿童端组件
│   │   ├── parent/      # 家长端组件
│   │   └── common/      # 通用组件
│   ├── pages/           # 页面
│   │   ├── child/       # 儿童端页面
│   │   └── parent/      # 家长端页面
│   ├── store/           # 状态管理
│   ├── utils/           # 工具函数
│   ├── App.vue          # 应用入口
│   ├── main.js          # 主文件
│   ├── manifest.json    # 应用配置
│   └── pages.json       # 页面配置
├── package.json         # 依赖配置
└── vite.config.js       # Vite 配置
```

#### 2.1.3 关键组件设计

##### 2.1.3.1 儿童端组件
- **TaskCard**：任务卡片组件，显示任务信息和进度
- **RewardItem**：奖励物品组件，显示可兑换的奖励
- **FocusMode**：专注模式组件，提供视觉和听觉反馈
- **AchievementBadge**：成就徽章组件，显示儿童获得的成就

##### 2.1.3.2 家长端组件
- **TaskCreator**：任务创建器，用于创建和配置任务
- **DataDashboard**：数据仪表盘，显示儿童的任务完成情况和情绪状态
- **EmotionAnalyzer**：情绪分析器，显示儿童的情绪变化趋势
- **DeviceManager**：设备管理器，用于管理和配置硬件设备

#### 2.1.4 页面设计

##### 2.1.4.1 儿童端页面
- **HomePage**：首页，显示任务列表和成就
- **TaskDetailPage**：任务详情页，显示任务的微步骤
- **RewardShopPage**：奖励商店，显示可兑换的奖励
- **AchievementPage**：成就页面，显示获得的成就
- **FocusPage**：专注模式页面，提供专注环境

##### 2.1.4.2 家长端页面
- **DashboardPage**：仪表盘，显示儿童的整体情况
- **TaskConfigPage**：任务配置页，用于创建和管理任务
- **EmotionDetailPage**：情绪详情页，显示儿童的情绪分析
- **RewardConfigPage**：奖励配置页，用于配置奖励规则
- **DeviceConfigPage**：设备配置页，用于管理硬件设备

### 2.2 管理后台设计

#### 2.2.1 技术栈
- **框架**：Nuxt 3
- **样式**：Tailwind CSS
- **UI 框架**：Element Plus
- **状态管理**：Pinia
- **路由**：Nuxt 路由

#### 2.2.2 目录结构
```
smallsteps-ui/
├── src/
│   ├── api/             # API 接口
│   ├── components/      # 组件
│   ├── layouts/         # 布局
│   ├── pages/           # 页面
│   ├── store/           # 状态管理
│   ├── utils/           # 工具函数
│   └── main.ts          # 主文件
├── package.json         # 依赖配置
└── vite.config.ts       # Vite 配置
```

#### 2.2.3 关键组件设计
- **Data大盘**：显示系统运行状态和用户数据统计
- **UserManager**：用户管理组件，用于管理用户账号
- **PromptConfig**：Prompt 模板配置组件，用于配置 AI 提示词模板
- **DeviceMonitor**：设备监控组件，显示设备在线状态

#### 2.2.4 页面设计
- **LoginPage**：登录页面
- **DashboardPage**：仪表盘，显示系统概览
- **UserManagementPage**：用户管理页面
- **PromptConfigPage**：Prompt 模板配置页面
- **DeviceManagementPage**：设备管理页面
- **DataAnalysisPage**：数据分析页面

## 3. 后端详细设计

### 3.1 技术栈
- **框架**：Java Spring Boot（基于 RuoYi-Vue-Plus）
- **数据库**：PostgreSQL
- **缓存**：Redis
- **消息队列**：RabbitMQ
- **认证**：JWT

### 3.2 目录结构
```
smallsteps-api/
├── smallsteps-common/         # 通用模块
│   ├── smallsteps-common-core/    # 核心功能
│   ├── smallsteps-common-ai/      # AI 相关功能
│   └── smallsteps-common-web/     # Web 相关功能
├── smallsteps-modules/        # 业务模块
│   ├── smallsteps-child/          # 儿童相关功能
│   ├── smallsteps-parent/         # 家长相关功能
│   ├── smallsteps-system/         # 系统相关功能
│   └── smallsteps-job/            # 定时任务
├── smallsteps-admin/          # 管理后台
├── smallsteps-extend/          # 扩展模块
└── pom.xml                     # Maven 配置
```

### 3.3 核心类设计

#### 3.3.1 认证相关
- **JwtTokenUtil**：JWT 令牌生成和验证工具
- **SecurityConfig**：安全配置类
- **UserDetailsServiceImpl**：用户详情服务实现

#### 3.3.2 任务管理相关
- **TaskService**：任务服务接口
- **TaskServiceImpl**：任务服务实现
- **TaskMapper**：任务数据访问接口
- **TaskStepService**：任务步骤服务

#### 3.3.3 奖励系统相关
- **RewardService**：奖励服务接口
- **RewardServiceImpl**：奖励服务实现
- **RewardMapper**：奖励数据访问接口

#### 3.3.4 设备管理相关
- **DeviceService**：设备服务接口
- **DeviceServiceImpl**：设备服务实现
- **DeviceMapper**：设备数据访问接口
- **MqttService**：MQTT 服务

#### 3.3.5 AI 服务相关
- **AiService**：AI 服务接口
- **AiServiceImpl**：AI 服务实现
- **TaskBreakdownService**：任务拆解服务
- **EmotionAnalysisService**：情绪分析服务

### 3.4 API 设计

#### 3.4.1 认证 API
- `POST /api/auth/login`：用户登录
- `POST /api/auth/logout`：用户登出
- `GET /api/auth/info`：获取用户信息

#### 3.4.2 任务管理 API
- `POST /api/task/create`：创建任务
- `GET /api/task/list`：获取任务列表
- `GET /api/task/detail`：获取任务详情
- `PUT /api/task/update`：更新任务
- `DELETE /api/task/delete`：删除任务
- `PUT /api/task/complete`：完成任务

#### 3.4.3 奖励系统 API
- `POST /api/reward/create`：创建奖励
- `GET /api/reward/list`：获取奖励列表
- `PUT /api/reward/exchange`：兑换奖励
- `GET /api/reward/history`：获取奖励历史

#### 3.4.4 设备管理 API
- `POST /api/device/register`：注册设备
- `GET /api/device/list`：获取设备列表
- `PUT /api/device/update`：更新设备信息
- `DELETE /api/device/delete`：删除设备
- `PUT /api/device/config`：配置设备

#### 3.4.5 AI 服务 API
- `POST /api/ai/breakdown`：任务拆解
- `POST /api/ai/emotion`：情绪分析
- `GET /api/ai/recommend`：获取智能推荐

## 4. 硬件详细设计

### 4.1 硬件配置
- **主控制器**：ESP32-S3
- **屏幕**：1.8寸 ST7735 屏幕 (128x160)
- **按键**：4个物理按键
- **LED**：WS2812B 灯环
- **NFC**：PN532 NFC 模块
- **音频**：DFPlayer 模块
- **存储**：MicroSD 卡

### 4.2 软件设计

#### 4.2.1 技术栈
- **语言**：MicroPython
- **通信**：MQTT / WebSocket
- **库**：umqtt.simple, st7735, mfrc522, dfplayermini

#### 4.2.2 目录结构
```
smallsteps-esp32/
├── lib/             # 库文件
├── ui/              # UI 相关
├── manager/         # 管理模块
├── tests/           # 测试文件
├── main.py          # 主文件
├── boot.py          # 启动文件
├── config.py        # 配置文件
├── device.py        # 设备管理
├── mqtt_client.py   # MQTT 客户端
├── task_manager.py  # 任务管理
└── audio_player.py  # 音频播放
```

#### 4.2.3 核心模块设计

##### 4.2.3.1 设备管理模块
- **Device**：设备类，管理设备状态和硬件组件
- **ConfigManager**：配置管理类，管理设备配置
- **WifiManager**：Wi-Fi 管理类，管理网络连接

##### 4.2.3.2 通信模块
- **MqttClient**：MQTT 客户端类，处理与后端的通信
- **WebSocketClient**：WebSocket 客户端类，处理与后端的实时通信

##### 4.2.3.3 任务管理模块
- **TaskManager**：任务管理类，管理任务的执行和状态
- **Task**：任务类，表示单个任务

##### 4.2.3.4 UI 模块
- **UI**：UI 基类
- **HomePage**：首页 UI
- **TaskPage**：任务页面 UI
- **FocusPage**：专注模式 UI
- **SettingsPage**：设置页面 UI

##### 4.2.3.5 音频模块
- **AudioPlayer**：音频播放器类，管理音频播放

### 4.3 通信协议

#### 4.3.1 MQTT 主题
- `smallsteps/{device_id}/task`：任务相关消息
- `smallsteps/{device_id}/status`：设备状态消息
- `smallsteps/{device_id}/emotion`：情绪相关消息
- `smallsteps/{device_id}/config`：设备配置消息

#### 4.3.2 消息格式
```json
// 任务消息
{
  "type": "task",
  "action": "create",
  "data": {
    "task_id": "123",
    "title": "完成作业",
    "steps": [
      {
        "step_id": "1",
        "content": "准备课本和文具",
        "duration": 5
      },
      {
        "step_id": "2",
        "content": "完成数学作业",
        "duration": 20
      }
    ]
  }
}

// 状态消息
{
  "type": "status",
  "data": {
    "battery": 80,
    "wifi": "connected",
    "online": true
  }
}
```

## 5. AI 中台详细设计

### 5.1 技术栈
- **框架**：Python + Flask
- **模型**：基于 Barkley/Greene 理论的垂类模型
- **部署**：Docker 容器

### 5.2 核心模块设计

#### 5.2.1 任务拆解模块
- **TaskBreakdownService**：任务拆解服务，将复杂任务拆解为微步骤
- **DifficultyEvaluator**：难度评估器，评估任务难度
- **StepGenerator**：步骤生成器，生成微步骤

#### 5.2.2 情绪分析模块
- **EmotionAnalyzer**：情绪分析器，分析儿童情绪状态
- **CrisisIntervention**：危机干预器，提供情绪危机干预建议

#### 5.2.3 智能推荐模块
- **RecommendationService**：推荐服务，基于用户行为推荐个性化任务
- **UserProfileManager**：用户画像管理器，管理用户行为数据

### 5.3 API 设计
- `POST /api/ai/breakdown`：任务拆解
- `POST /api/ai/emotion`：情绪分析
- `GET /api/ai/recommend`：获取智能推荐

## 6. 数据库设计

### 6.1 数据库表结构

#### 6.1.1 用户表 (`user`)
| 字段名 | 数据类型 | 约束 | 描述 |
|--------|----------|------|------|
| `id` | `BIGINT` | `PRIMARY KEY` | 用户 ID |
| `username` | `VARCHAR(50)` | `UNIQUE NOT NULL` | 用户名 |
| `password` | `VARCHAR(100)` | `NOT NULL` | 密码 |
| `role` | `VARCHAR(20)` | `NOT NULL` | 角色 (parent/child/admin) |
| `nickname` | `VARCHAR(50)` | | 昵称 |
| `avatar` | `VARCHAR(255)` | | 头像 |
| `created_at` | `TIMESTAMP` | `DEFAULT CURRENT_TIMESTAMP` | 创建时间 |
| `updated_at` | `TIMESTAMP` | `DEFAULT CURRENT_TIMESTAMP` | 更新时间 |

#### 6.1.2 家长-儿童关联表 (`parent_child`)
| 字段名 | 数据类型 | 约束 | 描述 |
|--------|----------|------|------|
| `id` | `BIGINT` | `PRIMARY KEY` | 关联 ID |
| `parent_id` | `BIGINT` | `REFERENCES user(id)` | 家长 ID |
| `child_id` | `BIGINT` | `REFERENCES user(id)` | 儿童 ID |
| `created_at` | `TIMESTAMP` | `DEFAULT CURRENT_TIMESTAMP` | 创建时间 |

#### 6.1.3 任务表 (`task`)
| 字段名 | 数据类型 | 约束 | 描述 |
|--------|----------|------|------|
| `id` | `BIGINT` | `PRIMARY KEY` | 任务 ID |
| `title` | `VARCHAR(100)` | `NOT NULL` | 任务标题 |
| `description` | `TEXT` | | 任务描述 |
| `creator_id` | `BIGINT` | `REFERENCES user(id)` | 创建者 ID |
| `child_id` | `BIGINT` | `REFERENCES user(id)` | 儿童 ID |
| `status` | `VARCHAR(20)` | `DEFAULT 'pending'` | 任务状态 (pending/in_progress/completed/failed) |
| `difficulty` | `INT` | `DEFAULT 1` | 任务难度 (1-5) |
| `reward_points` | `INT` | `DEFAULT 0` | 奖励积分 |
| `created_at` | `TIMESTAMP` | `DEFAULT CURRENT_TIMESTAMP` | 创建时间 |
| `updated_at` | `TIMESTAMP` | `DEFAULT CURRENT_TIMESTAMP` | 更新时间 |

#### 6.1.4 任务步骤表 (`task_step`)
| 字段名 | 数据类型 | 约束 | 描述 |
|--------|----------|------|------|
| `id` | `BIGINT` | `PRIMARY KEY` | 步骤 ID |
| `task_id` | `BIGINT` | `REFERENCES task(id)` | 任务 ID |
| `content` | `TEXT` | `NOT NULL` | 步骤内容 |
| `order` | `INT` | `NOT NULL` | 步骤顺序 |
| `duration` | `INT` | | 预计时长 (分钟) |
| `status` | `VARCHAR(20)` | `DEFAULT 'pending'` | 步骤状态 (pending/completed) |
| `created_at` | `TIMESTAMP` | `DEFAULT CURRENT_TIMESTAMP` | 创建时间 |

#### 6.1.5 奖励表 (`reward`)
| 字段名 | 数据类型 | 约束 | 描述 |
|--------|----------|------|------|
| `id` | `BIGINT` | `PRIMARY KEY` | 奖励 ID |
| `name` | `VARCHAR(100)` | `NOT NULL` | 奖励名称 |
| `description` | `TEXT` | | 奖励描述 |
| `points` | `INT` | `NOT NULL` | 所需积分 |
| `type` | `VARCHAR(20)` | `NOT NULL` | 奖励类型 (physical/virtual) |
| `created_at` | `TIMESTAMP` | `DEFAULT CURRENT_TIMESTAMP` | 创建时间 |

#### 6.1.6 奖励兑换记录表 (`reward_exchange`)
| 字段名 | 数据类型 | 约束 | 描述 |
|--------|----------|------|------|
| `id` | `BIGINT` | `PRIMARY KEY` | 兑换记录 ID |
| `child_id` | `BIGINT` | `REFERENCES user(id)` | 儿童 ID |
| `reward_id` | `BIGINT` | `REFERENCES reward(id)` | 奖励 ID |
| `status` | `VARCHAR(20)` | `DEFAULT 'pending'` | 兑换状态 (pending/approved/completed) |
| `created_at` | `TIMESTAMP` | `DEFAULT CURRENT_TIMESTAMP` | 创建时间 |
| `updated_at` | `TIMESTAMP` | `DEFAULT CURRENT_TIMESTAMP` | 更新时间 |

#### 6.1.7 设备表 (`device`)
| 字段名 | 数据类型 | 约束 | 描述 |
|--------|----------|------|------|
| `id` | `BIGINT` | `PRIMARY KEY` | 设备 ID |
| `device_id` | `VARCHAR(100)` | `UNIQUE NOT NULL` | 设备唯一标识 |
| `name` | `VARCHAR(100)` | `NOT NULL` | 设备名称 |
| `child_id` | `BIGINT` | `REFERENCES user(id)` | 绑定的儿童 ID |
| `status` | `VARCHAR(20)` | `DEFAULT 'offline'` | 设备状态 (online/offline) |
| `battery` | `INT` | `DEFAULT 100` | 电池电量 |
| `firmware_version` | `VARCHAR(20)` | | 固件版本 |
| `created_at` | `TIMESTAMP` | `DEFAULT CURRENT_TIMESTAMP` | 创建时间 |
| `updated_at` | `TIMESTAMP` | `DEFAULT CURRENT_TIMESTAMP` | 更新时间 |

#### 6.1.8 情绪记录表 (`emotion_record`)
| 字段名 | 数据类型 | 约束 | 描述 |
|--------|----------|------|------|
| `id` | `BIGINT` | `PRIMARY KEY` | 记录 ID |
| `child_id` | `BIGINT` | `REFERENCES user(id)` | 儿童 ID |
| `emotion` | `VARCHAR(20)` | `NOT NULL` | 情绪类型 (happy/sad/angry/anxious) |
| `intensity` | `INT` | `DEFAULT 1` | 情绪强度 (1-5) |
| `timestamp` | `TIMESTAMP` | `DEFAULT CURRENT_TIMESTAMP` | 记录时间 |
| `suggestion` | `TEXT` | | 干预建议 |

#### 6.1.9 成就表 (`achievement`)
| 字段名 | 数据类型 | 约束 | 描述 |
|--------|----------|------|------|
| `id` | `BIGINT` | `PRIMARY KEY` | 成就 ID |
| `name` | `VARCHAR(100)` | `NOT NULL` | 成就名称 |
| `description` | `TEXT` | | 成就描述 |
| `icon` | `VARCHAR(255)` | | 成就图标 |
| `condition` | `TEXT` | `NOT NULL` | 解锁条件 |
| `created_at` | `TIMESTAMP` | `DEFAULT CURRENT_TIMESTAMP` | 创建时间 |

#### 6.1.10 儿童成就表 (`child_achievement`)
| 字段名 | 数据类型 | 约束 | 描述 |
|--------|----------|------|------|
| `id` | `BIGINT` | `PRIMARY KEY` | 记录 ID |
| `child_id` | `BIGINT` | `REFERENCES user(id)` | 儿童 ID |
| `achievement_id` | `BIGINT` | `REFERENCES achievement(id)` | 成就 ID |
| `unlocked_at` | `TIMESTAMP` | `DEFAULT CURRENT_TIMESTAMP` | 解锁时间 |

### 6.2 索引设计
- **用户表**：`username` 唯一索引
- **任务表**：`child_id`、`status` 索引
- **任务步骤表**：`task_id`、`order` 索引
- **设备表**：`device_id` 唯一索引、`child_id` 索引
- **情绪记录表**：`child_id`、`timestamp` 索引

### 6.3 数据迁移策略
- **初始数据**：通过 SQL 脚本初始化基础数据
- **增量数据**：通过应用程序接口添加和更新数据
- **数据备份**：定期备份数据库

## 7. 部署设计

### 7.1 后端部署
- **容器化**：使用 Docker 容器部署
- **编排**：使用 Kubernetes 编排
- **环境变量**：通过环境变量配置
- **监控**：使用 Prometheus + Grafana 监控

### 7.2 前端部署
- **移动应用**：
  - iOS：App Store
  - Android：Google Play
- **管理后台**：
  - 静态部署到 Nginx
  - 使用 CDN 加速

### 7.3 硬件部署
- **固件烧录**：使用 ESP32 烧录工具烧录固件
- **网络配置**：通过 Wi-Fi 配置工具配置网络
- **设备绑定**：通过移动应用绑定设备

### 7.4 AI 中台部署
- **容器化**：使用 Docker 容器部署
- **负载均衡**：使用 Nginx 负载均衡
- **模型更新**：支持在线模型更新

## 8. 测试设计

### 8.1 单元测试
- **前端**：使用 Vitest 进行组件测试
- **后端**：使用 JUnit 进行单元测试
- **硬件**：使用 MicroPython 测试框架进行测试

### 8.2 集成测试
- **API 测试**：使用 Postman 进行 API 测试
- **端到端测试**：使用 Playwright 进行端到端测试
- **硬件集成测试**：测试硬件与后端的通信

### 8.3 性能测试
- **API 性能**：使用 JMeter 测试 API 性能
- **并发测试**：测试系统的并发处理能力
- **响应时间测试**：测试系统的响应时间

### 8.4 安全测试
- **渗透测试**：测试系统的安全性
- **漏洞扫描**：扫描系统的漏洞
- **数据安全测试**：测试数据的安全性

## 9. 总结

本详细设计文档详细描述了 Small Steps 系统的前端、后端、硬件和 AI 中台的具体实现细节，包括技术栈、目录结构、核心类设计、API 设计、数据库设计、部署设计和测试设计。

通过详细的设计，系统实现了以下功能：
- 移动应用的儿童端和家长端界面
- 管理后台的系统管理功能
- 后端的 API 服务和业务逻辑
- 硬件设备的任务提醒和专注模式
- AI 中台的任务拆解和情绪分析

本设计文档为开发人员提供了明确的实现指导，确保了系统的一致性和可靠性。同时，通过模块化的设计，系统具有良好的扩展性和可维护性，可以根据需求进行灵活的调整和扩展。

总之，本详细设计文档为 Small Steps 系统的实现奠定了坚实的基础，确保了系统的功能完整性和技术可行性，为 ADHD 儿童的行为习惯养成提供了有力的技术支持。
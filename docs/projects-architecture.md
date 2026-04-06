# Small Steps 项目架构图

## 项目概述

Small Steps（小步）是一个针对 ADHD 儿童的行为习惯辅助系统。本架构图展示了系统的三个核心项目及其关系。

---

## 系统架构总图

```
┌─────────────────────────────────────────────────────────────────────────────┐
│                          Small Steps 系统架构                                    │
├─────────────────────────────────────────────────────────────────────────────┤
│                                                                               │
│  ┌──────────────────────┐         ┌──────────────────────┐                  │
│  │   smallsteps-app     │         │   smallsteps-ui      │                  │
│  │   (移动应用)          │         │   (管理后台)          │                  │
│  ├──────────────────────┤         ├──────────────────────┤                  │
│  │ • UniApp X           │         │ • Vue 3 + TypeScript │                  │
│  │ • Vue 3 + Pinia      │         │ • Element Plus       │                  │
│  │ • Tailwind CSS       │         │ • Vite               │                  │
│  │ • 支持多端 (H5/小程序/App) │    │ • 家长端管理界面      │                  │
│  └──────────┬───────────┘         └──────────┬───────────┘                  │
│             │                                   │                               │
│             └────────────────┬──────────────────┘                               │
│                              │                                                    │
│                              ▼                                                    │
│                  ┌──────────────────────┐                                        │
│                  │   smallsteps-api      │                                        │
│                  │   (后端 API)          │                                        │
│                  ├──────────────────────┤                                        │
│                  │ • Java 21             │                                        │
│                  │ • Spring Boot 3.5.9   │                                        │
│                  │ • MyBatis Plus         │                                        │
│                  │ • PostgreSQL + Redis   │                                        │
│                  └──────────┬───────────┘                                        │
│                             │                                                    │
│                             ▼                                                    │
│                  ┌──────────────────────┐                                        │
│                  │   数据库层            │                                        │
│                  │ ┌──────────────────┐ │                                        │
│                  │ │  PostgreSQL      │ │                                        │
│                  │ │  (主数据库)      │ │                                        │
│                  │ └──────────────────┘ │                                        │
│                  │ ┌──────────────────┐ │                                        │
│                  │ │  Redis           │ │                                        │
│                  │ │  (缓存/会话)     │ │                                        │
│                  │ └──────────────────┘ │                                        │
│                  └──────────────────────┘                                        │
│                                                                                   │
└───────────────────────────────────────────────────────────────────────────────┘
```

---

## 项目详细架构

### 1. smallsteps-api (后端 API)

**技术栈：**
- Java 21
- Spring Boot 3.5.9
- MyBatis Plus 3.5.14
- PostgreSQL (主数据库)
- Redis (缓存/会话)
- Sa-Token (权限认证)
- Redisson (分布式锁)

**项目结构：**

```
smallsteps-api/
├── smallsteps-admin/          # 管理后台启动模块
├── smallsteps-common/         # 公共模块
│   ├── smallsteps-ai/         # AI 集成模块
│   ├── smallsteps-common-core/ # 核心工具
│   ├── smallsteps-common-web/ # Web 相关
│   ├── smallsteps-common-redis/ # Redis 集成
│   ├── smallsteps-common-satoken/ # 认证授权
│   └── ...
├── smallsteps-extend/         # 扩展模块
│   ├── smallsteps-monitor-admin/ # 监控管理
│   └── smallsteps-snailjob-server/ # 定时任务
└── smallsteps-modules/        # 业务模块
    ├── smallsteps-system/     # 系统管理 (用户/角色/菜单等)
    ├── smallsteps-parent/     # 家长端业务
    │   ├── ParentTaskController      # 任务管理
    │   ├── ParentRewardController    # 奖励配置
    │   ├── ParentContractController  # 契约管理
    │   └── ParentHealthController    # 健康数据
    ├── smallsteps-child/      # 儿童端业务
    │   └── ChildHealthController     # 儿童健康
    ├── smallsteps-workflow/   # 工作流引擎
    ├── smallsteps-generator/  # 代码生成器
    └── smallsteps-demo/       # 演示模块
```

**核心功能模块：**
- 用户认证与授权
- 任务管理与拆解
- 奖励系统
- 契约管理
- 健康数据追踪
- 工作流引擎
- 系统管理

---

### 2. smallsteps-ui (管理后台)

**技术栈：**
- Vue 3.5.22
- TypeScript 5.9.3
- Vite 6.4.1
- Element Plus 2.11.7
- Pinia 3.0.3 (状态管理)
- Vue Router 4.6.3
- ECharts 5.6.0 (数据可视化)
- UnoCSS (原子化 CSS)

**项目结构：**

```
smallsteps-ui/
├── src/
│   ├── api/              # API 接口定义
│   ├── directive/        # 自定义指令
│   ├── enums/            # 枚举定义
│   ├── hooks/            # 组合式函数
│   ├── lang/             # 国际化 (i18n)
│   ├── layout/           # 布局组件
│   ├── plugins/          # 插件配置
│   ├── router/           # 路由配置
│   ├── store/            # Pinia 状态管理
│   ├── types/            # TypeScript 类型定义
│   ├── utils/            # 工具函数
│   │   ├── request.ts    # HTTP 请求封装
│   │   ├── auth.ts       # 认证工具
│   │   └── websocket.ts  # WebSocket 连接
│   └── views/            # 页面视图
│       ├── login.vue     # 登录页
│       └── index.vue     # 首页
├── vite/                 # Vite 插件配置
├── package.json
└── vite.config.ts
```

**核心页面/功能：**
- 登录/注册
- 数据看板
- 用户管理
- 任务配置
- 奖励管理
- 数据统计与可视化

---

### 3. smallsteps-app (移动应用)

**技术栈：**
- UniApp X (跨端框架)
- Vue 3.5.30
- Vite 5.2.8
- Pinia 2.1.7 (状态管理)
- Tailwind CSS 3.4.1
- 支持多端：H5、微信小程序、原生 App

**项目结构：**

```
smallsteps-app/
├── src/
│   ├── api/              # API 接口
│   │   ├── auth.ts       # 认证接口
│   │   ├── task.ts       # 任务接口
│   │   └── reward.ts     # 奖励接口
│   ├── components/       # 公共组件
│   ├── pages/            # 页面
│   │   ├── login/        # 登录页
│   │   ├── work/         # 工作页
│   │   └── index.vue     # 首页
│   ├── plugins/          # 插件
│   │   ├── auth.js       # 认证插件
│   │   └── modal.js      # 弹窗插件
│   ├── static/           # 静态资源
│   │   ├── images/       # 图片
│   │   ├── scss/         # 样式文件
│   │   └── font/         # 字体
│   ├── store/            # Pinia 状态管理
│   │   ├── modules/
│   │   │   ├── user.ts   # 用户状态
│   │   │   ├── task.js   # 任务状态
│   │   │   └── config.js # 配置状态
│   │   └── index.js
│   ├── utils/            # 工具函数
│   │   ├── request.ts    # HTTP 请求
│   │   ├── auth.js       # 认证工具
│   │   ├── ble-manager.js # 蓝牙管理 (连接硬件)
│   │   └── storage.js    # 本地存储
│   ├── App.vue           # 应用入口
│   ├── main.js           # 主入口文件
│   ├── pages.json        # 页面配置
│   └── manifest.json     # 应用配置
├── package.json
├── vite.config.js
└── tailwind.config.js
```

**核心页面/功能：**

**儿童端：**
- 游戏化任务执行
- 奖励领取与兑换
- 成就系统
- 头像编辑
- NFC 互动扫描

**家长端：**
- 任务创建与配置
- 孩子状态监控
- 数据洞察
- 奖励配置
- 个人设置

---

## 数据流与交互

### 典型用户流程

#### 1. 家长创建任务流程
```
smallsteps-ui (管理后台)
    ↓ [HTTP]
smallsteps-api
    ↓ [SQL]
PostgreSQL (存储任务)
    ↓
Redis (缓存任务列表)
```

#### 2. 儿童执行任务流程
```
smallsteps-app (儿童端)
    ↓ [HTTP/WebSocket]
smallsteps-api
    ↓ [读取]
PostgreSQL/Redis
    ↓ [更新]
PostgreSQL (记录进度)
    ↓ [推送]
smallsteps-app (实时更新)
```

---

## 技术亮点

1. **微服务架构思想**：后端模块化设计，便于扩展
2. **跨端开发**：UniApp X 支持多端部署，降低开发成本
3. **现代化前端栈**：Vue 3 + TypeScript + Vite，开发体验优秀
4. **企业级后端**：基于 RuoYi-Vue-Plus，功能完善
5. **状态管理**：Pinia 统一管理前端状态
6. **缓存策略**：Redis 缓存热点数据，提升性能

---

## 后续开发重点

基于此架构，后续开发将聚焦于：
- 三个项目之间的 API 对接与联调
- 业务功能的完善与优化
- 性能优化与用户体验提升
- 测试覆盖与质量保障

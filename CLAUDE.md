# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## 项目概览

**Small Steps (小步)** 是一款面向 ADHD 儿童的行为习惯辅助系统，采用"物理伴侣 + 游戏化激励"模式。系统包含三个核心子系统：硬件终端、移动端 App、管理后台。

**核心理念**：Cognitive Ease & Emotional Warmth（认知极简与情感温润）

---

## 核心架构

```
┌─────────────────────────────────────────────────────────────┐
│                    小步系统架构                               │
├─────────────────────────────────────────────────────────────┤
│  硬件终端 (ESP32-S3)                                          │
│  • 1.8寸ST7735屏幕 (128x160)                                  │
│  • 4个物理按键 + WS2812B灯环 + NFC                            │
│  • 音频输出/采集 + 触觉反馈                                    │
├─────────────────────────────────────────────────────────────┤
│  移动端 (UniApp X)                                            │
│  • 儿童端：游戏化激励、沉浸式体验（Nunito字体、Bouncy动效）   │
│  • 家长端：数据看板、任务配置（系统字体、清晰高效）            │
│  • 双模式无缝切换                                             │
├─────────────────────────────────────────────────────────────┤
│  管理后台 (Vue3 + TS)                                         │
│  • 任务模板管理、难度分级、激励参数配置                        │
│  • 家庭账户管理、权限控制                                      │
│  • 大数据统计看板                                             │
├─────────────────────────────────────────────────────────────┤
│  后端API (Spring Boot 3)                                      │
│  • 统一鉴权（Sa-Token）                                       │
│  • 任务流转、积分计算、统计报告生成                            │
│  • RESTful接口                                               │
└─────────────────────────────────────────────────────────────┘
```

---

## 开发命令

### smallsteps-app (UniApp X 移动端)

```bash
# H5开发模式 (端口 9090，代理 /ssapi -> localhost:8098/ssapi)
npm run dev:h5

# 构建H5
npm run build:h5

# 构建微信小程序
npm run build:mp-weixin

# 运行单元测试
npm run test

# E2E测试（Playwright，需要先启动 dev:h5）
npm run test:e2e
npm run test:e2e:ui
npm run test:e2e:report

# Lint
npm run lint
```

### smallsteps-ui (管理后台)

```bash
# 开发模式
npm run dev

# 生产构建
npm run build:prod

# 预览构建结果
npm run preview

# Lint
npm run lint:eslint
npm run lint:eslint:fix
npm run prettier
```

### smallsteps-api (Spring Boot 后端)

```bash
# 进入API目录
cd smallsteps-api

# 使用Maven运行（默认dev环境，端口8098，context-path /ssapi）
mvn spring-boot:run -pl smallsteps-admin

# 编译打包
mvn clean package -DskipTests

# 运行特定模块测试
mvn test -pl smallsteps-system

# 安装到本地仓库
mvn install -DskipTests
```

**启动类位置**：`smallsteps-api/smallsteps-admin/src/main/java/com/kenzhao/smallsteps/admin/`

**配置文件**：
- `application.yml` - 主配置（端口8098，context-path `/ssapi`）
- `application-dev.yml` - 开发环境（PostgreSQL + Redis 连接）
- `application-prod.yml` - 生产环境（Docker 部署时端口覆盖为8080）

**API地址**：`http://localhost:8098/ssapi`（开发环境）

### smallsteps-esp32 (硬件终端)

```bash
# 进入ESP32目录
cd smallsteps-esp32

# 使用Thonny或VS Code MicroPython运行
# 主入口: main.py
```

---

## 模块结构

### smallsteps-api 模块划分

```
smallsteps-api/
├── smallsteps-admin/         # 管理后台启动模块（包含主应用）
├── smallsteps-common/        # 公共模块
│   ├── smallsteps-common-ss/ # Small Steps 核心领域模型
│   │   └── domain/           # ParentTask, ChildTask, Child, ChildScore, ParentReward 等
│   ├── smallsteps-common-ai/ # AI 服务抽象层
│   └── smallsteps-common-web # Web 基础设施
├── smallsteps-modules/       # 业务模块
│   ├── smallsteps-system/    # 系统管理（用户、角色、菜单、AI模型配置）
│   ├── smallsteps-task/      # 任务管理（ParentTask + ChildTask + TaskLog）
│   ├── smallsteps-job/       # 定时任务
│   ├── smallsteps-child/     # 儿童端（任务执行、积分、成就、AI聊天、情绪）
│   └── smallsteps-parent/    # 家长端（任务发布、奖励、洞察、家庭管理）
└── smallsteps-extend/        # 扩展模块
    ├── smallsteps-monitor-admin/  # 监控后台
    └── smallsteps-snailjob-server/ # 任务调度服务
```

---

## 核心业务模型与流程

### 任务生命周期

```
家长创建任务 (ParentTask) → 系统自动指派 (ChildTask) → 儿童执行 → 提交 → 家长点亮星星
     │                              │                                      │
     │                         ss_task_log                           触发积分奖励
     │                     状态: 1(进行中) → 2(已完成/待点亮) → 3(已点亮)
     │                                                              或 4(已放弃)
     └── 支持任务拆解 (parentId 字段关联子任务)
```

**关键表**：
- `ss_parent_task` - 任务定义（家长创建，含标题、难度、奖励积分、灯光/音频效果）
- `ss_task_log` - 任务执行记录（儿童维度的执行日志）
- `ss_child` - 儿童档案（星数余额、等级）
- `ss_child_score` - 积分账户（balance + totalEarned）
- `ss_score_history` - 积分流水
- `ss_parent_reward` - 奖励配置
- `ss_parent_reward_redemption` - 奖励兑换申请
- `ss_parent_contract` - 亲子契约
- `ss_parent_emotion_kit` - 情绪急救包
- `emotion_record` - 情绪记录
- `ss_family_invite` - 家庭邀请
- `ss_family_join_request` - 家庭加入申请

### 积分系统

任务完成 → `TaskLitUpEvent` 事件 → `ScoreService.addPoints()` → 更新 `ss_child_score` + 写入 `ss_score_history` → 触发勋章检查 `ChildAchievementService.checkAndUnlockBadges()`

### API路由规范

- `/parent/**` - 家长端接口（需 `parent:*` 权限）
- `/child/**` - 儿童端接口（需登录 + 数据归属校验）
- `/ss/**` - 通用业务接口
- `/system/**` - 系统管理接口

---

## 技术栈

### 后端
- **框架**：Spring Boot 3.5.9 + Java 21
- **基础框架**：基于 RuoYi-Vue-Plus
- **ORM**：MyBatis-Plus 3.5.14
- **数据库**：PostgreSQL
- **缓存**：Redis + Redisson
- **安全**：Sa-Token 1.44.0（JWT模式，token-name: Authorization）
- **调度**：SnailJob 1.9.0
- **监控**：Spring Boot Admin 3.5.5
- **工作流**：Warm Flow 1.8.4
- **API加密**：RSA非对称加密（请求解密 + 响应加密）

### 移动端
- **框架**：UniApp X (Vue 3 + UTS)
- **状态管理**：Pinia
- **样式**：Tailwind CSS
- **测试**：Playwright + Vitest
- **API基础路径**：`/ssapi`（通过 `VITE_APP_BASE_API` 环境变量配置）

### 管理后台
- **框架**：Vue 3 + TypeScript + Vite
- **UI库**：Element Plus + UnoCSS
- **图表**：ECharts

---

## 设计规范

### 双模式设计系统

**家长端 (Parent Mode)** - 认知极简
- 配色：`#6C9BD2`主色、`#f6f7f8`背景、`#ffffff`表面
- 字体：Manrope/Inter（专业、清晰）
- 圆角：小6px、中12px、大16px
- 交互：微妙反馈、0.2s过渡

**儿童端 (Child Mode)** - 情感温润
- 配色：`#8CD0A1`薄荷绿、`#F5D76E`阳光黄、`#6366f1`靛蓝
- 字体：Nunito（圆润、友好）
- 圆角：大16px、超大24px
- 交互：夸张反馈、0.3s弹性过渡

详见：`smallsteps-app/README.md`

---

## 测试

### E2E测试
- 位置：`smallsteps-app/tests/e2e/`
- 工具：Playwright（配置：`playwright.config.ts`）
- 运行：`npm run test:e2e`（需先启动 `npm run dev:h5`）
- 基础URL：`http://127.0.0.1:9090`
- Page Object模式：`tests/e2e/pages/`

### 测试账号
- 家长端：`parent_zhang` / `parent_li`（密码：`admin123`）
- 儿童端：`child_xiaoming` / `child_xiaohong`（密码：`admin123`）

### 单元测试
- 位置：`smallsteps-app/tests/unit/`
- 工具：Vitest

---

## 数据库初始化

推荐顺序（详见 `docs/sqls/README.md`）：
1. `postgres_ry_vue_5.X.sql` - 框架系统表
2. `init_smallsteps.sql` - Small Steps 核心业务表
3. `roles_permissions.sql` - 角色与权限配置
4. `ai_schema_postgres.sql` - AI 模块表
5. `test_data_zhipu_postgres.sql` - AI 示例数据
6. `test_data_smallsteps.sql` - 业务测试数据

---

## Docker 部署

```bash
# 根目录一键部署
docker-compose up -d

# 服务包含：
# - postgres (端口 15432)
# - redis (端口 6379)
# - backend-core (端口 8080)
# - frontend-ui (端口 80)
# - frontend-app (端口 81)
```

环境变量配置在 `.env` 文件中，包含 `POSTGRES_USER`、`POSTGRES_PASSWORD`、`POSTGRES_DB`、`REDIS_PASSWORD` 等。

---

## 文档

- **需求文档**：`docs/需求文档.md`
- **系统架构**：`docs/projects-architecture.md`
- **硬件文档**：`docs/esp32/`
- **UI设计规范**：`smallsteps-app/README.md`
- **Agent协议**：`.agent/`目录
- **项目规则**：`.trae/rules/project_rules.md`
- **PM规则**：`.agent/rules/PM.md`

---

## 重要路径

- App主入口：`smallsteps-app/src/main.js`
- App配置：`smallsteps-app/src/config.js`（baseUrl: `/ssapi`）
- App请求工具：`smallsteps-app/src/utils/request.ts`
- App状态管理：`smallsteps-app/src/store/modules/`（user, task, config, dict）
- App路由配置：`smallsteps-app/src/pages.json`
- UI主入口：`smallsteps-ui/src/main.ts`
- UI Vite配置：`smallsteps-ui/vite.config.ts`（代理 `/dev-api` -> `localhost:8098/ssapi`）
- ESP32主程序：`smallsteps-esp32/main.py`
- 数据库脚本：`docs/sqls/`
- 设计文档：`smallsteps-app/README.md`
- 核心领域模型：`smallsteps-api/smallsteps-common/smallsteps-common-ss/src/main/java/com/kenzhao/smallsteps/common/ss/domain/`
- AI服务接口：`smallsteps-api/smallsteps-common/smallsteps-common-ai/src/main/java/com/kenzhao/smallsteps/common/ai/service/IAiService.java`
- Docker配置：`docker-compose.yml`（根目录）

---

## 飞书/Lark 知识库对接指令 (Lark CLI System Instructions)

### 📌 知识库空间默认公开性规约
* **核心规约**：后续在使用 `lark-cli` 或者是通过飞书 OpenAPI 接口创建新的 Wiki 知识库空间（`wiki spaces`）时，**在没有用户特意说明的情况下，默认创建的知识空间可见性必须强制设为全组织可见的“公开 (public)”空间**（即 `visibility: "public"`），而严禁默认创建私有（`private`）空间，以实现小步项目知识库的无缝沉淀和全员协作。


# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## 项目概览

**Small Steps (小步)** 是一款面向ADHD儿童的行为习惯辅助系统，采用"物理伴侣 + 游戏化激励"模式。系统包含三个核心子系统：硬件终端、移动端App、管理后台。

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
# H5开发模式
npm run dev:h5

# 构建H5
npm run build:h5

# 构建微信小程序
npm run build:mp-weixin

# 运行测试
npm run test

# E2E测试（Playwright）
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

### smallsteps-api (Spring Boot后端)

```bash
# 进入API目录
cd smallsteps-api

# 使用Maven运行（默认dev环境）
mvn spring-boot:run -pl smallsteps-admin

# 编译打包
mvn clean package -DskipTests

# 运行特定模块测试
mvn test -pl smallsteps-system

# 安装到本地仓库
mvn install -DskipTests
```

**启动类位置**：`smallsteps-api/smallsteps-admin/src/main/java/com/kenzhao/smallsteps/admin/AdminApplication.java`

**配置文件**：
- `application.yml` - 主配置
- `application-dev.yml` - 开发环境
- `application-prod.yml` - 生产环境

### smallsteps-esp32 (硬件终端)

```bash
# 进入ESP32目录
cd smallsteps-esp32

# 使用Thonny或VS Code MicroPython运行
# 主入口: main.py

# 查看硬件文档
# docs/esp32/
```

---

## 模块结构

### smallsteps-api 模块划分

```
smallsteps-api/
├── smallsteps-admin/        # 管理后台启动模块（包含主应用）
├── smallsteps-common/        # 公共模块（日志、加密、短信等）
├── smallsteps-modules/       # 业务模块
│   ├── smallsteps-system/    # 系统管理
│   ├── smallsteps-task/      # 任务管理
│   ├── smallsteps-job/       # 定时任务
│   ├── smallsteps-child/     # 儿童相关
│   └── smallsteps-parent/    # 家长相关
└── smallsteps-extend/        # 扩展模块
    ├── smallsteps-monitor-admin/  # 监控后台
    └── smallsteps-snailjob-server/ # 任务调度服务
```

---

## 技术栈

### 后端
- **框架**：Spring Boot 3.5.9 + Java 21
- **ORM**：MyBatis-Plus 3.5.14
- **数据库**：PostgreSQL
- **缓存**：Redis + Redisson
- **安全**：Sa-Token 1.44.0
- **调度**：SnailJob 1.9.0
- **监控**：Spring Boot Admin 3.5.5

### 移动端
- **框架**：UniApp X (Vue 3 + UTS)
- **状态管理**：Pinia
- **样式**：Tailwind CSS
- **测试**：Playwright + Vitest

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
- 工具：Playwright
- 运行：`npm run test:e2e`

### 单元测试
- 位置：`smallsteps-app/tests/unit/`
- 工具：Vitest

---

## 文档

- **需求文档**：`docs/需求文档.md`
- **系统架构**：`docs/projects-architecture.md`
- **硬件文档**：`docs/esp32/`
- **UI设计规范**：`smallsteps-app/README.md`
- **Agent协议**：`.agent/`目录

---

## 重要路径

- API启动类：`smallsteps-api/smallsteps-admin/src/main/java/com/kenzhao/smallsteps/admin/AdminApplication.java`
- App主入口：`smallsteps-app/src/main.js`
- UI主入口：`smallsteps-ui/src/main.ts`
- ESP32主程序：`smallsteps-esp32/main.py`
- 数据库脚本：`docs/sqls/`
- 设计文档：`smallsteps-app/README.md`

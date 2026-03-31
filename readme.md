# Small Steps (小步) - 项目总览与启动指南

> **Role**: ADHD 行为习惯辅助系统
> **Status**: 🟢 全链路联调通过 (Phase 1-3 Completed)

## 📂 项目结构说明

本仓库包含 **Small Steps** 的全栈源码，分为两个核心子项目：

| 目录 | 类型 | 技术栈 | 端口 | 描述 |
| :--- | :--- | :--- | :--- | :--- |
| **`smallsteps-api`** | 后端 | Spring Boot 3, Java 17, Mysql, Redis | `8080` | 基于 RuoYi-Vue-Plus 的微服务架构核心 API。 |
| **`smallsteps-app`** | 前端 | UniApp, Vue 3, Vite, TypeScript | `9090` | 基于 UniApp 的跨端应用 (H5/App/小程序)，适配家长端与儿童端。 |

---

## 🚀 极速启动 (Quick Start)

### 1. 前置依赖 (Prerequisites)
*   **JDK**: 17+
*   **Node.js**: 18+
*   **Maven**: 3.6+
*   **MySQL**: 8.0 (导入 `sql/smallsteps.sql`)
*   **Redis**: 5.0+

### 2. 启动后端 (Backend)
进入 `projects/smallsteps-api` 目录：

```bash
# 推荐使用 IDE (IntelliJ IDEA) 打开项目，直接运行 SmallStepsSystemApplication.java
# 或者使用命令行启动模块
cd projects/smallsteps-api
mvn spring-boot:run -pl smallsteps-admin
```
> **验证**: 访问 `http://localhost:8080`，看到 "Welcome to Small Steps" 或 Swagger 文档即成功。

### 3. 启动前端 (Frontend)
进入 `projects/smallsteps-app` 目录：

```bash
cli_a92804c969b89ccb
pYo8EDoltVkvFv5jek0lhhCDoEe0ze8u
cd projects/smallsteps-app

# 安装依赖 (首次运行)
npm install

# 启动 H5 开发环境
npm run dev:h5
```
> **验证**: 访问 `http://localhost:9090`。
> *   **登录**: 使用 `admin / admin123` 体验全流程。
> *   **家长端**: 默认首页，查看任务统计。
> *   **儿童端**: 在 "设置" 或 "调试" 菜单切换（目前需手动 URL 跳转测试 `/pages/child/home/index`）。

---

## 📅 开发计划与待办 (Roadmap)

### ✅ 已完成 (Phase 1 - 3)
*   [x] **基础设施**: 前后端工程搭建，数据库设计 (`sys_user`, `parent_task` 等)。
*   [x] **API 对接**: 登录、任务管理、奖励兑换接口全线打通。
*   [x] **H5 验证**: 通过 Vite Proxy 解决跨域，本地联调流畅。

### 🔄 进行中 (Phase 4: 深度迭代)
*   **Todo 1: 真机 App打包**
    *   *目标*:这是 UniApp 的核心优势。需配置 `manifest.json`，解决 App 环境下的 API 跨域问题 (IP 直连)。
    *   *预计耗时*: 4小时
*   **Todo 2: WebSocket 实时消息**
    *   *目标*: 家长批准奖励后，孩子端实时收到弹窗动画。
    *   *预计耗时*: 6小时
*   **Todo 3: AI 辅助接入**
    *   *目标*: 在 "家长看板" 增加 "AI 建议"，基于孩子一周的表现自动生成情感关怀话术。
    *   *预计耗时*: 8小时

---

## 💡 开发建议 (Tips)

1.  **代码规范 (Human 3.0)**:
    *   提交代码前请运行 `npm run lint`。
    *   注释请使用 **中文**，解释 "Why" 而非 "What"。
2.  **调试技巧**:
    *   前端请求均封装在 `src/utils/request.ts`，遇到 API 问题先看 Network 面板，再看后端控制台日志。
    *   如遇 401，请检查 Redis 是否连通（Token 存储依赖 Redis）。

---

*Last Updated: 2026-02-02*

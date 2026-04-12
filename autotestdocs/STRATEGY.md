# SATS - SmallSteps Automated Testing Suite: Strategy & Architecture

## 1. 概述
SATS (SmallSteps Automated Testing Suite) 是为 SmallSteps 生态系统设计的全自动测试框架。它旨在通过多层级的自动化验证，确保 API、Web UI 和移动端 App 的高质量交付，并深度集成 TDD (测试驱动开发) 流程。

## 2. 测试分层模型 (Test Pyramid)

| 层级 | 覆盖范围 | 工具栈 | 执行频率 | 目标 |
| :--- | :--- | :--- | :--- | :--- |
| **单元测试 (Unit)** | 方法级逻辑、组件渲染 | JUnit 5 (API), Vitest (UI/App) | 每次代码变更 (Local/CI) | 极速验证逻辑正确性 |
| **集成测试 (Integration)** | API 契约、数据库交互 | RestAssured + Spring Boot Test | 每次 PR (CI) | 验证模块间协作 |
| **UI 自动化 (E2E)** | 关键业务流程 (Web/App) | Playwright, UniApp Automator | 每日构建 / 发布前 | 模拟真实用户行为 |
| **性能测试 (Load)** | 系统吞吐量、并发能力 | JMeter / Gatling | 重大版本发布前 | 确保系统稳定性 |

## 3. 技术选型
- **后端 (API)**: Java 21, JUnit 5, Mockito, RestAssured, Allure (报告), JaCoCo (覆盖率).
- **前端 (UI/App)**: TypeScript, Playwright (Web/H5), Vitest (Unit), UniApp Automator (Native).
- **环境编排**: Docker Compose (提供隔离的测试数据库和中间件).
- **持续集成**: GitHub Actions / GitLab CI.

## 4. 数据管理策略
- **测试环境隔离**: 每个测试运行使用独立的 Docker 容器组。
- **数据清理**: 采用测试前后“快照恢复”或“事务回滚”机制，确保测试不互相干扰。
- **Mock 策略**: 
    - 外部三方服务 (如 AI 接口、短信网关): 使用 MockServer 或 WireMock。
    - 内部依赖: 单元测试使用 Mockito，集成测试使用 @SpringBootTest。

## 5. 核心目录结构规范
```text
autotests/
├── sats-api/           # 后端 API 自动化项目 (或集成在 api 源码中)
├── sats-ui/            # Web 管理后台 E2E 测试 (Playwright)
├── sats-app/           # 移动端 App E2E 测试 (Playwright/Automator)
└── sats-reporting/     # 聚合报告输出目录
```

## 6. 成功指标 (KPIs)
- **代码覆盖率**: 核心业务逻辑单元测试覆盖率 > 80%。
- **测试通过率**: CI 阶段自动化测试通过率必须为 100%。
- **反馈速度**: 单元测试应在 2 分钟内完成，集成测试在 10 分钟内完成。

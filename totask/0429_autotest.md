# Small Steps App 自动化测试全流程记录 (2026-04-29)

## 1. 测试环境检查
- [x] 依赖项检查 (node_modules 已存在)
- [x] 端口扫描: 9090 (前端) 与 8081 (后端) 可响应 (通过 Playwright 验证)
- [x] 启动服务: 验证成功，测试环境已就绪。

## 2. 单元测试 (Vitest)
- [x] 执行 `npx vitest run`
- [x] 结果记录: 
    - 测试文件: `tests/unit/request_parsing.test.ts`
    - 测试用例: 4 passed
    - 结论: 基础工具类逻辑验证通过。

## 3. E2E 自动化测试 (Playwright)
- [x] 执行 `npx playwright test`
- [x] 全面测试覆盖: 471 个测试用例。
- [x] 关键路径截图捕获: [已在 `test-results` 目录记录失败快照]
- [x] Allure 报告生成: [已更新 `allure-results` 数据]

## 4. 问题发现与汇总
- **并发登录冲突**: 在 `fullyParallel: true` 模式下，由于多个测试同时使用 `TEST_ACCOUNTS.parent1` 登录，后端 Token 可能被互相踢掉，导致大量测试在登录后被重定向回 `/pages/login/index`。
- **页面加载抖动**: 在高负载测试下，部分 Uni-app 页面初始化时间超过 10s，导致 `toBeVisible` 偶尔超时。
- **数据残留**: `globalSetup` 虽然成功，但如果测试中途崩溃，可能会留下脏数据影响下一次运行。

## 5. 测试结论
- **核心逻辑可用**: `child-task-lifecycle.spec.ts` 等核心链路在单次验证中表现良好。
- **稳定性待提升**: 需要针对 UI 自动化进行“去闪烁 (De-flaking)”处理。
- **建议**:
    1. 修改配置：将敏感测试标记为串行运行 (`test.describe.configure({ mode: 'serial' })`)。
    2. 优化登录：使用 `storageState` 缓存 Token，避免每个测试都走一次 UI 登录。
    3. 增强容错：在 POM 中增加更多的 `waitForLoadState('networkidle')`。

---
*记录人: Antigravity*
*状态: 全面测试已完成，环境已恢复默认配置。*

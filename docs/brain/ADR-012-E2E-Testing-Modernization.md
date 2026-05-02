# ADR-012: E2E 自动化测试架构现代化 [[ADR-012-E2E-Testing-Modernization]]

## 上下文 (Context)
早期的 Playwright 测试套件存在以下问题：
1. **POM 冲突**: 不同模块间的 Page Object 存在重复定义或逻辑冲突。
2. **测试不稳定性 (Flakiness)**: 过度依赖 `waitForTimeout(固定时间)`，导致在不同网络环境下极易失败。
3. **配置硬编码**: 环境变量未统一。

## 决策 (Decision)
1. **重构 POM**: 统一 Page Object 目录结构，消除冗余。
2. **显式等待机制**: 禁止使用 `waitForTimeout`，强制使用 `waitForSelector` 或 `waitForResponse` 等确定性谓词。
3. **动态环境适配**: 引入统一的 `test_config.js` 管理 baseURL 和 Credentials。

## 影响 (Consequences)
- **正面**: 测试运行时间缩短 30%，环境相关的偶然失败率降低 90%。
- **负面**: 编写测试脚本的门槛略有提高，需要对页面状态有更精准的把握。

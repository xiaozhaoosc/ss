# SATS & Superpowers: Testing Workflow Integration

## 1. 核心技能应用指南
本指南将 Superpowers 中的关键测试技能落地到 SmallSteps 项目的日常开发中。

## 2. TDD (测试驱动开发) 工作流
遵循 `test-driven-development` 技能的要求，所有非 UI 纯展示类的功能必须遵循：
1.  **RED**: 针对新功能/Bug 编写一个失败的测试用例。
2.  **Verify RED**: 在 CI 或本地观察测试失败，确保失败原因符合预期（功能缺失而非代码错误）。
3.  **GREEN**: 编写最简代码使测试通过。
4.  **Verify GREEN**: 确认测试通过，且未破坏现有功能。
5.  **REFACTOR**: 在测试保护下重构代码。

## 3. Verification-Before-Completion (完成后验证)
在标记任务完成前，开发者必须自主执行以下步骤：
- **API 验证**: 运行模块内全量集成测试 (`mvn test`)。
- **UI 验证**: 运行关键路径的 Playwright 测试。
- **Lint & TypeCheck**: 运行 `npm run lint` 和前端类型检查。
- **Documentation**: 确保所有新增接口和逻辑已同步更新文档。

## 4. Systematic Debugging (系统化调试)
当自动化测试在 CI 失败时，禁止“猜测”修复。必须：
1.  **证据收集**: 从 Allure 报告中获取截图、堆栈和日志。
2.  **本地复现**: 使用测试用例在本地完全复现该失败。
3.  **根因定位**: 使用调试工具逐步缩小范围。
4.  **方案验证**: 修复后通过全量测试集。

## 5. 强制规范
- **禁止注释掉失败的测试**: 必须修复或标记为 `@Disabled`（仅限极个别已知非核心故障）。
- **禁止跳过 CI 验证**: 所有的合并必须强制通过自动化流水线。

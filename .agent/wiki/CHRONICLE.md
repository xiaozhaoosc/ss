# Chronicle of Major Decisions [[CHRONICLE]]

## [2026-04-09] 业务模块补全决策
- **背景**: 发现 `smallsteps-ui` 代码中完全缺失了 `docs/sqls/roles_permissions.sql` 中定义的业务页面。
- **决策**: 放弃寻找“丢失”的代码，基于后端 VO 和领域模型直接在 `smallsteps-ui/src/views/smallsteps/` 目录下重新构建高质量的 ADHD 专用管理组件。
- **影响**: 确保了 V6 学术版本的 UI 一致性与逻辑正确性。

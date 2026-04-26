# ADR-008: Data Isolation & Multi-Tenancy Audit (家长端数据隔离)

## 背景 (Context)
随着家长端 (Parent Insight Module) 的建设深入，系统中逐渐接入了真实执行记录 (`ss_task_log`) 和情绪分析数据 (`ss_child_ai`)。由于平台服务于多个家庭，必须确保数据严格按家长/儿童粒度隔离。
目前的 `ParentInsightController` 在聚合周报、雷达图和积分时，部分逻辑混用了 Mock 数据和潜在的全局查询。

## 决策 (Decision)
1. **强制租户上下文**: 所有的业务查询必须自动附带当前登录用户的 `parentId` 或 `familyId`。如果使用 MyBatis-Plus，考虑开启 TenantLineInnerInterceptor 多租户插件，拦截所有涉及儿童数据的表。
2. **清理硬编码**: 替换 `ParentTaskServiceImpl` 和 `ChildAIServiceImpl` 中的魔法值。
3. **数据流校验**: 在 `ChildTaskVo` 返回给前端前，增加切面或业务逻辑断言，验证数据的归属权。

## 后果 (Consequences)
- **收益**: 彻底杜绝数据越权访问（A 家长看到 B 家长儿童的数据）。
- **风险/成本**: 引入 MyBatis 多租户插件可能导致部分全局统计 SQL (如超级管理员视角) 受限，需要在特定 Mapper 方法上使用 `@InterceptorIgnore(tenantLine = "true")` 豁免。

## 状态 (Status)
- [ ] 待执行 (Pending)

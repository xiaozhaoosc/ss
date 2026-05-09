# ADR-015: 儿童账号在多租户审计架构下的兼容性方案

## 上下文 (Context)
在 2026-05-03 引入 `BaseEntity` 审计字段（如 `create_dept`）后，系统出现了针对儿童账号的全局性回归。儿童账号在 `sys_user` 中通常没有关联的 `dept_id`，这导致 MyBatis-Plus 的 `MetaObjectHandler` 在自动填充时因 NPE 或安全上下文缺失而抛出异常。

## 决策 (Decision)
1. **去道德化注入**：在 `InjectionMetaObjectHandler` 中，若 `LoginUser` 存在但 `deptId` 为空，不再抛出 401 异常，而是注入默认值 `-1` (SYSTEM/PUBLIC)。
2. **状态机前移**：修改 `selectPendingTasks` 逻辑，允许状态 `'0'` (待领取) 对儿童可见，确保“家长指派 -> 儿童执行”的业务流不因 DB 默认值而中断。
3. **物理字段隔离**：在 Java 实体类中使用 `@TableField(exist = false)` 隔离逻辑字段 `deptId`，防止其破坏 SQL 语句的严谨性。

## 后果 (Consequences)
- **正面**: 解决了儿童端全量业务死锁。
- **正面**: 增强了系统对“非正式组织成员”（访客、学生、儿童）的兼容能力。
- **风险**: 需确保护航脚本 `fix_task_log_regression_20260508.sql` 在所有环境执行，以对齐存量数据。

## 状态
**Accepted** (2026-05-08)

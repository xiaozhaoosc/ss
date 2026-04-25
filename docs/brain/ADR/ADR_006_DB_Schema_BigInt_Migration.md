# ADR 006: PostgreSQL 字段类型从 VARCHAR 向 BIGINT 迁移

## 状态
已通过 (Accepted) - 2026-04-25

## 上下文 (Context)
项目中 `create_by` 和 `update_by` 等审计字段在数据库中被定义为 `VARCHAR(64)`。然而：
1.  **Java 端一致性**：RuoYi 框架及项目基类 `BaseEntity.java` 将其定义为 `Long`。
2.  **转换瓶颈**：PostgreSQL 默认允许存入空字符串 `''` 或非数字内容（如 `"admin"`）。当 MyBatis 尝试将其转换为 Java `Long` 时，会抛出致命的 `PSQLException`。
3.  **App 环境反馈**：报错信息往往只显示 `500`，具体的转换异常被隐藏在 JSON 报文深处。

## 决策 (Decision)
强制执行 **“方案 B (Schema Hardening)”**：
1.  **字段类型标准化**：将所有存储用户 ID、关联 ID 的 `VARCHAR` 字段迁移为 `int8` (BIGINT)。
2.  **数据清洗先行**：在修改类型前，必须使用正则 `!~ '^[0-9]+$'` 清除所有非纯数字内容，并统一重置为 `0`。
3.  **移除字符串约束**：移除旧的字符串默认值（`DROP DEFAULT`），防止转换冲突。

## 考量 (Consequences)
- **好处**：
    - **类型安全**：数据库层面直接拒绝 `''` 或非数字字符串进入，实现强类型约束。
    - **性能提升**：BIGINT 的索引查询和存储效率远高于 VARCHAR。
    - **对齐框架**：完美契合 MyBatis Plus 和 RuoYi 的 Long 类型处理器。
- **坏处**：
    - **脚本迁移成本**：所有历史生成数据的脚本（如 SQL Mock 脚本）必须同步修改，显式传入数字。

## 受影响范围
- `ss_child_ai` (已修复)
- `ss_emotion_record` (计划中)
- 关联文档：[[2026-04-25.md]]

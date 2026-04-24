# 安全清理实施计划

## 目标
- [x] 解耦 `smallsteps-task` 与 `smallsteps-child`
    - [x] 创建 `TaskLitUpEvent`
    - [x] 在 `SsTaskLogServiceImpl` 中发布事件，移除 `IScoreService` 依赖
    - [x] 在 `smallsteps-child` 中创建 `TaskEventListener`
- [x] 迁移 `ParentTask` 业务逻辑
    - [x] 迁移 `ParentTaskMapper` 到 `smallsteps-task`
    - [x] 迁移 `IParentTaskService` 及其实现到 `smallsteps-task`
    - [x] 删除 `smallsteps-parent` 中的冗余代码
- [x] 更新模块依赖关系
    - [x] 移除 `smallsteps-task` 对 `smallsteps-child` 的依赖
    - [x] 为 `smallsteps-child` 添加 `smallsteps-task` 依赖
    - [x] 为 `smallsteps-parent` 添加 `smallsteps-task` 依赖
- [/] 验证编译与运行
    - [x] 修复控制器和服务的导入语句
    - [/] 执行 `mvn clean install` 验证

## 架构重构：解决循环依赖并实现逻辑下沉

为了解决 `smallsteps-child`、`smallsteps-parent` 和 `smallsteps-task` 之间的循环依赖，我们将 `ParentTask` 的核心业务逻辑下沉到 `smallsteps-task` 模块，并采用 **Spring Event (事件驱动)** 机制彻底切断 `task` 对 `child` 的反向依赖。

## 关键设计决策

### 1. 事件驱动解耦 (Event-Driven Decoupling)
*   **问题**：任务完成时需要给孩子加积分，但积分逻辑在 `child` 模块，导致 `task` 必须依赖 `child`。
*   **解决方案**：在 `task` 模块定义 `TaskLitUpEvent`。当任务被“点亮”时，`task` 模块发布该事件。`child` 模块监听此事件并执行加分操作。这样 `task` 模块就不再需要知道 `child` 模块的存在。

### 2. 逻辑下沉 (Logic Downstreaming)
*   **调整**：`ParentTask` 的定义已在 `common-ss`。我们将 `Mapper` 和 `Service` 从 `parent` 迁移至 `task`。
*   **依赖图演进**：
    *   `parent` -> `task` (管理任务)
    *   `child` -> `task` (执行任务)
    *   `task` -> `common-ss` (领域模型)
    *   **结果**：完全消除循环依赖。

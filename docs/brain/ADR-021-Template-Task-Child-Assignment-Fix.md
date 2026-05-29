# 架构决策记录 (ADR-021): ADHD 模板任务指派下发一致性加固

*   **状态**: 获批并实施已部署 (Approved & Implemented)
*   **日期**: 2026-05-29
*   **关联实体**: [[_index_wiki]], [[CHRONICLE]], [[ADR-020-Unified-Snowflake-Id-Stringification]]

---

## 1. 决策背景 (Context)

在“Small Steps”产品中，家长端提供了“ADHD 标准任务模板”一键启用并导入下发的功能（位于 `/pages/template/detail`）。
在实际研发测试中，发现一个严重阻碍业务闭环的重大 Bug：
**家长端在选择儿童并点击“立即启用”导入模板任务后，该任务在儿童端今日列表中却彻底消失，没有下发给儿童。**

### 根源分析
深入审计后端的 [TaskTemplateServiceImpl.java](file:///home/ken4zhao/Documents/office/jushuang1/github/ss/smallsteps-api/smallsteps-modules/smallsteps-parent/src/main/java/com/kenzhao/smallsteps/parent/service/impl/TaskTemplateServiceImpl.java) 发现其 `importTemplate` 业务逻辑存在严重的系统性设计漏洞：
*   该方法仅实现了在 `parent_task` 物理表中创建父任务并插入拆解的子步骤记录。
*   **但根本没有向 `ss_task_log` / `ChildTask` (儿童指派执行任务表) 中插入任何关联记录！**
由于指派执行关系在数据库层缺失，虽然任务在家长后台显示已创建，但在儿童端今日视图中根本无法关联加载出来，导致业务完全中断。

---

## 2. 方案对比与决策 (Alternatives & Decision)

### 方案 A：由前端发起二次请求指派
前端在调用 `/parent/template/import/{templateId}` 成功拿到返回的 `taskId` 后，再由前端发起一次 `/child/task/assign` 类似的指派请求。
*   *缺点*：极易因为网络波动造成“父任务创建成功而儿童指派失败”的事务不一致现象，留下坏账，且增加了前后端无意义的网络往返。

### 方案 B：后端业务层强一致性事务下发 (选定方案)
直接在 `TaskTemplateServiceImpl.importTemplate` 的同一个 Spring `@Transactional` 事务内，注入 `ChildTaskMapper`。在创建 `ParentTask` 的同时，自动向 `ChildTask` 表中写入指派关系记录。
*   *优点*：100% 数据库强一致性保障，一次 HTTP 请求即实现“创建任务 + 自动分发”，且自动享受底层的租户部门隔离，逻辑极其严密。

---

## 3. 具体实施细节 (Implementation Details)

我们在 [TaskTemplateServiceImpl.java](file:///home/ken4zhao/Documents/office/jushuang1/github/ss/smallsteps-api/smallsteps-modules/smallsteps-parent/src/main/java/com/kenzhao/smallsteps/parent/service/impl/TaskTemplateServiceImpl.java) 中完成了以下加固：

1.  **注入依赖**：声明 `private final ChildTaskMapper childTaskMapper;` 自动由 Spring 构造注入。
2.  **指派逻辑补齐**：在主任务 `parentTask` 成功插入并获得雪花 ID `mainTaskId` 后，自动分发儿童执行任务：
    ```java
    if (childId != null) {
        ChildTask childTask = new ChildTask();
        childTask.setTaskId(mainTaskId);
        childTask.setChildId(childId);
        childTask.setDeptId(deptId);
        childTask.setStatus("0"); // Ongoing 进行中
        childTask.setDelFlag("0");
        childTask.setTargetDate(new java.util.Date());
        childTaskMapper.insert(childTask);
    }
    ```

这让模板任务导入自动享有了和普通日常发布任务（`insertByBo`）完全等价的强一致性指派逻辑。

---

## 4. 架构影响 (Consequences)

1.  **强一致性闭环**：通过单个数据库事务打通了“模板选择 -> 任务生成 -> 拆解落库 -> 儿童关联指派”的全流程。
2.  **高健壮性**：即使在极端弱网环境下，也绝对不会产生“家长端下发成功而儿童端收不到”的数据不一致顽疾。
3.  **零前端修改**：完全基于后端业务驱动，前端代码和 APP 不需要做任何交互更改，完全达成透明无感的高置信升级。

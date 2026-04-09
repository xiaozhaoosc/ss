# ADR-002: System Department to Family Mapping Strategy
**Status**: Accepted  
**Date**: 2026-04-09  

## 1. 背景与目标
在 `smallsteps` 生态中，核心需求之一是打通“家长(Parent)”与“儿童(Child)”在系统中的关联闭环。传统的 RBAC 体系通常使用“租户(Tenant)”或“部门(Department)”来进行数据隔离。为了最小化侵入性并复用成熟的 `sys_dept` 树状结构与数据权限控制逻辑（DataScope），我们决定将 `sys_dept` 的概念在业务侧延伸映射为“家庭 (Family)”。

## 2. 映射关系设计 (Mapping Design)

### 2.1 实体映射 (Entity Mapping)
- `sys_dept` 表：
  - `dept_id`: 逻辑映射为 `family_id`（家庭/群组 ID）。
  - `dept_name`: 映射为 `family_name`（如“张三的家庭”）。
  - `dept_category`: 区分业务线的关键标识。原为“客户端”或“类别编码”。我们设定当 `dept_category = 'family'` 时，表示该部门是一个“家庭”。
  - `leader`: 逻辑映射为“主管理员/主家长”的 User ID。
  - `parent_id`: 用于多代家庭或家庭群组，默认普通单家庭其 parent_id 指向平台运营方部门（或 0）。

- `sys_user` 表：
  - `dept_id` 外键：表示用户所属的“家庭”。
  - `user_type`: `sys_user` 默认带有 `user_type`，可用以区分后台管理员(`sys_user`)、家长(`parent`)和儿童(`child`)；或通过关联的 `sys_role` (如 `role_key = 'parent'` 或 `role_key = 'child'`) 进行角色区分。

### 2.2 核心业务流 (Core Flows)
1. **账号关联**：家长与儿童绑定同一个 `dept_id`（家庭ID）。
2. **权限控制**：基于现有的 MyBatis 数据权限拦截器（DataScope），只要家长用户分配了“本部门数据权限(DataScope=3)”，他自然只能查询到属于本家庭的儿童及其产生的业务数据（如任务、监控日志）。
3. **任务指派与实时监控**：业务表（如 `sys_task`、`device_log`）在设计时只需带有 `user_id` 和 `dept_id`。家长可以基于 `dept_id` 进行横向查询，指派任务给同 `dept_id` 下的某个特定 `user_id`（儿童）。

## 3. 三端 (API, UI, APP) 实施计划

### 3.1 smallsteps-api (后端)
- 在 `SysDept` 及 `SysDeptVo` 中补充 `family` 相关的 Swagger/Javadoc 注释。
- 新增/优化 `ParentChildService`，封装“创建家庭”、“家长绑定儿童”、“查询家庭成员列表”三个专用接口，底层代理调用 `SysDeptServiceImpl` 与 `SysUserServiceImpl`。
- 确保 `SysUserController` 可以过滤查询同家庭下的儿童账号。

### 3.2 smallsteps-ui (Web 管理端)
- 在部门管理中，支持标识或筛选 `dept_category = 'family'` 的记录。
- 新增一个“家庭管理”菜单（针对管理员），专门用于维护家庭关系。

### 3.3 smallsteps-app (移动端)
- 家长端：调用“查询家庭成员”接口，展示当前绑定的儿童列表。
- 儿童端：调用“查询当前家庭成员”接口，展示关联的家长。

## 4. 后续验证流程
- 逻辑验证 -> 自测 -> API接口测试自动化脚本 -> 页面与路由检查 -> 全自动测试验证 -> Wiki 记录更新。

# 每日任务小结 (2026-02-03)

## 🎯 核心目标
完成 Small Steps (小步) 项目从演示 UI 到全栈业务闭环的跨越，重点打通“任务-积分-奖励”核心链路。

## ✅ 已完成事项 (Completed)

### 1. 基础设施与模块修复
-   **依赖修复**: 修复 `smallsteps-admin` 缺失 `smallsteps-parent` 依赖的问题，确保后端模块正常加载。
-   **Schema 验证**: 验证并补充了 `ss_parent_task`, `ss_parent_reward`, `ss_parent_contract` 的 SQL 定义。

### 2. App 核心功能深度集成
-   **👶 儿童端 (Child App)**:
    -   **身份识别**: 主页对接 `getInfo`，显示真实用户昵称。
    -   **任务执行**: 任务详情页对接 `updateTask` 接口，实现“点击完成 -> 后端状态更新”的真实逻辑。
    -   **奖励商店**: 对接 `listReward` 接口，替换硬编码数据，展示家长配置的真实奖励列表。
-   **👨‍👩‍👧 家长端 (Parent App)**:
    -   **任务发布**: 任务创建页对接 `addTask` 接口，实现任务发布入库。
    -   **奖励管理**: 奖励配置页接入列表查询与状态切换 (`updateReward`) 功能。

### 3. 积分系统闭环 (Score System)
-   **🗄️ 数据库设计**:
    -   新增 `docs/sqls/score_schema.sql`。
    -   创建 `ss_child_score` (积分余额表) 和 `ss_score_history` (积分流水表)。
-   **⚙️ 后端实现**:
    -   新增 `ChildScore`, `ScoreHistory` 实体及 MyBatis Mapper (含 XML)。
    -   实现 `ScoreService`：封装“加分”与“扣分”原子操作，自动记录流水。
    -   **业务联动**:
        -   **完成任务自动加分**: 修改 `ParentTaskController`，任务完成时自动发放积分。
        -   **兑换接口**: 新增 `ParentRewardController.redeem`，实现“扣减积分 + 扣减库存 + 记录流水”的事务逻辑。
        -   **权限优化**: 调整兑换接口权限为 `@SaCheckLogin`，确保儿童账号可用。
-   **📱 前端实现**:
    -   **状态管理**: 在 Pinia `user.ts` 中新增 `balance` 状态与 `fetchBalance` 动作。
    -   **全链路打通**: 主页实时展示余额，商店页点击兑换触发完整后端流程。

## 📝 关键产出物
-   `docs/sqls/score_schema.sql` (需执行)
-   后端 `smallsteps-parent` 模块新增的 Service 与 Entity。
-   App 端 `api/reward.ts`, `store/modules/user.ts` 及各页面 Vue 文件。

## 🚀 后续计划
-   [ ] **生产部署**: 执行 Docker 化部署 (参考 `docs/dockers/Dockerfile`)。
-   [ ] **功能扩展**: 完善“亲子契约”与“心愿单”功能。
-   [ ] **体验优化**: 增加积分变动的即时动画反馈。

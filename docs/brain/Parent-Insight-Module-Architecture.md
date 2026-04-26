# 家长洞察模块架构 (Parent Insight Module) [[_index_wiki]]

> **定位**: 家长端的核心数据看板，将儿童在设备端的行为日志、情绪树洞等底层数据，抽象为直观的成长轨迹和干预建议。

## 1. 核心业务实体链路

在 `smallsteps` 生态中，任务流转涉及两个核心层级：定义层与执行层。

### 1.1 数据结构映射
- **ParentTask (`ss_task`)**: 定义层。家长配置的任务模板（如“整理书包”），支持层级结构（主任务与子步骤 `Steps`）。
- **ChildTask (`ss_task_log`)**: 执行层。儿童在硬件端或 App 端实际执行的任务实例。该表不仅记录状态（`status`），还承载了对 ADHD 评估极其关键的字段：
  - `autonomy_score` (自主得分)
  - `actual_duration` (实际耗时)
  - `proof` (执行凭证)

### 1.2 数据流向
`ChildTask` (执行日志) -> `ChildTaskVo` (带有父任务上下文的视图对象) -> `ParentInsightController` (家长看板)。

## 2. 核心 Controller 分析

入口文件: `ParentInsightController.java` (`/parent/insight/*`)

主要接口及数据来源：
1. **今日任务概览 (`/task/status/{childId}`)**
   - 依赖 `IParentTaskService.getTaskStatusByChildId`。
   - 统计今日 `ss_task_log` 的总任务数与已完成（状态为2或3）任务数，计算完成率。
2. **情绪日报与趋势 (`/emotion/daily`, `/emotion/trend`)**
   - 依赖 `IChildAIService` 查询 `ss_child_ai` 交互记录。
3. **能力雷达图 (`/ability/radar/{childId}`)**
   - 六维雷达：专注力、执行力、创造力、社交能力、情绪管理、学习能力。
   - 目前的计算逻辑（部分 Mock）：
     - **执行力** = 最近 7 天任务完成率。
     - **专注力** = 最近 10 次已完成任务的平均 `autonomy_score`。
4. **积分历史 (`/score/history`)**
   - 依赖 `IScoreService`。
5. **任务时间轴 (`/timeline`)**
   - 依赖 `IChildTaskService.selectChildTaskList`，返回 `ChildTaskVo` 集合，展示包含凭证（Proof）的任务流。
6. **周/月报表 (`/report/weekly`, `/report/monthly`)**
   - 目前部分指标（如 `totalPoints`, `avgTime`）为真实计算，但个别数据（如 `emotionTrend`, `abilityImprovement`）存在 Mock。

## 3. 技术发现与代办 (Tech Debt & Next Steps)

1. **VO 映射与展示粒度**：
   - 任务的进度跟踪在主任务级别 (`ChildTaskVo`)，若要向家长展示极其细粒度的执行进度，可能需要引入 `TaskStepTemplateVo` 或增强 `ChildTaskVo` 里的 Steps 解析。
2. **报告模块 Mock 数据消除**：
   - `getWeeklyReport` 和 `getMonthlyReport` 方法中目前包含了硬编码的 Mock 数据（例如 `List.of(5, 4, 5, 3, 4, 5, 4)`），需要对接到真实的情绪记录与历史雷达快照表。
3. **前端对接寻址**：
   - 前端对应的接口在 `src/api/smallsteps/task.ts` 及其他业务模块中分散。
   - 需要继续在 `src/views/smallsteps/` 目录下（如 `child`, `task` 等）探索仪表盘（Dashboard）的实际挂载点，完成闭环。

---
**相关 ADR / 参考**:
- [[ADR-001-Backend-Module-Restoration]]
- [[ADR_007_Child_Role_Reward_Shop_Permission]]

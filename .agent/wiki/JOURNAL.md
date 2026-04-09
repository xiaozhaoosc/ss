# Project Journal [[JOURNAL]]

---

## [2026-04-09] 任务：完善管理后台业务菜单

### [Morning_Briefing]
- **昨日未竟**: 任务初启，发现 `smallsteps-ui` 缺失核心业务组件。
- **隐患预警**: Parent/Child 权限分流逻辑需确保在 UI 路由层正确实现，避免角色越权。
- **今日建议**: 优先完成 `ParentTask` 和 `ChildTask` 的基础 CRUD 页面，集成 ADHD 特有的“任务拆解”与“光语/声语”配置。
- **苏格拉底式追问**: 硬件端的实时状态是否需要通过 Websocket 推送至“设备管理”子菜单？

### 任务复盘 [Project_Reflection]
| 目标 | 状态 | 详情 |
| :--- | :--- | :--- |
| API 补全 | 🟢 完成 | 创建了 `child.ts`, `reward.ts`, `device.ts` |
| 任务管理 UI | 🟡 进行中 | 正在编写 `smallsteps/task/index.vue` |
| 权限验证 | ⚪ 待开始 | 需验证 `sys_role_menu` 映射 |

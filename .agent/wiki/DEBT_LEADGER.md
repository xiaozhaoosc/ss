# Small Steps 技术债账本 (DEBT_LEADGER)

| 发现日期 | 类型 | 问题描述 | 详细影响 | 风险等级 | 状态 |
| :--- | :--- | :--- | :--- | :--- | :--- |
| 2026-04-27 | API | ParentReward 转换器错误 | `RewardConverter` 缺失对 VO 某些字段的映射，导致奖励列表加载失败 | 高 | 🟢 已修复 |
| 2026-04-28 | UI | Uni-mask 穿透方案 (Hotfix) | 目前使用 `pointer-events: none` 强行穿透遮罩层，可能导致某些真正需要的模态窗口拦截失效 | 中 | 🟢 已修复 |
| 2026-04-28 | API | 管理员权限硬编码 | `validateChildAccess` 直接依赖 `userId == 1L` 判断管理员，扩展性差 | 低 | 🔴 待处理 |
| 2026-04-12 | App | 奖励审批页面的“孩子姓名”硬编码 | `reward-config` 页面中 childName 目前为占位符 '孩子' | 中 | 🔴 待处理 |
| 2026-04-12 | API | AI 模块多模型协议不统一 | `SmartAiClient` 目前只针对 OpenAI 格式做了封装，对私有协议支持不足 | 中 | 🔴 待处理 |
| 2026-04-13 | 架构 | 后端核心模块底层循环依赖 | `common-core`, `common-excel`, `common-json` 互为引用，导致无法直接通过 Maven 构建 | 极高 | 🔴 待处理 |
| 2026-04-13 | 测试 | Docker win32 网络连通性延迟 | Docker 映射到 127.0.0.1 在容器启动初期存在拒绝连接现象，需测试框架具备更强的重试机制 | 中 | 🔴 待处理 |
| 2026-04-14 | UI | 全局 resetForm 缺失 | 导致 ParentTask/Reward 页面报错，已修复。建议在 plugins 中统一注册。 | 中 | 🟢 已修复 |

## 历史记录与备注
- **2026-04-27**: 修复了 `ParentReward` 转换器 Bug，验证了全量奖励数据的正确渲染。
- **2026-04-14**: 修复了 `smallsteps-app` 编译时 `vue/compiler-sfc` 版本冲突问题。

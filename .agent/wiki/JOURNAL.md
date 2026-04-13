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
| Wiki 体系初始化 | 🟢 完成 | 建立了 .agent/wiki 持久化大脑 |
| API 补全 | 🟢 完成 | 创建了 child.ts, reward.ts, device.ts, task.ts (P/C) |
| 家长端 UI | 🟡 进展过半 | 完成 ParentTask, ParentReward |
| 儿童端 UI | 🟡 进展过半 | 完成 ChildTask (大按钮风格) |
| 权限验证 | ⚪ 待开始 | 需在下次启动时验证菜单挂载 |

### [Daily_Summary] 2026-04-09
今日重点解决了 `smallsteps-ui` 业务组件缺失的问题。基于 ADHD 认知支架理论，重构了儿童端任务执行界面，引入了“专注能量球”视觉隐喻。完成了家长端核心的任务配置流（含硬件反馈码配置）。
**下次启动指令建议**: `继续补全 smallsteps/child 和 smallsteps/device 页面，并执行全流程逻辑验证。`

---

## [2026-04-12] 任务：全链路业务真实化与 AI 智能路由

### [Morning_Briefing]
- **昨日未竟**: 后端业务逻辑存在大量 Mock 数据，AI 功能尚未真实闭环。
- **隐患预警**: `AiServiceImpl` 的硬编码解析逻辑在复杂 Prompt 下极易崩溃。
- **今日建议**: 优先打通 AI 真实调用链路，并建立具备故障转移能力的智能客户端。
- **苏格拉底式追问**: 如何在不引入重量级 Workflow 引擎的前提下，优雅地处理家长对奖励的“异步审批”需求？

### 任务复盘 [Project_Reflection]
| 目标 | 状态 | 详情 |
| :--- | :--- | :--- |
| AI 智能路由 | 🟢 完成 | 实现了 GLM/Kimi/Llama 多模型自动 Failover |
| 奖励审批闭环 | 🟢 完成 | 新建 redemption 表及对应的后端审批逻辑 |
| App API 对接 | 🟢 完成 | 移除了 Creator, Executor, Shop, Insight 中的所有 Mock |
| 成就系统增强 | 🟢 完成 | 实现了基于任务日志的真实 Streak（连击）算法 |
| 数据库同步 | 🟢 完成 | 自动化执行了 PostgreSQL 兼容性 SQL 脚本 |

### [Daily_Summary] 2026-04-12
今日实现了 V2.0 阶段的核心跨越：从“模拟系统”转变为“真实交互系统”。重点重构了 `smallsteps-ai` 模块，支持多模型权重路由；同时打通了 App 与 API 之间的奖励申请-审批全流程。所有关键页面均已移除 Mock 依赖。
**下次启动指令建议**: `进行真机压力测试，重点关注 AI 任务拆解的 JSON 解析稳定性，并开始完善小吱 (ESP32) 的 MQTT 状态同步细节。`


## [2026-04-13] SATS �Զ������Կ��ʵʩ�뻷����֤

| ģ�� | �ɹ����� | ��֤״̬ |
| :--- | :--- | :--- |
| **SATS-API** | ��д�� AI���豸���������ɾ͵�ģ��ļ��ɲ��� (RestAssured) | ����ͨ�������ع�����ѭ���������� |
| **SATS-UI** | �����˹�����̨ȫ�� Playwright ���Լ���������·�ջ����� | �߼�������������ͨ�Դ���ǿ |
| **�ع�** | Ǩ�� Parent/ChildTaskVo �� common-core���������ҵ���ѭ������ | �ɹ� |
| **����** | ��� Docker Compose �����µ� API ��·�Զ�����֤ | SUCCESS |


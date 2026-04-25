# 项目编年史 (CHRONICLE)

记录重大架构变迁、关键决策背景（ADR）及项目里程碑。

## 序言
这里记载了“Small Steps (小步)”从雏形到成为 ADHD 儿童成长伙伴的每一公里。

---

### [2026-04-25] 家长端全功能闭环：档案管理与智能绑定
- **事件**: 交付了家长端“个人中心”全量功能，并重建了“孩子档案绑定”交互链路。
- **产物**: 
    - **页面**: `pages/parent/profile/index` (动态渲染) / `pages/parent/family/bind` (新页面)。
    - **API**: 封装了 `listChildren` 与 `bindChild` 业务逻辑。
    - **算法**: 实现了基于 birthday 的年龄动态推算及备注（remark）字段的结构化解析展示。
- **意义**: 标志着家长端从“单纯的任务管理”扩展到了“完整的角色与设备管理”生态，实现了 1:N 家庭模型在移动端的首次全功能着陆。
- **关联**: [[Parent-Profile-And-Family-Binding]] / [[2026-04-25-Parent-Profile-And-Binding]]

### [2026-04-25] AI 链路修复与排版优化 (Session A)
- **事件**: 修复了导致线上 404 错误的强制路径变量配置，并解决了 `ParentTaskServiceImpl` 的 Lombok 编译障碍。
- **产物**: 
    - **API 规范**: 确立了可选 ID 传参范式，兼容路径变量与查询参数。
    - **持久层适配**: 将 `smallsteps-parent` 的 Entity 转换逻辑切换为 `BeanUtil`，规避了 Lombok 在复杂 Maven 继承下的失效风险。
- **意义**: 保证了系统在不同终端（移动端、PC端、Agent）请求时的极致健壮性，同时清零了阻塞 CI/CD 的技术利息。
- **关联**: [[2026-04-21]] / [[DEBT_LEADGER]]

### [2026-04-14] 毕业论文文档化里程碑
- **事件**: 建立 `python-docx` 自动化流水线，批量生成符合上海应用技术大学格式规范的 `.docx` 论文文件。
- **产物**: v2 + v4 两版论文 Word 文档，覆盖 MySQL 技术栈（v2）与 Postgres 技术栈（v4）两种叙述版本。
- **意义**: 论文从内容撰写进入终稿排版阶段。标志着系统设计类毕设的"设计—实现—文档"三闭环贯通。
- **关联**: [[thesis_docx_pipeline]] / [[2026-04-14]]

### [2026-04-13] 系统功能开发收官
- **事件**: 完成任务管理最后一批功能：100%进度自动更新、强制最新进展字段、管理后台状态/团队标记同步、奖品兑换通知。
- **意义**: smallsteps-api / smallsteps-ui / smallsteps-app 三端核心功能进入冻结状态，转入论文写作与查重阶段。
- **关联**: 参见会话 `886188a7` (Enhancing Project Management System)

### [2026-04-13] SATS 与 AOT 排版协议确立
- **[DECISION]**: **SATS (SmallSteps Automated Testing Suite)** 设计方案定稿。
    - 确立了 API, UI, App, System 四位一体的自动化测试路径。
    - 引入 Superpowers 协议 (TDD/Verification) 作为核心质量门禁。
- **[AOT_LAYOUT_SETTLED]**: 深度研究 `chenglou/pretext` 源码，沉淀 AOT 排版策略。
    - **Docs**: 建立了 [[AOT_Layout_Strategy]]。
    - **Standards**: 将“两阶段排版”原则写入了 [[esp-idf-principles]]。
    - **Refinement**: 确立了窗口式滑动预计算（3屏缓冲）与固定字阶 Bitmap Font 方案。

### [2026-04-12] 知识花园体系化
- **事件**: 正式激活 `DEBT_LEADGER` 与 `CHRONICLE`。
- **意义**: 标志着项目进入无人值守的自主管理阶段，所有技术债与决策历史实现闭环追踪。

### [2026-04-09] 核心模型映射 (ADR-002)
- **事件**: 确立了将 `sys_dept` 深度语义化为 Family 的架构决策。
- **影响**: 后端实现逻辑彻底从“组织管理”转向“家庭协同”，为多端数据隔离奠定基础。
- **关联**: [[ADR-002-Family-Dept-Mapping]]

### [2026-04-08] 环境准备与初期配置
- 初始化项目工程，整合 `ruoyi` 后端与移动端 App 框架。
- 确认了 ESP32-S3 硬件终端的交互限制 (1.8寸屏, 4按键)。

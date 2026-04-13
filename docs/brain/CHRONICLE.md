# 项目编年史 (CHRONICLE)

记录重大架构变迁、关键决策背景（ADR）及项目里程碑。

## 序言
这里记载了“Small Steps (小步)”从雏形到成为 ADHD 儿童成长伙伴的每一公里。

---

### [2026-04-13] SATS 与 AOT 排版协议确立
- **[DECISION]**: **SATS (SmallSteps Automated Testing Suite)** 设计方案定稿。
    - 确立了 API, UI, App, System 四位一体的自动化测试路径。
    - 引入 Superpowers 协议 (TDD/Verification) 作为核心质量门禁。
- **[DECISION]**: **AOT Layout (Ahead-of-Time)** 确立为核心 UI 渲染协议。
    - 深度研究 `chenglou/pretext` 源码，实现测量与渲染完全解耦。
    - 建立了 [[AOT_Layout_Strategy]] 并在 [[esp-idf-principles]] 中强制执行“两阶段排版”原则。

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

# 小步 (Small Steps) 知识花园入口 [[_index_wiki]]

> **定位**: ADHD 儿童行为习惯辅助终端生态

## 核心导航
- [[CHRONICLE]] - 项目编年史与重大里程碑
- [[DEBT_LEADGER]] - 技术债账本与风险追踪
- [[System-Architecture]] - 全局架构视图
- [[INBOX]] - 灵感与影子观察记录
- [[skills/adhd_parenting_anchor_v1|Distilled Skill: ADHD 家长情感锚点 (v1)]]
- [[skills/e2e_stability_architect_v1|Distilled Skill: E2E 稳定性架构师 (v1)]]

## 核心决策 (ADR)
- [[ADR-001-Backend-Module-Restoration]] - 核心业务模块在 admin 入口中的强制挂载决策
- [[20260408_Sidebar_Dynamic_Strategy]] - 侧边栏全动态化加载策略 ADR
- [[20260408_Role_Routing_Fix]] - 儿童与家长角色的双重分流判定逻辑 ADR
- [[adr_child_module_reconstruction]] - 针对代码丢失的儿童端执行模块 (ss-child) 自主重建 ADR
- [[ADR-002-Family-Dept-Mapping]] - Family 与系统部门的映射决策
- [[ADR_005_AI_Dynamic_System]] - AI 动态路由与提示词系统重构 ADR
- [[ADR_006_DB_Schema_BigInt_Migration]] - 数据库字段类型从 VARCHAR 向 BIGINT 迁移 ADR
- [[ADR_007_Child_Role_Reward_Shop_Permission]] - 儿童角色访问奖励商店列表权限开放 ADR
- [[ADR-008-Data-Isolation-Audit]] - 家长端多租户数据隔离审计与架构约束
- [[ADR-009-AI-Chat-Timeout-JSON-Exception]] - AI 深度思考 JSON 解析异常与长链接超时解决机制
- [[ADR-010-AI-Streaming-SSE-Optimization]] - AI 聊天流式 SSE 响应优化与 Vite 代理绕过机制
- [[ADR-011-Backend-Parameter-Mapping-Fix]] - 后端 Controller 儿童 ID 参数名兼容性修正 ADR
- [[ADR-012-E2E-Testing-Modernization]] - E2E 自动化测试架构现代化 ADR
- [[ADR-013-Onboarding-System-Design]] - ADHD 友好型新手引导系统设计 ADR
- [[ADR/ADR-014-Parent-AI-Emotional-Assistant|ADR-014: 家长端 AI 情感助手集成方案]]
- [[ADR-015-Backend-Driven-Data-Truth|ADR-015: 后端驱动的实时数据同步策略]]
- [[ADR-016-Dashboard-Analytics-Testing|ADR-016: 高保真仪表盘报表与自动化测试架构]]
- [[ADR-017-Audit-Field-Compatibility-for-Child-Accounts|ADR-017: 儿童账号在多租户审计架构下的兼容性方案]]
- [[ADR/ADR-018-TableDataInfo-Null-Safety-Defense|ADR-018: 分页数据封装层 (TableDataInfo) 与前端表格源的双向空安全治理]]
- [[ADR/ADR-019-AI-Knowledge-Base-Hybrid-Retrieval|ADR-019: AI 知识库管理与混合检索 (Hybrid Retrieval) 架构设计]]
- [[ADR-020-Unified-Snowflake-Id-Stringification|ADR-020: 全系统雪花长 ID 统一字符串化最小化架构方案]]


## 每日记录 (Journal)
- [[journal/2026-05-29|2026-05-29: 全系统长 ID 统一无损字符串化与家长中心 Bug 最终治理]]
- [[journal/2026-05-17|2026-05-17: AI 知识库混合检索系统架构与双向空安全防御]]
- [[journal/2026-05-16|2026-05-16: AI 知识库管理视图重构与全栈异常治理]]
- [[journal/2026-05-11|2026-05-11: 生产环境配置硬化与 Sass 3.0 构建升级]]
- [[journal/2026-05-08|2026-05-08: 功能验证与知识蒸馏实战]]
- [[journal/2026-05-06|2026-05-06: 环境解耦与安全加固]]
- [[journal/2026-05-05|2026-05-05: 系统加固与硬编码审计报告]]
- [[journal/2026-05-03|2026-05-03: 家长端体验闭环与数据底座加固]]
- [[2026-05-03]] (Project Awaken & E2E 稳定性总结)
- [[2026-05-02]] (Wiki 初始化 & 4月末进度同步)
- [[2026-04-30]] (自动化测试硬化 & UI 变量修复)
- [[2026-04-29]] (新手引导系统 & 角色动态分发)
- [[2026-04-28]] (时光机修复 & 后端参数对齐)
- [[2026-04-27]] (运行时环境恢复与 MyBatis 异常修复)
- [[2026-04-26]] (Web 自动化测试与家长端洞察探索)
- [[2026-04-25]] (V7 脚本交付 & 儿童端 403/500 报错彻底修复)
- [[Parent-Profile-And-Family-Binding|2026-04-25]] (家长端全功能闭环：档案管理与智能绑定)
- [[journal/2026-04-25-AI-Chat-Infrastructure-Debug|2026-04-25: AI 交互架构调试]]
- [[2026-04-25-AI-Breakdown-Fix-and-UI-Optimization.md|2026-04-25 (Session A)]] (AI 链路修复 & Pretext 布局深度优化)
- [[2026-04-25-AI-Chat-Infrastructure-Debug|2026-04-25 (Session B)]] (AI 聊天重构 & 基础设施深度调优)
- [[2026-04-23.md|2026-04-23]] (AI 路由重构 & 动态 Prompt 闭环验证)
- [[2026-04-21.md|2026-04-21]] (情绪动力系统交付 & API 404 路径稳定性加固)
- [[2026-04-14]] (论文多版本 Word 格式化生成 & 自动化流水线)
- [[2026-04-12]] (知识花园体系化 & 环境阻塞分析)
- [[2026-04-09]] (历史记录 - Docker 镜像构建状态同步)
- [[2026-04-08]] (历史记录 - 角色分流修复 & 数据库模型增强)
- [[20260408_Parent模块工程化重构纪要]] (关键会议记录)

- [[Child-Activity-Placeholders]] (儿童端辅助活动占位说明 - 艺术课/游戏时间)
- [[SmallSteps-AI-Architecture]] (AI 模块架构配置中心)
- **核心模块数据定义**
    - [[ss_child]] (儿童档案与星星余额)
    - [[ss_parent_task]] (任务体系与激励配置)
    - [[ss_parent_reward]] (奖励库与兑换逻辑)
    - [[ss_emotion_record]] (情绪记录 Schema)
- [[Parent-Insight-Module-Architecture]] (家长端数据看板后端抽象与流向分析)
- [[Emotion-Feedback-Loop-Architecture]] (AI 情绪解析闭环架构)
- [[Automatized-Achievement-System]] (自动化勋章激励逻辑)
- [[Device-Interaction-Flow]] (设备交互流)
- [[ADHD-Education-Psychology]] (理论基础)
- [[volcengine_integration]] (火山引擎/豆包大模型接入指南)
- [smallsteps-api 模块](file:///d:/office/jushuang1/github/ss/smallsteps-api/README.md)
- [smallsteps-esp32 核心文档](file:///d:/office/jushuang1/github/ss/docs/esp32/README.md)
- [论文 v6 文档](file:///d:/office/jushuang1/github/ss/论文/v6/README.md)
- [[thesis_docx_pipeline]] (论文 Word 自动化生成流水线)

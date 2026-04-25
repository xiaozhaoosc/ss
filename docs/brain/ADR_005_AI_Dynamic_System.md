# ADR 005: AI 动态路由与提示词系统重构

*   **Status**: Accepted
*   **Date**: 2026-04-23
*   **Context**: 
    初始 AI 模块配置硬编码在 `application.yml` 中，导致添加新供应商或调整模型参数需要重启服务。同时，提示词（Prompt）缺乏统一管理，不利于业务人员优化 AI 响应质量。

## 决策 (Decisions)

1.  **数据驱动配置**: 将 AI 供应商 (`sys_ai_provider`)、模型 (`sys_ai_model`)、路由策略 (`sys_ai_route`) 和提示词模板 (`sys_ai_prompt`) 全部移至数据库。
2.  **智能路由逻辑**: 
    - 实现 `IAiRouterService`，支持基于 `sceneKey` 的精确匹配与后缀匹配 (`_SCENE`)。
    - 引入 `default_scene` 兜底机制。
3.  **双重兜底 (Fail-safe) 设计**: 
    - **Prompt 兜底**: 在 `AiServiceImpl` 中内置硬编码常用模板。若数据库加载失败，自动回退。
    - **Persona 注入**: 专门针对 `AI_CHAT` 场景设计了“小步”AI 人格硬编码模板，确保在网络异常或数据库缺失时，AI 回复风格依然保持活泼、积极、带有鼓励性的品牌调性。
    - **模型路由兜底**: 若无任何路由配置，自动尝试调用数据库中第一个 `status=0` 的模型。

## 影响 (Consequences)

- **正面**: 极大地提升了系统的灵活性和运维效率。支持热更新 AI 策略。
- **正面**: 系统鲁棒性大幅增强，数据库故障或配置缺失不影响核心功能。
- **负面**: 增加了数据库查询开销（后续通过 [[INBOX#AI 路由性能优化]] 引入 Redis 解决）。

## 关联 (Links)
- [[_index_wiki]]
- [[DOCS_AI_SPEC]]
- [[2026-04-23_Journal]]

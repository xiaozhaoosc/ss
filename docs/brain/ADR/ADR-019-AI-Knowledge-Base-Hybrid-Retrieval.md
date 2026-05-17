# ADR-019: AI 知识库管理与混合检索 (Hybrid Retrieval) 架构设计

## 1. 决策背景
在 Small Steps 的 AI 辅助模块中（如儿童情绪分析、任务拆解与深度对话），大模型需要精准结合专业心理学准则、极端情绪干预流程（Crisis Protocol）以及既定业务规则。单纯依赖通用大模型容易产生幻觉，且单纯依靠长 Prompt 会导致 Token 开销激增及响应过慢。
因此，需要建立一套标准的 **AI 知识库管理系统 (Knowledge Base Management)**，支持多模态知识入库与高效检索。

## 2. 架构设计与技术决策

### 2.1 混合检索策略 (Hybrid Retrieval)
为确保严谨业务规则的绝对执行与广泛语义的精准关联，确立了 **关系型精确/关键词过滤 + 向量化语义相似度检索** 的双轨混合架构：
1. **精确与关键词匹配 (PostgreSQL SQL/Regex)**：
   - 针对危机干预规则、固定话术模板，通过关系型数据库表 `sys_ai_knowledge` 的 `keywords` 字段进行直接检索，保证高优准则百分之百命中。
2. **向量语义检索 (Spring AI SimpleVectorStore)**：
   - 针对非结构化的专业心理学长文、育儿指南等，通过 Spring AI 的 `TokenTextSplitter` 进行文本切块，计算 Embeddings，存储于本地/轻量级向量库 `SimpleVectorStore`（本地持久化为 `vector_store.json`）。

### 2.2 数据模型与实体映射
- **数据库表 `sys_ai_knowledge`**：存储知识项的 ID、标题、内容类型（TEXT, MARKDOWN, PDF）、内容原文、关键词、启用状态及审计字段。
- **MapStruct 与 `@AutoMapper` 转换适配**：
  - 为彻底解决 MapStruct 在多层泛型或深层数据结构下缺少 VO 转换器导致的运行时异常，创建了 `SysAiKnowledgeVo` 并显式使用 `@AutoMapper` 及配套转换逻辑，确保前后端数据交换的全类型安全。

### 2.3 优雅降级与全栈防御 (Graceful Degradation & Null Defense)
- **向量库失效容错**：当外部 Embedding 接口限流或本地 JSON 向量库挂载失败时，系统自动降级为仅依赖 PostgreSQL 关键词检索，确保系统核心能力不中断。
- **空安全防御**：配合 [[ADR/ADR-018-TableDataInfo-Null-Safety-Defense|ADR-018]]，在后端 Controller 响应层与前端 `knowledge/index.vue` 表格数据接收层实施双向防御，杜绝因极端的 `null` 返回导致的 UI 崩溃。

## 3. 前端交互与体验规范
- 位于 `src/views/ai/knowledge/index.vue`。
- 遵循 RuoYi 与 Element Plus 规范，提供全中文沉浸式管理界面，支持知识库列表查询、状态动态开关、文件导入及一键向量库同步操作。

## 4. 影响与后续行动
- 已全面接入 `AiRouterService` 与 `AiKnowledgeHybridSearchService`，大幅提升了 AI 情绪分析和家长情感助手的回答置信度。
- 后续将建立基于定期自动任务的数据同步巡检，监测知识库检索耗时与大模型生成质量。

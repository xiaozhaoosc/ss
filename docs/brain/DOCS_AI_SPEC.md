# SmallSteps AI Service Specification (v1)

## 1. 概述 (Overview)
SmallSteps AI 服务旨在为 ADHD 儿童提供智能辅助，包括任务拆解、情绪分析、智能鼓励等功能。系统采用动态路由架构，支持多供应商、多模型的无缝切换与成本控制。

## 2. 核心架构 (Core Architecture)

### 2.1 实体模型 (Entity Models)
- **AiProvider (供应商)**: 存储 API Key、Base URL 等凭证信息。 (表: `sys_ai_provider`)
- **AiModel (模型)**: 关联供应商，存储模型代码、单价、上下文窗口等。 (表: `sys_ai_model`)
- **AiRoute (路由规则)**: 定义不同业务场景的路由策略。 (表: `sys_ai_route`)
- **AiPrompt (提示词模板)**: 存储业务场景对应的提示词模板，支持动态参数替换。 (表: `sys_ai_prompt`)

### 2.2 逻辑流 (Logic Flow)
1. **业务请求**: 调用 `AiService`（如 `taskBreakdown`）。
2. **动态路由**: 调用 `AiRouterService.route(sceneKey)` 获取最佳 `AiModel`。
3. **获取模板**: 从 `sys_ai_prompt` 获取对应的提示词模板（如 `TASK_BREAKDOWN`）。
4. **参数填充**: 将业务参数（如 `taskName`）填充进模板占位符。
5. **智能调用**: `SmartAiClient` 根据 `AiModel` 及其关联的 `AiProvider` 调用外部 API。
6. **响应解析**: `AiService` 解析 JSON 响应并返回结构化数据。

## 3. 数据库设计 (Database Design)

### 3.1 sys_ai_provider (AI供应商配置表)
| 字段 | 类型 | 说明 |
| :--- | :--- | :--- |
| id | Long | 主键 (如: 1001) |
| name | String | 供应商名称 |
| type | String | 类型 (openai/vllm) |
| base_url | String | API 地址 |
| api_key | String | 密钥 |

### 3.2 sys_ai_model (AI模型配置表)
| 字段 | 类型 | 说明 |
| :--- | :--- | :--- |
| id | Long | 主键 (如: 2001, 2002) |
| provider_id | Long | 供应商 ID |
| model_code | String | API 调用代码 (如: gemma-4-26b) |
| context_window | Integer | 窗口大小 |

### 3.3 sys_ai_prompt (AI提示词模板表)
| 字段 | 类型 | 说明 |
| :--- | :--- | :--- |
| id | Long | 主键 |
| prompt_key | String | 业务标识 (如: `TASK_BREAKDOWN`) |
| content | Text | 提示词内容 (支持 `{param}` 占位符) |
| model_id | Long | 可选：绑定的特定模型 |

### 3.4 sys_ai_route (AI路由策略表)
| 字段 | 类型 | 说明 |
| :--- | :--- | :--- |
| scene_key | String | 场景 Key (如: `default_scene`, `emotion_analysis_scene`) |
| strategy | String | 策略 (PRIORITY_LEVEL) |
| default_model_id | Long | 默认模型 ID |
| config_json | Json | 扩展配置 (如: `{"fallback_model_id": 2002}`) |



## 4. 接口协议 (API Protocol)

### 4.1 任务拆解 (Task Breakdown)
- **Endpoint**: `POST /ai/taskBreakdown`
- **Prompt Logic**: 扮演 ADHD 专家，将任务拆解为微步骤，关注“可操作性”和“鼓励性”。
- **Response**: `List<Step>` 其中 `Step` 包含 `stepName`, `stepDesc`。

### 4.2 情绪分析 (Emotion Analysis)
- **Endpoint**: `POST /ai/emotion/analyze`
- **Prompt Logic**: 扮演心理专家，分析文字/语音转文字内容中的情绪强度与类型，提供家长建议。
- **Response**: `Map` 包含 `emotion`, `emotionType`, `level`, `suggestion`。

## 5. 容错与降级 (Resilience)
- **Mock Fallback**: 当 AI 服务不可用或解析失败时，系统自动切换至本地 Mock 逻辑，确保 UI 不崩溃。
- **Retry Mechanism**: 支持对失败请求进行重试。
- **Json Extraction**: 采用正则匹配方式从 LLM 的混合文本中提取 JSON 内容，提高解析成功率。

## 6. 后续规划 (Roadmap)
- [ ] 系统管理员后台管理页面 (供应商/模型/路由配置)。
- [ ] 个人用户自定义模型（允许家长配置自己的 API Key）。
- [ ] 语音直连分析（集成 STT + AI）。

# SmallSteps AI 模块架构 [[SmallSteps-AI-Architecture]]

## 1. 模块定位
`smallsteps-ai` 模块是 Small Steps 生态中的 AI 配置与编排中心。它负责管理不同 AI 供应商的连接、模型参数以及针对 ADHD 场景定制的 Prompt 模板。

## 2. 核心领域模型 (Domain Model)
模块目前包含以下核心实体，均继承自 [[BaseEntity]]：

- **AiProvider**: AI 服务供应商（如 OpenAI, DeepSeek, 智谱 AI 等）。
- **AiModel**: 具体模型配置（如 gpt-4o, deepseek-chat）。包含 API Key、Base URL 等敏感及配置信息。
- **AiPrompt**: Prompt 模板。支持参数化占位符，用于针对性场景（如任务拆解、情绪分析、成长周报生成）。

## 3. 技术实现
- **持久层**: MyBatis-Plus。
- **服务层**: 遵循标准 Spring Service 模式。由于多模块继承中 Lombok 的不稳定性，当前强制使用 **Hutool BeanUtil** 进行 Entity 与 VO/BO 的手动转换。
- **控制层**: RESTful 风格。
    - *风险点*: 部分接口使用 `@PathVariable` 接收 ID，若前端未传参会触发 404。建议优化为 `@RequestParam(required = false)` 或在 Service 层做空值检查。

## 4. 待办事项 (TODO)
- [ ] 接入 OpenRouter 或自研 Router 逻辑实现多模型热切换。
- [ ] 实现针对 ADHD 儿童语言风格的 Prompt 自动优化器。
- [ ] 解决 Controller 层路径参数导致的 404 隐患。
- [ ] 建立标准的 AI 请求响应日志追踪系统，记录 Token 消耗和模型延迟。

## 5. 相关链接
- [[System-Architecture]]
- [[Emotion-Feedback-Loop-Architecture]]
- [[INBOX]] (查看环境敏感配置建议)

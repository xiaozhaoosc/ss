# Volcengine (Doubao) AI Integration Guide | 火山引擎（豆包）接入指南

## 1. 概述
火山引擎的“火山方舟”平台提供的豆包 (Doubao) 系列大模型 API 与 OpenAI 协议高度兼容。得益于 `smallsteps-common-ai` 模块的通用设计，接入火山引擎无需修改后端代码，仅需进行数据库配置。

## 2. 接入步骤

### 2.1 获取凭证
1. 登录 [火山引擎控制台 - 火山方舟](https://console.volcengine.com/ark)。
2. 在“API Key 管理”中创建一个新的 API Key。
3. 在“推理接入点”中，创建一个接入点（例如：Doubao-pro-4k），并记录其 **接入点 ID (Endpoint ID)**。
    *   *重要提示*: 火山引擎在调用 API 时，`model` 字段必须填写 **Endpoint ID**，而不是模型名称（如 `doubao-pro-4k`）。

### 2.2 数据库配置
执行以下 SQL 脚本以添加供应商和模型配置。https://www.volcengine.com/docs/82379/1330310?lang=zh

```sql
-- 1. 添加供应商 (指定 ID 为 1005)
INSERT INTO sys_ai_provider (id, name, type, base_url, api_key, status, create_by, create_time)
VALUES (1005, '火山引擎 (Ark)', 'openai_compatible', 'https://ark.cn-beijing.volces.com/api/v3', 'YOUR_API_KEY_HERE', '0', '1', NOW());

-- 2. 添加模型配置 (指定 ID 为 2005)
INSERT INTO sys_ai_model (id, provider_id, model_code, name, cost_input, cost_output, context_window, is_free_tier, create_by, create_time)
VALUES (2005, 1005, 'ep-20240604xxxxxx-xxxxx', '豆包-Pro-4k', 0.0008, 0.002, 4096, '0', '1', NOW());

-- 3. 配置路由策略 (将任务拆解场景切换到豆包)
UPDATE sys_ai_route 
SET default_model_id = 2005
WHERE scene_key = 'TASK_BREAKDOWN';
```

## 3. 技术细节
*   **Base URL**: `https://ark.cn-beijing.volces.com/api/v3`
*   **Endpoint**: `/chat/completions` (由 `SmartAiClient` 自动拼接)
*   **Authentication**: `Authorization: Bearer <API_KEY>`
*   **Model Parameter**: 必须使用 **Endpoint ID**。

## 4. 验证方式
配置完成后，可以通过调用后端的 AI 接口（如任务拆解或情绪分析）并观察日志输出：
```text
>>> [INFO] Calling AI for task breakdown: ... using model: ep-20240604xxxxxx-xxxxx
```
如果返回正常的业务 JSON，则表示接入成功。

## 5. 性价比模型推荐 (Small Steps 场景)

基于火山引擎“厘时代”定价策略及 ADHD 儿童辅助场景，以下是推荐的 5 个模型配置：

| 推荐模型 | 核心特点 | 推荐理由 (针对本项目) | 预估单价 (每千 tokens) |
| :--- | :--- | :--- | :--- |
| **Doubao-Lite (32k)** | 极致速度，极低成本 | **习惯打卡与简易反馈**：适用于简单的肯定式对话、单步骤习惯确认。响应极快且成本几乎可以忽略不计。 | 入 0.0003 / 出 0.0006 |
| **Doubao-Pro (32k)** | 逻辑严密，指令遵从度高 | **核心任务拆解 (Task Breakdown)**：针对复杂指令（如“整理房间”）的结构化拆解，Pro 版在复杂逻辑上更稳健。 | 入 0.0008 / 出 0.002 |
| **Doubao-Character (32k)** | 情感丰富，人设稳固 | **伙伴聊天/树洞**：专为角色扮演和情感价值提供优化，能够更好地充当孩子的虚拟伙伴。 | 入 0.0008 / 出 0.002 |
| **Doubao-Pro (128k)** | 超长上下文支持 | **家长月度/周度洞察报告**：分析周期内大量行为日志并总结模式时，长上下文能确保信息不遗漏。 | 入 0.005 / 出 0.015 |
| **Doubao-Vision-Pro** | 视觉理解能力 | **作品分享与鼓励**：未来若支持孩子上传手工作品或心情绘画，该模型可实现对内容的真诚夸赞。 | 阶梯计费 |

> [!TIP]
> 建议在数据库 `sys_ai_route` 中根据不同 `scene_key`（场景）配置对应的 `default_model_id`，以实现效果与成本的最优平衡。


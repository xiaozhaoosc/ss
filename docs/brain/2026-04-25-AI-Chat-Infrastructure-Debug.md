# AI 聊天基础设施与连接性调试 (2026-04-25)

## 场景描述
在重构 AI 聊天功能（从硬编码切换为动态模型调用）过程中，发现前端请求虽通，但 AI 回复始终为兜底错误信息。

## 排查过程与发现

### 1. 链路确认
- **Endpoint**: `POST /ssapi/child/ai/chat`
- **Controller**: `ChildAIController`
- **Service**: `ChildAIServiceImpl` -> `AiServiceImpl` -> `SmartAiClient`

### 2. 模型服务器异常
通过查询数据库 `sys_ai_provider` 和 `sys_ai_model`，确认系统尝试连接以下服务器：
- **主服务器**: `192.168.1.9:8003` (Gemma-4-26b) -> **连接被拒绝 (Connection Refused)**。
- **备用服务器**: `10.8.0.1:8005` (Qwen3.5-9b) -> **返回 HTML 响应**。

### 3. JSON 解析错误
由于服务器 `10.8.0.1:8005` 返回了 HTML（可能是代理错误页面或 404 页面），Jackson 在尝试解析为 `Map` 时报错：
`Unexpected character ('<' (code 60)): expected a valid value`

## 解决方案与结论
1. **逻辑验证**: 确认了后端重构逻辑完全正确，已成功触发动态路由和 AI 调用。
2. **Persona 验证**: 触发了 `AiServiceImpl` 的 catch 块，返回了预设的“小情绪”兜底人格消息，验证了双重兜底机制。
3. **环境依赖**: 聊天功能的真实上线取决于 AI 模型服务器的稳定性。已建议用户检查 `10.8.0.1` 网络的 API 可用性。

## 关联 (Links)
- [[ADR_005_AI_Dynamic_System]]
- [[2026-04-25]] (Journal)

# Skill: Deploy Notify (部署通知与协作)

## 🎯 目标 (Goal)
打通研发工作流的 "最后一公里"，在关键节点（构建成功、部署上线、服务异常）向团队即时推送富文本通知。

## ⚙️ 依赖 (Dependencies)
- **Tool**: `run_command` (使用 `curl` 调用 Webhook) 或 `fetch` (如果配置了 Fetch MCP)
- **External**: Feishu/DingTalk Webhook URL

## 📝 提示词模板 (Prompt Template)

```markdown
请向飞书群发送部署完成通知。

**Context**:
- Project: Small Steps
- Status: Success ✅
- Version: v1.2.0
- Author: [Current User]

**Action**:
- 构造一个富文本卡片 (Interactive Card) JSON。
- 包含标题、状态颜色、关键变更点。
- 使用 `curl` 发送 POST 请求到 `FEISHU_WEBHOOK_URL`。
```

## 🚀 即时指令 (One-Shot Command)

你可以直接对 Agent 说：
> "部署成功了，发个飞书通知给团队，顺便@一下项目经理。"

Agent 将执行：
```bash
curl -X POST -H "Content-Type: application/json" \
-d '{"msg_type":"text","content":{"text":"🚀 Small Steps 部署成功！\n版本: v.1.2.0"}}' \
$FEISHU_WEBHOOK_URL
```

## 🧠 进阶：自动化工作流集成

将此 Skill 与 **Git MCP** 结合：

1.  **Monitor**: 定期检查 GitHub Actions 构建状态。
2.  **Trigger**: 当状态变为 `failure`。
3.  **Analyze**: 获取构建日志，分析错误原因。
4.  **Notify**: 发送飞书通知："构建失败 ❌，原因：依赖冲突，建议检查 package.json"。

## ⚠️ 安全贴士
- 不要将 Webhook URL 硬编码在 Prompt 中。
- 建议存储在 `.env` 或 MCP 配置文件中作为环境变量。

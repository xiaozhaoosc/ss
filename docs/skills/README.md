# Small Steps 自动化技能库 (Automation Skills Library)

> "Skill = Tool + Workflow + Prompt"

此目录存放项目沉淀的通用自动化技能。每个 Skill 都是一个标准化的 "SOP"，Agent 可通过阅读对应的 Markdown 文件来习得该技能。

## 📂 技能列表

### 1. 🧪 UI 测试生成 (UI Test Gen)
- **Path**: [`skill_ui_test_gen.md`](./skill_ui_test_gen.md)
- **Deps**: Playwright MCP
- **Desc**: 自动分析页面组件，生成鲁棒的 E2E 测试脚本。

### 2. 📢 部署通知 (Deploy Notify)
- **Path**: [`skill_deploy_notify.md`](./skill_deploy_notify.md)
- **Deps**: cURL / Fetch
- **Desc**: 构建完成或服务异常时，向飞书/钉钉群发送富文本卡片通知。

## 🚀 如何使用

1.  **加载技能**: 告诉 Agent "请使用 `ui-test-gen` 技能为当前页面生成测试"。
2.  **执行流程**: Agent 会读取对应文档中的 SOP，依次调用 MCP 工具完成任务。

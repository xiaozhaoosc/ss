---
description: 执行项目会话初始化与进度对齐 (init-session)
---

# 工作流: 项目记忆初始化

## 步骤 (Steps)
1. **环境侦探**:
   - `ls -R .agent`: 扫描规则与工作流。
   - `ls archive`: 寻找最新的归档时间戳。
2. **深度阅读**:
   - `cat .agent/context.md`: 获取 Roadmap。
   - `cat archive/YYYYMMDD/演示报告_*.md`: 理解最后的状态。
3. **任务重构**:
   - 基于以上信息，自动生成或更新当前任务的 `task.md`。
4. **用户同步**:
   - 向用户汇报：“我已通过阅读归档了解到，我们目前正处于 [阶段名]，接下来准备执行 [具体动作]。”

## 适用场景
- 每天第一次登录
- 开启新 Conversation
- Agent 更换上下文或需要重置思路时

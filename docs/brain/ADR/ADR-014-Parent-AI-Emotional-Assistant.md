# ADR-014: 家长端 AI 情感助手集成方案

## 上下文 (Context)
在“小步 (Small Steps)”生态中，家长的情绪状态直接影响 ADHD 儿童的干预效果。此前的“帮助与反馈”模块仅包含静态 FAQ 和反馈表单，缺乏即时性的、有温度的情感支持和专业指导。

## 决策 (Decision)
1. **角色定位**：AI 助手不再仅是儿童的伙伴，而是转变为家长的“情绪导师”和“专业顾问”。
2. **技术栈**：
   - **后端**：复用 `ChildAIController` 的流式接口，通过 `[家长模式]` 标签触发专属 Prompt。
   - **前端**：Uni-app + SSE (Server-Sent Events) 流式渲染，支持 `<think>` 标签以展示 AI 诊断逻辑。
3. **视觉规范**：采用温润的蓝黄色调，区别于儿童端的活泼感，更强调专业与信任。

## 后果 (Consequences)
- **优点**：
  - 提升了家长端的活跃度与粘性。
  - 降低了家长获取科学 ADHD 干预建议的门槛。
- **缺点**：
  - 目前复用儿童端接口，若未来 parent 场景逻辑复杂化，需剥离出独立的 `ParentAIController`。
  - 存储上目前仍记录在 `ss_child_ai` 表（使用 childId=0 占位），建议后续增加 `ss_parent_ai` 表。

## 状态 (Status)
Accepted (2026-05-03)

## 链接
- [[_index_wiki]]
- [[SmallSteps-AI-Architecture]]
- [[Parent-Profile-And-Family-Binding]]

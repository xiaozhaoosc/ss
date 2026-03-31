---
type: project-rule
id: session-init-protocol
version: 1.0.0
description: "强制 Agent 在启动新对话时进行上下文对齐与记忆检索。"
priority: high
triggers:
  - on-session-start
---

# 会话初始化协议 (Session Init Protocol)

## 1. 必读路径
每次正式开始任务前，Agent 必须通过 `view_file` 或 `list_dir` 检视以下路径：
- **`.agent/context.md`**: 获取项目总体进度与当前 Roadmap。
- **`archive/`** (最新日期子目录): 阅读最新的演示报告/实施计划，明确“上一次对话结束在哪里”。

## 2. 状态对齐
Agent 应在第一次回复中简要总结：
- **已交付**: 上次完成的关键特性。
- **进行中**: 当前正在解决的技术瓶颈。
- **下一步**: 本次对话准备攻克的具体目标。

## 3. 动态更新
任务完成后，必须同步更新 `.agent/context.md` 中的 `Roadmap` 章节，确保信息的“单点事实来源 (SSOT)”。

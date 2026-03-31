---
type: agent-rule
id: documentation-first
version: 1.0.0
description: "强制要求每个业务模块维护独立的 README.md 文档"
priority: high
triggers:
  - on-module-create
  - on-file-create
tags:
  - documentation
  - best-practice
---

# 模块文档化规范 (Documentation First)

## 1. 原则 (The Rule)
**"没有文档的代码是不存在的。"**
凡是新建或重构业务模块（Module），必须在模块根目录下创建或更新 `README.md`。

## 2. 文档结构模板
每个模块的 `README.md` 必须包含以下三部分：

### 2.1 模块简介 (Introduction)
- 一句话描述该模块的职责。
- 核心功能列表 (Bullet points)。

### 2.2 包结构说明 (Package Structure)
- 使用 Tree 结构展示关键包的作用。
```text
com.kenzhao.smallsteps.demo
├── controller      // 接口层
├── service         // 业务层
└── ...
```

### 2.3 变更日志 (Changelog)
-以此格式记录重要变更：
`[YYYY-MM-DD] 变更摘要`：详细说明新增了什么接口或重构了什么逻辑。

## 3. 执行要求
- Agent 在创建新模块时，**必须**同步创建 `README.md`。
- Agent 在修改现有模块核心逻辑时，**必须**检查并更新 `README.md` 中的变更日志。

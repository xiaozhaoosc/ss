---
name: knowledge_garden
description: 知识花园体系 - 用于将项目上下文编译和沉淀为结构化的 Wiki / Obsidian 笔记
---

# Knowledge Garden (知识花园)

## 目标
维持一个随着项目演进而有机生长的知识库 (Vault)，使用 Obsidian 双链网络连接想法、决策和文档。记录每日架构演进、任务进度及上下文。

## 工作流规则
当执行知识整理或 `/wiki` 命令时，请按照以下原则将当前对话、决策或上下文编译到 `docs/brain` 中：

1. **原子化思考 (Atomic Notes)**: 
   - 提取独立的概念或设计决策为一个独立的 MarkDown 文件。
   - 保留在 `docs/brain/` 目录或适当的分类下。
   
2. **双向链接 (Bi-directional Links)**:
   - 大量使用 Obsidian 的 `[[WikiLink]]` 语法串联上下文。
   - 必须将新笔记链接回入口文件 `[[_index_wiki]]` 以及其他相关的核心概念实体。
   
3. **每日记录 (Journaling)**:
   - 日常执行或灵感可以记录在 `docs/brain/journal/` 中的按日期命名的文件中，例如 `YYYY-MM-DD.md`。

4. **架构决策记录 (ADR)**:
   - 当做出重要的工程决定时，记录上下文、考量、替代方案和决定。

---
type: project-rule
id: doc-archival-policy
version: 1.0.0
description: "确保所有阶段性技术文档被精确、自动化地移动至日期文件夹进行版本管理。"
priority: high
triggers:
  - on-task-completion
  - on-walkthrough-creation
---

# 文档自动归档准则 (Doc Archival Policy)

## 1. 强制归档对象
任何包含以下关键词的文件必须在任务完成后进行归档：
- `plan*` (实施计划)
- `walkthrough*` (演示报告/走读文档)
- `*报告*` (调研、分析、总结报告)

## 2. 存储路径规范
路径格式：`archive/YYYYMMDD/` (精确到年月日)。
- **YYYYMMDD**: 基于本地当前系统日期。

## 3. 命名版本规范
原文件名后缀增加：`_YYYYMMDDHHMM_编号.md`。
- **HHMM**: 小时与分钟。
- **编号**: 若同一分钟内有多次更新，则递增（01, 02...）。

## 4. 自动化要求
每次生成新的 `演示报告` (walkthrough) 或 `实施计划` (plan) 时，Agent 必须主动检查并执行归档，无需用户再次提醒。

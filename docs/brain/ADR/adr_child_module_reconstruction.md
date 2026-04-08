# ADR: 针对代码丢失的儿童端执行模块 (ss-child) 自主重建

## Context
在 2026-04-08 的 ADHD 逻辑优化任务中，发现 `smallsteps-api/smallsteps-modules/smallsteps-child` 目录下除 Controller 外，所有的 domain, mapper, service 源码均处于缺失或严重不一致状态。由于系统需立即支持 ADHD 行为引导（灯光、音效、远程 Nudge），且当前处于 **YOLO/无人值守模式**，决定执行“自愈式重建”。

## Decision
1.  **数据映射方案**: 
    - 确立 `ChildTask` 实体与物理表 `ss_task_log` 的映射关系。
    - 确立 `ChildAchievement` 实体与资产表（星星、勇气碎片）的聚合。
2.  **跨模块依赖**: 
    - 让 `smallsteps-child` 显式依赖 `smallsteps-parent`，从而通过 `ParentTaskDefinition` 获取硬件反馈参数（`light_effect`, `audio_effect`）。
3.  **VO 扁平化**: 
    - 引入 `ChildTaskVo`，将执行日志与母版定义在 Service 层进行 Join 操作，确保 API 直接返回硬件所需的反馈代码，降低硬件端解析压力。
4.  **远程提醒 (Nudge) 机制**:
    - 采用 **Memory Cache + HTTP Polling** 的 MVP 方案实现家长对硬件的远程触发，替代复杂的 WebSocket 系统以适配 ESP32 的功耗需求。

## Consequences
- **Positive**: 解决了原有的代码库不一致问题，成功将硬件反馈链路从 0 到 1 建立。
- **Negative**: 在 `child` 模块中引入了对 `parent` 模块的硬耦合（Maven 依赖），后续若需完全解耦，需引入事件驱动机制。

## Links
- [[2026-04-08]]
- [[System-Architecture]]

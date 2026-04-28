# ADR-011: 后端 Controller 儿童 ID 参数名兼容性修正 [[ADR-011-Backend-Parameter-Mapping-Fix]]

## 状态
已执行 (Accepted)

## 上下文 (Context)
在 `smallsteps-app` 的开发与测试过程中，发现大量涉及儿童数据的 API 调用失败。
- **现象**: 页面显示“未选择儿童”，后端返回 `R.fail("未选择儿童")`。
- **原因**: 
    - 后端 Controller 方法定义中，使用 `@RequestParam(required = false) Long cid` 接收儿童 ID。
    - 前端 `src/api/child.ts` 中，统一使用 `childId` 作为请求参数名。
    - 由于名称不匹配，后端获取到的 `cid` 始终为 `null`，除非 ID 是通过 `@PathVariable` 传递的。

## 决策 (Decision)
为了不破坏前端既有实现（已广泛使用 `childId`），且不影响可能依赖 `cid` 的旧接口或硬件设备，决定对所有受影响的接口进行**兼容性升级**。

**修复方案**:
在 Controller 方法参数中，显式添加对 `childId` 的映射，并合并解析逻辑。
```java
public R<...> someMethod(
    @PathVariable(required = false) Long childId, 
    @RequestParam(value = "childId", required = false) Long qid, 
    @RequestParam(required = false) Long cid, ...) {
    // 优先级：路径变量 > childId 参数 > cid 参数
    Long finalChildId = childId != null ? childId : (qid != null ? qid : cid);
}
```

## 受影响范围 (Consequences)
- **已修改 Controller**:
    - `ChildAIController`: `recentInteractions`, `emotionTrend`
    - `ChildTaskController`: `pendingTasks`, `currentTask`
    - `ParentInsightController`: `getEmotionDaily`, `getEmotionTrend`, `getSummary`, `getTimeline`, `getWeeklyHeatmap`, `getWeeklyAiAnalysis`
- **收益**: 彻底消除了前端页面因参数名不一致导致的 500 报错，提升了系统鲁棒性。
- **风险**: 参数量略微增加，但逻辑清晰且具备完全的向后兼容性。

## 相关链接
- [[2026-04-28]] (Journal)
- [[DEBT_LEADGER]] (命名不规范债务)

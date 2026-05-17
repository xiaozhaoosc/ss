# ADR-018: 分页数据封装层 (TableDataInfo) 与前端组件源的双向空指针/防御式治理

- **状态**: 已采纳 (2026-05-17)
- **领域**: 后端分页数据包装 (MyBatis-Plus/MapStruct) / 前端 UI 渲染 (Element Plus)
- **作者**: Antigravity / The Orchestrator

## 1. 背景与隐患现象
在进行 AI 知识库 CRUD 全链路调试时，暴露出了以下系统级隐患：
1. **致命的空指针传递链**：
   当 MyBatis-Plus 的 `BaseMapperPlus.selectVoPage` 在动态执行中，如果由于 MapStruct Annotation Processor 编译期未生成对应的 VO 转换类或 Spring 容器中未查找到对应实体到 VO 的转换器，底层 `MapstructUtils.convert` 返回 `null`。
2. **包装层未做防御**：
   原有的 `TableDataInfo` 分页对象在调用 `setRows(page.getRecords())` 时，直接将上述 `null` 引用赋给了内部属性 `rows`。最终序列化响应体输出为：`{"code": 200, "msg": "查询成功", "rows": null, "total": 1}`。
3. **前端级联崩溃**：
   Element Plus `<el-table>` 组件在监听到数据源从 `[]` 突变为 `null` 时，其内部的选择器管理逻辑 (`watcher.ts: checkSelectedStatus`) 试图遍历 `null`，直接抛出 `Uncaught (in promise) TypeError: data2 is not iterable` 致命崩溃。用户提交数据后因表格崩溃无法显示，得出“保存失败”的结论。

## 2. 考量与决策点 (Decisions)
为建立高鲁棒性的无人值守系统底层架构，避免因某单一转换或网络降级导致整个 UI 崩溃，我们决定在全栈边界实施**双向防御拦截**。

### 2.1 后端：强制包装源非空保护
在 `TableDataInfo` 核心基类中，重写所有实例化入口（包括构造函数、静态构建器 `build` 方法以及属性存取器 `setRows/getRows`）：
```java
public void setRows(List<T> rows) {
    this.rows = rows != null ? rows : CollUtil.newArrayList();
}
```
保证无论分页源内部发生了何种未捕获异常或动态映射丢失，对外返回的 `rows` 字段必定为 `[]`，彻底消除 API 层面的脆弱点。

### 2.2 前端：短路求值与默认空降级
在所有数据获取接口回调处（例如 `knowledge/index.vue` 的 `getList` 方法），强制采用短路空数组表达式：
```javascript
knowledgeList.value = response.rows || [];
total.value = response.total || 0;
```
同时增加 `.catch()` 异常捕获重置，防止请求挂起或解析失败破坏 UI 状态。

## 3. 验证与后果 (Consequences)
- **正向收益**：即便后端服务由于 VO 转换未正确生成而出现数据空映射，前端也不会再抛出白屏或崩溃报错，保证了系统的“认知极简”和良好用户体验。
- **架构约束**：今后所有新增业务模块在生成 Controller 和分页查询时，禁止绕过 `TableDataInfo.build()` 方法直接手动拼接 Map 响应。

## 4. 关联记录
- 关联问题追踪: [[DEBT_LEADGER]]
- 知识花园索引: [[_index_wiki]]

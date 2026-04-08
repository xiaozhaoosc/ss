# ADR-002: 儿童与家长角色的双重分流判定逻辑

## 状态
已通过 (Accepted)

## 上下文 (Context)
在 **Small Steps** 移动端应用中，出现了儿童账号登录后依然显示家长界面的严重 bug。经分析，其根本原因在于：
1. **数据解包深度不足**：`request.js` 统一返回了 Axios/Uni 封装后的全量数据，而 `userStore` 在解析用户信息时，直接在根层级读取 `res.roles`，导致读到的是 `undefined`。
2. **逻辑判定单一**：原设计仅通过特定的权限字符串 (`'child'`) 区分角色，而忽略了数据库 `sys_user` 表中的核心字段 `user_type` (2:家长, 3:儿童)。

## 决策 (Decision)
为了修复此问题并提高系统鲁棒性，决定采取以下多层级判定策略：

1. **统一数据入口**：在 Store 中解析 `getInfo` 响应时，明确引用 `res.data` 负载。
2. **双重判定逻辑**：
   - 优先检查 `res.data.user.userType`。若值为 `3` (或其字符串形式)，则强制标记为 `child`。
   - 辅助检查 `res.data.roles` 数组。若包含 `'child'`，亦标记为 `child`。
   - 其余情况默认标记为 `parent`。
3. **路由安全增强**：
   - 在儿童首页 (`pages/child/home/index`) 增加全局 `onShow` 权限挂钩，非法进入（非 child 角色）将强制重定向。
   - 针对儿童端采用 **自定义 TabBar**，并显式调用 `uni.hideTabBar()` 隐藏来自 `pages.json` 的家长端原生菜单。

## 后果 (Consequences)
- **优点**：解决了跨端开发中的角色混淆问题，确保了针对 ADHD 儿童设计的“低认知负荷”界面能被准确渲染。
- **一致性**：实现了与 `db.md` (v2.1) 定义的 `user_type` 字段的严格映射。
- **后续影响**：未来增加“教师”或“医生”角色时，只需在分流器中增加对应的 `userType` 分支即可。

---
**关联**: [[_index_wiki]], [[System-Architecture]]

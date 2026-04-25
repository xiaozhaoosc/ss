# ADR-007: 儿童角色奖励商店列表访问权限开放

## 状态
已通过 (Accepted)

## 上下文 (Context)
在 "Small Steps" (小步) 应用的儿童端，"奖励商店" (Reward Shop) 是核心激励机制。
此前，后端 `ParentRewardController.java` 的 `/list` 接口使用了 `@SaCheckPermission("parent:reward:list")` 注解进行权限校验。
由于儿童账号 (Role: child) 通常不具备 `parent:*` 级别的管理权限，导致儿童在 App 中打开奖励商店时触发 403 错误，无法看到可兑换的商品。

## 决策 (Decision)
为了支持儿童端的激励闭环，决定将 `ParentRewardController.java` 中 `/list` 接口的权限要求从特定的“家长管理权限”降级为“已登录状态”即可访问。

1. **后端变更**: 将 `@SaCheckPermission("parent:reward:list")` 修改为 `@cn.dev33.satoken.annotation.SaCheckLogin`。
2. **前端逻辑**:
   - `useUserStore` 引入角色感知逻辑，`fetchBalance` 根据角色自动分流请求（儿童请求 `/child/achievement/stars/{id}`，家长请求 `/parent/reward/score/{id}`）。
   - 儿童端页面强制校验 `userStore.id`，防止未选择儿童时发送无效请求。

## 后果 (Consequences)
- **正面**: 实现了儿童端奖励商店的完整闭环，消除了 403 报错，提升了用户体验。
- **负面**: 任何登录用户（包括儿童）现在都能列出所有家长配置的奖励。在多租户或多家庭隔离环境下，需要确保底层 `Service` 层实现了基于 `family_id` 或 `tenant_id` 的数据隔离。

## 验证
- 儿童账号登录后，`/ssapi/parent/reward/list` 返回 200。
- 奖励商店商品列表正常渲染。
- `userStore.fetchBalance` 在儿童账号下不再触发 403。

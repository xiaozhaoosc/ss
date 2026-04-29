# Wiki Inbox [[INBOX.md]]

- **灵感 1**: 为任务管理增加“ADHD 模板库”，内置如“刷牙”、“整理书包”等标准拆解步骤，减少家长配置负荷。
- **灵感 2**: 引入“影子观察”模式，自动记录孩子在设备上的异常长按行为，推送到家长端作为“情绪预警”。
- **灵感 3**: 在“我的成就”中引入像素风 3D 展厅（Three.js），增加激励的视觉冲击力。

- [ ] **AI 路由性能优化**: 当前 `AiRouterServiceImpl` 每次都查询数据库。虽然使用了 MyBatis-Plus 缓存，但在高并发场景（如每日 Job 触发千名儿童分析）下，建议引入 Redis 缓存路由规则，并监听 `sys_ai_route` 的更新消息同步刷新。
- [ ] **Prompt 注入安全**: 动态参数 `{content}` 直接填充进 Prompt。若用户输入包含特定 Prompt Injection 词汇（如 "Ignore all previous instructions"），可能导致 AI 失控。建议在 `AiServiceImpl` 中增加简单的敏感词/指令过滤。
- [ ] **数据一致性风险**: `sys_ai_route` 的主键为 `scene_key`，限制了同一场景多模型权重分配的扩展性。未来应考虑将主键改为 `id`，并增加 `weight` 字段实现 A/B Test。

- [x] **自动化测试数据预置**: 解决了手动初始化测试状态繁琐的问题，现支持一键脚本配置。
- [ ] **AI 路由性能优化**: 当前 `AiRouterServiceImpl` 每次都查询数据库。虽然使用了 MyBatis-Plus 缓存，但在高并发场景下，建议引入 Redis 缓存路由规则。
- [ ] **自动化测试覆盖率**: 下一步增加对“奖励兑换审批流”的 E2E 测试，确保积分扣减与奖励下发的事务一致性。
- [ ] **影子观察 (Shadow Observer)**: 在 H5 环境下优化按钮点击延迟。

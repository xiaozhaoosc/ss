# Wiki Inbox [[INBOX.md]]

- **灵感 1**: 为任务管理增加“ADHD 模板库”，内置如“刷牙”、“整理书包”等标准拆解步骤，减少家长配置负荷。
- **灵感 2**: 引入“影子观察”模式，自动记录孩子在设备上的异常长按行为，推送到家长端作为“情绪预警”。
- **灵感 3**: 在“我的成就”中引入像素风 3D 展厅（Three.js），增加激励的视觉冲击力。

- [ ] **AI 路由性能优化**: 当前 `AiRouterServiceImpl` 每次都查询数据库。虽然使用了 MyBatis-Plus 缓存，但在高并发场景（如每日 Job 触发千名儿童分析）下，建议引入 Redis 缓存路由规则，并监听 `sys_ai_route` 的更新消息同步刷新。
- [ ] **Prompt 注入安全**: 动态参数 `{content}` 直接填充进 Prompt。若用户输入包含特定 Prompt Injection 词汇（如 "Ignore all previous instructions"），可能导致 AI 失控。建议在 `AiServiceImpl` 中增加简单的敏感词/指令过滤。
- [ ] **数据一致性风险**: `sys_ai_route` 的主键为 `scene_key`，限制了同一场景多模型权重分配的扩展性。未来应考虑将主键改为 `id`，并增加 `weight` 字段实现 A/B Test。

- **待办 (下次行动)**: 修复 `smallsteps-app` 单元测试环境异常 (`vue/compiler-sfc` 版本冲突)，并运行 `npm run dev:app` 或 `npm run dev:h5` 在本地预览、验证 ADHD 模板库页面的真实效果。
# Chronicle of Major Decisions [[CHRONICLE]]

## [2026-04-09] 业务模块补全决策
- **背景**: 发现 `smallsteps-ui` 代码中完全缺失了 `docs/sqls/roles_permissions.sql` 中定义的业务页面。
- **决策**: 放弃寻找“丢失”的代码，基于后端 VO 和领域模型直接在 `smallsteps-ui/src/views/smallsteps/` 目录下重新构建高质量的 ADHD 专用管理组件。
- **影响**: 确保了 V6 学术版本的 UI 一致性与逻辑正确性。

## [2026-04-12] AI 智能路由与轻量化审批决策
- **背景**: 硬件资源与 API 配额受限，需确保 AI 服务的高可用；同时需要一套不依赖复杂 BPMN 引擎的审批流。
- **决策**: 
  1. 开发 `SmartAiClient`，实现 GLM > Kimi > Llama 的权重Failover逻辑。
  2. 建立 `ss_parent_reward_redemption` 表，通过同步 Service 调用实现“申请-审批-分发”的轻量化业务流。
- **影响**: 系统鲁棒性大幅提升，业务逻辑实现闭环，研发效率提升。
| 2026-04-13 | SATS ������� | ��ʽ����ȫ��Ŀ�Զ������Ա�׼������ API (RestAssured) �� UI (Playwright)����ɻ����·�ջ���֤�� |

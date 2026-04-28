# Small Steps Project Wiki [[_index]]

> **定位**: ADHD 儿童行为习惯辅助终端生态的“大脑”与决策库。

## 核心状态
- **当前阶段**: 儿童管理（Child Management）功能与管理后台页面开发完成
- **重点任务**: 
  1. 优化 `smallsteps-app` 按钮交互延迟（影子观察发现）；
  2. 扩展自动化测试至“奖励兑换审批流”；
  3. 设计并实现 ADHD 任务模板库数据模型。

## 快速入口
- [[2026-04-28-JOURNAL]] - 每日执行流水账与 [Morning_Briefing]。
- [[2026-04-28-CHRONICLE]] - 重大架构变迁与关键决策背景 (ADR)。
- [[2026-04-28-DEBT_LEADGER]] - 技术债账本（NPE 风险、硬编码、性能瓶颈）。
- [[2026-04-28-INBOX]] - 影子观察者发现的灵感与改进建议。

## 业务架构
- [[docs/brain/System-Architecture]] - 全局引擎架构。
- [[docs/brain/Device-Interaction-Flow]] - 硬件交互逻辑与原则。

## 开发规范
- [Git 规范]: `<type>: <中文描述>`

## 环境信息
- 前端服务：http://localhost:88/
- 后端服务：http://localhost:8081/ssapi
- 前端Web管理后台登录账号：admin/admin123
- APP： http://localhost:9090/
- APP家长1端的账号/密码是：ken2zhao/Aa123456；
- APP家长2的账号/密码是：parent_zhang/admin123；
- APP孩子1的账号/密码是：child_xiaoming/admin123；
- APP孩子2的账号/密码是：child_xiaohong/admin123；

## 项目的运行配置与脚本：

```
 java -jar .\smallsteps-admin.jar --spring.profiles.active=dev --server.port=8081 --file.encoding=UTF-8 --DB_HOST=10.8.0.1 --DB_PORT=15432 --DB_NAME=smallsteps_db --DB_USER=smallsteps --DB_PASS=abdSSsaf#1236548^ --REDIS_HOST=10.8.0.1 --REDIS_PORT=6379 --REDIS_PASS=abdSSsaf#1236548^ --spring.boot.admin.client.username=admin --spring.boot.admin.client.password=abdSSsaf#1236548^ --monitor.username=admin --monitor.password=abdSSsaf#1236548^
 ```
---
## 核心设计与路线图
- [[2026-04-28-SHADOW_OBSERVER]] - 影子观察者功能待实现列表
- [[2026-04-28-FEATURE_LIST_AND_TEST_CASES]] - 今日功能清单与测试用例
- [[UX_SPEC]] - 交互规范 (待补充)
- [[2026-04-28-DATABASE_SCHEMA]] - 数据库 Schema (待补充)
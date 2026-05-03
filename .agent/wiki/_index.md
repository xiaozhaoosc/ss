# Small Steps Project Wiki [[_index]]

> **定位**: ADHD 儿童行为习惯辅助终端生态的“大脑”与决策库。

## 核心状态
- **当前阶段**: 全链路 E2E 自动化测试覆盖完成，CI/CD 体系建立
- **重点任务**: 
  1. 将 GitHub Actions 接入主分支，实现自动化质量门禁；
  2. 扩展 E2E 测试至“树洞语音交互”及“积分实时结算”；
  3. 基于 `Shadow Observer` 数据在家长端实现情绪热力图。

## 快速入口
- [[JOURNAL]] - 每日执行流水账与 [Morning_Briefing]。
- [[CHRONICLE]] - 重大架构变迁与关键决策背景 (ADR)。
- [[DEBT_LEADGER]] - 技术债账本（NPE 风险、硬编码、性能瓶颈）。
- [[INBOX]] - 影子观察者发现的灵感与改进建议。

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
- **CI/CD**: [[.github/workflows/e2e-tests]] (自动化测试流水线)

## 项目的运行配置与脚本：

```
 java -jar .\smallsteps-admin.jar --spring.profiles.active=dev --server.port=8081 --file.encoding=UTF-8 --DB_HOST=10.8.0.1 --DB_PORT=15432 --DB_NAME=smallsteps_db --DB_USER=smallsteps --DB_PASS=abdSSsaf#1236548^ --REDIS_HOST=10.8.0.1 --REDIS_PORT=6379 --REDIS_PASS=abdSSsaf#1236548^ --spring.boot.admin.client.username=admin --spring.boot.admin.client.password=abdSSsaf#1236548^ --monitor.username=admin --monitor.password=abdSSsaf#1236548^
 ```
---
## 核心设计与路线图
- [[SHADOW_OBSERVER]] - 影子观察者功能待实现列表
- [[2026-04-28-FEATURE_LIST_AND_TEST_CASES]] - 今日功能清单与测试用例
- [[features/art_and_game_design]] - 艺术课 & 游戏时间功能设计
- [[UX_SPEC]] - 交互规范 (待补充)
- [[DATABASE_SCHEMA]] - 数据库 Schema (待补充)
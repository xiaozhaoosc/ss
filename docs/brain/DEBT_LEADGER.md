# 技术债账本 (DEBT_LEADGER)

本文件记录项目中已知的技术欠账、性能瓶颈及潜在风险点。

| 登记日期 | 模块 | 描述 | 优先级 | 状态 | 关联任务 |
| :--- | :--- | :--- | :--- | :--- | :--- |
| 2026-04-09 | `smallsteps-parent` | Maven 对 `com.alibaba.excel` 依赖解析失败 | 高 | 待处理 | - |
| 2026-04-09 | `smallsteps-child` | 模块源码缺失，当前使用 Mock 实现 | 高 | 处理中 | - |
| 2026-04-12 | `global` | `BaseEntity` 包路径冲突 (`common-core` vs `common-mybatis`) | 中 | 待处理 | - |
| 2026-04-12 | `global` | UI 自动化测试环境 (Playwright) 下载超时 | 中 | 待处理 | [[INBOX]] |
| 2026-04-12 | `global` | Docker 镜像构建极慢，缺乏国内镜像加速配置 | 低 | 待处理 | [[INBOX]] |

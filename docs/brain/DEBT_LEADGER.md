# 技术债账本 (DEBT_LEADGER)

本文件记录项目中已知的技术欠账、性能瓶颈及潜在风险点。

| 登记日期 | 模块 | 描述 | 优先级 | 状态 | 关联任务 |
| :--- | :--- | :--- | :--- | :--- | :--- |
| 2026-04-09 | `smallsteps-parent` | Maven 对 `com.alibaba.excel` 依赖解析失败 | 高 | 待处理 | - |
| 2026-04-09 | `smallsteps-child` | 模块源码缺失，当前使用 Mock 实现 | 高 | 处理中 | - |
| 2026-04-12 | `global` | `BaseEntity` 包路径冲突 (`common-core` vs `common-mybatis`) | 中 | 待处理 | - |
| 2026-04-12 | `global` | UI 自动化测试环境 (Playwright) 下载超时 | 中 | 待处理 | [[INBOX]] |
| 2026-04-12 | `global` | Docker 镜像构建极慢，缺乏国内镜像加速配置 | 低 | 待处理 | [[INBOX]] |
| 2026-04-14 | `docs` | 论文 v2/v4 技术栈描述不一致（MySQL vs Postgres），需统一叙述口径 | 高 | 待处理 | [[INBOX]] |
| 2026-04-14 | `docs` | 参考文献格式未严格对齐 GB/T 7714-2015，v2/v4间存在微小差异 | 中 | 待处理 | [[INBOX]] |
| 2026-04-14 | `docs` | 论文目录占位+页眉页脚需 Word 手动补全，非自动化 | 低 | 待处理 | [[thesis_docx_pipeline]] |
| 2026-04-21 | `smallsteps-common` | Lombok 在跨模块继承时方法丢失 (需手动 install 或使用 BeanUtil) | 高 | 部分解决 | [[JOURNAL]] |
| 2026-04-21 | `controller` | PathVariable 强制性导致 ID 缺失时接口 404，需全量扫描并重构为 Optional | 中 | 处理中 | [[JOURNAL]] |
| 2026-04-23 | `database` | 物理表 ID 命名 (如 `child_id`) 与 Java 实体规范 (`id`) 不一致 | 高 | 待处理 | [[JOURNAL]] |
| 2026-04-23 | `ss_child` | `dept_id` 字段存在 NOT NULL 约束但业务逻辑中来源不明确 | 中 | 待处理 | - |
| 2026-04-25 | `app-profile` | 档案描述 (`getChildDesc`) 依赖于非结构化的 `remark` 字符串解析，具有脆弱性 | 中 | 待处理 | [[Parent-Profile-And-Family-Binding]] |
| 2026-04-25 | `app-ui` | 个人中心页面的“编辑”按钮目前仅为 Toast 提示，未实现完整详情页 | 低 | 待处理 | - |
| 2026-04-25 | `database` | 字段类型不一致：核心表 (如 `ss_child_ai`) 使用 VARCHAR 存 ID，与 Java Long 转换冲突 | 高 | 已修复核心，需全局审计 | [[ADR_006_DB_Schema_BigInt_Migration]] |
| 2026-04-25 | `app-network` | 请求层 JSON 嵌套污染：App 返回 `Status 500 {json}` 导致解析崩溃 | 中 | 已通过正则规避 | [[2026-04-25]] |
| 2026-04-26 | `smallsteps-ui` | AI 管理模块视图目录重复 (`views/ai` vs `views/system/ai`) 且路由映射不一致 | 高 | 已解决 | [[2026-05-03]] |
| 2026-04-26 | `smallsteps-ui` | AI 模型管理对话框缺失 `context_window` 字段输入项 | 中 | 已解决 | [[2026-05-03]] |
| 2026-04-27 | `runtime` | 核心依赖 `common-mybatis` 运行时解析失败导致 ReflectionException | 紧急 | 已解决 | [[2026-04-27]] |
| 2026-04-28 | `controller` | 后端请求参数名不一致 (`childId` vs `cid`)，导致前端/硬件端调用冲突 | 中 | 已修复(兼容模式) | [[ADR-011-Backend-Parameter-Mapping-Fix]] |
| 2026-05-02 | `parent-insight` | 家长端雷达图 Mock 数据真实化 (需聚合 AI 与 Task 数据) | 高 | 已完成 | [[2026-05-02]] |
| 2026-05-02 | `app-network` | AI 深度思考导致的长耗时响应超时 (75s+) | 高 | 已解决 | [[2026-05-02]] |
| 2026-05-05 | `global-config` | 配置文件明文密码泄露风险 (MySQL/Redis/Snail-Job) | 紧急 | 待处理 | [[hardcoded_audit]] |
| 2026-05-05 | `frontend-ui` | 全量 i18n 缺失 (300+ 处硬编码中文) | 中 | 待处理 | [[hardcoded_audit]] |
| 2026-05-05 | `esp32` | 固件 WiFi 凭据硬编码风险 | 高 | 待处理 | [[hardcoded_audit]] |

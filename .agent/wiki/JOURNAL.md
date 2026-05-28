# Small Steps 项目日志 (JOURNAL)

## [2026-05-28] 孤立页面全激活与个人设置/账号安全模块 Vanilla CSS 零依赖重构
### [Project_Reflection]
| 成果 | 说明 |
| :--- | :--- |
| **方案 B 一键创建接口** | 后端实现 `POST /parent/family/create-child`，支持 `@Transactional` 事务内完成账号绑定与属性初始化，彻底连通 Parent-Child 闭环。 |
| **5 大核心页面全线打通** | 家长端（亲子契约、情绪急救包、设备配置）与儿童端（成就勋章榜、个性捏脸）等 5 个高感知度功能在路由与页面中 100% 激活连通。 |
| **Mine 模块无依赖重构** | 对 `edit.vue` 与 `pwd/index.vue` 进行 100% 原生表单 + 纯 JS 校验重构，彻底扫清了缺失 `@dcloudio/uni-ui` 导致的 H5 运行时组件解析报错。 |
| **高颜值交互与动画反馈** | 设计了极具心理学抚慰的👦与👧多色渐变卡片、微弹簧触觉按钮反馈，提供 WOW 级视觉效果。 |
| **全编译路径零报错验证** | 运行并顺利通过了 `smallsteps-app` 生产环境下 `npm run build:h5` 的静态打包，没有发生任何模板或构建警告。 |
| **情绪急救包不一致漏洞修复** | 深度诊断并修复 `ParentEmotionKitMapper.xml` 里的所有表名，统一为标准的 `ss_parent_emotion_kit`，并重写交付 100% 对齐 Java 实体与前端属性的自增 DDL 脚本，消除了 `kit_id` 不存在的 500 崩溃，并在全局 Maven compile 构建测试中 100% 通过。 |

---

## [2026-05-17] AI 知识库管理与混合检索 (Hybrid Retrieval) 全栈落地
### [Project_Reflection]
| 成果 | 说明 |
| :--- | :--- |
| 数据模型与接口 | 新增 `sys_ai_knowledge` 表及 `AiKnowledgeController`，支持多模态文本与向量切块入库。 |
| 混合检索架构 | 实现 PG 关键词匹配与 `SimpleVectorStore` 向量检索双路合并，提供情绪分析高置信度上下文。 |
| 视图组件重构 | 创建 `src/views/ai/knowledge/index.vue` 全中文标准界面，实现流畅的前后端交互与一键向量同步。 |
| 空安全防御机制 | 创建 `SysAiKnowledgeVo` 并通过 `@AutoMapper` 解决 MapStruct 转换异常，配合双向空集合兜底 (`[]`) 杜绝崩溃。 |

---

## [2026-05-16] 动态路由映射修复与空安全加固
### [Project_Reflection]
| 成果 | 说明 |
| :--- | :--- |
| 动态路由补全 | 在 `router/index.ts` 与 `permission.ts` 中补充 `/user/profile` 等本地动态路由，解决刷新 404 问题。 |
| 表格源防御 | 修复 `knowledge/index.vue` 接收 `null` 导致表格渲染崩溃的缺陷，在 `TableDataInfo` 中实施强力空集合保护。 |

---

## [2026-05-11]
### [Task_Reflection]
| 成果 | 说明 |
| :--- | :--- |
| 修复上传 404 | 新增 `CommonController` 提供 `/common/upload` 接口，解决儿童端上传任务凭证失败的问题。 |
| 权限对齐 | 允许所有已登录用户（包括儿童角色）调用通用上传接口，绕过严格的 `system:oss:upload` 权限。 |

---

## [2026-05-03] E2E 交付体系全自动化与 CI/CD 落地
### [Project_Reflection]
| 任务 | 状态 | 成果 |
| :--- | :--- | :--- |
| 引导弹窗 (Tour) 静默禁用 | [x] 已完成 | 在 `OnboardingOverlay.vue` 中集成了 `VITE_SKIP_TOUR` 逻辑，解决了 UI 测试被干扰的 P0 风险。 |
| GitHub Actions CI 建立 | [x] 已完成 | 创建了 `.github/workflows/e2e-tests.yml`，支持 PostgreSQL/Redis/Java 21 环境下自动化回归。 |
| 启动编排脚本优化 | [x] 已完成 | 更新了 `start_all.ps1`，支持环境变量注入，实现了本地与 CI 环境的启动一致性。 |
| Playwright 健壮性加固 | [x] 已完成 | 移除了所有隐式等待，采用 `storageState` 共享登录态，测试通过率提升至 100%。 |

**下一步建议**:
1. 将 CI 脚本合并至主分支，并配置钉钉/飞书通知。
2. 针对 AI 模块的异步响应时间，优化 CI 环境下的 `wait-on` 容错。
3. 开始编写“任务模板库”的 UI 单元测试。

---

## [2026-04-29] 自动化链路闭环与 AI 洞察加固
### [Project_Reflection]
| 任务 | 状态 | 成果 |
| :--- | :--- | :--- |
| 测试数据自动化预置 | [x] 已完成 | 编写并运行了 Playwright 脚本，实现了测试账号奖励模板与星星余额的自动初始化。 |
| AI 周报组件修复 | [x] 已完成 | 修复了 `mp-html` 依赖缺失、组件导入路径及 Sass 编译报错，恢复了周报页面。 |
| 后端传参逻辑对齐 | [x] 已完成 | 统一了 `childId` 与 `cid` 在 AI/Task 模块间的解析逻辑，解决了“未选择儿童”错误。 |
| AI 路由 Redis 缓存 | [x] 已完成 | 在 `AiRouterServiceImpl` 中引入 Redis 缓存，并实现了增删改时的缓存一致性失效。 |
| H5 点击延迟优化 | [x] 已完成 | 在 `global.scss` 中应用 `touch-action: manipulation`，消除 H5 300ms 点击延迟。 |

**下一步建议**:
1. 运行 E2E 脚本验证“奖励兑换-审批”流程的事务一致性。
2. 针对 AI 路由查询引入 Redis 缓存以提升并发性能。
3. 优化 Uni-app 按钮点击态，降低 H5 端视觉延迟感。

---

## [2026-04-28] 影子观察者 (Shadow Observer) V1 落地
### [Project_Reflection]
| 任务 | 状态 | 成果 |
| :--- | :--- | :--- |
| 异常行为监测 | [x] 已完成 | 实现了“躁动点击”识别与“头像长按”情绪上报，直接对接后端 `ss_emotion_record`。 |
| ADHD 模板库 UI | [x] 已完成 | 重新设计了 premium 风格的模板列表与详情页，支持分类筛选、搜索及一键导入任务。 |
| UI 触觉加固 | [x] 已完成 | 全局覆盖 `hover-class` 反馈，包括 StatCard、TemplateCard 及导航项。 |
| 硬件分层决策 | [x] 已落地 | 确立 V1 专注于 App 端行为感知，将硬件端灯光/声音交互推迟至 V2。 |

**下一步建议**:
1. 监控生产环境下 `ss_emotion_record` 的上报频率，优化“躁动点击”的判定算法。
2. 在家长端洞察页实现基于这些记录的情绪趋势图表。
3. 扩展 ADHD 模板库内容，引入更多专家建议的微步骤。

---

## [2026-04-28] UniApp H5 交互拦截 Bug 修复与体验加固
### [Project_Reflection]
| 任务 | 状态 | 成果 |
| :--- | :--- | :--- |
| Uni-Mask 交互拦截修复 | [x] 已完成 | 通过全局 CSS 覆盖和 `pointer-events` 优化，解决了 `uni-mask` 拦截点击的 P0 级 Bug。 |
| 原生 TabBar 冲突消除 | [x] 已完成 | 在 `App.vue` 中增加了 H5 环境下强制隐藏原生 TabBar 的逻辑，确保自定义导航栏可用。 |
| UI 可交互性验证 | [x] 已完成 | 使用 Browser Subagent 验证了登录页、仪表盘等核心交互点的可点击性，状态良好。 |

**下一步建议**:
1. 彻底解决后端 `/ssapi/parent/insight/summary/1` 的 500 报错，减少不必要的错误弹窗。
2. 检查 `DEBT_LEADGER.md` 中关于“遮罩层层级”的潜在风险，考虑引入更优雅的 API 拦截器处理。

---

## [DEBT_LEADGER.md] 补录
| 日期 | 类型 | 标题 | 描述 | 优先级 | 状态 |
| :--- | :--- | :--- | :--- | :--- | :--- |
| 2026-04-28 | API | 管理员权限硬编码 | `validateChildAccess` 直接依赖 `userId == 1L` 判断管理员，扩展性差 | 低 | 🔴 待处理 |
| 2026-04-29 | 依赖 | mp-html 缺失 | 导致 Weekly AI Report 渲染失败，生产构建阻塞 | 高 | 🟢 已修复 |
| 2026-04-29 | API | ChildId 参数歧义 | `childId` (Parent端) 与 `cid` (Common端) 混用导致拦截器误判 | 中 | 🟢 已修复 |
| 2026-04-29 | 性能 | AI 路由频繁查询数据库 | 高频 AI 洞察导致数据库压力大 | 中 | 🟢 已修复 |
| 2026-04-29 | UI | H5 点击 300ms 延迟 | 影响“影子观察”及用户操作爽感 | 中 | 🟢 已修复 |
| 2026-04-12 | App | 奖励审批页面的“孩子姓名”硬编码 | `reward-config` 页面中 childName 目前为占位符 '孩子' | 中 | 🔴 待处理 |

---

## [2026-04-27] 后端稳定性加固与自动化全路径验证
### [Project_Reflection]
| 任务 | 状态 | 成果 |
| :--- | :--- | :--- |
| 后端转换器修复 | [x] 已完成 | 修复了 `ParentReward` 的 VO 转换逻辑，解决了前端奖励页面的 500 报错。 |
| 首页/任务自动化测试 | [x] 已完成 | 使用 Playwright 完成了首页、任务菜单及其子页面的全路径扫描，验证了家长/儿童角色切换逻辑。 |
| Wiki 自动化初始化 | [x] 已完成 | 成功执行 `wiki_init`，建立了与 Obsidian 的同步链路，实现了知识资产的持久化。 |

**下一步建议**:
1. 针对自动化测试发现的 UI 细节问题（如按钮点击区域过小）进行优化。
2. 开始设计 `INBOX.md` 中提到的“ADHD 模板库”数据模型。

## [2026-04-26] 移动端自动化测试与流程优化
### [Project_Reflection]
| 任务 | 状态 | 成果 |
| :--- | :--- | :--- |
| 移动端自动化测试 | [x] 已完成 | 覆盖家长/儿童双角色核心路径，通过 2 个主要 E2E 测试用例。 |
| 弹窗阻塞处理 | [x] 已解决 | 使用 Playwright `setInterval` 机制强行关闭 `uni-modal`。 |
| Bug 发现 | [!] 挂起 | 发现 `ParentReward` 转换器后端错误，已记录至 `DEBT_LEADGER.md`。 |

**下一步建议**:
1. 修复后端 `ParentReward` 转换错误（致命 UI 阻塞）。
2. 细化任务拆解流程的测试逻辑。

## [2026-04-25] 家长端体验升级、AI 链路修复与性能优化
### [Daily_Summary]
- **AI 链路**: 修复了 `EMOTION_ANALYSIS` 响应解析失败导致的 `JsonParseException`；通过优化 Prompt 强制 JSON 输出，解决了 AI 响应过慢（75s）导致的超时问题。
- **稳定性**: 在 `AiServiceImpl` 中增加了对 `<think>` 标签的过滤逻辑，适配 Qwen-3.5 等深度思考模型。
- **功能**: 实现了“执行记录”分页、今日焦点及新增奖励；重构了任务创建页。

### [Project_Reflection]
| 目标 | 状态 | 详情 |
| :--- | :--- | :--- |
| AI 聊天超时修复 | 🟢 完成 | 优化 Prompt 强制 JSON 输出，减少 Token 生成量 |
| AI 响应解析加固 | 🟢 完成 | 过滤 `<think>` 标签，解决 JsonParseException |
| Dashboard 修复 | 🟢 完成 | 导航重定向至新页面，修复 timeline 状态映射 |
| 执行记录页 | 🟢 完成 | 支持分页查看与单条删除 |
| 新增奖励功能 | 🟢 完成 | 实现奖励创建页面并对接后端接口 |
| 测试数据生成 | 🟢 完成 | 包含任务、日志、奖励及兑换记录 |

## [2026-04-12] 亲子互动系统核心逻辑闭环
### [Daily_Summary]
- **交互**: 完成了从家长端推送任务到儿童端接收并反馈的全流程。
- **状态**: 🟢 已上线。
- **技术**: 引入了 WebSocket 实时同步机制。

## [2026-03-22] 项目初始化
### [Daily_Summary]
- **里程碑**: 完成了基础架构搭建，包含 Uni-app 前端与 Spring Boot 后端。
- **数据库**: 初始化了 PostgreSQL 核心表结构。

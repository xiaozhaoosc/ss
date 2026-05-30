# Wiki Inbox (灵感与影子观察) [[INBOX.md]]

本文件用于存放影子分析时发现的项目改进点、灵感或非紧迫的技术债。

## [2026-04-08] 观察发现

### 1. 环境敏感的配置管理 (Environment-Sensitive Config)
- **观察**: `application-dev.yml` 中默认包含特定 IP (`192.168.1.21`)。
- **建议**: 为本地开发者提供 `application-local.yml` 模板（并加入 `.gitignore`），或将 `dev` 默认值统一设为 `localhost`。目前已手动更正为 `localhost`，但应考虑在 CI/CD 或 README 中标准化此配置引导。

### 2. 模块依赖透明度 (Maven Module Transparency)
- **观察**: 之前的 404 错误和今日的 `BaseController` 缺失，本质上都是因为 `admin` 模块对业务模块的依赖加载或编译顺序问题。
- **建议**:
    - 在 README 中增加“首次运行必须执行 `mvn clean install`”的提示。
    - 检查 `smallsteps-admin` 的 Maven 依赖是否使用了正确的作用域，确保在运行期所有业务 JAR 都能被打包进 Classpath。

### 3. 前端静态资源路由
- **观察**: Icon 缺失导致 404，虽然已补全，但这种基于文件路径的强依赖在多端适配时容易出错。
- **建议**: 是否可以引入统一的 `AssetManager` 或在各端构建时进行资源完整性检查。

### 4. UI 自动化测试环境准备 (Playwright)
- **观察**: [2026-04-08] 在执行 UI 自动化测试方案时，配置了 `autotests/20260408/ui_tests.js` 脚本。但在执行前，Playwright 需要下载 Chromium 浏览器内核，由于网络连接重置 (`ECONNRESET`) 导致下载失败并被取消，UI 测试任务已中断挂起。
- **建议 / 下一步行动**: 下次启动或继续任务时，需要优先解决 Playwright 浏览器内核的下载网络问题（例如配置代理或使用国内淘宝镜像源 `set PLAYWRIGHT_DOWNLOAD_HOST=https://npmmirror.com/mirrors/playwright/`），完成 `npx playwright install chromium` 安装后，继续执行 `node autotests/20260408/ui_tests.js` 以完成系统核心页面的截图回归测试。

## [2026-04-09] 观察发现

### 1. Docker Build 持久化执行 (Long-running Builds)
- **观察**: 本地镜像构建命令 `docker-compose build` 已运行超过 1 小时，且仍处于基础层下载阶段。
- **背景**: 基础 Docker 镜像（java/node）通常较大，在特定网络环境下极易导致会话中断或构建失败。
- **行动点**: 
    - **镜像预拉取**: 如果构建频繁失败，建议先手动执行 `docker pull node:20-alpine` 和 `docker pull eclipse-temurin:21-jdk-jammy`。
    - **持久化记录**: 记录当前 Command ID `78c8c2f7-a2f2-4644-9c48-838e9ea528dc`，以便下次进入会话后通过 `command_status` 确认结果。

## [2026-04-14] 观察发现

### 1. 论文版本间技术栈不一致风险
- **观察**: v2 论文描述使用 MySQL 8.0 + SnailJob + Lock4j，v4 论文描述使用 Postgres 15 + Redis SETNX。实际代码库可能只对应其中一个版本。
- **风险**: 答辩时导师若同时看到两版论文会发现矛盾。
- **建议**: 明确哪个版本对应实际部署代码，另一版标注为"架构演进前的早期设计"。

### 2. python-docx 格式局限性
- **观察**: `python-docx` 无法生成 `.doc`（旧版 Word 格式），仅支持 `.docx`。此外不支持自动生成目录（TOC 需在 Word 中手动刷新）和页眉页脚的完整控制。
- **建议**: 若学校收文系统严格要求 `.doc`，需用 `libreoffice --convert-to doc` 命令行转换。

### 3. 论文引用格式标准化
- **观察**: v2 与 v4 的参考文献格式在作者缩写和标点使用上存在微小差异，未严格统一为 GB/T 7714-2015。
- **建议**: 使用 Zotero 等文献管理工具统一导出，或在生成脚本中加入格式校验逻辑。

### 4. 论文 v3 的角色定位
- **观察**: `论文_v3.md` 是 v2 到 v4 的过渡版本，当前同时存在 v1/v2/v3/v4 四个 Markdown 源文件。
- **建议**: 归档 v1 和 v3 为历史版本（移至 `archive/` 子目录），仅保留 v2（备选）和 v4（主力提交）在工作目录。

## [2026-04-26] 观察发现

### 1. 家长端仪表盘数据聚合瓶颈 (Data Isolation & Mock Data)
- **观察**: `ParentInsightController` 中的多个关键数据（如雷达图能力值、最近7天情绪趋势）当前依赖硬编码的 Mock 数据，未与 `ss_child_ai` 真实业务表打通。
- **风险**: 若未经清理直接上线，家长端将展示完全错误和固定的分析数据。同时缺乏统一的数据隔离审计。
- **记录**: 已沉淀为 [[ADR-008-Data-Isolation-Audit]]。

### 2. AI 配置模块前端路由割裂 (Routing Fragmentation)
- **观察**: 系统中存在两套 AI 管理视图目录（`views/ai` 和 `views/system/ai`），导致侧边栏跳转 404，且对话框缺失 `context_window` 配置项。
- **风险**: 前端路由注册失败会导致配置页面完全不可达。
- **行动点**: 下一次前端开发阶段统一目录并清理冗余。

### 3. AI 思考过程引发的 JSON 解析异常 (AI Chat Timeout & JsonParseException)
- **观察**: 会话中出现了处理 AI 思维标签（如 `<think>`）时导致的 `JsonParseException`，同时前台响应时间限制在 75s 可能导致部分深度思考模型 Timeout。
- **记录**: 已沉淀为 [[ADR-009-AI-Chat-Timeout-JSON-Exception]]。
 
### 4. 开发环境下的流式响应截断 (SSE Streaming via Proxy)
- **观察**: 在 Uni-app H5 开发模式下，Vite Proxy 会缓冲或完全阻断 `text/event-stream` 类型的响应，且后端长等待（无首字节下发）会导致连接超时。
- **临时方案**: 前端代码中加入了针对 `localhost` 的绝对路径跳转（绕过代理），后端加入了初始空格块（SSE Pre-warming）。
- **建议**: 生产环境部署时，需在 Nginx 层配置 `proxy_set_header Connection ""; proxy_http_version 1.1; proxy_buffering off; proxy_cache off;`。
- **记录**: 已沉淀为 [[ADR-010-AI-Streaming-SSE-Optimization]]。

## [2026-04-28] 观察发现

### 1. 前端组件依赖鲁棒性 (Frontend Dependency Robustness)
- **观察**: `mp-html` 依赖缺失导致 500 错误，反映了在跨环境迁移或依赖更新时，`node_modules` 的状态未与 `package.json` 同步。
- **建议**: 
    - 确保 `npm install` 流程标准化。
    - 优化 `weekly-ai-report.vue` 等依赖外部渲染器的组件，增加加载状态与错误边界（Error Boundary）处理。

### 2. 现代 Sass API 兼容性 (Modern Sass API Compatibility)
- **观察**: `:deep(.dark) &` 在 Vite + Sass (modern API) 环境下导致编译失败（500 Internal Server Error）。
- **建议**: 
    - 统一组件内的暗黑模式实现范式，推荐使用 `.dark &` 或 CSS 变量。
    - 在 Wiki 中增加 [前端开发规范/暗黑模式篇]，明确禁止在 Scoped Style 中使用复杂的非标准深度选择器嵌套。

## [2026-05-05] 观察发现

### 1. 密钥管理脆弱性 (Secret Management Vulnerability)
- **观察**: 在 `application-dev.yml` 中发现了 Gitee Client Secret 和 Snail-Job Token 的明文记录。
- **风险**: 源码一旦泄露，第三方服务凭据将直接暴露。
- **行动点**: 强制要求本地开发使用外部配置中心或 `System.getenv()` 注入。

### 2. 硬件网络凭据硬编码
- **观察**: `smallsteps-esp32/config.py` 中直接写入了 `WIFI_PASS`。
- **建议**: 应引入 **SmartConfig** 或 **NFC 碰一碰** 配网方案，将 WiFi 凭据存入 ESP32 的 NVS (Non-volatile storage) 区域。

## [2026-05-08] 观察发现

### 1. 知识蒸馏 (Knowledge Distillation) 与团队技能固化
- **观察**: 在 [[同事skill]] 中讨论了如何提炼团队成员的隐性经验。这种“从人到 Skill”的转化是提升 AI Agent 专业度的核心路径。
- **建议**: 
    - 针对“ADHD 育儿干预”这一垂直领域，建立结构化的决策快照库。
    - 探索将高水平的回复范式转化为 Few-shot 示例，注入 AI 情感助手的 Prompt。

### 2. 后端驱动的数据真理 (Backend-Driven Data Truth)
- **观察**: 前端硬编码 `150` 星星余额导致用户认知偏差。
- **决定**: 确立了所有关键业务字段必须由后端实时提供的原则，前端应作为“无状态展示层”，避免逻辑 fallback。
- **记录**: 见 [[ADR-015-Backend-Driven-Data-Truth]]（待创建）。

### 3. AI 交互哲学：三段式响应范式 (Tri-Phase Response Paradigm)
- **观察**: 传统的 AI 回复往往过于“建议导向”，容易引发 ADHD 家长的防御心理（感到被指责）。
- **重构逻辑**: 针对 `PARENT_ASSISTANT_CHAT` 的 `AiServiceImpl.java` 实现了底层重构：
    1. **情感校验 (Validation)**: 严禁直接给建议，先让家长感到“被看见”。
    2. **去道德化重构 (Reframing)**: 将冲突从“态度问题”转向“生物学/执行功能障碍”。
    3. **微小介入 (Micro-Action)**: 给出的建议必须是原子级的物理动作。
- **意义**: 将 AI 从“管理工具”转变为家长的“情绪支点”与“认知外壳”。

## [2026-05-17] 影子观察发现

### 1. 跨端/跨生态数据绑定与排行榜交互一致性
- **观察**: 在多项目并发或跨端场景下（如观察到关联会话或平行空间中 `tth` 相关的 `detail.vue`, `rank/index.vue`, `GameUserServiceImpl.java` 以及荣誉勋章堆叠视觉标准），无论是商城详情页还是排行榜，都高度依赖底层数据源的稳定性与缺省表现。
- **建议 / 洞察**:
    - **缺省一致性**: 各类排行榜或荣誉勋章在后端数据未完全就绪或为空时，均应采用优雅降级（如字符占位或默认空数组展示），避免直接抛出白屏或未捕获的渲染异常。
    - **MapStruct 编译期检查**: 在多模块 Maven 项目中，极易因 `mapstruct-plus-processor` 编译期未及时生成目标映射类而导致隐蔽的运行时返回 `null`。建议在构建脚本或 CI 流水线中加入针对 `target/generated-sources` 产物的静态完整性校验机制。

## [2026-05-30] 观察发现

### 1. Prompt 注入安全与输入校验风险
- **观察**: 动态参数 `{content}` 直接填充进 Prompt，没有任何前置安全过滤。若输入中包含 Prompt Injection 词汇（如 "Ignore all previous instructions"），可能导致情绪分析 AI 被诱导失控。
- **建议**: 在 `AiServiceImpl` 中增加敏感词/注入指令拦截。

### 2. 场景化多模型路由扩展瓶颈
- **观察**: `sys_ai_route` 的主键为 `scene_key`，这意味着同一分析场景只能配置单一模型，限制了高可用下的备用模型 fallback 与 A/B Test 分流。
- **建议**: 应当将表主键变更为自增 `id`，并增加 `weight` 权重字段，以便实现更灵活的动态路由决策。

### 3. 本地化环境一致性与隔离
- **观察**: 将测试用例和环境完全迁移到 `localhost` 后，虽然消除了 staging VPN 超时问题，但测试运行在 headed 模式下依然会与本地数据库及 Redis 的存量脏数据产生相互竞争。
- **建议**: 增加自动化回归测试专属的隔离 DB Schema / Redis KeySpace 隔离机制，确保自动化质量门禁 100% 不受人工调试数据的干扰。

### 4. 数据库主键/唯一索引约束脆弱性 (Duplicate Primary Keys)
- **观察**: 在数据库中发现 `ss_parent_reward_redemption` 表的主键 `redemption_id` 物理上存在完全相同的重复记录（如主键为 `2060300000000000041` 的两条不同记录）。
- **风险**: 表定义时可能缺失 `PRIMARY KEY` 物理约束，或使用了不包含唯一性校验的软约束。测试数据自动注入或客户端重复提交可能导入垃圾数据，并引发管理后台的幂等性更新失败或审批展示混乱。
- **建议**: 在微服务数据库 Schema 升级脚本中明确为该表补充强力唯一主键及关联的 `UNIQUE` 索引限制。

### 5. 前端状态常量硬编码异味 (Status Literal Mismatch)
- **观察**: 家长端今日焦点视图（`daily-focus/index.vue`）中，硬编码了 `task.status === '1'` 判断已完成，而真实的后端微服务设计和打卡逻辑（`ParentTaskServiceImpl.java`）中，已完成/点亮的状态常量应为 `'2'`（完成待点亮）或 `'3'`（已点亮星）。
- **影响**: 导致孩子在微信或 APP 终端全部 100% 打卡后，家长的仪表盘右上角显示 `6/6 已完成`，但具体列表中所有的任务状态仍顽固显示为 `未完成`。
- **已处理**: 已将前端判定逻辑无缝修正为 `task.status === '2' || task.status === '3'`，实现完美自愈。

# Wiki Inbox (灵感与影子观察) [[INBOX.md]]

本文件用于存放影子分析时发现的项目改进点、灵感或非紧迫的技术债。

## [2026-04-08] 观察发现

### 1. 环境敏感的配置管理 (Environment-Sensitive Config)
- **观察**: `application-dev.yml` 中默认包含特定 IP (`192.168.1.21`)。
- **建议**: 为本地开发者提供 `application-local.yml` 模板（并加入 `.gitignore`），或将 `dev` 默认值统一设为 `localhost`。目前已手动更正为 `localhost`，但应考虑在 CI/CD 或 README 中标准化此配置引导。

### 2. 模块依赖透明度 (Maven Module Transparency)
- **观察**: 之前的 404 错误和今日的 `BaseController` 缺失，本质上都是因为 `admin` 模块对业务模块的依赖加载或编译顺序问题。
- **建议**:
    - 在 README 中增加“首次运行必须执行 `mvn clean install`”的提示。
    - 检查 `smallsteps-admin` 的 Maven 依赖是否使用了正确的作用域，确保在运行期所有业务 JAR 都能被打包进 Classpath。

### 3. 前端静态资源路由
- **观察**: Icon 缺失导致 404，虽然已补全，但这种基于文件路径的强依赖在多端适配时容易出错。
- **建议**: 是否可以引入统一的 `AssetManager` 或在各端构建时进行资源完整性检查。

### 4. UI 自动化测试环境准备 (Playwright)
- **观察**: [2026-04-08] 在执行 UI 自动化测试方案时，配置了 `autotests/20260408/ui_tests.js` 脚本。但在执行前，Playwright 需要下载 Chromium 浏览器内核，由于网络连接重置 (`ECONNRESET`) 导致下载失败并被取消，UI 测试任务已中断挂起。
- **建议 / 下一步行动**: 下次启动或继续任务时，需要优先解决 Playwright 浏览器内核的下载网络问题（例如配置代理或使用国内淘宝镜像源 `set PLAYWRIGHT_DOWNLOAD_HOST=https://npmmirror.com/mirrors/playwright/`），完成 `npx playwright install chromium` 安装后，继续执行 `node autotests/20260408/ui_tests.js` 以完成系统核心页面的截图回归测试。

## [2026-04-09] 观察发现

### 1. Docker Build 持久化执行 (Long-running Builds)
- **观察**: 本地镜像构建命令 `docker-compose build` 已运行超过 1 小时，且仍处于基础层下载阶段。
- **背景**: 基础 Docker 镜像（java/node）通常较大，在特定网络环境下极易导致会话中断或构建失败。
- **行动点**: 
    - **镜像预拉取**: 如果构建频繁失败，建议先手动执行 `docker pull node:20-alpine` 和 `docker pull eclipse-temurin:21-jdk-jammy`。
    - **持久化记录**: 记录当前 Command ID `78c8c2f7-a2f2-4644-9c48-838e9ea528dc`，以便下次进入会话后通过 `command_status` 确认结果。

## [2026-04-14] 观察发现

### 1. 论文版本间技术栈不一致风险
- **观察**: v2 论文描述使用 MySQL 8.0 + SnailJob + Lock4j，v4 论文描述使用 Postgres 15 + Redis SETNX。实际代码库可能只对应其中一个版本。
- **风险**: 答辩时导师若同时看到两版论文会发现矛盾。
- **建议**: 明确哪个版本对应实际部署代码，另一版标注为"架构演进前的早期设计"。

### 2. python-docx 格式局限性
- **观察**: `python-docx` 无法生成 `.doc`（旧版 Word 格式），仅支持 `.docx`。此外不支持自动生成目录（TOC 需在 Word 中手动刷新）和页眉页脚的完整控制。
- **建议**: 若学校收文系统严格要求 `.doc`，需用 `libreoffice --convert-to doc` 命令行转换。

### 3. 论文引用格式标准化
- **观察**: v2 与 v4 的参考文献格式在作者缩写和标点使用上存在微小差异，未严格统一为 GB/T 7714-2015。
- **建议**: 使用 Zotero 等文献管理工具统一导出，或在生成脚本中加入格式校验逻辑。

### 4. 论文 v3 的角色定位
- **观察**: `论文_v3.md` 是 v2 到 v4 的过渡版本，当前同时存在 v1/v2/v3/v4 四个 Markdown 源文件。
- **建议**: 归档 v1 和 v3 为历史版本（移至 `archive/` 子目录），仅保留 v2（备选）和 v4（主力提交）在工作目录。

## [2026-04-26] 观察发现

### 1. 家长端仪表盘数据聚合瓶颈 (Data Isolation & Mock Data)
- **观察**: `ParentInsightController` 中的多个关键数据（如雷达图能力值、最近7天情绪趋势）当前依赖硬编码的 Mock 数据，未与 `ss_child_ai` 真实业务表打通。
- **风险**: 若未经清理直接上线，家长端将展示完全错误和固定的分析数据。同时缺乏统一的数据隔离审计。
- **记录**: 已沉淀为 [[ADR-008-Data-Isolation-Audit]]。

### 2. AI 配置模块前端路由割裂 (Routing Fragmentation)
- **观察**: 系统中存在两套 AI 管理视图目录（`views/ai` 和 `views/system/ai`），导致侧边栏跳转 404，且对话框缺失 `context_window` 配置项。
- **风险**: 前端路由注册失败会导致配置页面完全不可达。
- **行动点**: 下一次前端开发阶段统一目录并清理冗余。

### 3. AI 思考过程引发的 JSON 解析异常 (AI Chat Timeout & JsonParseException)
- **观察**: 会话中出现了处理 AI 思维标签（如 `<think>`）时导致的 `JsonParseException`，同时前台响应时间限制在 75s 可能导致部分深度思考模型 Timeout。
- **记录**: 已沉淀为 [[ADR-009-AI-Chat-Timeout-JSON-Exception]]。
 
### 4. 开发环境下的流式响应截断 (SSE Streaming via Proxy)
- **观察**: 在 Uni-app H5 开发模式下，Vite Proxy 会缓冲或完全阻断 `text/event-stream` 类型的响应，且后端长等待（无首字节下发）会导致连接超时。
- **临时方案**: 前端代码中加入了针对 `localhost` 的绝对路径跳转（绕过代理），后端加入了初始空格块（SSE Pre-warming）。
- **建议**: 生产环境部署时，需在 Nginx 层配置 `proxy_set_header Connection ""; proxy_http_version 1.1; proxy_buffering off; proxy_cache off;`。
- **记录**: 已沉淀为 [[ADR-010-AI-Streaming-SSE-Optimization]]。

## [2026-04-28] 观察发现

### 1. 前端组件依赖鲁棒性 (Frontend Dependency Robustness)
- **观察**: `mp-html` 依赖缺失导致 500 错误，反映了在跨环境迁移或依赖更新时，`node_modules` 的状态未与 `package.json` 同步。
- **建议**: 
    - 确保 `npm install` 流程标准化。
    - 优化 `weekly-ai-report.vue` 等依赖外部渲染器的组件，增加加载状态与错误边界（Error Boundary）处理。

### 2. 现代 Sass API 兼容性 (Modern Sass API Compatibility)
- **观察**: `:deep(.dark) &` 在 Vite + Sass (modern API) 环境下导致编译失败（500 Internal Server Error）。
- **建议**: 
    - 统一组件内的暗黑模式实现范式，推荐使用 `.dark &` 或 CSS 变量。
    - 在 Wiki 中增加 [前端开发规范/暗黑模式篇]，明确禁止在 Scoped Style 中使用复杂的非标准深度选择器嵌套。

## [2026-05-05] 观察发现

### 1. 密钥管理脆弱性 (Secret Management Vulnerability)
- **观察**: 在 `application-dev.yml` 中发现了 Gitee Client Secret 和 Snail-Job Token 的明文记录。
- **风险**: 源码一旦泄露，第三方服务凭据将直接暴露。
- **行动点**: 强制要求本地开发使用外部配置中心或 `System.getenv()` 注入。

### 2. 硬件网络凭据硬编码
- **观察**: `smallsteps-esp32/config.py` 中直接写入了 `WIFI_PASS`。
- **建议**: 应引入 **SmartConfig** 或 **NFC 碰一碰** 配网方案，将 WiFi 凭据存入 ESP32 的 NVS (Non-volatile storage) 区域。

## [2026-05-08] 观察发现

### 1. 知识蒸馏 (Knowledge Distillation) 与团队技能固化
- **观察**: 在 [[同事skill]] 中讨论了如何提炼团队成员的隐性经验。这种“从人到 Skill”的转化是提升 AI Agent 专业度的核心路径。
- **建议**: 
    - 针对“ADHD 育儿干预”这一垂直领域，建立结构化的决策快照库。
    - 探索将高水平的回复范式转化为 Few-shot 示例，注入 AI 情感助手的 Prompt。

### 2. 后端驱动的数据真理 (Backend-Driven Data Truth)
- **观察**: 前端硬编码 `150` 星星余额导致用户认知偏差。
- **决定**: 确立了所有关键业务字段必须由后端实时提供的原则，前端应作为“无状态展示层”，避免逻辑 fallback。
- **记录**: 见 [[ADR-015-Backend-Driven-Data-Truth]]（待创建）。

### 3. AI 交互哲学：三段式响应范式 (Tri-Phase Response Paradigm)
- **观察**: 传统的 AI 回复往往过于“建议导向”，容易引发 ADHD 家长的防御心理（感到被指责）。
- **重构逻辑**: 针对 `PARENT_ASSISTANT_CHAT` 的 `AiServiceImpl.java` 实现了底层重构：
    1. **情感校验 (Validation)**: 严禁直接给建议，先让家长感到“被看见”。
    2. **去道德化重构 (Reframing)**: 将冲突从“态度问题”转向“生物学/执行功能障碍”。
    3. **微小介入 (Micro-Action)**: 给出的建议必须是原子级的物理动作。
- **意义**: 将 AI 从“管理工具”转变为家长的“情绪支点”与“认知外壳”。

## [2026-05-17] 影子观察发现

### 1. 跨端/跨生态数据绑定与排行榜交互一致性
- **观察**: 在多项目并发或跨端场景下（如观察到关联会话或平行空间中 `tth` 相关的 `detail.vue`, `rank/index.vue`, `GameUserServiceImpl.java` 以及荣誉勋章堆叠视觉标准），无论是商城详情页还是排行榜，都高度依赖底层数据源的稳定性与缺省表现。
- **建议 / 洞察**:
    - **缺省一致性**: 各类排行榜或荣誉勋章在后端数据未完全就绪或为空时，均应采用优雅降级（如字符占位或默认空数组展示），避免直接抛出白屏或未捕获的渲染异常。
    - **MapStruct 编译期检查**: 在多模块 Maven 项目中，极易因 `mapstruct-plus-processor` 编译期未及时生成目标映射类而导致隐蔽的运行时返回 `null`。建议在构建脚本或 CI 流水线中加入针对 `target/generated-sources` 产物的静态完整性校验机制。

## [2026-05-30] 观察发现

### 1. Prompt 注入安全与输入校验风险
- **观察**: 动态参数 `{content}` 直接填充进 Prompt，没有任何前置安全过滤。若输入中包含 Prompt Injection 词汇（如 "Ignore all previous instructions"），可能导致情绪分析 AI 被诱导失控。
- **建议**: 在 `AiServiceImpl` 中增加敏感词/注入指令拦截。

### 2. 场景化多模型路由扩展瓶颈
- **观察**: `sys_ai_route` 的主键为 `scene_key`，这意味着同一分析场景只能配置单一模型，限制了高可用下的备用模型 fallback 与 A/B Test 分流。
- **建议**: 应当将表主键变更为自增 `id`，并增加 `weight` 权重字段，以便实现更灵活的动态路由决策。

### 3. 本地化环境一致性与隔离
- **观察**: 将测试用例和环境完全迁移到 `localhost` 后，虽然消除了 staging VPN 超时问题，但测试运行在 headed 模式下依然会与本地数据库及 Redis 的存量脏数据产生相互竞争。
- **建议**: 增加自动化回归测试专属的隔离 DB Schema / Redis KeySpace 隔离机制，确保自动化质量门禁 100% 不受人工调试数据的干扰。

### 4. 数据库主键/唯一索引约束脆弱性 (Duplicate Primary Keys)
- **观察**: 在数据库中发现 `ss_parent_reward_redemption` 表的主键 `redemption_id` 物理上存在完全相同的重复记录（如主键为 `2060300000000000041` 的两条不同记录）。
- **风险**: 表定义时可能缺失 `PRIMARY KEY` 物理约束，或使用了不包含唯一性校验的软约束。测试数据自动注入或客户端重复提交可能导入垃圾数据，并引发管理后台的幂等性更新失败或审批展示混乱。
- **建议**: 在微服务数据库 Schema 升级脚本中明确为该表补充强力唯一主键及关联的 `UNIQUE` 索引限制。

### 5. 前端状态常量硬编码异味 (Status Literal Mismatch)
- **观察**: 家长端今日焦点视图（`daily-focus/index.vue`）中，硬编码了 `task.status === '1'` 判断已完成，而真实的后端微服务设计和打卡逻辑（`ParentTaskServiceImpl.java`）中，已完成/点亮的状态常量应为 `'2'`（完成待点亮）或 `'3'`（已点亮星）。
- **影响**: 导致孩子在微信或 APP 终端全部 100% 打卡后，家长的仪表盘右上角显示 `6/6 已完成`，但具体列表中所有的任务状态仍顽固显示为 `未完成`。
- **已处理**: 已将前端判定逻辑无缝修正为 `task.status === '2' || task.status === '3'`，实现完美自愈。

### 6. 全局提示组件未装载导致修改密码提示缺失 (Plugins Unregistered in Main.js)
- **观察**: `/pages/mine/pwd/index.vue` 中调用了 `proxy.$modal.msgSuccess` 和 `proxy.$modal.msgError`。然而在 `main.js` 中没有通过 `app.use(install)` 将 `plugins/index.js` 导入并挂载，导致运行时 `proxy.$modal` 恒为 `undefined`，密码修改成功后不仅没有任何成功的 Toast 提示，而且还会抛出未捕获异常导致控制流被阻断。
- **已处理**: 
  - 在 `main.js` 中补全了全局插件 `install` 的注册流程，打通了 `$modal`、`$tab` 和 `$auth` 的全局可用性，消除了整个 App 跨页面调用的安全隐患。
  - 重构了 `pwd/index.vue` 的提交响应流，在 `then` 和 `catch` 中补全了对“成功/失败”的视觉 Toast 确认，并设计了对原生 `uni.showToast` 的优雅 fallback 降级支持。

### 7. 儿童端“切换家长模式”快捷入口安全漏洞 (Parent-Gate Bypass Mitigation)
- **观察**: 儿童首页“家长之门”（`child/home/index.vue`）验证通过后，ActionSheet 中提供了“切回家长模式”的快捷操作。这让孩子容易通过猜测乘法答案（例如通过多次点击获取简单的乘法题），从而一键进入家长后台进行自我任务审批或余额篡改。
- **已处理**: 
  - 从 `itemList` 中彻底**隐藏并删除了“切回家长模式”**的选项，仅保留“退出当前登录”和“留在儿童首页”。
  - 修正了 `tapIndex` 点击索引对应的登出逻辑，实现纯净且严密的物理隔离。现在如需切回管理后台，必须执行完全退出并重新键入家长账户密码，极大地保障了儿童端数据的真实性。

### 8. Pinia 状态管理登出接口同步混淆与拼写大小写异味 (Pinia LogOut Promise & Case Sensitivity)
- **观察**: 在 `store/modules/user.ts` 中，`logOut()` 被定义为同步函数且未返回 Promise。而多个页面（如 `child/home/index.vue`、`setting/index.vue`、`mine/index.vue`）中，却硬编码了 `userStore.logOut().then(...)` 的异步回调，或混用拼写小写了 `userStore.logout()`。
- **影响**: 导致当用户点击“退出当前登录”时，在底层返回 `undefined` 或直接抛出 "logout is not a function" 运行时异常，使整个退出逻辑完全卡死失效。
- **已处理**:
  - 重写了 `logOut()` 动作为返回 `Promise<void>`，确保所有 `.then()` 与 `await` 回调机制在全系统瞬间对齐畅通。
  - 在 `user.ts` store 内部增加了一个小写 `logout()` 别名函数，实现强力的自动防错自愈，不论大写还是小写拼写均可完美支持。

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

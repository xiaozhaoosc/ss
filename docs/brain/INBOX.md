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

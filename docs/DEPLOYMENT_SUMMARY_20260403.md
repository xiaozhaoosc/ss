# SmallSteps 项目部署总结报告 (2026-04-03)

## 1. 部署概览
本次部署通过 `docker-compose` 统筹管理，成功实现了后端 API、管理后台 (UI) 及移动端 H5 (App) 的一键式构建与启动。

### 服务状态清单
| 服务名称 | 容器名称 | 外部端口 | 内部端口 | 状态 |
| :--- | :--- | :--- | :--- | :--- |
| 后端核心服务 | `ss-api` | 8081 | 8080 | 🟢 运行中 |
| 管理后台 (Web) | `ss-ui` | 8080 | 80 | 🟢 运行中 |
| 移动端 H5 | `ss-app` | 8082 | 80 | 🟢 运行中 |
| PostgreSQL | `ss-postgres` | 15432 | 5432 | 🟢 运行中 |
| Redis | `ss-redis` | 6379 | 6379 | 🟢 运行中 |

---

## 2. 关键修复事项

### 2.1 前端环境适配
*   **Node.js 版本升级**: 将 `smallsteps-ui` 和 `smallsteps-app` 的 Docker 基础镜像从 `18-alpine` 升级至 `20-alpine`。
    *   **原因**: 修复了由于低版本 Node.js 不支持 `node:util` 中的 `styleText` 导致的构建失败。
*   **路由导出修复**: 修正了 `smallsteps-ui/src/router/index.ts`。
    *   **动作**: 显式导出 `constantRoutes` 和 `dynamicRoutes`。
    *   **原因**: 解决了权限组件因找不到导出变量而导致的打包错误。

### 2.2 Maven 构建与依赖优化
*   **BOM 循环依赖修复**: 修改了 `smallsteps-common-bom` 的 `pom.xml`。
    *   **动作**: 移除了其对业务父项目的继承，并硬编码版本号为 `0.0.1`。
    *   **原因**: Maven 不允许根项目导入一个又继承自该根项目的 BOM 模块（循环引用）。
*   **依赖补全**: 在 `smallsteps-admin/pom.xml` 中手动添加了 `smallsteps-common-ai` 依赖及版本号 `${revision}`。
*   **构建策略调整**: 将 Dockerfile 中的 `mvn package -pl ...` 改为 `mvn clean install`。
    *   **原因**: 确保多模块项目下的本地依赖包能正确安装到临时容器的本地仓库中，避免“模块缺失”错误。

### 2.3 后端代码逻辑修正
*   **AI 模块补全**: 在 `smallsteps-common-ai` 模块中手动创建了 `OpenAIClient.java` 存根类。
    *   **原因**: 源码引用了该类但物理文件缺失，导致编译中断。
*   **实体类匹配**: 调整了 `AiRouterServiceImpl.java`。
    *   **动作**: 将非标准的 `setModelId` / `setModelName` 修正为符合 `AiModel` 实体的 `setId` / `setName`。
*   **类型转换**: 在调用 AI 接口时，增加了 `String.valueOf(model.getId())` 强制转换，解决了 `Long` 与 `String` 类型不匹配问题。

---

## 3. 运行验证
*   **启动耗时**: 后端服务 `SmallStepsApplication` 在 6.314 秒内完成初始化。
*   **数据库连接**: HikariPool 已成功建立与 PostgreSQL 的连接。
*   **系统组件**: OSS 配置初始化成功，SSE 监听器正常启动。

## 4. 维护建议
1.  **AI 模块落地**: 目前 `OpenAIClient` 为存根实现，正式环境需接入实际的 API Provider（如 OpenAI、DeepSeek 等）。
2.  **镜像加速**: 构建过程中若遇到 `403` 或下载缓慢，建议在 Docker 宿主机配置稳定镜像源或使用代理。

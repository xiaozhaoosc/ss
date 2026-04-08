# ADR-001: 恢复后端核心业务模块挂载

## 状态
已接受 (Accepted)

## 上下文 (Context)
在 2026-04-08 的排查中发现，`smallsteps-admin` 控制台无法响应 `/parent/task/list` 等业务接口，返回 404。经查，后端代码库中虽然存在 `smallsteps-parent` 模块及其 Controller，但在项目的入口模块 `smallsteps-admin` 的 `pom.xml` 中，这些依赖被注释掉了。

这导致 `smallsteps-admin` 构建生成的 JAR 包中不包含具体的业务逻辑类。

## 决策 (Decision)
在 `smallsteps-admin/pom.xml` 中重新引入以下依赖：
- `smallsteps-parent`
- `smallsteps-child`
- `smallsteps-job`
- `smallsteps-generator`
- `smallsteps-demo`
- `smallsteps-workflow`

## 后果 (Consequences)
- **正面**: 恢复了所有 REST API 接口的正常访问。
- **负面**: 增加了编译后的 JAR 包体积，且增加了应用启动时的 Bean 扫描负载（约增加 200-500ms 启动时间）。
- **后续**: 如果需要实现模块化可选加载，建议引入 Maven Profiles 机制，由环境变量控制编译范围，而不是直接修改代码。

## 关联
- [[2026-04-08]] (Journal)

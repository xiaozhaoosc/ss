# SATS - Integration & CI/CD Pipeline

## 1. 自动化流水线概述
SATS 测试套件被集成到持续集成流程中，每个 Pull Request (PR) 和代码合并动作都会触发自动化验证。

## 2. GitHub Actions 工作流设计

### 2.1 触发策略
- **Push**: `main`, `develop` 分支。
- **PR**: 目标分支为 `main`, `develop` 的所有 PR。
- **Scheduled**: 每日凌晨进行全量回归测试。

### 2.2 工作流步骤 (以 Backend 为例)
```yaml
jobs:
  test:
    runs-on: ubuntu-latest
    services:
      postgres: { image: postgres:15-alpine }
      redis: { image: redis:7-alpine }
    steps:
      - uses: actions/checkout@v4
      - name: Run SATS-API Tests
        run: mvn test -Dspring.profiles.active=test
      - name: Generate Allure Report
        run: mvn allure:report
      - name: Upload Report
        uses: actions/upload-artifact@v4
        with: { path: target/site/allure-maven-plugin }
```

## 3. 测试环境编排 (Docker)
- 使用 `docker-compose.test.yml` 定义最小化测试环境。
- 自动化脚本应具备自动启动容器、运行测试、清理环境的能力。

## 4. 缺陷追踪与通知
- **测试失败**: 自动向 DingTalk/Lark 发送告警，包含测试报告链接。
- **测试报告**: 报告中需包含失败时的屏幕截图 (UI) 和接口调用链路日志 (API).

## 5. 指标看板
- 定期统计各模块的通过率趋势。
- 将 JaCoCo 覆盖率报告发布至 Codecov 或 SonarQube。

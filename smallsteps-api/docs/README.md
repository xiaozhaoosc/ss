# Small Steps API 文档

## 项目概述

Small Steps API 是 Small Steps 系统的后端服务，基于 Java Spring Boot 框架（RuoYi-Vue-Plus）开发，为前端应用和硬件设备提供数据接口和业务逻辑支持。

### 核心功能

- **用户管理**：家长和儿童用户的注册、登录、权限管理
- **任务管理**：任务创建、分配、执行、进度跟踪
- **奖励系统**：奖励配置、发放、兑换
- **数据分析**：儿童行为数据收集和分析
- **设备管理**：硬件设备的注册、配置、状态管理
- **AI 服务**：任务拆解、情绪分析与干预

## 技术栈

- **框架**：Java Spring Boot
- **数据库**：PostgreSQL
- **缓存**：Redis
- **消息队列**：RabbitMQ
- **认证**：Sa-Token
- **ORM**：MyBatis Plus

## 项目结构

```
smallsteps-api/
├── smallsteps-admin/        # 管理后台
├── smallsteps-common/       # 公共模块
│   ├── smallsteps-ai/       # AI 相关功能
│   ├── smallsteps-common-core/    # 核心功能
│   ├── smallsteps-common-security/ # 安全相关
│   └── ...
├── smallsteps-extend/       # 扩展模块
│   ├── smallsteps-monitor-admin/   # 监控管理
│   └── smallsteps-snailjob-server/ # 任务调度
├── smallsteps-modules/      # 业务模块
│   ├── smallsteps-child/    # 儿童相关
│   ├── smallsteps-parent/   # 家长相关
│   ├── smallsteps-system/   # 系统管理
│   └── ...
├── dockers/                 # Docker 部署配置
├── script/                  # 脚本工具
└── docs/                    # 文档目录
```

## 快速开始

### 环境要求

- JDK 17+
- Maven 3.8+
- PostgreSQL 14+
- Redis 6+
- RabbitMQ 3.8+

### 本地开发

1. **克隆代码**

```bash
git clone <repository-url>
cd smallsteps-api
```

2. **配置数据库**

创建 PostgreSQL 数据库，并执行 `script/sql/ry_vue_5.X.sql` 初始化表结构。

3. **配置环境变量**

修改 `smallsteps-admin/src/main/resources/application-dev.yml` 中的数据库连接信息。

4. **编译项目**

```bash
mvn clean install
```

5. **启动服务**

运行 `SmallStepsApplication.java` 启动应用。

### Docker 部署

```bash
# 构建镜像
docker build -t smallsteps-api .

# 运行容器
docker run -d --name smallsteps-api -p 8080:8080 smallsteps-api
```

## API 文档

服务启动后，可通过以下地址访问 API 文档：

- Swagger UI: `http://localhost:8080/doc.html`

## 开发指南

### 代码规范

- 遵循 Java 代码规范
- 使用 IDE 格式化工具保持代码风格一致
- 提交代码前运行 `mvn checkstyle:check` 检查代码风格

### 开发流程

1. 从 `develop` 分支创建功能分支
2. 编写代码和测试
3. 提交代码并创建 Pull Request
4. 代码审查
5. 合并到 `develop` 分支

## 部署指南

### 生产环境

1. **配置环境变量**

修改 `smallsteps-admin/src/main/resources/application-prod.yml` 中的配置。

2. **构建生产包**

```bash
mvn clean package -Pprod
```

3. **部署到服务器**

使用 Docker Compose 部署：

```bash
cd dockers
docker-compose up -d
```

## 监控与维护

- **日志管理**：日志文件位于 `logs` 目录
- **监控系统**：可通过 `smallsteps-monitor-admin` 模块查看系统状态
- **常见问题**：参考 [常见问题文档](FAQ.md)

## 贡献指南

1. Fork 项目
2. 创建功能分支
3. 提交更改
4. 创建 Pull Request

## 许可证

[MIT License](LICENSE)

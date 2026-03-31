# SmallSteps 项目 Docker 部署文档

本文档描述了 SmallSteps 项目的 Docker 部署方案，包括完整的服务栈配置和运行说明。

## 📁 目录结构

```
docs/dockers/
├── docker-compose.yml      # 主 Docker Compose 配置文件
├── .env.example           # 环境变量示例文件
├── nginx/                 # Nginx 配置目录
│   └── nginx.conf         # Nginx 反向代理配置
├── sql/                   # 数据库初始化脚本目录
│   └── init.sql           # PostgreSQL 初始化脚本
└── readme.md              # 本文档
```

## 🚀 服务栈组成

| 服务名称 | 服务类型 | 容器名称 | 版本标签 | 主要职责 |
|---------|---------|---------|---------|--------|
| gateway | 前端接入 | ss-gateway | small-steps-ui:0.0.1 | Nginx 反向代理，前端静态文件 |
| backend-core | 后端服务 | ss-api | small-steps-api:0.0.1 | SmallSteps API 核心服务 |
| postgres | 数据库 | ss-postgres | postgres:15-alpine | 关系型数据库 |
| redis | 缓存 | ss-redis | redis:7-alpine | 缓存和会话存储 |
| rabbitmq | 消息队列 | ss-rabbitmq | rabbitmq:3-management-alpine | 异步消息处理 |
| emqx | IoT  broker | ss-emqx | emqx:5.3.0 | MQTT 消息代理 |
| minio | 对象存储 | ss-minio | minio:latest | 文件和媒体存储 |
| n8n | 工作流编排 | ss-n8n | n8nio:latest | 业务流程自动化 |

## 🔧 环境配置

### 1. 环境变量配置

在运行前，请复制 `.env.example` 文件为 `.env` 并根据实际情况修改配置：

```bash
cp .env.example .env
```

主要配置项说明：

- `PROJECT_NAME`: 项目名称，用于 Docker 网络和容器前缀
- `TZ`: 时区设置，建议设置为 `Asia/Shanghai`
- `PORT_NGINX`: Nginx 对外端口
- `PORT_EMQX_TCP`, `PORT_EMQX_WS`, `PORT_EMQX_DASHBOARD`: EMQX 相关端口
- `PORT_MINIO_API`, `PORT_MINIO_CONSOLE`: MinIO 相关端口
- `PORT_N8N`: n8n 工作流平台端口
- `POSTGRES_USER`, `POSTGRES_PASSWORD`, `POSTGRES_DB`: PostgreSQL 数据库配置
- `REDIS_PASSWORD`: Redis 密码
- `RABBITMQ_USER`, `RABBITMQ_PASSWORD`: RabbitMQ 配置
- `EMQX_USER`, `EMQX_PASSWORD`: EMQX 配置
- `MINIO_ROOT_USER`, `MINIO_ROOT_PASSWORD`: MinIO 配置
- `N8N_USER`, `N8N_PASSWORD`: n8n 配置
- `DOCKER_IMAGE_PREFIX`: Docker 镜像前缀（用于中国大陆网络加速）

### 2. 版本管理

本配置使用固定版本标签，确保部署的一致性：

- 前端 UI: `small-steps-ui:0.0.1`
- 后端 API: `small-steps-api:0.0.1`

版本号与 Maven `pom.xml` 文件保持一致。

## 📦 构建与运行

### 1. 构建镜像

```bash
# 在 docs/dockers 目录下执行
docker compose build

docker-compose -f .\docker-compose.yml up -d --build gateway

# 方式一：分步构建（推荐）
docker-compose -f .\docker-compose.yml build --build-arg USE_BUILD=true backend-core
docker-compose -f .\docker-compose.yml up -d backend-core

# 方式二：通过环境变量传参（需先修改 docker-compose.yml）
# PowerShell:
# $env:USE_BUILD="true"; docker-compose -f .\docker-compose.yml up -d --build backend-core



```

### 2. 启动服务

```bash
# 启动所有服务
docker compose up -d

# 查看服务状态
docker compose ps

# 查看服务日志
docker compose logs -f
```

### 3. 停止服务

```bash
docker compose down

# 停止并清理数据卷
docker compose down -v
```

## 🌐 访问地址

| 服务 | 访问地址 | 说明 |
|-----|---------|------|
| 前端应用 | http://localhost:${PORT_NGINX} | 通过 Nginx 访问 |
| 后端 API | http://localhost:8080 | 直接访问后端服务 |
| PostgreSQL | localhost:15432 | 数据库连接端口 |
| Redis | localhost:6379 | 缓存服务端口 |
| RabbitMQ 管理 | http://localhost:15672 | 消息队列管理界面 |
| EMQX 管理 | http://localhost:${PORT_EMQX_DASHBOARD} | MQTT  broker 管理界面 |
| MinIO 控制台 | http://localhost:${PORT_MINIO_CONSOLE} | 对象存储管理界面 |
| n8n 工作流 | http://localhost:${PORT_N8N} | 工作流编排平台 |

## 🧪 测试验证

### 1. 服务健康检查

```bash
# 检查所有服务状态
docker compose ps

# 检查特定服务日志
docker compose logs backend-core
```

### 2. API 测试

使用 curl 测试后端 API 是否正常响应：

```bash
# 测试后端服务是否启动
timeout 30 bash -c 'until curl -s http://localhost:8080/actuator/health; do echo "Waiting for API..."; sleep 2; done'

# 查看 API 健康状态
curl -s http://localhost:8080/actuator/health | jq
```

### 3. 前端测试

打开浏览器访问前端地址：
```
http://localhost:${PORT_NGINX}
```

## ⚠️ 常见问题排查

### 1. 端口冲突

如果遇到端口冲突，请修改 `.env` 文件中的端口配置，或停止占用相应端口的其他服务。

### 2. 数据库连接问题

- 检查 PostgreSQL 服务是否正常运行
- 验证数据库用户名和密码配置
- 查看 `init.sql` 脚本是否正确执行

### 3. Redis 连接问题

- 检查 Redis 服务是否正常运行
- 验证 Redis 密码配置
- 检查网络连接是否正常

### 4. 镜像拉取失败

如果在中国大陆网络环境下遇到镜像拉取慢的问题，请在 `.env` 文件中配置 Docker 镜像加速前缀：

```
DOCKER_IMAGE_PREFIX=docker.m.daocloud.io/
```

### 5. 构建失败

- 检查 Maven 构建是否成功（后端）
- 检查前端构建是否成功（前端）
- 验证 Dockerfile 路径是否正确

## 📝 版本历史

| 版本 | 日期 | 变更说明 |
|-----|------|--------|
| 0.0.1 | 2024-07 | 初始版本，使用固定版本标签 |

## 📄 许可证

MIT License

---

**注意**: 本部署方案适用于开发、测试和生产环境。在生产环境中，请确保修改默认密码和配置以提高安全性。
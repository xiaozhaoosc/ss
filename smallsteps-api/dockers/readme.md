# Docker 运行方案说明

## 环境配置方案

### 1. 开发环境 - 外挂方式

**适用场景**：日常开发、代码调试、配置修改

**实现方式**：修改 `docker-compose.yml` 文件，为 `backend-core` 服务添加卷挂载

```yaml
backend-core:
  <<: *common-opts
  container_name: ss-api
  build:
    context: ..
    dockerfile: smallsteps-admin/Dockerfile
    tags:
      - small-steps-backend-core:0.0.1
  volumes:
    # 外挂 jar 包
    - ../smallsteps-admin/target:/app
    # 外挂配置文件
    - ../smallsteps-admin/src/main/resources:/app/config
    # 外挂日志目录
    - ./logs:/app/logs
  environment:
    - TZ=${TZ}
    - DB_HOST=postgres
    # 其他环境变量...
```

**启动命令**：
```bash
# 1. 先构建 jar 包
mvn clean package -DskipTests

# 2. 启动 Docker 服务
docker-compose up -d
```

**优点**：
- 代码修改后重新构建 jar 包即可生效，无需重新构建 Docker 镜像
- 可以直接修改本地配置文件，实时生效
- 日志直接输出到本地目录，便于查看和分析
- 资源节省，无需频繁构建和推送 Docker 镜像

### 2. 测试/生产环境 - 成品包方式

**适用场景**：测试验证、生产部署

**实现方式**：使用完整的 Docker 镜像，包含所有依赖和配置

**启动命令**：
```bash
# 1. 构建 Docker 镜像
docker-compose build

# 2. 启动 Docker 服务
docker-compose up -d
```

**优点**：
- 一致性：确保每个环境的部署都是完全相同的
- 可靠性：镜像包含所有依赖，减少运行时错误
- 安全性：可以对镜像进行扫描和验证
- 可移植性：镜像可以在任何 Docker 环境中运行
- 版本控制：每个版本对应一个唯一的镜像标签

## 目录结构

```
dockers/
├── .env                    # 环境变量配置
├── docker-compose.yml      # Docker 服务配置
├── logs/                   # 开发环境日志目录
└── readme.md               # 本说明文件
```

## 环境变量说明

### 1. 使用 .env 文件管理环境变量

所有环境变量都通过 `.env` 文件进行配置，位于 `dockers/.env` 文件中。这种方式的优势：

- **集中管理**：所有配置集中在一个文件中，便于管理和修改
- **环境分离**：不同环境可以使用不同的配置文件
- **安全管理**：敏感信息可以从代码仓库中分离
- **灵活性**：可以根据需要快速切换配置

### 2. 主要环境变量

**数据库配置**：
- `POSTGRES_USER`：PostgreSQL 用户名
- `POSTGRES_PASSWORD`：PostgreSQL 密码
- `POSTGRES_DB`：PostgreSQL 数据库名
- `DB_HOST`：数据库主机地址
- `DB_PORT`：数据库端口

**Redis 配置**：
- `REDIS_PASSWORD`：Redis 密码
- `REDIS_HOST`：Redis 主机地址
- `REDIS_PORT`：Redis 端口

**其他配置**：
- `PROJECT_NAME`：项目名称
- `TZ`：时区设置
- `SNAIL_JOB_SERVER_HOST`：SnailJob 服务器主机
- `SNAIL_JOB_SERVER_PORT`：SnailJob 服务器端口

### 3. 环境分离建议

为不同环境创建不同的 .env 文件：

- **开发环境**：`.env.dev`
- **测试环境**：`.env.test`
- **生产环境**：`.env.prod`

**使用方式**：
```bash
# 使用开发环境配置
docker-compose --env-file .env.dev up -d

# 使用生产环境配置
docker-compose --env-file .env.prod up -d
```

### 4. 敏感信息管理

对于生产环境的敏感信息，建议使用 Docker secrets 或环境变量注入：

**Docker secrets 示例**：
```yaml
services:
  backend-core:
    secrets:
      - db_password
      - redis_password
    environment:
      - DB_PASS_FILE=/run/secrets/db_password
      - REDIS_PASS_FILE=/run/secrets/redis_password

secrets:
  db_password:
    external: true
  redis_password:
    external: true
```

### 5. 环境变量优化

将所有环境相关的配置都集中到 `.env` 文件中，修改 `docker-compose.yml` 文件：

```yaml
environment:
  - TZ=${TZ}
  - DB_HOST=${DB_HOST}
  - DB_PORT=${DB_PORT}
  - DB_NAME=${POSTGRES_DB}
  - DB_USER=${POSTGRES_USER}
  - DB_PASS=${POSTGRES_PASSWORD}
  - REDIS_HOST=${REDIS_HOST}
  - REDIS_PORT=${REDIS_PORT}
  - REDIS_PASS=${REDIS_PASSWORD}
  # SnailJob Server Configuration
  - SNAIL_JOB_SERVER_HOST=${SNAIL_JOB_SERVER_HOST}
  - SNAIL_JOB_SERVER_PORT=${SNAIL_JOB_SERVER_PORT}
```

**修改 .env 文件**，添加相应的变量：
```env
# 数据库配置
DB_HOST=postgres
DB_PORT=5432

# Redis 配置
REDIS_HOST=redis
REDIS_PORT=6379

# SnailJob 配置
SNAIL_JOB_SERVER_HOST=smallsteps-snailjob-server
SNAIL_JOB_SERVER_PORT=17888
```

## 服务端口

| 服务名称    | 端口号 | 说明           |
|------------|--------|----------------|
| backend-core | 8081   | 后端 API 服务   |
| postgres   | 5432   | PostgreSQL 数据库 |
| redis      | 6379   | Redis 缓存服务  |

## 常见问题

### 1. 端口冲突
如果本地 8081 端口已被占用，可以修改 `docker-compose.yml` 文件中的端口映射：

```yaml
ports:
  - "8082:8080"  # 修改为其他端口
```

### 2. Redis 启动失败
如果 Redis 服务因 RDB 格式版本问题启动失败，可以删除旧的数据卷：

```bash
docker volume rm small-steps_redis_data
docker-compose up -d
```

### 3. 构建速度慢
可以在 `.env` 文件中配置国内镜像加速：

```
DOCKER_IMAGE_PREFIX=docker.m.daocloud.io/
```

## 版本管理

Docker 镜像版本与 `pom.xml` 中的版本号保持一致：
- 当前版本：0.0.1
- 镜像标签：small-steps-backend-core:0.0.1

## 部署建议

1. **开发环境**：使用外挂方式，提高开发效率
2. **测试环境**：使用成品包方式，模拟生产环境
3. **生产环境**：使用成品包方式，确保稳定性和可靠性

## 维护命令

```bash
# 查看服务状态
docker-compose ps

# 查看服务日志
docker-compose logs [service-name]

# 停止服务
docker-compose down

# 重启服务
docker-compose restart
```
# XiaoZhi ESP32 Server Java 部署所需资料清单

## 1. 基础环境

### 1.1 系统要求
- **最低配置**：
  - 2核CPU
  - 2GB RAM
  - 10GB 存储空间
  - 注：此配置不适用于本地语音识别，需添加第三方识别 API

- **推荐配置**：
  - 2核CPU
  - 4GB RAM
  - 20GB+ 存储空间
  - 适用于本地语音识别，建议使用较小的 Vosk 模型

- **大型语音模型配置**：
  - 4核CPU
  - 8GB RAM
  - 30GB+ 存储空间
  - 适用于本地语音识别，可使用较大的 Vosk 模型

### 1.2 软件依赖
- [Docker](https://docs.docker.com/get-docker/)
- [Docker Compose](https://docs.docker.com/compose/install/)

## 2. 项目文件

### 2.1 核心文件
- 项目源代码（git clone）：`https://github.com/joey-zhou/xiaozhi-esp32-server-java/`
- Docker 配置文件：
  - `Dockerfile-mysql`
  - `Dockerfile-node`
  - `Dockerfile-server`
  - `docker-compose.yml`

### 2.2 配置文件
- 后端配置：
  - `src/main/resources/application.yml`
  - `src/main/resources/application-dev.yml`
  - `src/main/resources/application-prod.yml`

- 前端配置：
  - `web/.env.development`
  - `web/.env.production`
  - `web/.env.local.example`

### 2.3 数据库文件
- 数据库初始化脚本：
  - `db/init.sql`
  - `db/2025_12_17.sql`
  - `database/migration_sa_token.sql`

### 2.4 模型文件
- 语音识别模型：
  - `models/silero_vad.onnx`
- 语音识别依赖库：
  - `lib/libonnxruntime.so`
  - `lib/libvosk.dylib`

## 3. 网络配置

### 3.1 端口需求
- MySQL：13306
- 前端 Node 服务：8084
- 后端 Java 服务：8091

### 3.2 网络访问
- 前端界面：http://localhost:8084
- 后端 API：http://localhost:8091
- WebSocket 服务：ws://宿主机IP:8091/ws/xiaozhi/v1/

### 3.3 防火墙设置
- 确保上述端口在防火墙中开放
- ESP32 设备连接时需使用宿主机实际 IP 地址

## 4. 环境变量

### 4.1 主要环境变量
- `VOSK_MODEL_SIZE`：语音识别模型大小，可选值：
  - "small"（默认，下载快，识别效果一般）
  - "standard"（下载慢，识别效果好）

### 4.2 数据库配置
- 数据库地址：`jdbc:mysql://mysql:3306/xiaozhi`
- 用户名：`xiaozhi`
- 密码：`123456`

### 4.3 前端配置
- API 地址：`http://server:8091`

## 5. 持久化数据

### 5.1 持久化卷
- `mysql_data`：MySQL 数据库数据
- `maven_repo`：Maven 仓库缓存
- `vosk_models`：Vosk 语音识别模型缓存

### 5.2 数据备份
- 定期备份 `mysql_data` 卷
- 备份重要配置文件

## 6. 部署步骤

### 6.1 基本部署
1. 克隆项目代码
2. 启动 Docker 容器：`docker-compose up -d`
3. 访问应用：http://localhost:8084

### 6.2 自定义部署
- 修改端口映射：编辑 `docker-compose.yml` 文件中的 `ports` 部分
- 修改环境变量：在启动命令中设置，如 `VOSK_MODEL_SIZE=standard docker-compose up -d`

### 6.3 故障排除
- 检查容器状态：`docker-compose ps`
- 查看日志：`docker-compose logs <service_name>`
- 重建容器：`docker-compose build --no-cache && docker-compose up -d`

## 7. 服务组成

### 7.1 核心服务
- **MySQL**：数据库服务
- **Node**：前端服务
- **Server**：后端 Java 服务
- **Redis**：缓存服务

### 7.2 服务依赖关系
- Node 和 Server 服务依赖 MySQL 服务
- Server 服务依赖 Redis 服务

## 8. 其他注意事项

### 8.1 首次部署
- 首次启动需要较长时间，因为需要下载 Docker 镜像、构建应用程序并下载相关依赖
- 数据库会自动初始化

### 8.2 更新应用
- 拉取最新代码：`git pull`
- 重新构建并启动容器：`docker-compose build && docker-compose up -d`

### 8.3 性能优化
- 根据实际硬件配置选择合适的 Vosk 模型大小
- 调整 JVM 内存参数以优化 Java 服务性能

### 8.4 安全考虑
- 生产环境中应修改默认数据库密码
- 配置 HTTPS 以增强安全性
- 限制外部访问端口
---
name: deploy-template
description: 项目打包部署通用模板 - Maven/前端构建、SCP上传、Docker重启（适用于 Spring Boot + Vue 项目）
triggers:
  - "项目部署"
  - "打包部署"
  - "deploy project"
  - "docker 部署"
---

# 项目打包部署通用模板

> **📋 使用说明**
> - 这是**全局模板**，提供通用的部署流程
> - 首次使用时，运行 `~/.hermes/scripts/copy-deploy-template.sh <项目路径>` 复制到项目
> - 项目级副本会优先加载，请在项目副本中修改配置
> - 全局模板保持通用，不包含项目特定配置

---

## 🎯 快速开始

### 方式一：自动复制（推荐）

```bash
# 复制模板到项目
~/.hermes/scripts/copy-deploy-template.sh /path/to/your/project

# 编辑项目级配置
vim /path/to/your/project/.hermes/skills/deploy/SKILL.md
```

### 方式二：手动复制

```bash
# 创建项目 skill 目录
mkdir -p /path/to/your/project/.hermes/skills/deploy/

# 复制全局模板
cp ~/.hermes/skills/devops/deploy-template/SKILL.md \
   /path/to/your/project/.hermes/skills/deploy/SKILL.md
```

---

## ⚙️ 配置区域

**Small Steps 项目配置**（已预填）：

| 配置项 | 说明 | 当前值 |
|--------|------|--------|
| `PROJECT_NAME` | 项目名称 | Small Steps |
| `PROJECT_ROOT` | 项目根目录 | /home/ken4zhao/Documents/office/jushuang1/github/ss |
| `SERVER_HOST` | 服务器地址 | 10.8.0.1 |
| `SERVER_USER` | SSH 用户名 | root |
| `SERVER_SSH_PORT` | SSH 端口 | 2216 |
| `REMOTE_DEPLOY_DIR` | 服务器部署目录 | /opt/smallsteps |
| `DOCKER_COMPOSE_FILE` | docker-compose 文件路径 | ./docker-compose.yml |

---

## 🚀 部署流程

### 阶段一：环境检查

**⚠️ 需要用户确认**

```bash
# 1. 检查 SSH 连接
ssh -p ${SERVER_SSH_PORT} ${SERVER_USER}@${SERVER_HOST} "echo 'SSH OK'"

# 2. 检查本地环境
java -version    # 需要 Java 17/21
node -v          # 需要 Node 18+
mvn -v           # 需要 Maven 3.8+
```

**请确认 SSH 端口号和连接正常后回复"开始打包"**

---

### 阶段二：本地打包

#### Step 1: Maven 打包后端

```bash
cd ${PROJECT_ROOT}/smallsteps-api

# 清理并打包（跳过测试）
mvn clean package -DskipTests

# 验证产物
ls -lh smallsteps-admin/target/*.jar
```

**预期产物**: `smallsteps-admin.jar` (约 80-100MB)

---

#### Step 2: 构建 Web 管理后台

```bash
cd ${PROJECT_ROOT}/smallsteps-ui

# 安装依赖
npm install

# 生产构建
npm run build:prod

# 验证产物
ls -lh dist/
```

**预期产物**: `dist/` 目录

---

#### Step 3: 构建 H5 移动端

```bash
cd ${PROJECT_ROOT}/smallsteps-app

# 安装依赖
npm install

# 构建 H5
npm run build:h5

# 验证产物
ls -lh dist/build/h5/
```

**预期产物**: `dist/build/h5/` 目录

---

### 阶段三：SCP 上传

**⚠️ 需要用户确认**

**请确认 SSH 连接正常后回复"确认上传"**

---

#### Step 4: 创建远程目录

```bash
ssh -p ${SERVER_SSH_PORT} ${SERVER_USER}@${SERVER_HOST} \
    "mkdir -p ${REMOTE_DEPLOY_DIR}/{api,ui,app}"
```

---

#### Step 5: 上传后端 JAR

```bash
scp -P ${SERVER_SSH_PORT} \
    ${PROJECT_ROOT}/smallsteps-api/smallsteps-admin/target/smallsteps-admin.jar \
    ${SERVER_USER}@${SERVER_HOST}:${REMOTE_DEPLOY_DIR}/api/
```

---

#### Step 6: 上传 Web UI

```bash
scp -P ${SERVER_SSH_PORT} -r \
    ${PROJECT_ROOT}/smallsteps-ui/dist/* \
    ${SERVER_USER}@${SERVER_HOST}:${REMOTE_DEPLOY_DIR}/ui/
```

---

#### Step 7: 上传 H5 APP

```bash
scp -P ${SERVER_SSH_PORT} -r \
    ${PROJECT_ROOT}/smallsteps-app/dist/build/h5/* \
    ${SERVER_USER}@${SERVER_HOST}:${REMOTE_DEPLOY_DIR}/app/
```

---

### 阶段四：Docker 部署

**⚠️ 需要用户确认**

**请确认以下事项后回复"确认重启"：**
1. 数据库已备份（如需要）
2. 确认重启时间窗口
3. 端口已开放

---

#### Step 8: 上传 Docker 配置

```bash
# 上传 docker-compose.yml
scp -P ${SERVER_SSH_PORT} \
    ${PROJECT_ROOT}/docker-compose.yml \
    ${SERVER_USER}@${SERVER_HOST}:${REMOTE_DEPLOY_DIR}/

# 上传环境变量文件（如有）
scp -P ${SERVER_SSH_PORT} \
    ${PROJECT_ROOT}/.env \
    ${SERVER_USER}@${SERVER_HOST}:${REMOTE_DEPLOY_DIR}/ 2>/dev/null || true
```

---

#### Step 9: 停止旧容器

```bash
ssh -p ${SERVER_SSH_PORT} ${SERVER_USER}@${SERVER_HOST} \
    "cd ${REMOTE_DEPLOY_DIR} && docker-compose down"
```

---

#### Step 10: 启动新容器

```bash
ssh -p ${SERVER_SSH_PORT} ${SERVER_USER}@${SERVER_HOST} \
    "cd ${REMOTE_DEPLOY_DIR} && docker-compose up -d"
```

---

#### Step 11: 验证部署

```bash
# 检查容器状态
ssh -p ${SERVER_SSH_PORT} ${SERVER_USER}@${SERVER_HOST} \
    "docker ps | grep ss-"

# 检查服务健康
ssh -p ${SERVER_SSH_PORT} ${SERVER_USER}@${SERVER_HOST} \
    "curl -s -o /dev/null -w '%{http_code}' http://localhost:8080/ssapi || echo 'API 启动中...'"
```

---

## 🔄 一键部署脚本

创建项目级 `deploy.sh`：

```bash
#!/bin/bash
set -e

# ========== Small Steps 项目配置 ==========
PROJECT_NAME="Small Steps"
PROJECT_ROOT="/home/ken4zhao/Documents/office/jushuang1/github/ss"
SERVER_HOST="10.8.0.1"
SERVER_USER="root"
SERVER_SSH_PORT="22"              # ⚠️ 请确认实际端口
REMOTE_DEPLOY_DIR="/opt/smallsteps"
# ==========================================

echo "🚀 开始部署 ${PROJECT_NAME}..."

# 1. Maven 打包
echo "📦 [1/5] 打包后端 API..."
cd ${PROJECT_ROOT}/smallsteps-api
mvn clean package -DskipTests

# 2. 构建 Web UI
echo "🎨 [2/5] 构建管理后台..."
cd ${PROJECT_ROOT}/smallsteps-ui
npm run build:prod

# 3. 构建 H5
echo "📱 [3/5] 构建 H5 移动端..."
cd ${PROJECT_ROOT}/smallsteps-app
npm run build:h5

# 4. 上传到服务器
echo "📤 [4/5] 上传到服务器..."
SSH_CMD="ssh -p ${SERVER_SSH_PORT} ${SERVER_USER}@${SERVER_HOST}"
SCP_CMD="scp -P ${SERVER_SSH_PORT}"

${SSH_CMD} "mkdir -p ${REMOTE_DEPLOY_DIR}/{api,ui,app}"

${SCP_CMD} ${PROJECT_ROOT}/smallsteps-api/smallsteps-admin/target/*.jar \
    ${SERVER_USER}@${SERVER_HOST}:${REMOTE_DEPLOY_DIR}/api/

${SCP_CMD} -r ${PROJECT_ROOT}/smallsteps-ui/dist/* \
    ${SERVER_USER}@${SERVER_HOST}:${REMOTE_DEPLOY_DIR}/ui/

${SCP_CMD} -r ${PROJECT_ROOT}/smallsteps-app/dist/build/h5/* \
    ${SERVER_USER}@${SERVER_HOST}:${REMOTE_DEPLOY_DIR}/app/

# 上传 Docker 配置
${SCP_CMD} ${PROJECT_ROOT}/docker-compose.yml \
    ${SERVER_USER}@${SERVER_HOST}:${REMOTE_DEPLOY_DIR}/

# 5. 重启 Docker
echo "🐳 [5/5] 重启 Docker 服务..."
${SSH_CMD} "cd ${REMOTE_DEPLOY_DIR} && docker-compose down && docker-compose up -d"

echo ""
echo "✅ 部署完成！"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "管理后台: http://${SERVER_HOST}:80"
echo "移动端:   http://${SERVER_HOST}:81"
echo "API:      http://${SERVER_HOST}:8080/ssapi"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
```

---

## 📁 项目目录结构

部署后服务器目录结构：

```
${REMOTE_DEPLOY_DIR}/
├── docker-compose.yml
├── .env                    # 环境变量
├── api/
│   └── smallsteps-admin.jar
├── ui/
│   ├── index.html
│   └── assets/
└── app/
    ├── index.html
    └── assets/
```

---

## 🔙 回滚方案

```bash
# SSH 登录服务器
ssh -p ${SERVER_SSH_PORT} ${SERVER_USER}@${SERVER_HOST}

# 进入部署目录
cd ${REMOTE_DEPLOY_DIR}

# 停止新容器
docker-compose down

# 恢复旧版本文件（需提前备份）
cp -r /opt/backup/api/* ./api/
cp -r /opt/backup/ui/* ./ui/
cp -r /opt/backup/app/* ./app/

# 重新启动
docker-compose up -d
```

---

## 🛠️ 常见问题

### 1. Maven 打包失败
```bash
# 清理缓存
rm -rf ~/.m2/repository/com/kenzhao
mvn clean package -DskipTests -U
```

### 2. npm 构建失败
```bash
# 清理依赖
rm -rf node_modules package-lock.json
npm install
npm run build:h5
```

### 3. Docker 启动失败
```bash
# 查看日志
docker-compose logs <service_name>

# 检查端口
netstat -tlnp | grep -E '8080|80|81'

# 强制重建
docker-compose up -d --force-recreate
```

### 4. SCP 传输中断
```bash
# 使用 rsync 支持续传
rsync -avz --progress -e "ssh -p ${SERVER_SSH_PORT}" \
    ${PROJECT_ROOT}/smallsteps-api/smallsteps-admin/target/*.jar \
    ${SERVER_USER}@${SERVER_HOST}:${REMOTE_DEPLOY_DIR}/api/
```

---

## 📊 端口映射表

| 服务 | 容器名 | 内部端口 | 外部端口 | 说明 |
|------|--------|----------|----------|------|
| PostgreSQL | ss-postgres | 5432 | 15432 | 数据库 |
| Redis | ss-redis | 6379 | 6379 | 缓存 |
| Backend API | ss-api | 8080 | 8080 | 后端服务 |
| Web Admin | ss-ui | 80 | 80 | 管理后台 |
| Mobile App | ss-app | 80 | 81 | H5移动端 |

---

## ✅ 部署检查清单

- [ ] Java 17/21 环境就绪
- [ ] Node.js 18+ 环境就绪
- [ ] SSH 公钥已部署到服务器
- [ ] 服务器 Docker 已安装
- [ ] 服务器磁盘空间充足（建议 2GB+）
- [ ] 防火墙端口已开放（80、81、8080、15432、6379）
- [ ] 数据库已备份（如需要）

---

*模板版本: 1.0*
*最后更新: 2026-05-28*
*适用项目: Spring Boot + Vue + UniApp*
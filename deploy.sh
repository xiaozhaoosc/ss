#!/bin/bash
set -e

# ========== Small Steps 项目配置 ==========
PROJECT_NAME="Small Steps"
PROJECT_ROOT="/home/ken4zhao/Documents/office/jushuang1/github/ss"
SERVER_HOST="10.8.0.1"
SERVER_USER="ken3zhao"
SERVER_SSH_PORT="2216"
REMOTE_BASE_DIR="/home/ken3zhao/smallsteps_rsync"
# ==========================================

echo "🚀 开始部署 ${PROJECT_NAME}..."
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"

# 颜色定义
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m'

# SSH 和 SCP 命令
SSH_CMD="ssh -p ${SERVER_SSH_PORT} ${SERVER_USER}@${SERVER_HOST}"
SCP_CMD="scp -P ${SERVER_SSH_PORT}"

# 检查 SSH 连接
echo -e "${YELLOW}[0/6] 检查 SSH 连接...${NC}"
if ! ${SSH_CMD} "echo 'SSH OK'" > /dev/null 2>&1; then
    echo -e "${RED}❌ SSH 连接失败${NC}"
    exit 1
fi
echo -e "${GREEN}✅ SSH 连接正常${NC}"

# 1. Maven 打包后端
echo ""
echo -e "${YELLOW}[1/6] 📦 打包后端 API...${NC}"
cd ${PROJECT_ROOT}/smallsteps-api
mvn clean package -DskipTests
echo -e "${GREEN}✅ 后端打包完成${NC}"

# 2. 构建 Web 管理后台
echo ""
echo -e "${YELLOW}[2/6] 🎨 构建管理后台...${NC}"
cd ${PROJECT_ROOT}/smallsteps-ui
npm run build:prod
echo -e "${GREEN}✅ 管理后台构建完成${NC}"

# 3. 构建 H5 移动端
echo ""
echo -e "${YELLOW}[3/6] 📱 构建 H5 移动端...${NC}"
cd ${PROJECT_ROOT}/smallsteps-app
npm run build:h5
echo -e "${GREEN}✅ H5 移动端构建完成${NC}"

# 4. 创建远程目录（如不存在）
echo ""
echo -e "${YELLOW}[4/6] 📂 确认远程目录...${NC}"
${SSH_CMD} "mkdir -p ${REMOTE_BASE_DIR}/smallsteps-api"
${SSH_CMD} "mkdir -p ${REMOTE_BASE_DIR}/smallsteps-ui/dist"
${SSH_CMD} "mkdir -p ${REMOTE_BASE_DIR}/smallsteps-ui/dist/webadminss"
echo -e "${GREEN}✅ 远程目录就绪${NC}"

# 5. 上传文件
echo ""
echo -e "${YELLOW}[5/6] 📤 上传文件到服务器...${NC}"

echo "  → 上传后端 JAR..."
${SCP_CMD} ${PROJECT_ROOT}/smallsteps-api/smallsteps-admin/target/smallsteps-admin.jar \
    ${SERVER_USER}@${SERVER_HOST}:${REMOTE_BASE_DIR}/smallsteps-api/

echo "  → 上传 H5 移动端..."
${SCP_CMD} -r ${PROJECT_ROOT}/smallsteps-app/dist/build/h5/* \
    ${SERVER_USER}@${SERVER_HOST}:${REMOTE_BASE_DIR}/smallsteps-ui/dist/

echo "  → 上传管理后台..."
${SCP_CMD} -r ${PROJECT_ROOT}/smallsteps-ui/dist/* \
    ${SERVER_USER}@${SERVER_HOST}:${REMOTE_BASE_DIR}/smallsteps-ui/dist/webadminss/

echo "  → 上传 Docker 配置..."
${SCP_CMD} ${PROJECT_ROOT}/docker-compose.yml \
    ${SERVER_USER}@${SERVER_HOST}:${REMOTE_BASE_DIR}/

# 检查 .env 文件
if [ -f "${PROJECT_ROOT}/.env" ]; then
    echo "  → 上传环境变量文件..."
    ${SCP_CMD} ${PROJECT_ROOT}/.env \
        ${SERVER_USER}@${SERVER_HOST}:${REMOTE_BASE_DIR}/
fi

echo -e "${GREEN}✅ 文件上传完成${NC}"

# 6. 重启 Docker
echo ""
echo -e "${YELLOW}[6/6] 🐳 重启 Docker 服务...${NC}"
${SSH_CMD} "cd ${REMOTE_BASE_DIR} && docker-compose -f docker-compose.yml down && docker-compose -f docker-compose.yml up -d"

# 验证状态
echo ""
echo -e "${YELLOW}📊 验证部署状态...${NC}"
${SSH_CMD} "cd ${REMOTE_BASE_DIR} && docker-compose -f docker-compose.yml ps"

echo ""
echo -e "${GREEN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e "${GREEN}✅ ${PROJECT_NAME} 部署完成！${NC}"
echo -e "${GREEN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo ""
echo "📊 服务访问地址："
echo "   • 管理后台: http://${SERVER_HOST}:80"
echo "   • 移动端:   http://${SERVER_HOST}:81"
echo "   • API:      http://${SERVER_HOST}:8080/ssapi"
echo ""
echo "📋 测试账号："
echo "   • 管理后台: admin / admin123"
echo "   • 家长端:   parent_zhang / admin123"
echo "   • 儿童端:   child_xiaoming / admin123"
echo ""
echo "🔧 常用命令："
echo "   • 查看日志: ssh -p ${SERVER_SSH_PORT} ${SERVER_USER}@${SERVER_HOST} 'cd ${REMOTE_BASE_DIR} && docker-compose logs -f'"
echo "   • 查看状态: ssh -p ${SERVER_SSH_PORT} ${SERVER_USER}@${SERVER_HOST} 'cd ${REMOTE_BASE_DIR} && docker-compose ps'"
echo "   • 重启服务: ssh -p ${SERVER_SSH_PORT} ${SERVER_USER}@${SERVER_HOST} 'cd ${REMOTE_BASE_DIR} && docker-compose restart'"

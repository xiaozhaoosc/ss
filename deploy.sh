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

# 颜色定义
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
BLUE='\033[0;34m'
NC='\033[0m'

# SSH 和 SCP 命令
SSH_CMD="ssh -p ${SERVER_SSH_PORT} ${SERVER_USER}@${SERVER_HOST}"
SCP_CMD="scp -P ${SERVER_SSH_PORT}"
RSYNC_CMD="rsync -avz --progress -e 'ssh -p ${SERVER_SSH_PORT}'"

# 临时目录
TEMP_DIR="/tmp/ss-deploy-$$"
mkdir -p ${TEMP_DIR}

# 日志函数
log_info() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

log_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

log_warn() {
    echo -e "${YELLOW}[WARN]${NC} $1"
}

log_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# 清理函数
cleanup() {
    log_info "清理临时文件..."
    rm -rf ${TEMP_DIR}
}
trap cleanup EXIT

# 检查 SSH 连接
check_ssh() {
    log_info "检查 SSH 连接..."
    if ! ${SSH_CMD} "echo 'SSH OK'" > /dev/null 2>&1; then
        log_error "SSH 连接失败"
        exit 1
    fi
    log_success "SSH 连接正常"
}

# 创建远程目录
create_remote_dirs() {
    log_info "创建远程目录..."
    ${SSH_CMD} "mkdir -p ${REMOTE_BASE_DIR}/{smallsteps-api,smallsteps-ui/dist/webadminss}"
}

# Docker 重启
restart_docker() {
    log_info "重启 Docker 服务..."
    ${SSH_CMD} "cd ${REMOTE_BASE_DIR} && docker-compose -f docker-compose.yml down"
    ${SSH_CMD} "cd ${REMOTE_BASE_DIR} && docker-compose -f docker-compose.yml up -d"
    
    log_info "验证部署状态..."
    ${SSH_CMD} "cd ${REMOTE_BASE_DIR} && docker-compose -f docker-compose.yml ps"
    
    echo ""
    log_success "${PROJECT_NAME} 部署完成！"
    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    echo "📊 服务访问地址："
    echo "   • 管理后台: http://${SERVER_HOST}:8043/webadminss/#"
    echo "   • 移动端:   http://${SERVER_HOST}:8043/#"
    echo "   • API:      http://${SERVER_HOST}:8081/ssapi"
    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
}

# 部署后端 API
deploy_api() {
    log_info "📦 [1/2] 打包后端 API..."
    cd ${PROJECT_ROOT}/smallsteps-api
    mvn clean package -DskipTests -q
    
    log_info "📦 [2/2] 压缩并上传后端 JAR..."
    # 压缩 JAR（压缩率约 10-15%）
    cd ${PROJECT_ROOT}/smallsteps-api/smallsteps-admin/target
    tar czf ${TEMP_DIR}/smallsteps-admin.tar.gz smallsteps-admin.jar
    
    # 上传并解压
    ${SCP_CMD} ${TEMP_DIR}/smallsteps-admin.tar.gz ${SERVER_USER}@${SERVER_HOST}:${REMOTE_BASE_DIR}/smallsteps-api/
    ${SSH_CMD} "cd ${REMOTE_BASE_DIR}/smallsteps-api && tar xzf smallsteps-admin.tar.gz && rm smallsteps-admin.tar.gz"
    
    log_success "后端 API 部署完成"
}

# 部署 Web 管理后台
deploy_ui() {
    log_info "🎨 [1/2] 构建管理后台..."
    cd ${PROJECT_ROOT}/smallsteps-ui
    node node_modules/vite/bin/vite.js build --mode production > /dev/null 2>&1
    
    log_info "🎨 [2/2] 压缩并上传管理后台..."
    # 压缩 dist 目录
    cd ${PROJECT_ROOT}/smallsteps-ui
    tar czf ${TEMP_DIR}/webadminss.tar.gz -C dist .
    
    # 上传并解压
    ${SCP_CMD} ${TEMP_DIR}/webadminss.tar.gz ${SERVER_USER}@${SERVER_HOST}:${REMOTE_BASE_DIR}/smallsteps-ui/dist/webadminss/
    ${SSH_CMD} "cd ${REMOTE_BASE_DIR}/smallsteps-ui/dist/webadminss && tar xzf webadminss.tar.gz && rm webadminss.tar.gz"
    
    log_success "管理后台部署完成"
}

# 部署 H5 移动端
deploy_app_h5() {
    log_info "📱 [1/2] 构建 H5 移动端..."
    cd ${PROJECT_ROOT}/smallsteps-app
    chmod +x node_modules/.bin/uni
    npm run build:h5 > /dev/null 2>&1
    
    log_info "📱 [2/2] 压缩并上传 H5 移动端..."
    # 压缩 h5 目录
    cd ${PROJECT_ROOT}/smallsteps-app/dist/build/h5
    tar czf ${TEMP_DIR}/app-h5.tar.gz .
    
    # 上传并解压到 dist 根目录
    ${SCP_CMD} ${TEMP_DIR}/app-h5.tar.gz ${SERVER_USER}@${SERVER_HOST}:${REMOTE_BASE_DIR}/smallsteps-ui/dist/
    ${SSH_CMD} "cd ${REMOTE_BASE_DIR}/smallsteps-ui/dist && tar xzf app-h5.tar.gz && rm app-h5.tar.gz"
    
    log_success "H5 移动端部署完成"
}

# 规范化命令（支持 /ss-xxx 和 -ss-xxx 两种格式）
normalize_command() {
    local cmd="$1"
    # 去掉前导 / 或 -，统一为 ss-xxx
    cmd="${cmd#/}"
    cmd="${cmd#-}"
    case "$cmd" in
        ss-all)     echo "/ss-all" ;;
        ss-api)     echo "/ss-api" ;;
        ss-ui)      echo "/ss-ui" ;;
        ss-app:h5)  echo "/ss-app:h5" ;;
        *)          echo "$1" ;;  # 原样返回（help 等）
    esac
}

# 显示帮助
show_help() {
    echo "Small Steps 部署脚本"
    echo ""
    echo "用法: $0 [命令]"
    echo ""
    echo "命令:（支持 / 或 - 前缀）"
    echo "  -ss-all       部署全部（后端 + 管理后台 + H5移动端）"
    echo "  -ss-api       仅部署后端 API"
    echo "  -ss-ui        仅部署管理后台"
    echo "  -ss-app:h5    仅部署 H5 移动端"
    echo "  help          显示此帮助信息"
    echo ""
    echo "示例:"
    echo "  $0 -ss-all      # 完整部署"
    echo "  $0 -ss-api      # 只更新后端"
    echo "  $0 -ss-ui       # 只更新管理后台"
    echo "  $0 -ss-app:h5   # 只更新移动端"
    echo ""
    echo "  也兼容旧格式: $0 /ss-api"
}

# 主函数
main() {
    local raw_command="${1:--ss-all}"
    local command
    command=$(normalize_command "$raw_command")
    
    echo "🚀 开始部署 ${PROJECT_NAME}..."
    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    
    # 检查 SSH
    check_ssh
    
    # 创建远程目录
    create_remote_dirs
    
    case "$command" in
        /ss-all)
            log_info "执行完整部署..."
            deploy_api
            deploy_ui
            deploy_app_h5
            restart_docker
            ;;
        /ss-api)
            log_info "仅部署后端 API..."
            deploy_api
            restart_docker
            ;;
        /ss-ui)
            log_info "仅部署管理后台..."
            deploy_ui
            restart_docker
            ;;
        /ss-app:h5)
            log_info "仅部署 H5 移动端..."
            deploy_app_h5
            restart_docker
            ;;
        help|--help|-h)
            show_help
            exit 0
            ;;
        *)
            log_error "未知命令: $raw_command"
            show_help
            exit 1
            ;;
    esac
}

# 执行主函数
main "$@"

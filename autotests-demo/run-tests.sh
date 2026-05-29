#!/bin/bash
# Small Steps 自动化测试运行脚本
# 用法: bash run-tests.sh [ui|app|all] [headed|headless]
# 示例: bash run-tests.sh all headed
#       bash run-tests.sh ui headless

set -e

SS_DIR="/home/ken4zhao/Documents/office/jushuang1/github/ss"
DEMO_DIR="$SS_DIR/autotests-demo"
ORIG_DIR="$SS_DIR/autotests"

MODE="${1:-all}"
DISPLAY_MODE="${2:-headed}"

# 颜色
GREEN='\033[0;32m'
RED='\033[0;31m'
BLUE='\033[0;34m'
NC='\033[0m'

# 设置 NVM
export NVM_DIR="/home/ken4zhao/.nvm"
source "$NVM_DIR/nvm.sh" 2>/dev/null || true

# 设置显示
if [ "$DISPLAY_MODE" = "headed" ]; then
    export DISPLAY=:10
    echo -e "${BLUE}🖥️  有头模式 (DISPLAY=:10)${NC}"
else
    echo -e "${BLUE}🔇 无头模式${NC}"
fi

run_ui_tests() {
    local dir="$1"
    local label="$2"
    echo ""
    echo -e "${BLUE}━━━ $label: 管理后台 UI 测试 ━━━${NC}"
    cd "$dir/sats-ui"
    
    if [ "$DISPLAY_MODE" = "headless" ]; then
        npx playwright test --reporter=list --headed=false 2>&1 || true
    else
        npx playwright test --reporter=list 2>&1 || true
    fi
}

run_app_tests() {
    local dir="$1"
    local label="$2"
    echo ""
    echo -e "${BLUE}━━━ $label: H5 移动端测试 ━━━${NC}"
    cd "$dir/sats-app"
    
    if [ "$DISPLAY_MODE" = "headless" ]; then
        npx playwright test --reporter=list --headed=false 2>&1 || true
    else
        npx playwright test --reporter=list 2>&1 || true
    fi
}

echo "🚀 Small Steps 自动化测试"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━"

case "$MODE" in
    ui)
        run_ui_tests "$DEMO_DIR" "DEMO"
        ;;
    app)
        run_app_tests "$DEMO_DIR" "DEMO"
        ;;
    all)
        run_ui_tests "$DEMO_DIR" "DEMO"
        run_app_tests "$DEMO_DIR" "DEMO"
        ;;
    compare)
        run_ui_tests "$ORIG_DIR" "原始"
        run_app_tests "$ORIG_DIR" "原始"
        run_ui_tests "$DEMO_DIR" "DEMO"
        run_app_tests "$DEMO_DIR" "DEMO"
        ;;
    *)
        echo "用法: $0 [ui|app|all|compare] [headed|headless]"
        echo "  ui       - 仅运行管理后台 UI 测试"
        echo "  app      - 仅运行 H5 移动端测试"
        echo "  all      - 运行全部 (默认)"
        echo "  compare  - 原始 vs DEMO 对比运行"
        exit 1
        ;;
esac

echo ""
echo -e "${GREEN}━━━ 测试完成 ━━━${NC}"
echo "📊 UI 报告: $DEMO_DIR/sats-ui/playwright-report/index.html"
echo "📊 APP 报告: $DEMO_DIR/sats-app/playwright-report/index.html"

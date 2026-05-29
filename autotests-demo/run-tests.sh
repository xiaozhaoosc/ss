#!/bin/bash
# Small Steps 自动化测试 - Linux 版
# 用法: bash run-tests.sh [ui|app|all] [headed|headless]
# 示例: bash run-tests.sh all headed
#       bash run-tests.sh ui headless

set -e

SS_DIR="$(cd "$(dirname "$0")/.." && pwd)"
DEMO_DIR="$SS_DIR/autotests-demo"

MODE="${1:-all}"
DISPLAY_MODE="${2:-headed}"

# 颜色
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
NC='\033[0m'

# 设置 NVM
export NVM_DIR="/home/ken4zhao/.nvm"
source "$NVM_DIR/nvm.sh" 2>/dev/null || true

# 设置显示模式
export DISPLAY_MODE
if [ "$DISPLAY_MODE" = "headed" ]; then
    export DISPLAY=:10
    echo -e "${BLUE}🖥️  有头模式 (DISPLAY=:10)${NC}"
else
    echo -e "${BLUE}🔇 无头模式${NC}"
fi

run_tests() {
    local dir="$1"
    local label="$2"
    echo ""
    echo -e "${BLUE}━━━ $label 测试 ━━━${NC}"
    cd "$dir"
    npx playwright test --reporter=list 2>&1 || true
}

echo "🚀 Small Steps 自动化测试"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━"

case "$MODE" in
    ui)
        run_tests "$DEMO_DIR/sats-ui" "管理后台 UI"
        ;;
    app)
        run_tests "$DEMO_DIR/sats-app" "H5 移动端"
        ;;
    all)
        run_tests "$DEMO_DIR/sats-ui" "管理后台 UI"
        run_tests "$DEMO_DIR/sats-app" "H5 移动端"
        ;;
    *)
        echo "用法: $0 [ui|app|all] [headed|headless]"
        exit 1
        ;;
esac

echo ""
echo -e "${GREEN}━━━ 测试完成 ━━━${NC}"
echo "📊 UI 报告: $DEMO_DIR/sats-ui/playwright-report/index.html"
echo "📊 APP 报告: $DEMO_DIR/sats-app/playwright-report/index.html"

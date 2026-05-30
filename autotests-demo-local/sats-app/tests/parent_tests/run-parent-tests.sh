#!/bin/bash
# 家长端测试运行脚本
# 用法: bash run-parent-tests.sh [test-file] [headed|headless]

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

if [ "$DISPLAY_MODE" = "headed" ] || [ "$2" = "headed" ]; then
  export DISPLAY_MODE=headed
  export DISPLAY=:10
  echo "🖥️  有头模式 (DISPLAY=:10)"
else
  export DISPLAY_MODE=headless
  echo "🔇 无头模式"
fi

echo "🚀 家长端功能测试"
echo "━━━━━━━━━━━━━━━━━━━━━━"

cd "$SCRIPT_DIR"

if [ -n "$1" ]; then
  npx playwright test "$1" --config=playwright.config.ts --reporter=list
else
  npx playwright test --config=playwright.config.ts --reporter=list
fi

echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━"
echo "📊 报告: $SCRIPT_DIR/../playwright-report-parent/index.html"

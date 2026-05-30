#!/bin/bash
# 儿童端自动化测试运行脚本
cd "$(dirname "$0")"
export DISPLAY_MODE=${1:-headless}
npx playwright test --config=playwright.config.ts 2>&1

@echo off
chcp 65001 >nul 2>&1
setlocal enabledelayedexpansion

:: ============================================
:: Small Steps 自动化测试 - Windows 版
:: 用法: run-tests.bat [ui|app|all] [headed|headless]
:: 示例: run-tests.bat all headed
::       run-tests.bat ui headless
:: ============================================

set "SS_DIR=%~dp0"
set "DEMO_DIR=%SS_DIR%autotests-demo"

set "MODE=%~1"
set "DISPLAY_MODE=%~2"
if "%MODE%"=="" set "MODE=all"
if "%DISPLAY_MODE%"=="" set "DISPLAY_MODE=headed"

echo.
echo 🚀 Small Steps 自动化测试 (Windows)
echo ━━━━━━━━━━━━━━━━━━━━━━━━━━

:: 检查 Node.js
where node >nul 2>&1
if errorlevel 1 (
    echo ❌ 未找到 Node.js，请先安装: https://nodejs.org/
    pause
    exit /b 1
)
echo ✅ Node.js: 
node --version

:: 检查 Playwright
cd /d "%DEMO_DIR%\sats-ui"
if not exist "node_modules\@playwright" (
    echo.
    echo 📦 安装测试依赖...
    cd /d "%DEMO_DIR%\sats-ui" && npm install
    cd /d "%DEMO_DIR%\sats-app" && npm install
)

:: 安装 Playwright 浏览器（如果需要）
cd /d "%DEMO_DIR%\sats-ui"
npx playwright install chromium 2>nul

echo.
echo 模式: %DISPLAY_MODE%
echo ━━━━━━━━━━━━━━━━━━━━━━━━━━

if "%MODE%"=="ui" (
    call :run_tests "%DEMO_DIR%\sats-ui" "管理后台 UI"
    goto :done
)
if "%MODE%"=="app" (
    call :run_tests "%DEMO_DIR%\sats-app" "H5 移动端"
    goto :done
)
if "%MODE%"=="all" (
    call :run_tests "%DEMO_DIR%\sats-ui" "管理后台 UI"
    call :run_tests "%DEMO_DIR%\sats-app" "H5 移动端"
    goto :done
)

echo 用法: %~nx0 [ui^|app^|all] [headed^|headless]
echo   ui       - 仅运行管理后台 UI 测试
echo   app      - 仅运行 H5 移动端测试
echo   all      - 运行全部 (默认)
echo   headed   - 有头模式，显示浏览器 (默认)
echo   headless - 无头模式，后台运行
pause
exit /b 1

:done
echo.
echo ━━━━━━━━━━━━━━━━━━━━━━━━━━
echo 📊 UI 报告: %DEMO_DIR%\sats-ui\playwright-report\index.html
echo 📊 APP 报告: %DEMO_DIR%\sats-app\playwright-report\index.html
echo.
pause
exit /b 0

:: ============================================
:: 运行测试函数
:: ============================================
:run_tests
set "TEST_DIR=%~1"
set "TEST_NAME=%~2"

echo.
echo ━━━ %TEST_NAME% 测试 ━━━
cd /d "%TEST_DIR%"

if "%DISPLAY_MODE%"=="headless" (
    npx playwright test --reporter=list --headed=false
) else (
    npx playwright test --reporter=list
)
goto :eof

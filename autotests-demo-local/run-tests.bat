@echo off
setlocal enabledelayedexpansion

:: ============================================
:: Small Steps Auto Test - Windows
:: Usage: run-tests.bat [ui|app|all] [headed|headless]
:: ============================================

set "DEMO_DIR=%~dp0"
if "%DEMO_DIR:~-1%"=="\" set "DEMO_DIR=%DEMO_DIR:~0,-1%"

set "MODE=%~1"
set "DISPLAY_MODE=%~2"
if "%MODE%"=="" set "MODE=all"
if "%DISPLAY_MODE%"=="" set "DISPLAY_MODE=headed"

echo.
echo Small Steps Auto Test (Windows)
echo ------------------------------------------------

:: Check Node.js
where node >nul 2>&1
if errorlevel 1 (
    echo [ERROR] Node.js not found. Install from https://nodejs.org/
    pause
    exit /b 1
)
echo [OK] Node.js:
node --version

:: Check & install dependencies
if not exist "%DEMO_DIR%\sats-ui\node_modules\@playwright" (
    echo.
    echo Installing dependencies...
    cd /d "%DEMO_DIR%\sats-ui" && call npm install
    cd /d "%DEMO_DIR%\sats-app" && call npm install
)

:: Install Playwright browsers if needed
cd /d "%DEMO_DIR%\sats-ui"
call npx playwright install chromium 2>nul

echo.
echo Mode: %DISPLAY_MODE%
echo ------------------------------------------------

if "%MODE%"=="ui" (
    call :run_tests "%DEMO_DIR%\sats-ui" "Management UI"
    goto :done
)
if "%MODE%"=="app" (
    call :run_tests "%DEMO_DIR%\sats-app" "H5 Mobile"
    goto :done
)
if "%MODE%"=="all" (
    call :run_tests "%DEMO_DIR%\sats-ui" "Management UI"
    call :run_tests "%DEMO_DIR%\sats-app" "H5 Mobile"
    goto :done
)

echo Usage: %~nx0 [ui^|app^|all] [headed^|headless]
echo   ui       - Management UI tests only
echo   app      - H5 Mobile tests only
echo   all      - All tests (default)
echo   headed   - Show browser window (default)
echo   headless - Run in background
pause
exit /b 1

:done
echo.
echo ------------------------------------------------
echo UI Report: %DEMO_DIR%\sats-ui\playwright-report\index.html
echo APP Report: %DEMO_DIR%\sats-app\playwright-report\index.html
echo.
pause
exit /b 0

:: ============================================
:: Run tests function
:: ============================================
:run_tests
set "TEST_DIR=%~1"
set "TEST_NAME=%~2"

echo.
echo ========== %TEST_NAME% ==========
cd /d "%TEST_DIR%"

if "%DISPLAY_MODE%"=="headless" (
    call npx playwright test --reporter=list
) else (
    call npx playwright test --reporter=list --headed
)
goto :eof

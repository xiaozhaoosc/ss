@echo off
chcp 65001 >nul
echo.
echo ==========================================
echo   Markdown to Word 转换工具
echo ==========================================
echo.

REM 检查 pandoc 是否安装
where pandoc >nul 2>nul
if %errorlevel% neq 0 (
    echo [错误] 未找到 pandoc，请先安装 pandoc
    echo [下载] https://pandoc.org/installing.html
    echo.
    pause
    exit /b 1
)

echo [信息] 正在将 md 文件转换为 Word 文档...
echo.

REM 调用 PowerShell 脚本
powershell -ExecutionPolicy Bypass -File "%~dp0md2word.ps1"

echo.
pause

@echo off
chcp 65001 >nul
echo.
echo ==========================================
echo   V10 论文 Markdown to Word 转换工具
echo ==========================================
echo.

REM 检查 Python 是否安装
python --version >nul 2>nul
if %errorlevel% neq 0 (
    echo [错误] 未找到 Python，请先安装 Python
    echo [下载] https://www.python.org/downloads/
    echo.
    pause
    exit /b 1
)

REM 检查 python-docx 是否安装
python -c "import docx" >nul 2>nul
if %errorlevel% neq 0 (
    echo [信息] 正在安装 python-docx 库...
    pip install python-docx
    if %errorlevel% neq 0 (
        echo [错误] 安装 python-docx 失败
        echo [提示] 请手动运行: pip install python-docx
        pause
        exit /b 1
    )
)

echo [信息] 正在将 论文_v10.md 转换为 Word 文档...
echo.

REM 运行 Python 脚本
python "%~dp0md2word.py"

if %errorlevel% equ 0 (
    echo.
    echo [完成] 转换完成！
) else (
    echo.
    echo [错误] 转换失败！
)

echo.
pause

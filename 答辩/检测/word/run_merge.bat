@echo off
chcp 65001 >nul
echo ========================================
echo Word文档合并工具
echo ========================================
echo.

REM 检查Python是否安装
python --version >nul 2>&1
if errorlevel 1 (
    echo 错误: 未找到Python，请先安装Python
    pause
    exit /b 1
)

REM 检查python-docx库是否安装
python -c "import docx" >nul 2>&1
if errorlevel 1 (
    echo 正在安装python-docx库...
    pip install python-docx
    if errorlevel 1 (
        echo 安装python-docx失败，请手动运行: pip install python-docx
        pause
        exit /b 1
    )
)

echo 正在运行合并脚本...
echo.
python merge_word_docs.py

echo.
echo ========================================
echo 按任意键退出...
pause >nul

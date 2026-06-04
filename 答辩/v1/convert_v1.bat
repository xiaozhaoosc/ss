@echo off
chcp 65001 >nul
echo.
echo ==========================================
echo   V1 论文 Markdown to Word 转换工具
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

echo [信息] 正在将 论文_v1.md 转换为 Word 文档...
echo.

REM 使用 PowerShell 执行 pandoc 转换
powershell -Command "pandoc -f markdown -t docx --toc --highlight-style=tango '%~dp0论文_v1.md' -o '%~dp0论文_v1.docx'"

if %errorlevel% equ 0 (
    echo.
    echo [成功] 转换完成！
    echo [输出] 论文_v1.docx
    echo.

    REM 显示文件信息
    powershell -Command "(Get-Item '%~dp0论文_v1.docx') | Select-Object Name, Length, LastWriteTime"
) else (
    echo.
    echo [错误] 转换失败！
)

echo.
pause

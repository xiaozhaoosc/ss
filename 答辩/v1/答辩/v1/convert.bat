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

REM 使用 pandoc 转换
pandoc -f markdown -t docx --toc --highlight-style=tango "论文_v1.md" -o "论文_v1.docx"

if %errorlevel% equ 0 (
    echo.
    echo [成功] 转换完成！
    echo [输出] 论文_v1.docx
    echo.

    REM 显示文件信息
    for %%I in (论文_v1.docx) do (
        echo [信息] 文件大小: %%~zI bytes
        echo [信息] 修改时间: %%~tI
    )
) else (
    echo.
    echo [错误] 转换失败！
)

echo.
pause

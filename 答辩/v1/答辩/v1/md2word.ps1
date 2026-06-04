# Markdown to Word 转换脚本
# 使用 pandoc 将 md 文件转换为 docx 格式

param(
    [string]$InputFile = "论文_v1.md",
    [string]$OutputFile = "论文_v1.docx"
)

# 获取脚本所在目录
$ScriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$InputPath = Join-Path $ScriptDir $InputFile
$OutputPath = Join-Path $ScriptDir $OutputFile

Write-Host "=========================================="
Write-Host "  Markdown to Word 转换工具"
Write-Host "=========================================="
Write-Host ""

# 检查输入文件是否存在
if (-not (Test-Path $InputPath)) {
    Write-Host "[错误] 找不到输入文件: $InputPath" -ForegroundColor Red
    exit 1
}

Write-Host "[信息] 输入文件: $InputFile" -ForegroundColor Cyan
Write-Host "[信息] 输出文件: $OutputFile" -ForegroundColor Cyan
Write-Host ""

# 创建参考文档（可选，用于自定义Word样式）
$ReferenceDoc = Join-Path $ScriptDir "reference.docx"
$UseReference = Test-Path $ReferenceDoc

if ($UseReference) {
    Write-Host "[信息] 使用参考文档: reference.docx" -ForegroundColor Yellow
    $RefParam = "--reference-doc=$ReferenceDoc"
} else {
    Write-Host "[提示] 未找到 reference.docx，使用默认样式" -ForegroundColor Yellow
    Write-Host "       如需自定义样式，请创建 reference.docx 文件" -ForegroundColor Gray
    $RefParam = ""
}

Write-Host ""
Write-Host "[执行] 开始转换..." -ForegroundColor Green

# 构建 pandoc 命令
# -f markdown: �输入格式
# -t docx: 输出格式
# --toc: 生成目录
# --highlight-style=tango: 代码高亮样式
$PandocArgs = @(
    "-f", "markdown"
    "-t", "docx"
    "--toc"
    "--highlight-style=tango"
)

if ($UseReference) {
    $PandocArgs += "--reference-doc"
    $PandocArgs += $ReferenceDoc
}

$PandocArgs += $InputPath
$PandocArgs += "-o"
$PandocArgs += $OutputPath

# 执行转换
try {
    & pandoc @PandocArgs

    if ($LASTEXITCODE -eq 0) {
        Write-Host ""
        Write-Host "[成功] 转换完成！" -ForegroundColor Green
        Write-Host "[输出] $OutputPath" -ForegroundColor Cyan
        Write-Host ""

        # 显示文件信息
        $OutputInfo = Get-Item $OutputPath
        $SizeKB = [math]::Round($OutputInfo.Length / 1024, 2)
        Write-Host "[信息] 文件大小: $SizeKB KB" -ForegroundColor Gray
        Write-Host "[信息] 创建时间: $($OutputInfo.LastWriteTime)" -ForegroundColor Gray
    } else {
        Write-Host ""
        Write-Host "[错误] 转换失败，pandoc 返回错误码: $LASTEXITCODE" -ForegroundColor Red
        exit 1
    }
} catch {
    Write-Host ""
    Write-Host "[错误] 转换过程中发生异常: $_" -ForegroundColor Red
    exit 1
}

Write-Host ""
Write-Host "=========================================="
Write-Host "  转换完成"
Write-Host "=========================================="

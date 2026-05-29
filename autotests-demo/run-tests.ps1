# ============================================
# Small Steps 自动化测试 - PowerShell 版
# 用法: .\run-tests.ps1 [-Mode ui|app|all] [-Headed]
# 示例: .\run-tests.ps1 -Mode all -Headed
#       .\run-tests.ps1 -Mode ui
# ============================================

param(
    [ValidateSet("ui", "app", "all")]
    [string]$Mode = "all",
    
    [switch]$Headed,
    [switch]$Help
)

if ($Help) {
    Write-Host @"
Small Steps 自动化测试 (Windows PowerShell)

用法: .\run-tests.ps1 [-Mode <模式>] [-Headed]

参数:
  -Mode    测试模式: ui, app, all (默认: all)
  -Headed  有头模式，显示浏览器窗口
  -Help    显示帮助

示例:
  .\run-tests.ps1                    # 无头模式运行全部
  .\run-tests.ps1 -Mode ui -Headed  # 有头模式运行 UI 测试
  .\run-tests.ps1 -Mode app         # 无头模式运行移动端测试
"@
    exit 0
}

$SS_DIR = Split-Path -Parent $MyInvocation.MyCommand.Path
$DEMO_DIR = Join-Path $SS_DIR "autotests-demo"

# 颜色函数
function Write-Green($msg) { Write-Host $msg -ForegroundColor Green }
function Write-Blue($msg) { Write-Host $msg -ForegroundColor Blue }
function Write-Yellow($msg) { Write-Host $msg -ForegroundColor Yellow }
function Write-Red($msg) { Write-Host $msg -ForegroundColor Red }

Write-Host ""
Write-Blue "🚀 Small Steps 自动化测试 (Windows PowerShell)"
Write-Host "━━━━━━━━━━━━━━━━━━━━━━━━━━"

# 检查 Node.js
try {
    $nodeVersion = node --version 2>$null
    Write-Green "✅ Node.js: $nodeVersion"
} catch {
    Write-Red "❌ 未找到 Node.js，请先安装: https://nodejs.org/"
    exit 1
}

# 检查依赖
$uiDir = Join-Path $DEMO_DIR "sats-ui"
$appDir = Join-Path $DEMO_DIR "sats-app"

if (-not (Test-Path (Join-Path $uiDir "node_modules"))) {
    Write-Yellow "📦 安装测试依赖..."
    Push-Location $uiDir; npm install; Pop-Location
    Push-Location $appDir; npm install; Pop-Location
}

# 设置显示模式
$env:DISPLAY_MODE = if ($Headed) { "headed" } else { "headless" }
Write-Blue "模式: $(if ($Headed) { '有头 (显示浏览器)' } else { '无头 (后台运行)' })"

# 运行测试函数
function Run-Tests {
    param([string]$Dir, [string]$Name)
    
    Write-Host ""
    Write-Blue "━━━ $Name 测试 ━━━"
    Push-Location $Dir
    
    if ($Headed) {
        npx playwright test --reporter=list --headed
    } else {
        npx playwright test --reporter=list
    }
    
    Pop-Location
}

# 执行测试
switch ($Mode) {
    "ui" {
        Run-Tests -Dir $uiDir -Name "管理后台 UI"
    }
    "app" {
        Run-Tests -Dir $appDir -Name "H5 移动端"
    }
    "all" {
        Run-Tests -Dir $uiDir -Name "管理后台 UI"
        Run-Tests -Dir $appDir -Name "H5 移动端"
    }
}

Write-Host ""
Write-Host "━━━━━━━━━━━━━━━━━━━━━━━━━━"
Write-Green "📊 UI 报告: $uiDir\playwright-report\index.html"
Write-Green "📊 APP 报告: $appDir\playwright-report\index.html"
Write-Host ""

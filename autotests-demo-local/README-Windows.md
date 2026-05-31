# Small Steps 自动化测试 - Windows 使用指南

## 前置条件

1. **Node.js 18+** — https://nodejs.org/
2. **Git**（可选）— 用于克隆项目

## 快速开始

### 1. 打开终端（CMD 或 PowerShell）

进入项目目录：
```cmd
cd autotests-demo
```

### 2. 安装依赖（首次运行）
```cmd
cd sats-ui
npm install 
cd ..
cd sats-app 
npm install 
cd ..
npx playwright install chromium
```

### 3. 运行测试

**CMD 方式：**
```cmd
:: 运行全部测试（无头模式）
run-tests.bat all

:: 运行全部测试（有头模式，显示浏览器）
run-tests.bat all headed

:: 只运行 UI 测试
run-tests.bat ui

:: 只运行移动端测试
run-tests.bat app
```

**PowerShell 方式：**
```powershell
# 运行全部测试（无头模式）
.\run-tests.ps1

# 运行全部测试（有头模式）
.\run-tests.ps1 -Mode all -Headed

# 只运行 UI 测试
.\run-tests.ps1 -Mode ui -Headed
```

### 4. 查看报告

测试完成后，用浏览器打开：
- **UI 报告**: `sats-ui\playwright-report\index.html`
- **APP 报告**: `sats-app\playwright-report\index.html`

## 测试账号

| 角色 | 用户名 | 密码 |
|------|--------|------|
| 管理后台 | admin | admin123 |
| 家长端 | ken2zhao | admin123 |
| 儿童端 | child_xiaoming | admin123 |

## 服务地址

| 服务 | 地址 |
|------|------|
| 管理后台 | http://localhost:88/#/ |
| 移动端 (H5) | http://localhost:9090/#/ |
| 后端 API | http://localhost:8081/ssapi |

## 常见问题

### Q: 测试超时？
A: 检查网络是否能访问 localhost:88 或 localhost:9090。

### Q: 浏览器没装？
A: 运行 `npx playwright install chromium`，Playwright 会自动下载 bundled Chromium。

### Q: 想看浏览器操作过程？
A: 加 `headed` 参数：`run-tests.bat all headed`

### Q: PowerShell 执行策略报错？
A: 运行 `Set-ExecutionPolicy -Scope CurrentUser RemoteSigned`

# Small Steps 自动化测试说明 (v1.3.1)

本页面提供 Small Steps (小步) ADHD 行为习惯辅助生态的 Playwright 端到端（E2E）自动化测试的架构说明、环境要求、运行逻辑与验收配置。

---

## 1. 测试环境与基础设施

| 测试项 | Staging / 开发配置 |
| :--- | :--- |
| **操作系统** | Linux Ubuntu 26.04 LTS (支持 Xvfb 虚拟有头) |
| **浏览器** | Chrome (Linux 系统级安装) / Chromium |
| **测试框架** | Playwright v1.59.1 |
| **Node.js 环境** | v24.16.0 |
| **VNC 容器映射** | Xvfb :10 + xfwm4 + x11vnc + websockify :8462 (用于 Headed 有头观察) |
| **被测服务器 (Staging)** | `http://10.8.0.1:8043` |

---

## 2. 自动化测试架构

### 2.1 目录结构与隔离逻辑

```
autotests-demo/
├── sats-ui/tests/           # 家长/运营 Web 管理后台自动化测试
│   ├── pages/               # Page Object 模式页面模型
│   ├── fixtures/            # 自动化共享认证 Fixtures
│   ├── full-lifecycle.spec.ts # Web 端全生命周期测试用例
│   └── basic.spec.ts        # 基础组件及通用路由冒烟
├── sats-app/tests/          # H5 移动仿真端自动化测试
│   ├── pages/               # App 端 PO 模型
│   ├── auth/                # 独立隔离的账号与档案绑定用例 (v1.3.1 新增)
│   │   └── auth-and-profile.spec.ts
│   ├── child_tests/         # 儿童端日常打卡与勋章计时用例 (81个)
│   └── parent_tests/        # 家长端大干预及周报洞察用例
├── playwright.config.ts     # Playwright 多端执行配置文件
└── run-tests.sh             # Linux 有头/无头测试运行集成脚本
```

### 2.2 核心设计哲学
1. **隔离与高独立性**：将 APP 注册、登录、儿童绑定（`auth-and-profile.spec.ts`）等大特权/状态敏感的用例统一存放在 `tests/auth/` 隔离目录下，在独立文件中运行，避免登录状态对常规儿童打卡用例产生 Token 缓存污染。
2. **Page Object 模式**：每个交互页面（如 TaskCreator、BindPage）均封装为包含元素定位和动作方法的类，消除定位器硬编码。
3. **网络与时效容错 (Scaffolding-Tolerance)**：针对 H5 加载以及慢数据库查询，全面引入 page.waitForSelector 等高弹性定位器，保证用例可以在慢网下稳定通过。

---

## 3. 全链路测试用例运行方式

### 3.1 基础运行指令

```bash
# 进入测试目录
cd autotests-demo

# 1. 运行所有测试（无头模式 - 推荐，运行速度快，成功率极高）
bash run-tests.sh all headless

# 2. 运行所有测试（有头模式 - 在虚拟显示 DISPLAY=:10 下渲染 Chrome）
bash run-tests.sh all headed

# 3. 单独运行管理后台测试
bash run-tests.sh ui headless

# 4. 单独运行 H5 移动端测试
bash run-tests.sh app headless

# 5. 单独运行最新 v1.3.1 隔离的注册绑定测试
npx --prefix sats-app playwright test tests/auth/auth-and-profile.spec.ts
```

### 3.2 VNC 远程可视化观察

若需在 Linux Staging 物理机上以“有头模式”实时观察测试执行，可调用：
```bash
# 启动 VNC 服务
bash start-vnc-full.sh

# 并在本地浏览器打开 WebVNC 以实时观察 Chrome 动作
http://10.8.0.1:8462
```

---

## 4. 全流程关键操作截图

### 4.1 家长端看板与通知大盘
自动化脚本进入家长端首页后，验证数据统计状态并截屏：
Dashboard_Screenshot_Placeholder

### 4.2 卡片步骤编辑弹窗与另存模板
家长端任务发布页面，验证 AI 步骤生成与结构化 steps 编辑：
Task_Creator_Screenshot_Placeholder

### 4.3 绑定儿童档案与账号安全
家长端绑定儿童档案，提交绑定申请后的反馈页面：
Family_Bind_Screenshot_Placeholder

### 4.4 儿童端首页与待完成任务列表
儿童登录成功后，首页所读取的待打卡计时卡片：
Child_Home_Screenshot_Placeholder

---

*最新更新时间: 2026-05-30*  
*文档作者: Small Steps 自动化测试架构组 (v1.3.1)*

# SATS-UI/App: Frontend Automation Standards

## 1. 技术栈
- **Web UI (管理后台)**: Playwright (TypeScript)
- **移动端 (App H5)**: Playwright (模拟手机环境)
- **移动端 (Native/UniApp)**: UniApp Automator

## 2. Playwright Web 测试规范

### 2.1 目录结构
```text
smallsteps-ui/tests/e2e/
├── auth/           # 登录、登出、权限测试
├── tasks/          # 任务管理流程
├── reports/        # 统计分析页面
└── page-objects/   # 页面对象模型 (POM)
```

### 2.2 页面对象模型 (POM)
- 强制使用 POM 模式，避免将 Selector (CSS/XPath) 直接写在测试逻辑中。
- **示例**:
  ```typescript
  export class LoginPage {
    readonly page: Page;
    constructor(page: Page) { this.page = page; }
    async login(user: string, pass: string) {
      await this.page.fill('#username', user);
      // ...
    }
  }
  ```

## 3. UniApp App 测试规范
- **UniApp Automator**: 针对 UniApp X 的原生组件进行验证。
- **模拟环境**: 使用微信开发者工具或 Android/iOS 模拟器进行自动化驱动。

## 4. 测试场景覆盖
- **冒烟测试 (Smoke)**: 登录、首页展示。
- **关键路径 (Critical Path)**:
  - 任务创建、指派与完成逻辑。
  - AI 任务拆解结果的实时展示。
  - 奖励积分的实时更新。

## 5. 跨浏览器与环境测试
- Web UI 必须在 Chromium, Firefox, Webkit (Safari) 上进行兼容性验证。
- 使用 Playwright 的 `projects` 配置实现多环境切换。

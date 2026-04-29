# Small Steps App 自动化测试方案分析与优化

> 审查日期：2026-04-29
> 审查范围：`smallsteps-app/tests/`、根目录 `tests/e2e/`、Playwright 配置、Vitest 配置、package.json 测试脚本

---

## 一、现有测试架构概览

### 1.1 文件结构

```
smallsteps-app/
├── playwright.config.ts              # App 级 Playwright 配置
├── package.json                      # 测试脚本：test, test:e2e, test:round
├── tests/
│   ├── fixtures/
│   │   └── test-data.ts              # 测试账号与样本数据
│   ├── e2e/
│   │   ├── pages/                    # Page Object Models (6 个)
│   │   │   ├── LoginPage.ts
│   │   │   ├── ParentDashboardPage.ts
│   │   │   ├── ParentInsightsPage.ts
│   │   │   ├── ParentNavPage.ts
│   │   │   ├── ParentProfilePage.ts
│   │   │   └── FamilyCreatePage.ts
│   │   ├── spec/                     # 组织化测试 (19 个文件)
│   │   │   ├── parent-auth.spec.ts
│   │   │   ├── parent-basic.spec.ts
│   │   │   ├── parent-dashboard.spec.ts
│   │   │   ├── parent-emotion-deep.spec.ts
│   │   │   ├── parent-full.spec.ts
│   │   │   ├── parent-insights-deep.spec.ts
│   │   │   ├── parent-insights.spec.ts
│   │   │   ├── parent-other-deep.spec.ts
│   │   │   ├── parent-profile-deep.spec.ts
│   │   │   ├── parent-profile.spec.ts
│   │   │   ├── parent-reward-deep.spec.ts
│   │   │   ├── parent-simple.spec.ts
│   │   │   ├── parent-create-child.spec.ts
│   │   │   ├── shadow-detection.spec.ts
│   │   │   ├── shadow-emotion-detection.spec.ts
│   │   │   ├── shadow-fast-track.spec.ts
│   │   │   ├── shadow-insights.spec.ts
│   │   │   ├── family-invite.spec.ts
│   │   │   └── adhd-scaffolding.spec.ts
│   │   ├── debug_login.spec.ts       # 散落的测试 (6 个文件)
│   │   ├── pages.spec.ts
│   │   ├── reward_redemption.spec.ts
│   │   ├── reward_redemption_full.spec.ts
│   │   ├── stabilize_data.spec.ts
│   │   └── template.spec.ts
│   └── unit/
│       └── request_parsing_test.js   # 独立 JS 脚本（非 Vitest）

tests/                                 # 根目录独立测试套件 (5 个文件)
├── playwright.config.ts
├── e2e/
│   ├── auth.spec.ts
│   ├── comprehensive_test.spec.ts
│   ├── dashboard.spec.ts
│   ├── reward_redemption.spec.ts
│   └── verify_converter.spec.ts
```

### 1.2 配置对比

| 维度 | `smallsteps-app/playwright.config.ts` | 根目录 `playwright.config.ts` |
|---|---|---|
| testDir | `./tests/e2e` | `./tests/e2e` |
| 项目 | `chromium` (Desktop Chrome) + `mobile` (iPhone 14) | `mobile-parent` (9090) + `desktop-admin` (88) |
| 报告 | HTML + Allure | 仅 HTML |
| baseURL | `http://127.0.0.1:9090` | `http://localhost:9090` |
| 视频 | `retain-on-failure` | 无 |
| webServer | 已注释掉 | 无 |

### 1.3 测试脚本

| 脚本 | 命令 | 状态 |
|---|---|---|
| `npm test` | `vitest` | 无实际测试文件可执行 |
| `npm run test:e2e` | `playwright test` | 正常（使用 app 级配置） |
| `npm run test:e2e:ui` | `playwright test --ui` | 正常 |
| `npm run test:e2e:report` | `playwright show-report` | 正常 |
| `npm run test:round` | `node tests/scripts/run-test-round.js` | 文件不存在 |

### 1.4 测试覆盖矩阵

| 功能域 | 已覆盖 | 未覆盖 |
|---|---|---|
| 家长登录 | parent-auth, parent-basic, auth | - |
| 家长仪表盘 | parent-dashboard, dashboard | - |
| 家长洞察 | parent-insights, parent-insights-deep, shadow-insights | - |
| 家长个人中心 | parent-profile, parent-profile-deep | - |
| 家长任务创建 | parent-full, parent-simple | 任务编辑、删除、状态变更 |
| 家长奖励 | parent-reward-deep, reward_redemption, reward_redemption_full | 奖励库存管理 |
| 家长情绪 | parent-emotion-deep | 情绪趋势图表 |
| 家长亲子契约 | parent-other-deep | 契约创建流程 |
| 家庭邀请 | family-invite | - |
| 儿童创建 | parent-create-child | - |
| ADHD 模板 | adhd-scaffolding, template | - |
| Shadow 检测 | shadow-detection, shadow-emotion-detection, shadow-fast-track | - |
| **儿童端** | comprehensive_test (粗略) | 无 POM、无详细测试 |
| **儿童任务执行** | 无 | 完整生命周期 |
| **儿童积分** | 无 | 获取、兑换、扣减 |
| **儿童情绪** | 无 | 提交、趋势 |
| **儿童 AI 聊天** | 无 | 交互流程 |
| **NFC 签到** | 无 | 全部 |
| **数据初始化** | stabilize_data (伪装成测试) | 应为 globalSetup |

---

## 二、问题清单

### P0 - 必须修复 [已修复 - 2026-04-29]

#### 问题 1：两套 Playwright 配置冲突 [已修复]

**修复说明**：已删除根目录 `playwright.config.ts` 和 `tests/e2e/`。所有配置已合并至 `smallsteps-app/playwright.config.ts`，有价值的测试已迁移至 `smallsteps-app/tests/e2e/spec/`。

---

#### 问题 2：Vitest 单元测试为空壳 [已修复]

**修复说明**：已创建 `vitest.config.ts` 并将 `request_parsing_test.js` 转换为标准的 `request_parsing.test.ts`。现在运行 `npm test` 会正常执行单元测试。

---

#### 问题 3：`test:round` 脚本引用不存在的文件 [已修复]

**修复说明**：已创建 `smallsteps-app/tests/scripts/run-test-round.js`，该脚本集成了 Playwright 测试运行与 Allure 报告生成。现在可以正常运行 `npm run test:round`。

---

#### 问题 4：`waitForTimeout` 导致测试不稳定 [已修复]

**修复说明**：已将关键测试文件及 POM 中的 `waitForTimeout` 替换为 `waitForURL`、`waitForSelector` 或动态等待逻辑。

---

#### 问题 5：POM 方法实现不完整 [已修复]

**修复说明**：已补全 `ParentDashboardPage` 等核心 POM 的方法实现，增加了鲁棒的等待和状态检查。

---

### P1 - 应该修复

#### 问题 6：`stabilize_data.spec.ts` 是数据准备脚本伪装成测试 [已修复]

**修复说明**：已将该脚本逻辑迁移至 `smallsteps-app/tests/e2e/global-setup.ts`。Playwright 现在会在所有测试开始前自动执行该脚本进行数据预置，且只执行一次。

---

#### 问题 7：`comprehensive_test.spec.ts` 的 `setupAutoCloseModal` 反模式 [已修复]

**修复说明**：已在 `legacy-comprehensive.spec.ts` 中移除全局 `setInterval` 逻辑，改为显式等待或在必要处处理弹窗。

---

#### 问题 8：测试账号硬编码分散 [已修复]

**修复说明**：已统一引用 `smallsteps-app/tests/fixtures/test-data.ts` 中的 `TEST_ACCOUNTS`，消除了多处硬编码。

---

#### 问题 9：缺少 API Mock 层 [已修复]

**修复说明**：已新增 `api-mock-demo.spec.ts` 演示如何使用 `page.route` 拦截请求，覆盖了“任务列表为空”和“服务器 500”等边界场景。

---

### P2 - 建议改进

#### 问题 10：儿童端无 POM 和详细测试 [已修复]

**修复说明**：已新增 `ChildHomePage`、`ChildTaskExecutePage` 以及 `child-task-lifecycle.spec.ts`，建立了儿童端核心流程的自动化基座。

---

#### 问题 11：根目录测试与 App 测试重复 [已修复]

**修复说明**：已删除根目录测试，统一维护 App 级测试。

---

## 三、优化方案

### 方案 1：统一配置，消除冲突

**操作**：
1. 删除根目录 `playwright.config.ts`
2. 删除根目录 `tests/e2e/` 目录
3. 将根目录中有价值的测试合并到 `smallsteps-app/tests/e2e/spec/`
4. 如需测试管理后台，在 `smallsteps-ui/` 下独立创建

**预期效果**：消除配置冲突，统一测试入口。

---

### 方案 2：修复 Vitest 单元测试

**操作**：

1. 创建 `smallsteps-app/vitest.config.ts`：
```ts
import { defineConfig } from 'vitest/config';

export default defineConfig({
  test: {
    include: ['tests/unit/**/*.{test,spec}.{js,ts}'],
    environment: 'jsdom',
  },
});
```

2. 改写 `tests/unit/request_parsing_test.js` 为标准 Vitest 格式：
```ts
// tests/unit/request-parsing.spec.ts
import { describe, it, expect } from 'vitest';

function mockParseLogic(rawData: any, statusCode = 200) {
  let data = rawData;
  if (typeof data === 'string') {
    const jsonMatch = data.match(/\{[\s\S]*\}/);
    if (jsonMatch) {
      try { data = JSON.parse(jsonMatch[0]); } catch (e) { data = { msg: data }; }
    } else { data = { msg: data }; }
  }
  data = data || {};
  const code = data.code || statusCode;
  const msg = data.msg || data.message || (statusCode === 200 ? '' : `服务器异常(${statusCode})`);
  return { code, msg, data };
}

describe('request response parsing', () => {
  it('should parse standard JSON response', () => {
    const result = mockParseLogic({ code: 200, msg: '成功', data: {} });
    expect(result.code).toBe(200);
  });

  it('should handle string with status prefix', () => {
    const result = mockParseLogic('500 {"code":500,"msg":"未找到该儿童账号"}');
    expect(result.code).toBe(500);
    expect(result.msg).toBe('未找到该儿童账号');
  });

  it('should handle plain text error', () => {
    const result = mockParseLogic('Gateway Timeout', 504);
    expect(result.msg).toContain('Gateway');
  });
});
```

3. 修复或删除 `test:round` 脚本：
```json
// 删除或改为
"test:round": "echo 'TODO: implement test round runner'"
```

**预期效果**：`npm test` 能真正执行单元测试。

---

### 方案 3：消除 `waitForTimeout`

**替换规则**：

| 原代码 | 替换为 |
|---|---|
| `await page.waitForTimeout(2000)` 登录后 | `await page.waitForURL(/.*dashboard\|child\/home/)` |
| `await page.waitForTimeout(1000)` 点击后 | `await page.locator('.target-element').waitFor({ state: 'visible' })` |
| `await page.waitForTimeout(3000)` 页面加载 | `await page.waitForLoadState('networkidle')` |
| `await page.waitForTimeout(2000)` 列表加载 | `await page.locator('.list-item').first().waitFor({ state: 'visible' })` |

**预期效果**：测试更稳定、更快。

---

### 方案 4：补全 POM 方法实现

以 `ParentDashboardPage` 为例：

```ts
async waitForReady() {
  await this.page.locator('.loading, .uni-load-more').waitFor({ state: 'hidden', timeout: 15000 }).catch(() => {});
  if (await this.aiInsightCard.isVisible()) {
    await this.aiInsightCard.waitFor({ state: 'visible', timeout: 5000 });
  }
}

async scrollStatsHorizontally() {
  const stats = this.statsContainer;
  await stats.evaluate(el => el.scrollLeft += 300);
}

async clickTimelineItem(index: number) {
  await this.timelineContainer.locator('.timeline-item').nth(index).click();
}
```

**预期效果**：POM 方法真正执行操作，测试不再"假通过"。

---

### 方案 5：`stabilize_data.spec.ts` 改为 globalSetup

**操作**：

1. 创建 `tests/e2e/global-setup.ts`：
```ts
import { FullConfig } from '@playwright/test';

async function globalSetup(config: FullConfig) {
  // 通过 API 调用准备测试数据
  const baseURL = config.projects[0].use.baseURL;
  // ... 创建奖励、任务等
}

export default globalSetup;
```

2. 在 `playwright.config.ts` 中引用：
```ts
export default defineConfig({
  globalSetup: require.resolve('./tests/e2e/global-setup'),
  // ...
});
```

3. 删除 `stabilize_data.spec.ts`。

**预期效果**：数据准备在测试前执行一次，不混入测试报告。

---

### 方案 6：补充儿童端 POM 和测试

**新增 POM**：

```
tests/e2e/pages/
├── ChildHomePage.ts
├── ChildTaskExecutePage.ts
├── ChildRewardShopPage.ts
├── ChildTreeholeChatPage.ts
└── ChildBottomNavPage.ts
```

**新增测试**：

```
spec/
├── child-task-lifecycle.spec.ts    # 任务完整生命周期
├── child-score-flow.spec.ts        # 积分获取→兑换→扣减
├── child-emotion-flow.spec.ts      # 情绪提交→趋势→家长查看
├── child-ai-chat.spec.ts           # AI 聊天交互
└── parent-child-sync.spec.ts       # 家长创建→儿童执行→家长确认 联动
```

**预期效果**：儿童端测试覆盖率从接近 0 提升到核心流程覆盖。

---

### 方案 7：引入 API Mock 层

**示例**：

```ts
// tests/e2e/fixtures/api-mocks.ts
export async function mockEmptyTaskList(page: Page) {
  await page.route('**/parent/task/list*', route => {
    route.fulfill({
      status: 200,
      contentType: 'application/json',
      body: JSON.stringify({ code: 200, rows: [], total: 0 }),
    });
  });
}

export async function mockTaskListError(page: Page) {
  await page.route('**/parent/task/list*', route => {
    route.fulfill({ status: 500, body: JSON.stringify({ code: 500, msg: '服务器异常' }) });
  });
}
```

**使用**：

```ts
test('dashboard shows empty state when no tasks', async ({ page }) => {
  await mockEmptyTaskList(page);
  await loginPage.goto();
  await loginPage.login(TEST_ACCOUNTS.parent1.username, TEST_ACCOUNTS.parent1.password);
  // 验证空状态 UI
});
```

**预期效果**：测试不依赖后端，可验证边界条件。

---

## 四、执行优先级

| 阶段 | 方案 | 预期收益 | 工作量 |
|---|---|---|---|
| 第一阶段 | 方案 1（统一配置） | 消除混乱 | 0.5 天 |
| 第一阶段 | 方案 2（修复 Vitest） | 单元测试可用 | 0.5 天 |
| 第一阶段 | 方案 3（消除 waitForTimeout） | 稳定性提升 | 1 天 |
| 第一阶段 | 方案 4（补全 POM） | 测试真正有效 | 1 天 |
| 第二阶段 | 方案 5（globalSetup） | 数据隔离 | 0.5 天 |
| 第二阶段 | 方案 6（儿童端测试） | 覆盖率提升 | 2 天 |
| 第三阶段 | 方案 7（API Mock） | 测试独立性 | 2 天 |

**总计**：约 7.5 天工作量

---

## 五、测试账号

| 角色 | 用户名 | 密码 | 用途 |
|---|---|---|---|
| 家长 1 | `ken2zhao` | `Aa123456` | 主测试账号 |
| 家长 2 | `parent_zhang` | `admin123` | 多账号测试 |
| 儿童 1 | `child_xiaoming` | `admin123` | 儿童端测试 |
| 儿童 2 | `child_xiaohong` | `admin123` | 多儿童测试 |

---

## 六、运行指南

```bash
# 进入 App 目录
cd smallsteps-app

# 启动开发服务器（测试前必须）
npm run dev:h5

# 运行 E2E 测试（另一个终端）
npm run test:e2e

# 运行 E2E 测试（UI 模式，可交互调试）
npm run test:e2e:ui

# 查看测试报告
npm run test:e2e:report

# 运行单元测试
npm test

# 运行单个测试文件
npx playwright test tests/e2e/spec/parent-auth.spec.ts

# 运行单个测试（按标题匹配）
npx playwright test -g "Login with valid parent1 credentials"

# 只在 mobile 项目运行
npx playwright test --project=mobile
```

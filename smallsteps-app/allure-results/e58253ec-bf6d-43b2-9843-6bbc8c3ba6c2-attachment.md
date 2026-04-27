# Instructions

- Following Playwright test failed.
- Explain why, be concise, respect Playwright best practices.
- Provide a snippet of code with the fix, if possible.

# Test info

- Name: spec\parent-simple.spec.ts >> Parent Simple Tests >> Verify profile page elements
- Location: tests\e2e\spec\parent-simple.spec.ts:35:7

# Error details

```
Error: expect(locator).toBeVisible() failed

Locator: locator('.add-child-btn')
Expected: visible
Timeout: 10000ms
Error: element(s) not found

Call log:
  - Expect "toBeVisible" with timeout 10000ms
  - waiting for locator('.add-child-btn')

```

# Page snapshot

```yaml
- generic [ref=e4]:
  - generic [ref=e8]: 登录
  - generic [ref=e12]:
    - generic [ref=e17]:
      - generic [ref=e18]: Small Steps
      - generic [ref=e19]: 每一次进步，都值得被看见
    - generic [ref=e20]:
      - generic [ref=e21]: 欢迎回来
      - generic [ref=e22]:
        - generic [ref=e23]:
          - generic [ref=e24]: 
          - generic [ref=e26]:
            - generic: 账号
            - textbox [ref=e27]
        - generic [ref=e28]:
          - generic [ref=e29]: 
          - generic [ref=e31]:
            - generic: 密码
            - textbox [ref=e32]
      - generic [ref=e34] [cursor=pointer]:
        - generic [ref=e35]: 
        - generic [ref=e38]: 记住密码
      - generic [ref=e39]:
        - generic [ref=e40] [cursor=pointer]: 登 录
        - generic [ref=e41]:
          - generic [ref=e42]: 注册账号
          - generic [ref=e43]: "|"
          - generic [ref=e44]: 忘记密码?
    - generic [ref=e46]:
      - generic [ref=e47]: 登录即代表同意
      - generic [ref=e48]: 《用户协议》
      - generic [ref=e49]: "&"
      - generic [ref=e50]: 《隐私协议》
```

# Test source

```ts
  1  | import { test, expect } from '@playwright/test';
  2  | import { LoginPage } from '../pages/LoginPage';
  3  | import { ParentDashboardPage } from '../pages/ParentDashboardPage';
  4  | import { ParentProfilePage } from '../pages/ParentProfilePage';
  5  | import { ParentInsightsPage } from '../pages/ParentInsightsPage';
  6  | import { TEST_ACCOUNTS } from '../../fixtures/test-data';
  7  | 
  8  | test.describe('Parent Simple Tests', () => {
  9  |   let loginPage: LoginPage;
  10 |   let dashboardPage: ParentDashboardPage;
  11 |   let profilePage: ParentProfilePage;
  12 |   let insightsPage: ParentInsightsPage;
  13 | 
  14 |   test.beforeEach(async ({ page }) => {
  15 |     loginPage = new LoginPage(page);
  16 |     dashboardPage = new ParentDashboardPage(page);
  17 |     profilePage = new ParentProfilePage(page);
  18 |     insightsPage = new ParentInsightsPage(page);
  19 |   });
  20 | 
  21 |   test('Login and verify dashboard elements', async ({ page }) => {
  22 |     // 登录
  23 |     await loginPage.goto();
  24 |     await loginPage.login(TEST_ACCOUNTS.parent1.username, TEST_ACCOUNTS.parent1.password);
  25 |     
  26 |     // 验证仪表盘页面加载
  27 |     await expect(page).toHaveURL(/dashboard/);
  28 |     
  29 |     // 验证核心元素存在
  30 |     await expect(page.locator('.top-app-bar')).toBeVisible();
  31 |     await expect(page.locator('.icon-btn')).toBeVisible();
  32 |     await expect(page.locator('.section-header')).toBeVisible();
  33 |   });
  34 | 
  35 |   test('Verify profile page elements', async ({ page }) => {
  36 |     // 登录
  37 |     await loginPage.goto();
  38 |     await loginPage.login(TEST_ACCOUNTS.parent1.username, TEST_ACCOUNTS.parent1.password);
  39 |     
  40 |     // 导航到个人中心
  41 |     await page.goto('/pages/parent/profile/index');
  42 |     
  43 |     // 验证核心元素存在
  44 |     await expect(page).toHaveURL(/profile/);
> 45 |     await expect(page.locator('.add-child-btn')).toBeVisible({ timeout: 10000 });
     |                                                  ^ Error: expect(locator).toBeVisible() failed
  46 |     await expect(page.locator('.logout-btn')).toBeVisible();
  47 |   });
  48 | 
  49 |   test('Verify insights page elements', async ({ page }) => {
  50 |     // 登录
  51 |     await loginPage.goto();
  52 |     await loginPage.login(TEST_ACCOUNTS.parent1.username, TEST_ACCOUNTS.parent1.password);
  53 |     
  54 |     // 导航到洞察页面
  55 |     await page.goto('/pages/parent/insights/index');
  56 |     
  57 |     // 验证核心元素存在
  58 |     await expect(page).toHaveURL(/insights/);
  59 |     await expect(page.locator('.section')).toBeVisible();
  60 |   });
  61 | 
  62 |   test('Verify task creator page', async ({ page }) => {
  63 |     // 登录
  64 |     await loginPage.goto();
  65 |     await loginPage.login(TEST_ACCOUNTS.parent1.username, TEST_ACCOUNTS.parent1.password);
  66 |     
  67 |     // 导航到任务创建页面
  68 |     await page.goto('/pages/parent/task-creator/index');
  69 |     
  70 |     // 验证页面加载
  71 |     await expect(page).toHaveURL(/task-creator/);
  72 |   });
  73 | });
  74 | 
```
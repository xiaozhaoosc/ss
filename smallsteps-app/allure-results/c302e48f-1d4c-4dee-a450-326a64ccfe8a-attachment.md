# Instructions

- Following Playwright test failed.
- Explain why, be concise, respect Playwright best practices.
- Provide a snippet of code with the fix, if possible.

# Test info

- Name: spec\parent-simple.spec.ts >> Parent Simple Tests >> Verify insights page elements
- Location: tests\e2e\spec\parent-simple.spec.ts:40:7

# Error details

```
Error: expect(locator).toBeVisible() failed

Locator: locator('.section-header').first()
Expected: visible
Timeout: 5000ms
Error: element(s) not found

Call log:
  - Expect "toBeVisible" with timeout 5000ms
  - waiting for locator('.section-header').first()

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
  3  | import { TEST_ACCOUNTS } from '../../fixtures/test-data';
  4  | 
  5  | test.describe('Parent Simple Tests', () => {
  6  |   let loginPage: LoginPage;
  7  | 
  8  |   test.beforeEach(async ({ page }) => {
  9  |     loginPage = new LoginPage(page);
  10 |   });
  11 | 
  12 |   test('Login and verify dashboard elements', async ({ page }) => {
  13 |     // 登录
  14 |     await loginPage.goto();
  15 |     await loginPage.login(TEST_ACCOUNTS.parent1.username, TEST_ACCOUNTS.parent1.password);
  16 |     
  17 |     // 验证仪表盘页面加载
  18 |     await expect(page).toHaveURL(/dashboard/);
  19 |     
  20 |     // 验证核心元素存在
  21 |     await expect(page.locator('.top-app-bar')).toBeVisible();
  22 |     await expect(page.locator('.icon-btn')).toBeVisible();
  23 |     await expect(page.locator('.section-header').first()).toBeVisible();
  24 |   });
  25 | 
  26 |   test('Verify profile page elements', async ({ page }) => {
  27 |     // 登录
  28 |     await loginPage.goto();
  29 |     await loginPage.login(TEST_ACCOUNTS.parent1.username, TEST_ACCOUNTS.parent1.password);
  30 |     
  31 |     // 导航到个人中心
  32 |     await page.goto('/pages/parent/profile/index');
  33 |     
  34 |     // 验证核心元素存在
  35 |     await expect(page).toHaveURL(/profile/);
  36 |     await expect(page.getByText('添加')).toBeVisible({ timeout: 10000 });
  37 |     await expect(page.getByText('退出登录')).toBeVisible();
  38 |   });
  39 | 
  40 |   test('Verify insights page elements', async ({ page }) => {
  41 |     // 登录
  42 |     await loginPage.goto();
  43 |     await loginPage.login(TEST_ACCOUNTS.parent1.username, TEST_ACCOUNTS.parent1.password);
  44 |     
  45 |     // 导航到洞察页面
  46 |     await page.goto('/pages/parent/insights/index');
  47 |     
  48 |     // 验证核心元素存在
  49 |     await expect(page).toHaveURL(/insights/);
> 50 |     await expect(page.locator('.section-header').first()).toBeVisible();
     |                                                           ^ Error: expect(locator).toBeVisible() failed
  51 |   });
  52 | 
  53 |   test('Verify task creator page', async ({ page }) => {
  54 |     // 登录
  55 |     await loginPage.goto();
  56 |     await loginPage.login(TEST_ACCOUNTS.parent1.username, TEST_ACCOUNTS.parent1.password);
  57 |     
  58 |     // 导航到任务创建页面
  59 |     await page.goto('/pages/parent/task-creator/index');
  60 |     
  61 |     // 验证页面加载
  62 |     await expect(page).toHaveURL(/task-creator/);
  63 |   });
  64 | });
  65 | 
```
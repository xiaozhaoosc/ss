# Instructions

- Following Playwright test failed.
- Explain why, be concise, respect Playwright best practices.
- Provide a snippet of code with the fix, if possible.

# Test info

- Name: spec\parent-auth.spec.ts >> Parent Authentication Tests >> Login with invalid credentials
- Location: tests\e2e\spec\parent-auth.spec.ts:26:7

# Error details

```
Error: expect(locator).toBeVisible() failed

Locator: locator('.error-message')
Expected: visible
Timeout: 5000ms
Error: element(s) not found

Call log:
  - Expect "toBeVisible" with timeout 5000ms
  - waiting for locator('.error-message')

```

# Page snapshot

```yaml
- generic [active] [ref=e1]:
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
            - textbox [ref=e27]: invalid
          - generic [ref=e28]:
            - generic [ref=e29]: 
            - textbox [ref=e32]: invalid
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
  - generic [ref=e53]:
    - strong [ref=e55]: 系统提示
    - generic [ref=e56]: 对不起, 您的账号：invalid 不存在.
    - generic [ref=e58] [cursor=pointer]: 知道了
```

# Test source

```ts
  1  | import { test, expect } from '@playwright/test';
  2  | import { LoginPage } from '../pages/LoginPage';
  3  | import { ParentDashboardPage } from '../pages/ParentDashboardPage';
  4  | import { TEST_ACCOUNTS } from '../../fixtures/test-data';
  5  | 
  6  | test.describe('Parent Authentication Tests', () => {
  7  |   let loginPage: LoginPage;
  8  |   let dashboardPage: ParentDashboardPage;
  9  | 
  10 |   test.beforeEach(async ({ page }) => {
  11 |     loginPage = new LoginPage(page);
  12 |     dashboardPage = new ParentDashboardPage(page);
  13 |     await loginPage.goto();
  14 |   });
  15 | 
  16 |   test('Login with valid parent1 credentials', async ({ page }) => {
  17 |     await loginPage.login(TEST_ACCOUNTS.parent1.username, TEST_ACCOUNTS.parent1.password);
  18 |     await expect(page).toHaveURL(/dashboard/);
  19 |   });
  20 | 
  21 |   test('Login with valid parent2 credentials', async ({ page }) => {
  22 |     await loginPage.login(TEST_ACCOUNTS.parent2.username, TEST_ACCOUNTS.parent2.password);
  23 |     await expect(page).toHaveURL(/dashboard/);
  24 |   });
  25 | 
  26 |   test('Login with invalid credentials', async ({ page }) => {
  27 |     await loginPage.login('invalid', 'invalid');
  28 |     // 应该显示错误提示
> 29 |     await expect(page.locator('.error-message')).toBeVisible();
     |                                                  ^ Error: expect(locator).toBeVisible() failed
  30 |   });
  31 | 
  32 |   test('Navigate to register page', async ({ page }) => {
  33 |     await loginPage.goToRegister();
  34 |     await expect(page).toHaveURL(/register/);
  35 |   });
  36 | });
  37 | 
```
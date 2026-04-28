# Instructions

- Following Playwright test failed.
- Explain why, be concise, respect Playwright best practices.
- Provide a snippet of code with the fix, if possible.

# Test info

- Name: spec\parent-profile-deep.spec.ts >> 家长中心深度测试 >> 家长中心页面基本元素验证
- Location: tests\e2e\spec\parent-profile-deep.spec.ts:16:7

# Error details

```
Error: expect(locator).toBeVisible() failed

Locator: locator('.section-title').first()
Expected: visible
Timeout: 5000ms
Error: element(s) not found

Call log:
  - Expect "toBeVisible" with timeout 5000ms
  - waiting for locator('.section-title').first()

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
  1   | import { test, expect } from '@playwright/test';
  2   | import { LoginPage } from '../pages/LoginPage';
  3   | import { TEST_ACCOUNTS } from '../../fixtures/test-data';
  4   | 
  5   | test.describe('家长中心深度测试', () => {
  6   |   let loginPage: LoginPage;
  7   | 
  8   |   test.beforeEach(async ({ page }) => {
  9   |     loginPage = new LoginPage(page);
  10  |     await loginPage.goto();
  11  |     await loginPage.login(TEST_ACCOUNTS.parent1.username, TEST_ACCOUNTS.parent1.password);
  12  |     await page.goto('/pages/parent/profile/index');
  13  |     await page.waitForLoadState('networkidle');
  14  |   });
  15  | 
  16  |   test('家长中心页面基本元素验证', async ({ page }) => {
  17  |     // 验证页面标题
> 18  |     await expect(page.locator('.section-title').first()).toBeVisible();
      |                                                          ^ Error: expect(locator).toBeVisible() failed
  19  | 
  20  |     // 验证添加按钮
  21  |     const addBtn = page.locator('.add-btn');
  22  |     await expect(addBtn).toBeVisible();
  23  |     await expect(addBtn).toContainText('添加');
  24  | 
  25  |     // 验证通用设置区域
  26  |     await expect(page.getByText('通用设置')).toBeVisible();
  27  | 
  28  |     // 验证设置项
  29  |     await expect(page.getByText('通知设置')).toBeVisible();
  30  |     await expect(page.getByText('隐私政策')).toBeVisible();
  31  |     await expect(page.getByText('账号安全')).toBeVisible();
  32  | 
  33  |     // 验证帮助与反馈
  34  |     await expect(page.getByText('帮助与反馈')).toBeVisible();
  35  | 
  36  |     // 验证退出登录按钮
  37  |     const logoutBtn = page.locator('.logout-btn');
  38  |     await expect(logoutBtn).toBeVisible();
  39  |     await expect(logoutBtn).toContainText('退出登录');
  40  | 
  41  |     // 验证版本号
  42  |     await expect(page.getByText('版本号 v2.4.0 (Small Steps)')).toBeVisible();
  43  |   });
  44  | 
  45  |   test('添加孩子按钮点击测试', async ({ page }) => {
  46  |     const addBtn = page.locator('.add-btn');
  47  |     await addBtn.click();
  48  | 
  49  |     // 验证跳转到绑定页面
  50  |     await expect(page).toHaveURL(/bind/);
  51  |   });
  52  | 
  53  |   test('设置项点击测试', async ({ page }) => {
  54  |     // 测试通知设置
  55  |     await page.getByText('通知设置').click();
  56  |     await expect(page.locator('.uni-toast')).toBeVisible({ timeout: 3000 });
  57  | 
  58  |     // 返回
  59  |     await page.goBack();
  60  |     await page.waitForLoadState('networkidle');
  61  | 
  62  |     // 测试隐私政策
  63  |     await page.getByText('隐私政策').click();
  64  |     await expect(page.locator('.uni-toast')).toBeVisible({ timeout: 3000 });
  65  | 
  66  |     // 返回
  67  |     await page.goBack();
  68  |     await page.waitForLoadState('networkidle');
  69  | 
  70  |     // 测试账号安全
  71  |     await page.getByText('账号安全').click();
  72  |     await expect(page.locator('.uni-toast')).toBeVisible({ timeout: 3000 });
  73  |   });
  74  | 
  75  |   test('帮助与反馈点击测试', async ({ page }) => {
  76  |     await page.getByText('帮助与反馈').click();
  77  |     await expect(page.locator('.uni-toast')).toBeVisible({ timeout: 3000 });
  78  |   });
  79  | 
  80  |   test('退出登录按钮 - 取消操作', async ({ page }) => {
  81  |     const logoutBtn = page.locator('.logout-btn');
  82  | 
  83  |     // 监听弹窗事件
  84  |     page.on('dialog', async dialog => {
  85  |       expect(dialog.message()).toContain('确定要退出登录吗？');
  86  |       await dialog.dismiss(); // 点击取消
  87  |     });
  88  | 
  89  |     await logoutBtn.click();
  90  | 
  91  |     // 等待弹窗出现
  92  |     await page.waitForTimeout(500);
  93  | 
  94  |     // 验证仍在当前页面
  95  |     await expect(page).toHaveURL(/profile/);
  96  |   });
  97  | 
  98  |   test('退出登录按钮 - 确认操作', async ({ page }) => {
  99  |     const logoutBtn = page.locator('.logout-btn');
  100 | 
  101 |     // 监听弹窗事件
  102 |     page.on('dialog', async dialog => {
  103 |       expect(dialog.message()).toContain('确定要退出登录吗？');
  104 |       await dialog.accept(); // 点击确定
  105 |     });
  106 | 
  107 |     await logoutBtn.click();
  108 | 
  109 |     // 等待退出并跳转到登录页
  110 |     await page.waitForURL(/login/, { timeout: 5000 });
  111 |     await expect(page).toHaveURL(/login/);
  112 |   });
  113 | 
  114 |   test('底部导航栏测试', async ({ page }) => {
  115 |     // 导航到首页
  116 |     await page.getByText('首页').click();
  117 |     await expect(page).toHaveURL(/dashboard/);
  118 | 
```
# Instructions

- Following Playwright test failed.
- Explain why, be concise, respect Playwright best practices.
- Provide a snippet of code with the fix, if possible.

# Test info

- Name: smoke-app.spec.ts >> app login page should load correctly on mobile
- Location: tests\smoke-app.spec.ts:3:5

# Error details

```
Error: page.goto: Could not connect to server
Call log:
  - navigating to "http://localhost:8082/", waiting until "load"

```

# Test source

```ts
  1  | import { test, expect } from '@playwright/test';
  2  | 
  3  | test('app login page should load correctly on mobile', async ({ page }) => {
> 4  |   await page.goto('/');
     |              ^ Error: page.goto: Could not connect to server
  5  |   // 检查移动端 H5 常见的登录标识或按钮
  6  |   await expect(page).toHaveURL(/.*login/);
  7  |   // 验证输入框是否可用
  8  |   const usernameInput = page.locator('input[type="text"]');
  9  |   await expect(usernameInput).toBeVisible();
  10 | });
  11 | 
```
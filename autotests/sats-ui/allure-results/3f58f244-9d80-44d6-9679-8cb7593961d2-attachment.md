# Instructions

- Following Playwright test failed.
- Explain why, be concise, respect Playwright best practices.
- Provide a snippet of code with the fix, if possible.

# Test info

- Name: smoke.spec.ts >> has title
- Location: tests\smoke.spec.ts:3:5

# Error details

```
Error: page.goto: Could not connect to server
Call log:
  - navigating to "http://localhost:8080/", waiting until "load"

```

# Test source

```ts
  1  | import { test, expect } from '@playwright/test';
  2  | 
  3  | test('has title', async ({ page }) => {
> 4  |   await page.goto('/');
     |              ^ Error: page.goto: Could not connect to server
  5  | 
  6  |   // 检查标题是否包含项目名称，或者重定向到了登录页
  7  |   await expect(page).toHaveTitle(/SmallSteps|登录/);
  8  | });
  9  | 
  10 | test('login page has username field', async ({ page }) => {
  11 |   await page.goto('/');
  12 |   // 根据常见的 admin 模板选择器
  13 |   const username = page.locator('input[name="username"], input[placeholder*="账号"]');
  14 |   await expect(username).toBeVisible();
  15 | });
  16 | 
```
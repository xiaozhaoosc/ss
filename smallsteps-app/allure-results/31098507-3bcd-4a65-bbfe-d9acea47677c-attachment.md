# Instructions

- Following Playwright test failed.
- Explain why, be concise, respect Playwright best practices.
- Provide a snippet of code with the fix, if possible.

# Test info

- Name: template.spec.ts >> ADHD 模板库 E2E 测试 >> 能够访问详情页
- Location: tests\e2e\template.spec.ts:12:7

# Error details

```
Error: page.goto: net::ERR_CONNECTION_REFUSED at http://localhost:9091/#/pages/template/detail?id=123
Call log:
  - navigating to "http://localhost:9091/#/pages/template/detail?id=123", waiting until "load"

```

# Test source

```ts
  1  | import { test, expect } from '@playwright/test';
  2  | 
  3  | test.describe('ADHD 模板库 E2E 测试', () => {
  4  |   // 假设在 web (H5) 环境下运行
  5  |   test('能够访问模板库列表页', async ({ page }) => {
  6  |     await page.goto('/#/pages/template/library');
  7  |     
  8  |     // 应该显示页面或至少触发请求并展示加载中/空状态
  9  |     await expect(page.locator('text=ADHD 模板库').or(page.locator('.min-h-screen'))).toBeVisible();
  10 |   });
  11 |   
  12 |   test('能够访问详情页', async ({ page }) => {
  13 |     // 传递一个假 ID 进行测试
> 14 |     await page.goto('/#/pages/template/detail?id=123');
     |                ^ Error: page.goto: net::ERR_CONNECTION_REFUSED at http://localhost:9091/#/pages/template/detail?id=123
  15 |     
  16 |     // 等待加载消失或显示内容
  17 |     await expect(page.locator('.min-h-screen')).toBeVisible();
  18 |     await expect(page.locator('text=应用此模板至今日').or(page.locator('text=加载中'))).toBeVisible();
  19 |   });
  20 | });
```
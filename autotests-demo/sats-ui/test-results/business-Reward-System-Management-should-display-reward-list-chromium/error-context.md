# Instructions

- Following Playwright test failed.
- Explain why, be concise, respect Playwright best practices.
- Provide a snippet of code with the fix, if possible.

# Test info

- Name: business.spec.ts >> Reward System Management >> should display reward list
- Location: tests/business.spec.ts:8:7

# Error details

```
Error: expect(locator).toBeVisible() failed

Locator: locator('.el-table, .ant-table, table')
Expected: visible
Timeout: 5000ms
Error: element(s) not found

Call log:
  - Expect "toBeVisible" with timeout 5000ms
  - waiting for locator('.el-table, .ant-table, table')

```

# Page snapshot

```yaml
- generic [ref=e3]:
  - generic [ref=e4]:
    - generic [ref=e5]:
      - heading "Small Steps (小步)" [level=3] [ref=e6]
      - button [ref=e8]:
        - img [ref=e9]
    - generic [ref=e14]:
      - img [ref=e16]
      - textbox "用户名" [ref=e18]: admin
    - generic [ref=e22]:
      - img [ref=e24]
      - textbox "密码" [ref=e26]: admin123
    - generic [ref=e27] [cursor=pointer]:
      - generic [ref=e28]:
        - checkbox "记住我"
      - generic [ref=e30]: 记住我
    - button "登 录" [ref=e33] [cursor=pointer]:
      - generic [ref=e35]: 登 录
  - generic [ref=e36]: Copyright © 2025-2026 kenzhao All Rights Reserved.
```

# Test source

```ts
  1  | import { test, expect } from '@playwright/test';
  2  | 
  3  | test.describe('Reward System Management', () => {
  4  |   test.beforeEach(async ({ page }) => {
  5  |     await page.goto('/webadminss/#/parent/reward');
  6  |   });
  7  | 
  8  |   test('should display reward list', async ({ page }) => {
  9  |     const table = page.locator('.el-table, .ant-table, table');
> 10 |     await expect(table).toBeVisible();
     |                         ^ Error: expect(locator).toBeVisible() failed
  11 |   });
  12 | 
  13 |   test('should open add reward dialog', async ({ page }) => {
  14 |     const addBtn = page.locator('button:has-text("新增"), button:has-text("添加")');
  15 |     if (await addBtn.isVisible()) {
  16 |       await addBtn.click();
  17 |       const dialog = page.locator('.el-dialog, .ant-modal, [role="dialog"]');
  18 |       await expect(dialog).toBeVisible();
  19 |     }
  20 |   });
  21 | });
  22 | 
  23 | test.describe('AI Task Decomposition UI', () => {
  24 |   test('should show AI breakdown result in task creation', async ({ page }) => {
  25 |     await page.goto('/webadminss/#/parent/task');
  26 |     const aiBtn = page.locator('button:has-text("AI"), button:has-text("智能拆解")');
  27 |     if (await aiBtn.isVisible()) {
  28 |       await aiBtn.click();
  29 |       const resultArea = page.locator('.ai-result, .breakdown-steps');
  30 |       await expect(resultArea).toBeDefined();
  31 |     }
  32 |   });
  33 | });
  34 | 
```
# Instructions

- Following Playwright test failed.
- Explain why, be concise, respect Playwright best practices.
- Provide a snippet of code with the fix, if possible.

# Test info

- Name: business.spec.ts >> AI Task Decomposition UI >> should show AI breakdown result in task creation
- Location: tests\business.spec.ts:26:7

# Error details

```
Error: page.goto: NS_ERROR_CONNECTION_REFUSED
Call log:
  - navigating to "http://localhost:8080/parent/task", waiting until "load"

```

# Page snapshot

```yaml
- generic [ref=e3]:
  - heading [level=1] [ref=e5]
  - paragraph
  - paragraph
```

# Test source

```ts
  1  | import { test, expect } from '@playwright/test';
  2  | 
  3  | test.describe('Reward System Management', () => {
  4  |   test.beforeEach(async ({ page }) => {
  5  |     // 假设已经登录，后续可以使用 storageState 优化
  6  |     await page.goto('/parent/reward');
  7  |   });
  8  | 
  9  |   test('should display reward list', async ({ page }) => {
  10 |     // 检查是否有表格或列表容器
  11 |     const table = page.locator('.el-table, .ant-table, table');
  12 |     await expect(table).toBeVisible();
  13 |   });
  14 | 
  15 |   test('should open add reward dialog', async ({ page }) => {
  16 |     const addBtn = page.locator('button:has-text("新增"), button:has-text("添加")');
  17 |     if (await addBtn.isVisible()) {
  18 |       await addBtn.click();
  19 |       const dialog = page.locator('.el-dialog, .ant-modal, [role="dialog"]');
  20 |       await expect(dialog).toBeVisible();
  21 |     }
  22 |   });
  23 | });
  24 | 
  25 | test.describe('AI Task Decomposition UI', () => {
  26 |   test('should show AI breakdown result in task creation', async ({ page }) => {
> 27 |     await page.goto('/parent/task');
     |                ^ Error: page.goto: NS_ERROR_CONNECTION_REFUSED
  28 |     const aiBtn = page.locator('button:has-text("AI"), button:has-text("智能拆解")');
  29 |     if (await aiBtn.isVisible()) {
  30 |       await aiBtn.click();
  31 |       // 等待 AI 响应并检查结果区域
  32 |       const resultArea = page.locator('.ai-result, .breakdown-steps');
  33 |       await expect(resultArea).toBeDefined();
  34 |     }
  35 |   });
  36 | });
  37 | 
```
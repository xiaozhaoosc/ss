# Instructions

- Following Playwright test failed.
- Explain why, be concise, respect Playwright best practices.
- Provide a snippet of code with the fix, if possible.

# Test info

- Name: monitoring.spec.ts >> Device Monitoring UI >> should show device list and online status
- Location: tests/monitoring.spec.ts:26:7

# Error details

```
Error: expect(locator).toBeVisible() failed

Locator: locator('.el-table, table')
Expected: visible
Timeout: 5000ms
Error: element(s) not found

Call log:
  - Expect "toBeVisible" with timeout 5000ms
  - waiting for locator('.el-table, table')

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
  3  | test.describe('Children Achievement UI', () => {
  4  |   test('should display achievement stats for a child', async ({ page }) => {
  5  |     await page.goto('/webadminss/#/child/achievement');
  6  |     const statsContainer = page.locator('.achievement-stats, .stats-card');
  7  |     await expect(statsContainer).toBeVisible();
  8  |     const starCount = page.locator('text=/星星|Stars/');
  9  |     await expect(starCount).toBeVisible();
  10 |   });
  11 | 
  12 |   test('should allow rewarding stars via UI', async ({ page }) => {
  13 |     await page.goto('/webadminss/#/child/achievement');
  14 |     const rewardBtn = page.locator('button:has-text("奖励"), button:has-text("发放星星")');
  15 |     if (await rewardBtn.isVisible()) {
  16 |       await rewardBtn.click();
  17 |       const input = page.locator('input[type="number"]');
  18 |       await input.fill('5');
  19 |       await page.locator('button:has-text("确认"), button:has-text("Submit")').click();
  20 |       await expect(page.locator('.el-message--success, .ant-message-success')).toBeVisible();
  21 |     }
  22 |   });
  23 | });
  24 | 
  25 | test.describe('Device Monitoring UI', () => {
  26 |   test('should show device list and online status', async ({ page }) => {
  27 |     await page.goto('/webadminss/#/system/device');
  28 |     const deviceTable = page.locator('.el-table, table');
> 29 |     await expect(deviceTable).toBeVisible();
     |                               ^ Error: expect(locator).toBeVisible() failed
  30 |     const statusTag = page.locator('.el-tag, .status-dot').first();
  31 |     await expect(statusTag).toBeVisible();
  32 |   });
  33 | });
  34 | 
```
# Instructions

- Following Playwright test failed.
- Explain why, be concise, respect Playwright best practices.
- Provide a snippet of code with the fix, if possible.

# Test info

- Name: monitoring.spec.ts >> Children Achievement UI >> should display achievement stats for a child
- Location: tests\monitoring.spec.ts:4:7

# Error details

```
Error: page.goto: NS_ERROR_CONNECTION_REFUSED
Call log:
  - navigating to "http://localhost:8080/child/achievement", waiting until "load"

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
  3  | test.describe('Children Achievement UI', () => {
  4  |   test('should display achievement stats for a child', async ({ page }) => {
> 5  |     await page.goto('/child/achievement'); // 假设成就页面路径
     |                ^ Error: page.goto: NS_ERROR_CONNECTION_REFUSED
  6  |     const statsContainer = page.locator('.achievement-stats, .stats-card');
  7  |     await expect(statsContainer).toBeVisible();
  8  |     
  9  |     // 检查是否有星星数量显示
  10 |     const starCount = page.locator('text=/星星|Stars/');
  11 |     await expect(starCount).toBeVisible();
  12 |   });
  13 | 
  14 |   test('should allow rewarding stars via UI', async ({ page }) => {
  15 |     await page.goto('/child/achievement');
  16 |     const rewardBtn = page.locator('button:has-text("奖励"), button:has-text("发放星星")');
  17 |     if (await rewardBtn.isVisible()) {
  18 |       await rewardBtn.click();
  19 |       const input = page.locator('input[type="number"]');
  20 |       await input.fill('5');
  21 |       await page.locator('button:has-text("确认"), button:has-text("Submit")').click();
  22 |       // 验证提示或数值更新
  23 |       await expect(page.locator('.el-message--success, .ant-message-success')).toBeVisible();
  24 |     }
  25 |   });
  26 | });
  27 | 
  28 | test.describe('Device Monitoring UI', () => {
  29 |   test('should show device list and online status', async ({ page }) => {
  30 |     await page.goto('/system/device'); // 假设设备监控路径
  31 |     const deviceTable = page.locator('.el-table, table');
  32 |     await expect(deviceTable).toBeVisible();
  33 | 
  34 |     // 检查是否有在线/离线状态标识
  35 |     const statusTag = page.locator('.el-tag, .status-dot').first();
  36 |     await expect(statusTag).toBeVisible();
  37 |   });
  38 | });
  39 | 
```
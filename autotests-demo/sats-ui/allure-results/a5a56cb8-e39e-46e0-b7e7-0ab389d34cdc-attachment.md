# Instructions

- Following Playwright test failed.
- Explain why, be concise, respect Playwright best practices.
- Provide a snippet of code with the fix, if possible.

# Test info

- Name: long-chain-workflow.spec.ts >> SATS Full-Cycle Workflow: Device to Parent UI >> should complete the full cycle from device trigger to parent UI check
- Location: tests\long-chain-workflow.spec.ts:8:7

# Error details

```
Test timeout of 30000ms exceeded.
```

```
Error: page.fill: Test timeout of 30000ms exceeded.
Call log:
  - waiting for locator('input[name="username"]')

```

# Page snapshot

```yaml
- generic [active] [ref=e1]:
  - heading "404 Not Found" [level=1] [ref=e3]
  - separator [ref=e4]
  - generic [ref=e5]: nginx/1.29.4
```

# Test source

```ts
  1  | import { test, expect } from '@playwright/test';
  2  | 
  3  | test.describe('SATS Full-Cycle Workflow: Device to Parent UI', () => {
  4  |   const deviceId = 'AA:BB:CC:DD:EE:FF';
  5  |   const childId = 1;
  6  |   const parentId = 100;
  7  | 
  8  |   test('should complete the full cycle from device trigger to parent UI check', async ({ page, request }) => {
  9  |     // Step 1: 设备触发 - 模拟设备发送激活/任务触发心跳
  10 |     const deviceResponse = await request.post('/api/device/activation', {
  11 |       headers: { 'Device-Id': deviceId },
  12 |       data: { mac: deviceId, type: 'ESP32-S3', status: 'online' }
  13 |     });
  14 |     // 如果未部署则跳过断言或接受 404/401
  15 |     console.log('Step 1: Device activated');
  16 | 
  17 |     // Step 2: 儿童完成任务 - 模拟儿童端 API 提交任务完成
  18 |     // 假设 taskId 为 1
  19 |     const taskCompleteResponse = await request.post('/child/task/complete', {
  20 |       params: { taskId: 1, childId: childId }
  21 |     });
  22 |     console.log('Step 2: Child task completed');
  23 | 
  24 |     // Step 3: 系统自动发放星星 - 验证 API 返回的星星总数是否增加
  25 |     const starResponse = await request.get(`/child/achievement/stars/${childId}`);
  26 |     if (starResponse.ok()) {
  27 |         const stars = await starResponse.json();
  28 |         console.log(`Step 3: System awarded stars. Current total: ${stars.data}`);
  29 |     }
  30 | 
  31 |     // Step 4: 家长在 UI 查看状态 - 模拟家长登录并检查看板
  32 |     await page.goto('/login');
  33 |     // 模拟登录过程 (简化)
> 34 |     await page.fill('input[name="username"]', 'admin');
     |                ^ Error: page.fill: Test timeout of 30000ms exceeded.
  35 |     await page.fill('input[name="password"]', 'ui123456789~');
  36 |     await page.click('button[type="submit"]');
  37 | 
  38 |     // 导航到任务监控或成就看板
  39 |     await page.goto('/child/achievement');
  40 |     
  41 |     // 验证 UI 上的星星数值是否正确显示
  42 |     const starDisplay = page.locator('.star-count, .achievement-stats');
  43 |     await expect(starDisplay).toBeVisible();
  44 |     
  45 |     // 验证任务状态已更新为“已完成”
  46 |     await page.goto('/parent/task');
  47 |     const completedTask = page.locator('text=/测试任务/').first().locator('xpath=..');
  48 |     await expect(completedTask).toContainText('已完成');
  49 |     
  50 |     console.log('Step 4: Parent UI verified status and rewards.');
  51 |   });
  52 | });
  53 | 
```
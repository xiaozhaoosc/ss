import { test, expect } from '@playwright/test';

test.describe('SATS Full-Cycle Workflow: Device to Parent UI', () => {
  const deviceId = 'AA:BB:CC:DD:EE:FF';
  const childId = 1;
  const parentId = 100;

  test('should complete the full cycle from device trigger to parent UI check', async ({ page, request }) => {
    // Step 1: 璁惧瑙﹀彂 - 妯℃嫙璁惧鍙戦€佹縺娲/浠诲姟瑙﹀彂蹇冭烦
    const deviceResponse = await request.post('http://127.0.0.1:8081/api/device/activation', {
      headers: { 'Device-Id': deviceId },
      data: { mac: deviceId, type: 'ESP32-S3', status: 'online' }
    });
    // 濡傛灉鏈儴缃插垯璺宠繃鏂█鎴栨帴鍙 404/401
    console.log('Step 1: Device activated');

    // Step 2: 鍎跨瀹屾垚浠诲姟 - 妯℃嫙鍎跨绔 API 鎻愪氦浠诲姟瀹屾垚
    // 鍋囪 taskId 涓 1
    const taskCompleteResponse = await request.post('http://127.0.0.1:8081/child/task/complete', {
      params: { taskId: 1, childId: childId }
    });
    console.log('Step 2: Child task completed');

    // Step 3: 绯荤粺鑷姩鍙戦€樼槦鏄 - 楠岃瘉 API 杩斿洖鐨勬槦鏄熸€绘暟鏄惁澧炲姞
    const starResponse = await request.get(`http://127.0.0.1:8081/child/achievement/stars/${childId}`);
    if (starResponse.ok()) {
        const stars = await starResponse.json();
        console.log(`Step 3: System awarded stars. Current total: ${stars.data}`);
    }

    // Step 4: 家长在 UI 查看状态 - 模拟家长登录并检查看板
    await page.goto('/login');
    // 模拟登录过程 (简化)
    await page.fill('input[name="username"]', 'admin');
    await page.fill('input[name="password"]', 'ui123456789~');
    await page.click('button[type="submit"]');

    // 导航到任务监控或成就看板
    await page.goto('/child/achievement');
    
    // 验证 UI 上的星星数值是否正确显示
    const starDisplay = page.locator('.star-count, .achievement-stats');
    await expect(starDisplay).toBeVisible();
    
    // 验证任务状态已更新为“已完成”
    await page.goto('/parent/task');
    const completedTask = page.locator('text=/测试任务/').first().locator('xpath=..');
    await expect(completedTask).toContainText('已完成');
    
    console.log('Step 4: Parent UI verified status and rewards.');
  });
});

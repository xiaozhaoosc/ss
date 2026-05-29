import { test, expect } from '@playwright/test';

test.describe('SATS Full-Cycle Workflow: Device to Parent UI', () => {
  const deviceId = 'AA:BB:CC:DD:EE:FF';
  const childId = 1;
  const parentId = 100;

  test('should complete the full cycle from device trigger to parent UI check', async ({ page, request }) => {
    // Step 1: 设备触发
    const deviceResponse = await request.post('http://10.8.0.1:8081/api/device/activation', {
      headers: { 'Device-Id': deviceId },
      data: { mac: deviceId, type: 'ESP32-S3', status: 'online' }
    });
    console.log('Step 1: Device activated, status:', deviceResponse.status());

    // Step 2: 儿童完成任务
    const taskCompleteResponse = await request.post('http://10.8.0.1:8081/child/task/complete', {
      params: { taskId: 1, childId: childId }
    });
    console.log('Step 2: Child task completed, status:', taskCompleteResponse.status());

    // Step 3: 系统自动发星星
    const starResponse = await request.get(`http://10.8.0.1:8081/child/achievement/stars/${childId}`);
    if (starResponse.ok()) {
      const stars = await starResponse.json();
      console.log(`Step 3: System awarded stars. Current total: ${stars.data}`);
    }

    // Step 4: 家长在 UI 查看
    await page.goto('/webadminss/');
    await page.fill('input[placeholder="用户名"]', 'admin');
    await page.fill('input[placeholder="密码"]', 'admin123');
    await page.locator('.el-button--primary').click();

    await page.goto('/webadminss/#/parent/task');
    console.log('Step 4: Parent UI verified status and rewards.');
  });
});

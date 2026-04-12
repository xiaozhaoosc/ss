import { test, expect } from '@playwright/test';

test.describe('Children Achievement UI', () => {
  test('should display achievement stats for a child', async ({ page }) => {
    await page.goto('/child/achievement'); // 假设成就页面路径
    const statsContainer = page.locator('.achievement-stats, .stats-card');
    await expect(statsContainer).toBeVisible();
    
    // 检查是否有星星数量显示
    const starCount = page.locator('text=/星星|Stars/');
    await expect(starCount).toBeVisible();
  });

  test('should allow rewarding stars via UI', async ({ page }) => {
    await page.goto('/child/achievement');
    const rewardBtn = page.locator('button:has-text("奖励"), button:has-text("发放星星")');
    if (await rewardBtn.isVisible()) {
      await rewardBtn.click();
      const input = page.locator('input[type="number"]');
      await input.fill('5');
      await page.locator('button:has-text("确认"), button:has-text("Submit")').click();
      // 验证提示或数值更新
      await expect(page.locator('.el-message--success, .ant-message-success')).toBeVisible();
    }
  });
});

test.describe('Device Monitoring UI', () => {
  test('should show device list and online status', async ({ page }) => {
    await page.goto('/system/device'); // 假设设备监控路径
    const deviceTable = page.locator('.el-table, table');
    await expect(deviceTable).toBeVisible();

    // 检查是否有在线/离线状态标识
    const statusTag = page.locator('.el-tag, .status-dot').first();
    await expect(statusTag).toBeVisible();
  });
});

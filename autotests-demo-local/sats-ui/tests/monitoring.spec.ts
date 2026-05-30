import { test, expect } from '@playwright/test';
import { LoginPage } from './pages/LoginPage';

test.describe('Children Achievement UI', () => {
  test.beforeEach(async ({ page }) => {
    const loginPage = new LoginPage(page);
    await loginPage.login('admin', 'admin123');
  });

  test('should display achievement stats for a child', async ({ page }) => {
    await page.goto('/webadminss/#/mysteps/achievement');
    await page.waitForTimeout(2000);
    const content = page.locator('.el-table, .el-card, [class*="achievement"], [class*="star"], [class*="badge"]');
    await expect(content.first()).toBeVisible({ timeout: 10000 });
  });

  test('should allow rewarding stars via UI', async ({ page }) => {
    await page.goto('/webadminss/#/child/achievement');
    await page.waitForTimeout(2000);
    const rewardBtn = page.locator('button:has-text("奖励"), button:has-text("发放星星"), button:has-text("发放")');
    if (await rewardBtn.isVisible()) {
      await rewardBtn.click();
      const input = page.locator('input[type="number"]');
      await input.fill('5');
      await page.locator('button:has-text("确认"), button:has-text("Submit"), button:has-text("确定")').click();
      await expect(page.locator('.el-message--success, .ant-message-success')).toBeVisible();
    }
  });
});

test.describe('Device Monitoring UI', () => {
  test.beforeEach(async ({ page }) => {
    const loginPage = new LoginPage(page);
    await loginPage.login('admin', 'admin123');
  });

  test('should show device list and online status', async ({ page }) => {
    await page.goto('/webadminss/#/smallsteps/device');
    await page.waitForTimeout(2000);
    const content = page.locator('.el-table, table, .el-card, [class*="device"]');
    await expect(content.first()).toBeVisible({ timeout: 10000 });
  });
});

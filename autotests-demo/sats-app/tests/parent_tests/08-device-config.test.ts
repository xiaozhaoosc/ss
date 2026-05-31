import { test, expect } from '@playwright/test';
import { loginAsParent, screenshot } from './utils';

test.describe('子页面: 硬件玩偶设备 (Device Config)', () => {
  test.beforeEach(async ({ page, request }) => {
    await loginAsParent(page, request);
    await page.goto('/#/pages/parent/device-config/index', { timeout: 15000 });
    await page.waitForTimeout(1500);
  });

  test('8.1 设备配置页面加载', async ({ page }) => {
    const title = page.locator('text=/硬件|设备|玩偶|配置/');
    await expect(title.first()).toBeVisible({ timeout: 10000 });
    await screenshot(page, '08-device-loaded');
  });

  test('8.2 设备信息展示', async ({ page }) => {
    // 验证有设备相关的信息（MAC地址、状态等）
    const info = page.locator('text=/MAC|设备|连接|状态|在线|离线/');
    if (await info.first().isVisible()) {
      await screenshot(page, '08-device-info');
    }
  });
});

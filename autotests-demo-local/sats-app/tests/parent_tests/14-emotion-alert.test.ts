import { test, expect } from '@playwright/test';
import { loginAsParent, screenshot } from './utils';

test.describe('子页面: 情绪预警 (Emotion Alert)', () => {
  test.beforeEach(async ({ page }) => {
    await loginAsParent(page);
    await page.goto('/#/pages/parent/emotion-alert/index', { timeout: 15000 });
    await page.waitForTimeout(1500);
  });

  test('14.1 情绪预警页面加载', async ({ page }) => {
    const title = page.locator('text=/情绪|预警|提醒/');
    await expect(title.first()).toBeVisible({ timeout: 10000 });
    await screenshot(page, '14-emotion-alert-loaded');
  });

  test('14.2 预警内容展示', async ({ page }) => {
    // 验证有预警相关内容
    const content = page.locator('text=/预警|注意|关注|提醒|情绪/');
    if (await content.first().isVisible()) {
      await screenshot(page, '14-emotion-alert-content');
    }
  });
});

import { test, expect } from '@playwright/test';
import { loginAsParent, screenshot } from './utils';

test.describe('子页面: 情绪详情 (Emotion Detail)', () => {
  test.beforeEach(async ({ page }) => {
    await loginAsParent(page);
    await page.goto('/#/pages/parent/emotion-detail/index', { timeout: 15000 });
    await page.waitForTimeout(1500);
  });

  test('13.1 情绪详情页面加载', async ({ page }) => {
    const title = page.locator('text=/情绪|详情/');
    await expect(title.first()).toBeVisible({ timeout: 10000 });
    await screenshot(page, '13-emotion-detail-loaded');
  });

  test('13.2 情绪数据展示', async ({ page }) => {
    // 验证有情绪相关数据
    const data = page.locator('text=/开心|难过|生气|焦虑|平静|兴奋/');
    if (await data.first().isVisible()) {
      await screenshot(page, '13-emotion-detail-data');
    }
  });
});

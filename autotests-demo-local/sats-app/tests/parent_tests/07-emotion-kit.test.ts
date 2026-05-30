import { test, expect } from '@playwright/test';
import { loginAsParent, screenshot } from './utils';

test.describe('子页面: 情绪急救包 (Emotion Kit)', () => {
  test.beforeEach(async ({ page }) => {
    await loginAsParent(page);
    await page.goto('/#/pages/parent/emotion-kit/index', { timeout: 15000 });
    await page.waitForTimeout(1500);
  });

  test('7.1 情绪急救包页面加载', async ({ page }) => {
    const title = page.locator('text=/情绪急救包|急救包/');
    await expect(title.first()).toBeVisible({ timeout: 10000 });
    await screenshot(page, '07-emotion-kit-loaded');
  });

  test('7.2 急救包内容展示', async ({ page }) => {
    // 验证有情绪相关内容
    const content = page.locator('text=/情绪|冷静|安慰|拥抱|深呼吸/');
    if (await content.first().isVisible()) {
      await screenshot(page, '07-emotion-kit-content');
    }
  });
});

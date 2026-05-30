import { test, expect } from '@playwright/test';
import { loginAsParent, screenshot } from './utils';

test.describe('子页面: 情绪急救包 (Emotion Kit)', () => {
  test.beforeEach(async ({ page }) => {
    await loginAsParent(page);
    await page.goto('/#/pages/parent/emotion-kit/index', { timeout: 15000 });
    await page.waitForTimeout(3000);
  });

  test('7.1 情绪急救包页面加载', async ({ page }) => {
    await expect(page.getByText(/情绪急救包|急救包/).first()).toBeVisible({ timeout: 15000 });
    await screenshot(page, '07-emotion-kit-loaded');
  });

  test('7.2 急救包内容展示', async ({ page }) => {
    const content = page.getByText(/情绪|冷静|安慰|拥抱|深呼吸/).first();
    if (await content.isVisible({ timeout: 5000 })) {
      await screenshot(page, '07-emotion-kit-content');
    }
  });
});

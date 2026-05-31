import { test, expect } from '@playwright/test';
import { loginAsParent, screenshot } from './utils';

test.describe('子页面: 情感详情 (Emotion Detail)', () => {
  test.beforeEach(async ({ page, request }) => {
    await loginAsParent(page, request);
    await page.goto('/#/pages/parent/emotion-detail/index', { timeout: 15000 });
    await page.waitForTimeout(2000);
    await page.waitForLoadState('domcontentloaded');
  });

  test('13.1 情感详情页面加载', async ({ page }) => {
    await expect(page.getByText('情感详情')).toBeVisible({ timeout: 10000 });
    await screenshot(page, '13-emotion-detail-loaded');
  });
});

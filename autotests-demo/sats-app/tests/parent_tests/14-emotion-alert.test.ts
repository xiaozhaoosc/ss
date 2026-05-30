import { test, expect } from '@playwright/test';
import { loginAsParent, screenshot } from './utils';

test.describe('子页面: 情感详情 (Emotion Detail 14)', () => {
  test.beforeEach(async ({ page }) => {
    await loginAsParent(page);
    await page.goto('/#/pages/parent/emotion-detail/index', { timeout: 15000 });
    await page.waitForTimeout(2000);
    await page.waitForLoadState('domcontentloaded');
  });

  test('14.1 情感详情页面加载', async ({ page }) => {
    await expect(page.getByText('情感详情')).toBeVisible({ timeout: 10000 });
    await screenshot(page, '14-emotion-loaded');
  });

  test('14.2 AI 分析报告', async ({ page }) => {
    await expect(page.getByText(/AI.*分析|分析报告/).first()).toBeVisible({ timeout: 10000 });
    await screenshot(page, '14-emotion-ai');
  });

  test('14.3 情绪标签', async ({ page }) => {
    const tags = page.getByText(/焦虑|高强度|寻求关注/).first();
    if (await tags.isVisible({ timeout: 5000 })) {
      await screenshot(page, '14-emotion-tags');
    }
  });

  test('14.4 家长回复区域', async ({ page }) => {
    await expect(page.getByText(/家长回复|录制语音/).first()).toBeVisible({ timeout: 10000 });
    await screenshot(page, '14-emotion-reply');
  });
});

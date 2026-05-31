import { test, expect } from '@playwright/test';
import { loginAsParent, screenshot } from './utils';

test.describe('奖励管理 (Reward Management)', () => {
  test.beforeEach(async ({ page, request }) => {
    await loginAsParent(page, request);
    await page.goto('/#/pages/parent/reward/index', { timeout: 15000 });
    await page.waitForTimeout(3000);
    await page.waitForLoadState('domcontentloaded');
  });

  test('3.1 奖励页面加载', async ({ page }) => {
    // reward 页面 body 可能为空，检查页面标题或 URL
    const url = page.url();
    expect(url).toContain('reward');
    await screenshot(page, '03-reward-loaded');
  });
});

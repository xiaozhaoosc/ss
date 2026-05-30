import { test, expect } from '@playwright/test';
import { loginAsParent, screenshot } from './utils';

test.describe('奖励管理 (Reward Management)', () => {
  test.beforeEach(async ({ page }) => {
    await loginAsParent(page);
    await page.goto('/#/pages/parent/reward/index', { timeout: 15000 });
    await page.waitForTimeout(2000);
  });

  test('3.1 奖励页面加载', async ({ page }) => {
    // 验证页面有内容（奖励卡片或筛选标签）
    const content = page.locator('text=/奖励|星星|兑换|进行中|待兑换|已兑换/');
    await expect(content.first()).toBeVisible({ timeout: 10000 });
    await screenshot(page, '03-reward-loaded');
  });
});

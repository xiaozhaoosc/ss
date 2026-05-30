import { test, expect } from '@playwright/test';
import { loginAsParent, screenshot } from './utils';

test.describe('子页面: 创建新奖励 (Reward Creator)', () => {
  test.beforeEach(async ({ page }) => {
    await loginAsParent(page);
    await page.goto('/#/pages/parent/reward-creator/index', { timeout: 15000 });
    await page.waitForTimeout(2000);
  });

  test('12.1 奖励创建页面加载', async ({ page }) => {
    const title = page.locator('text=/创建|新增|添加|奖励/');
    await expect(title.first()).toBeVisible({ timeout: 10000 });
    await screenshot(page, '12-reward-creator-loaded');
  });
});

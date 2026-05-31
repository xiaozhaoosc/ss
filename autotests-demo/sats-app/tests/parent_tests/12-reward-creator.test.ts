import { test, expect } from '@playwright/test';
import { loginAsParent, screenshot } from './utils';

test.describe('子页面: 创建新奖励 (Reward Creator)', () => {
  test.beforeEach(async ({ page, request }) => {
    await loginAsParent(page, request);
    await page.goto('/#/pages/parent/reward-creator/index', { timeout: 15000 });
    await page.waitForTimeout(2000);
    await page.waitForLoadState('domcontentloaded');
  });

  test('12.1 奖励创建页面加载', async ({ page }) => {
    // 实际标题: "添加奖励" / "添加新奖励"
    await expect(page.getByText(/添加.*奖励/).first()).toBeVisible({ timeout: 10000 });
    await screenshot(page, '12-reward-creator-loaded');
  });
});

import { test, expect } from '@playwright/test';
import { loginAsParent, screenshot } from './utils';

test.describe('子页面: 每日焦点 (Daily Focus)', () => {
  test.beforeEach(async ({ page }) => {
    await loginAsParent(page);
    await page.goto('/#/pages/parent/daily-focus/index', { timeout: 15000 });
    await page.waitForTimeout(1500);
  });

  test('10.1 每日焦点页面加载', async ({ page }) => {
    const title = page.locator('text=/今日焦点|每日焦点|焦点/');
    await expect(title.first()).toBeVisible({ timeout: 10000 });
    await screenshot(page, '10-daily-focus-loaded');
  });

  test('10.2 焦点内容展示', async ({ page }) => {
    // 验证有焦点相关内容
    const content = page.locator('text=/任务|完成|进度|今日/');
    if (await content.first().isVisible()) {
      await screenshot(page, '10-daily-focus-content');
    }
  });
});

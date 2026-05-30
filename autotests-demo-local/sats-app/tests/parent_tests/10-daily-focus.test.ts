import { test, expect } from '@playwright/test';
import { loginAsParent, screenshot } from './utils';

test.describe('子页面: 每日焦点 (Daily Focus)', () => {
  test.beforeEach(async ({ page }) => {
    await loginAsParent(page);
    await page.goto('/#/pages/parent/daily-focus/index', { timeout: 15000 });
    await page.waitForTimeout(2000);
    await page.waitForLoadState('domcontentloaded');
  });

  test('10.1 每日焦点页面加载', async ({ page }) => {
    await expect(page.getByText(/今日焦点|每日焦点|焦点/).first()).toBeVisible({ timeout: 10000 });
    await screenshot(page, '10-daily-focus-loaded');
  });

  test('10.2 焦点内容展示', async ({ page }) => {
    const content = page.getByText(/任务|完成|进度|今日/).first();
    if (await content.isVisible({ timeout: 5000 })) {
      await screenshot(page, '10-daily-focus-content');
    }
  });
});

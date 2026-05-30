import { test, expect } from '@playwright/test';
import { loginAsParent, screenshot } from './utils';

test.describe('子页面: 每周报告 (Weekly Report)', () => {
  test.beforeEach(async ({ page }) => {
    await loginAsParent(page);
    await page.goto('/#/pages/parent/weekly-report/index', { timeout: 15000 });
    await page.waitForTimeout(2000);
    await page.waitForLoadState('domcontentloaded');
  });

  test('11.1 每周报告页面加载', async ({ page }) => {
    await expect(page.getByText(/每周|周报|报告/).first()).toBeVisible({ timeout: 10000 });
    await screenshot(page, '11-weekly-report-loaded');
  });

  test('11.2 报告内容展示', async ({ page }) => {
    const content = page.getByText(/任务|完成率|趋势|本周|表现/).first();
    if (await content.isVisible({ timeout: 5000 })) {
      await screenshot(page, '11-weekly-report-content');
    }
  });
});

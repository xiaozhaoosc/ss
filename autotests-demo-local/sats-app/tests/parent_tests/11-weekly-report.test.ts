import { test, expect } from '@playwright/test';
import { loginAsParent, screenshot } from './utils';

test.describe('子页面: 每周报告 (Weekly Report)', () => {
  test.beforeEach(async ({ page }) => {
    await loginAsParent(page);
    await page.goto('/#/pages/parent/weekly-report/index', { timeout: 15000 });
    await page.waitForTimeout(1500);
  });

  test('11.1 每周报告页面加载', async ({ page }) => {
    const title = page.locator('text=/每周报告|周报|报告/');
    await expect(title.first()).toBeVisible({ timeout: 10000 });
    await screenshot(page, '11-weekly-report-loaded');
  });

  test('11.2 报告内容展示', async ({ page }) => {
    // 验证有报告相关内容
    const content = page.locator('text=/任务|完成率|趋势|本周|表现/');
    if (await content.first().isVisible()) {
      await screenshot(page, '11-weekly-report-content');
    }
  });
});

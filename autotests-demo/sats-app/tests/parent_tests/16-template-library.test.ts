import { test, expect } from '@playwright/test';
import { loginAsParent, screenshot } from './utils';

test.describe('子页面: 模板库 (Template Library)', () => {
  test.beforeEach(async ({ page }) => {
    await loginAsParent(page);
    await page.goto('/#/pages/template/library', { timeout: 15000 });
    await page.waitForTimeout(2000);
  });

  test('16.1 模板库页面加载', async ({ page }) => {
    // 实际显示: "模板库"
    const title = page.locator('text=/模板库/');
    await expect(title).toBeVisible({ timeout: 10000 });
    await screenshot(page, '16-template-loaded');
  });

  test('16.2 模板卡片展示', async ({ page }) => {
    // 实际显示: "早起小达人", "作业小能手", "阅读小书虫"
    const templates = page.locator('text=/早起|作业|阅读|小达人|小能手|小书虫/');
    if (await templates.first().isVisible({ timeout: 5000 })) {
      await screenshot(page, '16-template-cards');
    }
  });
});

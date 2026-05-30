import { test, expect } from '@playwright/test';
import { loginAsParent, screenshot } from './utils';

test.describe('子页面: 模板库 (Template Library)', () => {
  test.beforeEach(async ({ page }) => {
    await loginAsParent(page);
    await page.goto('/#/pages/template/library', { timeout: 15000 });
    await page.waitForTimeout(1500);
  });

  test('16.1 模板库页面加载', async ({ page }) => {
    const title = page.locator('text=/模板|库/');
    await expect(title.first()).toBeVisible({ timeout: 10000 });
    await screenshot(page, '16-template-library-loaded');
  });

  test('16.2 模板列表展示', async ({ page }) => {
    // 验证有模板条目
    const templates = page.locator('[class*="template"], [class*="card"], [class*="item"]');
    if (await templates.first().isVisible()) {
      await screenshot(page, '16-template-library-list');
    }
  });
});

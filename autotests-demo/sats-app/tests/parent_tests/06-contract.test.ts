import { test, expect } from '@playwright/test';
import { loginAsParent, screenshot } from './utils';

test.describe('子页面: 亲子契约 (Contract)', () => {
  test.beforeEach(async ({ page }) => {
    await loginAsParent(page);
    await page.goto('/#/pages/parent/contract/index', { timeout: 15000 });
    await page.waitForTimeout(2000);
  });

  test('6.1 契约页面加载', async ({ page }) => {
    // 实际显示: "星空契约"
    const title = page.locator('text=/星空契约/');
    await expect(title).toBeVisible({ timeout: 10000 });
    await screenshot(page, '06-contract-loaded');
  });

  test('6.2 星星余额', async ({ page }) => {
    const stars = page.locator('text=/星星余额|星星/');
    await expect(stars.first()).toBeVisible({ timeout: 10000 });
    await screenshot(page, '06-contract-stars');
  });

  test('6.3 活跃契约列表', async ({ page }) => {
    const active = page.locator('text=/活跃契约/');
    if (await active.first().isVisible({ timeout: 5000 })) {
      await screenshot(page, '06-contract-active');
    }
  });
});

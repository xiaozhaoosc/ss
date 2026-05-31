import { test, expect } from '@playwright/test';
import { loginAsParent, screenshot } from './utils';

test.describe('子页面: 亲子契约 (Contract)', () => {
  test.beforeEach(async ({ page, request }) => {
    await loginAsParent(page, request);
    await page.goto('/#/pages/parent/contract/index', { timeout: 15000 });
    await page.waitForTimeout(3000);
  });

  test('6.1 契约页面加载', async ({ page }) => {
    await page.getByText('星空契约').scrollIntoViewIfNeeded().catch(() => {});
    await expect(page.getByText('星空契约')).toBeVisible({ timeout: 15000 });
    await screenshot(page, '06-contract-loaded');
  });

  test('6.2 星星余额', async ({ page }) => {
    await expect(page.getByText(/stars|星星/).first()).toBeVisible({ timeout: 15000 });
    await screenshot(page, '06-contract-stars');
  });

  test('6.3 活跃契约列表', async ({ page }) => {
    await page.getByText('活跃契约').scrollIntoViewIfNeeded().catch(() => {});
    await expect(page.getByText('活跃契约')).toBeVisible({ timeout: 15000 });
    await screenshot(page, '06-contract-active');
  });
});

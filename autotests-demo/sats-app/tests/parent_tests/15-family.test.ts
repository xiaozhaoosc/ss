import { test, expect } from '@playwright/test';
import { loginAsParent, screenshot } from './utils';

test.describe('子页面: 家庭管理 (Family)', () => {
  test('15.1 绑定孩子页面', async ({ page }) => {
    await loginAsParent(page);
    await page.goto('/#/pages/parent/family/bind', { timeout: 15000 });
    await page.waitForTimeout(1500);
    const title = page.locator('text=/绑定|孩子|添加/');
    await expect(title.first()).toBeVisible({ timeout: 10000 });
    await screenshot(page, '15-family-bind');
  });

  test('15.2 创建孩子账号页面', async ({ page }) => {
    await loginAsParent(page);
    await page.goto('/#/pages/parent/family/create', { timeout: 15000 });
    await page.waitForTimeout(1500);
    const title = page.locator('text=/创建|孩子|新建/');
    await expect(title.first()).toBeVisible({ timeout: 10000 });
    await screenshot(page, '15-family-create');
  });
});

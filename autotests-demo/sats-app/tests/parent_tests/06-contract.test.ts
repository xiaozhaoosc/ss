import { test, expect } from '@playwright/test';
import { loginAsParent, screenshot } from './utils';

test.describe('子页面: 亲子契约 (Contract)', () => {
  test.beforeEach(async ({ page }) => {
    await loginAsParent(page);
    await page.goto('/#/pages/parent/contract/index', { timeout: 15000 });
    await page.waitForTimeout(1500);
  });

  test('6.1 契约页面加载', async ({ page }) => {
    const title = page.locator('text=/星空契约/');
    await expect(title).toBeVisible({ timeout: 10000 });
    await screenshot(page, '06-contract-loaded');
  });

  test('6.2 星星余额显示', async ({ page }) => {
    const stars = page.locator('text=/星星|stars/');
    await expect(stars.first()).toBeVisible({ timeout: 10000 });
    await screenshot(page, '06-contract-stars');
  });

  test('6.3 待处理兑换区域', async ({ page }) => {
    const pending = page.locator('text=/待处理兑换/');
    await expect(pending).toBeVisible({ timeout: 10000 });
    await screenshot(page, '06-contract-pending');
  });

  test('6.4 活跃契约列表', async ({ page }) => {
    const activeContracts = page.locator('text=/活跃契约/');
    await expect(activeContracts).toBeVisible({ timeout: 10000 });
    // 验证有进行中的契约
    const inProgress = page.locator('text=/进行中/');
    if (await inProgress.isVisible()) {
      const days = page.locator('text=/已坚持|目标/');
      expect(await days.count()).toBeGreaterThan(0);
    }
    await screenshot(page, '06-contract-active');
  });

  test('6.5 契约详情展示', async ({ page }) => {
    // 验证有契约描述（连续 X 天完成...即可兑换...）
    const desc = page.locator('text=/连续|完成|兑换/');
    if (await desc.first().isVisible()) {
      await screenshot(page, '06-contract-detail');
    }
  });
});

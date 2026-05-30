import { test, expect } from '@playwright/test';
import { loginAsParent, switchTab, screenshot } from './utils';

test.describe('Tab 3: 家长洞察 (Insights)', () => {
  test.beforeEach(async ({ page }) => {
    await loginAsParent(page);
    await switchTab(page, '洞察');
  });

  test('4.1 洞察页面加载', async ({ page }) => {
    await page.waitForTimeout(1000);
    await page.getByText('家长洞察').scrollIntoViewIfNeeded().catch(() => {});
    await expect(page.getByText('家长洞察')).toBeVisible({ timeout: 15000 });
    await screenshot(page, '04-insights-loaded');
  });

  test('4.2 能力维度展示', async ({ page }) => {
    await page.getByText('创造力').first().scrollIntoViewIfNeeded().catch(() => {});
    await expect(page.getByText('创造力').first()).toBeVisible({ timeout: 15000 });
    await screenshot(page, '04-insights-dimensions');
  });
});

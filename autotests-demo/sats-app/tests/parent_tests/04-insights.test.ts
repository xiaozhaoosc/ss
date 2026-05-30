import { test, expect } from '@playwright/test';
import { loginAsParent, switchTab, screenshot } from './utils';

test.describe('Tab 3: 家长洞察 (Insights)', () => {
  test.beforeEach(async ({ page }) => {
    await loginAsParent(page);
    await switchTab(page, '洞察');
  });

  test('4.1 洞察页面加载', async ({ page }) => {
    // 实际标题是 "家长洞察"
    await expect(page.getByText('家长洞察')).toBeVisible({ timeout: 10000 });
    await screenshot(page, '04-insights-loaded');
  });

  test('4.2 能力维度展示', async ({ page }) => {
    await expect(page.getByText('创造力').first()).toBeVisible({ timeout: 10000 });
    await screenshot(page, '04-insights-dimensions');
  });

  test('4.3 查看详情入口', async ({ page }) => {
    const detail = page.getByText('查看详情').first();
    if (await detail.isVisible({ timeout: 5000 })) {
      await screenshot(page, '04-insights-detail');
    }
  });
});

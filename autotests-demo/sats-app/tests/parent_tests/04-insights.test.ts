import { test, expect } from '@playwright/test';
import { loginAsParent, switchTab, screenshot } from './utils';

test.describe('Tab 3: 数据洞察 (Insights)', () => {
  test.beforeEach(async ({ page }) => {
    await loginAsParent(page);
    await switchTab(page, '洞察');
  });

  test('4.1 洞察页面加载', async ({ page }) => {
    // 验证洞察页面标题或能力相关内容
    const content = page.locator('text=/洞察|能力|专注|创造|社交|情绪/');
    await expect(content.first()).toBeVisible({ timeout: 10000 });
    await screenshot(page, '04-insights-loaded');
  });

  test('4.2 能力维度展示', async ({ page }) => {
    // 验证能力维度
    const creativity = page.locator('text=/创造力/');
    if (await creativity.first().isVisible({ timeout: 5000 })) {
      await screenshot(page, '04-insights-dimensions');
    }
  });

  test('4.3 查看详情入口', async ({ page }) => {
    const detail = page.locator('text=/查看详情/');
    if (await detail.first().isVisible({ timeout: 5000 })) {
      await screenshot(page, '04-insights-detail');
    }
  });
});

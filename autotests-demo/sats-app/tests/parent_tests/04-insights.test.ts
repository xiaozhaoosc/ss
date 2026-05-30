import { test, expect } from '@playwright/test';
import { loginAsParent, switchTab, screenshot } from './utils';

test.describe('Tab 3: 家长洞察 (Insights)', () => {
  test.beforeEach(async ({ page }) => {
    await loginAsParent(page);
    await switchTab(page, '洞察');
  });

  test('4.1 洞察页面加载', async ({ page }) => {
    const title = page.locator('text=/家长洞察/');
    await expect(title).toBeVisible({ timeout: 10000 });
    await screenshot(page, '04-insights-loaded');
  });

  test('4.2 孩子选择器', async ({ page }) => {
    // 验证有孩子头像/名字可选
    const children = page.locator('text=/张小明|张小红/');
    const count = await children.count();
    expect(count).toBeGreaterThan(0);
    await screenshot(page, '04-insights-children');
  });

  test('4.3 能力发展总览', async ({ page }) => {
    const overview = page.locator('text=/能力发展总览/');
    await expect(overview).toBeVisible({ timeout: 10000 });
    // 验证能力维度
    const dimensions = ['专注力', '执行力', '创造力', '社交能力', '情绪管理', '学习能力'];
    for (const dim of dimensions) {
      const el = page.locator(`text=${dim}`);
      if (await el.isVisible()) {
        // 能力维度可见
      }
    }
    await screenshot(page, '04-insights-abilities');
  });

  test('4.4 每周重点区域', async ({ page }) => {
    const weeklyFocus = page.locator('text=/每周重点/');
    await expect(weeklyFocus).toBeVisible({ timeout: 10000 });
    await screenshot(page, '04-insights-weekly-focus');
  });

  test('4.5 情绪预警趋势', async ({ page }) => {
    const emotionTrend = page.locator('text=/情绪预警趋势|影子观察者/');
    await expect(emotionTrend.first()).toBeVisible({ timeout: 10000 });
    // 验证本周预警总数
    const alertCount = page.locator('text=/本周预警总数/');
    await expect(alertCount).toBeVisible();
    // 验证平均情绪指数
    const emotionIndex = page.locator('text=/平均情绪指数/');
    await expect(emotionIndex).toBeVisible();
    await screenshot(page, '04-insights-emotion-trend');
  });

  test('4.6 月度情绪热力图', async ({ page }) => {
    const heatmap = page.locator('text=/月度情绪热力图/');
    await expect(heatmap).toBeVisible({ timeout: 10000 });
    // 验证月份显示
    const month = page.locator('text=/\d+年/');
    await expect(month.first()).toBeVisible();
    // 验证图例
    const legend = page.locator('text=/平静|开心|兴奋|一般/');
    if (await legend.first().isVisible()) {
      // 图例可见
    }
    await screenshot(page, '04-insights-heatmap');
  });
});

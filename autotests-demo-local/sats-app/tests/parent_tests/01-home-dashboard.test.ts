import { test, expect } from '@playwright/test';
import { loginAsParent, screenshot } from './utils';

test.describe('Tab 1: 家长端首页 (Dashboard)', () => {
  test.beforeEach(async ({ page }) => {
    await loginAsParent(page);
  });

  test('1.1 欢迎语显示', async ({ page }) => {
    await expect(page.getByText('欢迎回来')).toBeVisible({ timeout: 15000 });
    await screenshot(page, '01-dashboard-welcome');
  });

  test('1.2 今日焦点统计', async ({ page }) => {
    // 等待页面内容完全加载
    await page.waitForTimeout(1000);
    await page.getByText('今日焦点').scrollIntoViewIfNeeded().catch(() => {});
    await expect(page.getByText('今日焦点')).toBeVisible({ timeout: 15000 });
    await screenshot(page, '01-dashboard-focus');
  });

  test('1.3 执行记录列表', async ({ page }) => {
    await page.getByText('执行记录').scrollIntoViewIfNeeded().catch(() => {});
    await expect(page.getByText('执行记录')).toBeVisible({ timeout: 15000 });
    await screenshot(page, '01-dashboard-records');
  });
});

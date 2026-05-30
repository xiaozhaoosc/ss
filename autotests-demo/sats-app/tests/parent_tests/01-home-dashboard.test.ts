import { test, expect } from '@playwright/test';
import { loginAsParent, screenshot } from './utils';

test.describe('Tab 1: 家长端首页 (Dashboard)', () => {
  test.beforeEach(async ({ page }) => {
    await loginAsParent(page);
  });

  test('1.1 欢迎语显示', async ({ page }) => {
    // 实际显示: "欢迎回来, 家长"
    const welcome = page.locator('text=/欢迎回来/');
    await expect(welcome).toBeVisible({ timeout: 10000 });
    await screenshot(page, '01-dashboard-welcome');
  });

  test('1.2 今日焦点统计', async ({ page }) => {
    // 实际显示: "今日焦点" + "任务总数" + "奖励总数"
    const focus = page.locator('text=/今日焦点/');
    await expect(focus).toBeVisible({ timeout: 10000 });
    await expect(page.locator('text=/任务总数/').first()).toBeVisible();
    await expect(page.locator('text=/奖励总数/').first()).toBeVisible();
    await screenshot(page, '01-dashboard-focus');
  });

  test('1.3 执行记录列表', async ({ page }) => {
    // 实际显示: "执行记录" + "查看全部"
    const records = page.locator('text=/执行记录/');
    await expect(records).toBeVisible({ timeout: 10000 });
    await screenshot(page, '01-dashboard-records');
  });
});

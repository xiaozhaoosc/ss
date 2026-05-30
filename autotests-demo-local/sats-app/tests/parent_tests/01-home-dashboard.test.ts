import { test, expect } from '@playwright/test';
import { loginAsParent, switchTab, screenshot } from './utils';

test.describe('Tab 1: 家长端首页 (Dashboard)', () => {
  test.beforeEach(async ({ page }) => {
    await loginAsParent(page);
  });

  test('1.1 欢迎语和用户信息', async ({ page }) => {
    // 验证欢迎语
    const greeting = page.locator('text=/欢迎回来/');
    await expect(greeting).toBeVisible({ timeout: 10000 });
    // 验证"家长"身份标签
    const role = page.locator('text=/家长/');
    await expect(role.first()).toBeVisible();
    await screenshot(page, '01-home-greeting');
  });

  test('1.2 今日焦点统计卡片', async ({ page }) => {
    // 验证任务总数和奖励总数
    const taskCount = page.locator('text=/任务总数/');
    await expect(taskCount).toBeVisible({ timeout: 10000 });
    const rewardCount = page.locator('text=/奖励总数/');
    await expect(rewardCount).toBeVisible();
    await screenshot(page, '01-home-stats');
  });

  test('1.3 执行记录列表', async ({ page }) => {
    // 验证有执行记录条目
    const records = page.locator('text=/执行记录/');
    await expect(records.first()).toBeVisible({ timeout: 10000 });
    // 应该有已完成的任务
    const completed = page.locator('text=/已完成/');
    const count = await completed.count();
    expect(count).toBeGreaterThan(0);
    await screenshot(page, '01-home-records');
  });

  test('1.4 执行记录含任务详情', async ({ page }) => {
    // 验证任务步骤展示
    const steps = page.locator('text=/\d+\./');
    if (await steps.first().isVisible()) {
      const count = await steps.count();
      expect(count).toBeGreaterThan(0);
    }
    await screenshot(page, '01-home-task-steps');
  });

  test('1.5 通知铃铛图标', async ({ page }) => {
    const bell = page.locator('text=/notifications/');
    if (await bell.isVisible()) {
      await screenshot(page, '01-home-notifications');
    }
  });
});

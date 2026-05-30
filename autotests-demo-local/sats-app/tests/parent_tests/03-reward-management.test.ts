import { test, expect } from '@playwright/test';
import { loginAsParent, screenshot } from './utils';

test.describe('Tab 2: 奖励管理 (Reward Management)', () => {
  test.beforeEach(async ({ page }) => {
    await loginAsParent(page);
    // 直接导航到奖励配置页
    await page.goto('/#/pages/parent/reward-config/index', { timeout: 15000 });
    await page.waitForTimeout(1500);
  });

  test('3.1 奖励设置页面加载', async ({ page }) => {
    const title = page.locator('text=/奖励设置/');
    await expect(title).toBeVisible({ timeout: 10000 });
    await screenshot(page, '03-reward-loaded');
  });

  test('3.2 现有奖励列表', async ({ page }) => {
    // 验证有奖励条目
    const rewards = page.locator('text=/颗星/');
    const count = await rewards.count();
    expect(count).toBeGreaterThan(0);
    await screenshot(page, '03-reward-list');
  });

  test('3.3 添加新奖励按钮', async ({ page }) => {
    const addBtn = page.locator('text=/添加新奖励/');
    await expect(addBtn).toBeVisible({ timeout: 10000 });
    await screenshot(page, '03-reward-add-btn');
  });

  test('3.4 待处理请求区域', async ({ page }) => {
    const pending = page.locator('text=/待处理请求/');
    await expect(pending).toBeVisible({ timeout: 10000 });
    await screenshot(page, '03-reward-pending');
  });

  test('3.5 配置奖励和兑换历史标签', async ({ page }) => {
    const configTab = page.locator('text=/配置奖励/');
    await expect(configTab).toBeVisible({ timeout: 10000 });
    const historyTab = page.locator('text=/兑换历史/');
    await expect(historyTab).toBeVisible();
    await screenshot(page, '03-reward-tabs');
  });
});

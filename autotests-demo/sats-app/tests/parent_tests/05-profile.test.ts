import { test, expect } from '@playwright/test';
import { loginAsParent, switchTab, screenshot } from './utils';

test.describe('Tab 4: 个人中心 (Profile)', () => {
  test.beforeEach(async ({ page }) => {
    await loginAsParent(page);
    await switchTab(page, '我的');
  });

  test('5.1 家长中心标题', async ({ page }) => {
    await expect(page.getByText('家长中心')).toBeVisible({ timeout: 10000 });
    await screenshot(page, '05-profile-title');
  });

  test('5.2 用户名显示', async ({ page }) => {
    await expect(page.getByText('ken2zhao')).toBeVisible({ timeout: 10000 });
    await screenshot(page, '05-profile-username');
  });

  test('5.3 孩子档案列表', async ({ page }) => {
    // 可能需要滚动到孩子档案区域
    await page.getByText('孩子档案').scrollIntoViewIfNeeded({ timeout: 10000 }).catch(() => {});
    await expect(page.getByText('孩子档案')).toBeVisible({ timeout: 10000 });
    await expect(page.getByText('小明').first()).toBeVisible();
    await expect(page.getByText('小红').first()).toBeVisible();
    await screenshot(page, '05-profile-children');
  });

  test('5.4 添加孩子按钮', async ({ page }) => {
    await page.getByText(/添加/).first().scrollIntoViewIfNeeded({ timeout: 5000 }).catch(() => {});
    await expect(page.getByText(/添加/).first()).toBeVisible({ timeout: 10000 });
    await screenshot(page, '05-profile-add');
  });

  test('5.5 通用设置菜单', async ({ page }) => {
    await page.getByText('通用设置').scrollIntoViewIfNeeded({ timeout: 5000 }).catch(() => {});
    await expect(page.getByText('通用设置')).toBeVisible({ timeout: 10000 });
    await expect(page.getByText('亲子契约手册').first()).toBeVisible();
    await expect(page.getByText('情绪急救包').first()).toBeVisible();
    await screenshot(page, '05-profile-settings');
  });
});

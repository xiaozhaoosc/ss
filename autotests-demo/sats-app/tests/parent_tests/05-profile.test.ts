import { test, expect } from '@playwright/test';
import { loginAsParent, switchTab, screenshot } from './utils';

test.describe('Tab 4: 个人中心 (Profile)', () => {
  test.beforeEach(async ({ page }) => {
    await loginAsParent(page);
    await switchTab(page, '我的');
  });

  test('5.1 个人中心页面加载', async ({ page }) => {
    const title = page.locator('text=/家长中心/');
    await expect(title).toBeVisible({ timeout: 10000 });
    await screenshot(page, '05-profile-loaded');
  });

  test('5.2 用户名显示', async ({ page }) => {
    const username = page.locator('text=/ken2zhao/');
    await expect(username).toBeVisible({ timeout: 10000 });
    await screenshot(page, '05-profile-username');
  });

  test('5.3 孩子档案列表', async ({ page }) => {
    const childSection = page.locator('text=/孩子档案/');
    await expect(childSection).toBeVisible({ timeout: 10000 });
    // 验证有孩子条目
    const child1 = page.locator('text=/小红|7岁/');
    await expect(child1.first()).toBeVisible();
    const child2 = page.locator('text=/小明|10岁/');
    await expect(child2.first()).toBeVisible();
    await screenshot(page, '05-profile-children');
  });

  test('5.4 添加孩子按钮', async ({ page }) => {
    const addBtn = page.locator('text=/添加/');
    await expect(addBtn.first()).toBeVisible({ timeout: 10000 });
    await screenshot(page, '05-profile-add-child');
  });

  test('5.5 通用设置菜单项', async ({ page }) => {
    const menuItems = [
      '亲子契约手册',
      '情绪急救包',
      '硬件玩偶设备',
      '通知设置',
      '隐私政策',
      '账号安全',
      '帮助与反馈',
    ];
    for (const item of menuItems) {
      const el = page.locator(`text=${item}`);
      await expect(el).toBeVisible({ timeout: 5000 });
    }
    await screenshot(page, '05-profile-settings');
  });

  test('5.6 退出登录按钮', async ({ page }) => {
    const logoutBtn = page.locator('text=/退出登录/');
    await expect(logoutBtn).toBeVisible({ timeout: 10000 });
    await screenshot(page, '05-profile-logout');
  });

  test('5.7 版本号显示', async ({ page }) => {
    const version = page.locator('text=/v\d+\.\d+\.\d+/');
    await expect(version).toBeVisible({ timeout: 10000 });
    await screenshot(page, '05-profile-version');
  });
});

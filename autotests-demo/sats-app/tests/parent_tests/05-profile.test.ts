import { test, expect } from '@playwright/test';
import { loginAsParent, switchTab, screenshot } from './utils';

test.describe('Tab 4: 个人中心 (Profile)', () => {
  test.beforeEach(async ({ page }) => {
    await loginAsParent(page);
    await switchTab(page, '我的');
  });

  test('5.1 家长中心标题', async ({ page }) => {
    // 实际显示: "家长中心"
    const title = page.locator('text=/家长中心/');
    await expect(title).toBeVisible({ timeout: 10000 });
    await screenshot(page, '05-profile-title');
  });

  test('5.2 用户名显示', async ({ page }) => {
    // 实际显示: "ken2zhao"
    const username = page.locator('text=/ken2zhao/');
    await expect(username).toBeVisible({ timeout: 10000 });
    await screenshot(page, '05-profile-username');
  });

  test('5.3 孩子档案列表', async ({ page }) => {
    // 实际显示: "孩子档案" + "小明" + "小红"
    await expect(page.locator('text=/孩子档案/').first()).toBeVisible({ timeout: 10000 });
    await expect(page.locator('text=/小明/').first()).toBeVisible();
    await expect(page.locator('text=/小红/').first()).toBeVisible();
    await screenshot(page, '05-profile-children');
  });

  test('5.4 添加孩子按钮', async ({ page }) => {
    const addBtn = page.locator('text=/添加/');
    await expect(addBtn.first()).toBeVisible({ timeout: 10000 });
    await screenshot(page, '05-profile-add');
  });

  test('5.5 通用设置菜单', async ({ page }) => {
    // 实际显示: "通用设置" + "亲子契约手册" + "情绪急救包" + "硬件玩偶设备"
    await expect(page.locator('text=/通用设置/').first()).toBeVisible({ timeout: 10000 });
    await expect(page.locator('text=/亲子契约手册/').first()).toBeVisible();
    await expect(page.locator('text=/情绪急救包/').first()).toBeVisible();
    await screenshot(page, '05-profile-settings');
  });
});

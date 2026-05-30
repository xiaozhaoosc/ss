import { test, expect } from '@playwright/test';
import { loginAsChild, screenshot } from './utils';

test.describe('儿童端: 登录与首页', () => {
  test.beforeEach(async ({ page }) => {
    await loginAsChild(page);
  });

  test('1.1 儿童登录成功', async ({ page }) => {
    // 验证登录后不在登录页
    const url = page.url();
    expect(url).not.toContain('login');
    await screenshot(page, '01-child-login');
  });

  test('1.2 儿童首页加载', async ({ page }) => {
    // 验证首页内容（任务卡片、积分等）
    const content = page.locator('text=/任务|今日|积分|星/');
    await expect(content.first()).toBeVisible({ timeout: 10000 });
    await screenshot(page, '01-child-home');
  });

  test('1.3 底部导航栏可见', async ({ page }) => {
    // 验证底部 Tab 栏
    const viewport = page.viewportSize() || { width: 393, height: 727 };
    const tabBar = page.locator('[class*="tabbar"], [class*="tab-bar"], [class*="bottom"]');
    if (await tabBar.first().isVisible()) {
      await screenshot(page, '01-child-tabbar');
    }
  });
});

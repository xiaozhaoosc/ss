import { test, expect } from '@playwright/test';
import { LoginPage } from '../pages/LoginPage';
import { TEST_ACCOUNTS } from '../../fixtures/test-data';

test.describe('Parent Simple Tests', () => {
  let loginPage: LoginPage;

  test.beforeEach(async ({ page }) => {
    loginPage = new LoginPage(page);
  });

  test('Login and verify dashboard elements', async ({ page }) => {
    // 自动登录后直接验证仪表盘页面加载
    await page.goto('/#/pages/parent/dashboard/index');
    await expect(page).toHaveURL(/dashboard/);
    
    // 验证核心元素存在
    await expect(page.locator('.top-app-bar')).toBeVisible();
    await expect(page.locator('.icon-btn')).toBeVisible();
    await expect(page.locator('.section-header').first()).toBeVisible();
  });

  test('Verify profile page elements', async ({ page }) => {
    // 使用自动登录直接导航到个人中心
    await page.goto('/#/pages/parent/profile/index');
    
    // 验证核心元素存在
    await expect(page).toHaveURL(/profile/);
    await expect(page.getByText('添加')).toBeVisible({ timeout: 10000 });
    await expect(page.getByText('退出登录')).toBeVisible();
  });

  test('Verify insights page elements', async ({ page }) => {
    // 使用自动登录直接导航到洞察页面
    await page.goto('/#/pages/parent/insights/index');
    
    // 验证核心元素存在
    await expect(page).toHaveURL(/insights/);
    await expect(page.locator('.section-header').first()).toBeVisible();
  });

  test('Verify task creator page', async ({ page }) => {
    // 使用自动登录直接导航到任务创建页面
    await page.goto('/#/pages/parent/task-creator/index');
    
    // 验证页面加载
    await expect(page).toHaveURL(/task-creator/);
  });
});

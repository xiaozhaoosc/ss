import { test, expect } from '@playwright/test';
import { PROD_ACCOUNTS, PRD_ROUTES } from '../fixtures/prd-test-data';

/**
 * PRD Section 5.2.1 - 多角色权限与路由测试
 * 验证三种角色（管理员、家长、儿童）的登录认证流程
 */

test.describe('PRD 5.2.1 - 多角色登录认证', () => {

  test('家长登录成功后跳转到数据看板', async ({ page }) => {
    await page.goto(PRD_ROUTES.app.login);
    await page.locator('input[type="text"]').first().fill(PROD_ACCOUNTS.parent1.username);
    await page.locator('input[type="password"]').first().fill(PROD_ACCOUNTS.parent1.password);
    await page.locator('.login-btn').click();

    await expect(page).toHaveURL(/.*pages\/parent\/dashboard\/index/, { timeout: 30000 });
    // PRD要求：家长端显示数据看板
    await expect(page.locator('.stats-container, .insight-card')).toBeVisible({ timeout: 10000 });
  });

  test('儿童登录成功后跳转到首页', async ({ page }) => {
    await page.goto(PRD_ROUTES.app.login);
    await page.locator('input[type="text"]').first().fill(PROD_ACCOUNTS.child1.username);
    await page.locator('input[type="password"]').first().fill(PROD_ACCOUNTS.child1.password);
    await page.locator('.login-btn').click();

    await expect(page).toHaveURL(/.*pages\/child\/home\/index/, { timeout: 30000 });
    // PRD要求：儿童端显示任务卡片
    await expect(page.locator('.mission-item, .mission-card').first()).toBeVisible({ timeout: 10000 });
  });

  test('管理员登录成功后跳转到管理后台', async ({ page }) => {
    await page.goto(PRD_ROUTES.admin.login);
    await page.waitForSelector('input[name="username"], input[type="text"]', { timeout: 15000 });
    await page.locator('input[name="username"], input[type="text"]').first().fill(PROD_ACCOUNTS.admin.username);
    await page.locator('input[name="password"], input[type="password"]').first().fill(PROD_ACCOUNTS.admin.password);
    await page.locator('button[type="submit"], .el-button--primary').first().click();

    await expect(page).toHaveURL(/.*webadminss/, { timeout: 30000 });
    // PRD要求：管理后台显示侧边栏菜单
    await expect(page.locator('.el-menu, .sidebar-container')).toBeVisible({ timeout: 10000 });
  });

  test('错误密码登录失败', async ({ page }) => {
    await page.goto(PRD_ROUTES.app.login);
    await page.locator('input[type="text"]').first().fill(PROD_ACCOUNTS.parent1.username);
    await page.locator('input[type="password"]').first().fill('wrong_password_123');
    await page.locator('.login-btn').click();

    // 应停留在登录页或显示错误提示
    await page.waitForTimeout(3000);
    const stillOnLogin = page.url().includes('login');
    const hasError = await page.locator('.uni-toast, .error-msg, .el-message--error').isVisible().catch(() => false);
    expect(stillOnLogin || hasError).toBeTruthy();
  });
});

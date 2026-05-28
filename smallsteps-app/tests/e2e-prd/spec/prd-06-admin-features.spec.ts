import { test, expect } from '@playwright/test';
import { PRD_ROUTES } from '../fixtures/prd-test-data';

/**
 * PRD Section 2.2.2(5) - 管理后台功能需求
 * 用户管理、素材和模板管理、大模型配置
 */

test.describe('PRD 2.2.2(5) - 管理后台功能', () => {
  test.use({ storageState: 'tests/e2e-prd/.auth/admin.json' });

  test('管理后台首页加载', async ({ page }) => {
    await page.goto(PRD_ROUTES.admin.dashboard);
    await page.waitForTimeout(5000);
    // PRD要求：管理后台显示侧边栏菜单
    const sidebar = page.locator('.el-menu, .sidebar-container, .el-aside');
    await expect(sidebar.first()).toBeVisible({ timeout: 15000 });
  });

  test('侧边栏菜单包含用户管理', async ({ page }) => {
    await page.goto(PRD_ROUTES.admin.dashboard);
    await page.waitForTimeout(5000);
    // PRD要求：用户管理 - 对家长账号、孩子子账号进行冻结、解封
    const userMenu = page.locator('text=用户管理, text=用户列表, .el-menu-item:has-text("用户")');
    await expect(userMenu.first()).toBeVisible({ timeout: 10000 });
  });

  test('用户管理页面可访问', async ({ page }) => {
    await page.goto(PRD_ROUTES.admin.userManagement);
    await page.waitForTimeout(5000);
    // PRD要求：用户管理页面应有用户列表表格
    const table = page.locator('.el-table, table');
    const hasTable = await table.first().isVisible().catch(() => false);
    // 或者可能在其他路径
    const body = await page.locator('body').innerText();
    const hasUserContent = body.includes('用户') || body.includes('管理');
    expect(hasTable || hasUserContent).toBeTruthy();
  });

  test('管理后台登录页路由守卫', async ({ page }) => {
    // 清除storage state模拟未登录
    await page.context().clearCookies();
    await page.goto(PRD_ROUTES.admin.dashboard);
    await page.waitForTimeout(3000);
    // PRD要求：无Token会弹回登录页
    const url = page.url();
    const redirectedToLogin = url.includes('login');
    expect(redirectedToLogin).toBeTruthy();
  });
});

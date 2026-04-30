import { test, expect } from '@playwright/test';

test.describe('AI管理模块测试', () => {
  test.beforeEach(async ({ page }) => {
    await page.goto('/');
    await page.getByPlaceholder('用户名').fill('admin');
    await page.getByPlaceholder('密码').fill('admin123');
    await page.click('button:has-text("登 录")');
    await page.waitForURL('**/index**', { timeout: 10000 });
  });

  test('AI模型管理 - 列表页面加载', async ({ page }) => {
    await page.goto('/#/ai/model');
    await page.waitForLoadState('networkidle');
    const title = await page.textContent('h3');
    expect(title).toContain('AI');
  });

  test('AI模型管理 - 添加模型', async ({ page }) => {
    await page.goto('/#/ai/model');
    await page.waitForLoadState('networkidle');
    await page.click('button:has-text("新增")');
    await page.waitForSelector('.el-dialog', { timeout: 5000 });
    const dialog = await page.locator('.el-dialog');
    await expect(dialog).toBeVisible();
  });

  test('AI提示词模板 - 列表页面', async ({ page }) => {
    await page.goto('/#/ai/prompt');
    await page.waitForLoadState('networkidle');
    await page.waitForSelector('.el-table', { timeout: 5000 });
    const table = await page.locator('.el-table');
    await expect(table).toBeVisible();
  });

  test('AI路由配置 - 列表页面', async ({ page }) => {
    await page.goto('/#/ai/route');
    await page.waitForLoadState('networkidle');
    await page.waitForSelector('.el-table', { timeout: 5000 });
    const table = await page.locator('.el-table');
    await expect(table).toBeVisible();
  });

  test('AI供应商配置 - 列表页面', async ({ page }) => {
    await page.goto('/#/ai/provider');
    await page.waitForLoadState('networkidle');
    await page.waitForSelector('.el-table', { timeout: 5000 });
    const table = await page.locator('.el-table');
    await expect(table).toBeVisible();
  });

  test('AI日志 - 列表页面', async ({ page }) => {
    await page.goto('/#/ai/log');
    await page.waitForLoadState('networkidle');
    await page.waitForSelector('.el-table', { timeout: 5000 });
    const table = await page.locator('.el-table');
    await expect(table).toBeVisible();
  });
});
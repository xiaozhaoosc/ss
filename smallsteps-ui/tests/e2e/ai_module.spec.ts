import { test, expect } from '@playwright/test';

test.describe('AI管理模块测试', () => {
  test.beforeEach(async ({ page }) => {
    // Already logged in via storageState
    await page.goto('/');
    
    // Skip guided tour if present
    const skipBtn = page.locator('.introjs-skipbutton');
    if (await skipBtn.isVisible()) {
      await skipBtn.click();
    }
  });

  test('AI模型管理 - 列表页面加载', async ({ page }) => {
    await page.goto('/#/ai/model');
    await page.waitForSelector('.app-container', { timeout: 10000 });
    // Check for the table instead of h3 which doesn't exist in this view
    await page.waitForSelector('.el-table', { timeout: 10000 });
    const table = await page.locator('.el-table');
    await expect(table).toBeVisible();
  });

  test('AI模型管理 - 添加模型', async ({ page }) => {
    await page.goto('/#/ai/model');
    await page.waitForSelector('.app-container', { timeout: 10000 });
    await page.click('button:has-text("新增")');
    await page.waitForSelector('.el-dialog', { timeout: 5000 });
    const dialog = await page.locator('.el-dialog');
    await expect(dialog).toBeVisible();
  });

  test('AI提示词模板 - 列表页面', async ({ page }) => {
    await page.goto('/#/ai/prompt');
    await page.waitForSelector('.app-container', { timeout: 10000 });
    await page.waitForSelector('.el-table', { timeout: 5000 });
    const table = await page.locator('.el-table');
    await expect(table).toBeVisible();
  });

  test('AI路由配置 - 列表页面', async ({ page }) => {
    await page.goto('/#/ai/route');
    await page.waitForSelector('.app-container', { timeout: 10000 });
    await page.waitForSelector('.el-table', { timeout: 5000 });
    const table = await page.locator('.el-table');
    await expect(table).toBeVisible();
  });

  test('AI供应商配置 - 列表页面', async ({ page }) => {
    await page.goto('/#/ai/provider');
    await page.waitForSelector('.app-container', { timeout: 10000 });
    await page.waitForSelector('.el-table', { timeout: 5000 });
    const table = await page.locator('.el-table');
    await expect(table).toBeVisible();
  });

  test('AI日志 - 列表页面', async ({ page }) => {
    await page.goto('/#/ai/log');
    await page.waitForSelector('.app-container', { timeout: 10000 });
    await page.waitForSelector('.el-table', { timeout: 5000 });
    const table = await page.locator('.el-table');
    await expect(table).toBeVisible();
  });
});
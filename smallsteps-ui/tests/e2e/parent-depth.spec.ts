import { test, expect } from '@playwright/test';

test.describe('Parent Center & Insights Depth Test', () => {
  test.beforeEach(async ({ page }) => {
    await page.goto('http://localhost:88/#/login');
    // Fill login form
    await page.locator('input').nth(0).fill('admin');
    await page.locator('input').nth(1).fill('admin123');
    const loginButton = page.locator('button[type="submit"]').or(page.locator('.el-button').first());
    await loginButton.click();
    
    // Wait for redirect and token storage
    await page.waitForURL(/.*dashboard/, { timeout: 15000 });
    await page.waitForFunction(() => localStorage.getItem('Admin-Token') !== null);

    // Skip guided tour if present
    const skipBtn = page.locator('.introjs-skipbutton');
    if (await skipBtn.isVisible()) {
      await skipBtn.click();
    }
  });

  test('Navigate and verify Parent Center', async ({ page }) => {
    // Navigate to Parent dashboard
    await page.goto('http://localhost:88/#/dashboard');
    await page.waitForLoadState('networkidle');
    
    // Ensure no login dialog popped up
    const reLoginDialog = page.getByText('登录状态已过期');
    if (await reLoginDialog.isVisible()) {
        await page.click('button:has-text("确认")');
        await page.waitForURL(/.*login/);
        throw new Error('Login session expired during test');
    }

    // Verify some text on dashboard (e.g. "首页" or dashboard title)
    await expect(page).toHaveURL(/.*dashboard/);
    
    // Check for statistics cards
    const statCards = page.locator('.el-card');
    await expect(statCards.first()).toBeVisible();
    
    // Check for ECharts (usually in a div with canvas)
    const chartCanvas = page.locator('canvas').first();
    await expect(chartCanvas).toBeVisible({ timeout: 10000 });

    const content = await page.textContent('body');
    expect(content).not.toContain('404');
  });
  
  test('Navigate to AI Logs', async ({ page }) => {
    // Attempt to navigate to the newly fixed AI log route
    await page.goto('http://localhost:88/#/ai/log');
    await page.waitForLoadState('networkidle');
    
    // Check for the specific header with a robust wait
    const header = page.locator('h3:has-text("AI 调用日志")');
    await page.waitForSelector('h3:has-text("AI 调用日志")', { timeout: 10000 });
    await expect(header).toBeVisible();
    
    const pageContent = await page.content();
    expect(pageContent).not.toContain('404');
  });
});
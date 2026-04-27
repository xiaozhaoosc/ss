import { test, expect } from '@playwright/test';
test.describe('Depth', () => {
  test.beforeEach(async ({ page }) => {
    await page.goto('http://localhost:88/');
    await page.locator('input').nth(0).fill('ken2zhao');
    await page.locator('input').nth(1).fill('Aa123456');
    await page.locator('.el-button').first().click();
  });
  test('nav', async ({ page }) => {
    await page.waitForSelector('h1', { timeout: 10000 });
    await page.locator('.el-sub-menu__title').hasText('Small Steps').click();
    await page.waitForSelector('.el-menu-item', { timeout: 5000 });
    await page.screenshot({ path: 'nav_menu.png' });
  });
});
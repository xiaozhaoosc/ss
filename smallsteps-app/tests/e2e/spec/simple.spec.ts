import { test, expect } from '@playwright/test';

test('simple check', async ({ page }) => {
  await page.goto('http://www.baidu.com');
  await expect(page).toHaveTitle(/百度/);
});

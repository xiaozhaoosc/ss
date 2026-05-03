import { test as setup, expect } from '@playwright/test';

const authFile = 'playwright/.auth/user.json';

setup('authenticate', async ({ page }) => {
  await page.goto('/');
  await page.waitForSelector('#loader-wrapper', { state: 'hidden', timeout: 30000 });
  
  await page.locator('input[placeholder="用户名"]').fill('admin');
  await page.locator('input[placeholder="密码"]').fill('admin123');
  await page.getByRole('button', { name: '登 录' }).click();

  await page.waitForURL(/.*(dashboard|index)/, { timeout: 30000 });
  await expect(page.getByRole('heading', { name: '早安, 小步守护者' })).toBeVisible({ timeout: 15000 });

  await page.context().storageState({ path: authFile });
});

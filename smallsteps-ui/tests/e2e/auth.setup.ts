import { test as setup, expect } from '@playwright/test';

const authFile = 'playwright/.auth/user.json';

setup('authenticate', async ({ page }) => {
  await page.goto('/');
  await page.waitForSelector('#loader-wrapper', { state: 'hidden', timeout: 30000 });
  
  await page.locator('input').first().fill('admin');
  await page.locator('input[type="password"]').fill('admin123');
  await page.getByText('登 录', { exact: true }).click();

  await page.waitForURL(/.*(dashboard|index)/, { timeout: 30000 });
  
  // 如果新手引导弹出，选择跳过
  const skipButton = page.getByRole('button', { name: '跳过' });
  if (await skipButton.isVisible()) {
    await skipButton.click();
  }

  await expect(page.locator('h1')).toContainText('早安, 小步守护者', { timeout: 15000 });

  await page.context().storageState({ path: authFile });
});

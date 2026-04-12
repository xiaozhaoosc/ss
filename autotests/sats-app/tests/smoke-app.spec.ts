import { test, expect } from '@playwright/test';

test('app login page should load correctly on mobile', async ({ page }) => {
  await page.goto('/');
  // 检查移动端 H5 常见的登录标识或按钮
  await expect(page).toHaveURL(/.*login/);
  // 验证输入框是否可用
  const usernameInput = page.locator('input[type="text"]');
  await expect(usernameInput).toBeVisible();
});

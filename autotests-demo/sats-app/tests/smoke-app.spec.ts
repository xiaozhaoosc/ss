import { test, expect } from '@playwright/test';

test('app login page loads correctly', async ({ page }) => {
  await page.goto('/');
  // H5 移动端用 hash 路由，会跳到 #/ 路径
  await expect(page).toHaveURL(/.*#/);
  // 验证有登录相关的输入框
  const textInputs = page.locator('input[type="text"], input[type="password"]');
  const count = await textInputs.count();
  expect(count).toBeGreaterThanOrEqual(2);
});

test('app has login button', async ({ page }) => {
  await page.goto('/');
  // 查找登录按钮
  const loginBtn = page.locator('button, .login-btn, [class*="login"]').first();
  await expect(loginBtn).toBeVisible();
});

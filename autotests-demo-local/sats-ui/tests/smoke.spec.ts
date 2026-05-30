import { test, expect } from '@playwright/test';

// Admin UI 路径: /

test('has title', async ({ page }) => {
  await page.goto('/');
  await expect(page).toHaveTitle(/Small Steps/);
});

test('login page has username field', async ({ page }) => {
  await page.goto('/');
  const username = page.locator('input[placeholder="用户名"]');
  await expect(username).toBeVisible();
});

test('login page has password field', async ({ page }) => {
  await page.goto('/');
  const password = page.locator('input[placeholder="密码"]');
  await expect(password).toBeVisible();
});

test('login button is visible', async ({ page }) => {
  await page.goto('/');
  // 按钮文字是 "登 录"（中间有空格），用 el-button--primary class 更稳定
  const loginBtn = page.locator('.el-button--primary');
  await expect(loginBtn).toBeVisible();
});

test('can perform login', async ({ page }) => {
  await page.goto('/');
  await page.fill('input[placeholder="用户名"]', 'admin');
  await page.fill('input[placeholder="密码"]', 'admin123');
  await page.locator('.el-button--primary').click();
  // 登录后应该跳转到 dashboard
  await page.waitForURL(/dashboard|index/, { timeout: 10000 });
});

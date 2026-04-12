import { test, expect } from '@playwright/test';

test('has title', async ({ page }) => {
  await page.goto('/');

  // 检查标题是否包含项目名称，或者重定向到了登录页
  await expect(page).toHaveTitle(/SmallSteps|登录/);
});

test('login page has username field', async ({ page }) => {
  await page.goto('/');
  // 根据常见的 admin 模板选择器
  const username = page.locator('input[name="username"], input[placeholder*="账号"]');
  await expect(username).toBeVisible();
});

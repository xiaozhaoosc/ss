import { test, expect } from '@playwright/test';

const MOBILE_URL = 'http://localhost:9090';
const ADMIN_URL = 'http://localhost:88';

const ACCOUNTS_MOBILE = {
  parent1: { user: 'ken2zhao', pass: 'Aa123456' },
  parent2: { user: 'parent_zhang', pass: 'admin123' },
  child1: { user: 'child_xiaoming', pass: 'admin123' },
  child2: { user: 'child_xiaohong', pass: 'admin123' },
};

const ACCOUNTS_ADMIN = {
  admin: { user: 'admin', pass: 'admin123' },
};

test.describe('Mobile App Authentication (9090)', () => {
  for (const [role, creds] of Object.entries(ACCOUNTS_MOBILE)) {
    test(`Login as ${role} on mobile`, async ({ page }) => {
      test.skip(test.info().project.name !== 'mobile-parent');
      await page.goto('/'); // Uses baseURL from project
      await page.waitForSelector('input[type="text"]', { timeout: 10000 });
      await page.fill('input[type="text"]', creds.user);
      await page.fill('input[type="password"]', creds.pass);
      await page.click('text=登 录');
      
      // 检查登录后的状态
      await expect(page).not.toHaveURL(/.*login.*/, { timeout: 10000 });
    });
  }
});

test.describe('Admin Dashboard Authentication (88)', () => {
  for (const [role, creds] of Object.entries(ACCOUNTS_ADMIN)) {
    test(`Login as ${role} on desktop`, async ({ page }) => {
      test.skip(test.info().project.name !== 'desktop-admin');
      await page.goto('/'); // Uses baseURL from project
      // 适配 RuoYi 或类似后台的选择器
      await page.waitForSelector('input[placeholder*="用户名"], input[placeholder*="账号"]', { timeout: 10000 });
      const userSelector = await page.isVisible('input[placeholder*="用户名"]') ? 'input[placeholder*="用户名"]' : 'input[placeholder*="账号"]';
      await page.fill(userSelector, creds.user);
      await page.fill('input[type="password"]', creds.pass);
      await page.click('button:has-text("登 录"), button:has-text("登录")');
      
      await expect(page).not.toHaveURL(/.*login.*/, { timeout: 10000 });
    });
  }
});

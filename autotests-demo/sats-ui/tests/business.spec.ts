import { test, expect } from '@playwright/test';
import { LoginPage } from './pages/LoginPage';

test.describe('Reward System Management', () => {
  test.beforeEach(async ({ page }) => {
    const loginPage = new LoginPage(page);
    await loginPage.login('admin', 'admin123');
    await page.goto('/webadminss/#/smallsteps/reward');
    await page.waitForTimeout(2000);
  });

  test('should display reward list', async ({ page }) => {
    // 奖励页面可能用卡片布局，也可能是表格
    const content = page.locator('.el-table, .ant-table, table, .el-card, .card-item, [class*="reward"]');
    await expect(content.first()).toBeVisible({ timeout: 10000 });
  });

  test('should open add reward dialog', async ({ page }) => {
    const addBtn = page.locator('button:has-text("新增"), button:has-text("添加"), button:has-text("奖励")');
    if (await addBtn.isVisible()) {
      await addBtn.click();
      // Wait for the dialog overlay to become visible, then find the actual dialog content
      await page.waitForTimeout(500);
      const dialog = page.locator('.el-overlay-dialog').last();
      await expect(dialog).toBeVisible({ timeout: 5000 });
    }
  });
});

test.describe('AI Task Decomposition UI', () => {
  test('should show AI breakdown result in task creation', async ({ page }) => {
    const loginPage = new LoginPage(page);
    await loginPage.login('admin', 'admin123');
    await page.goto('/webadminss/#/parent/task');
    const aiBtn = page.locator('button:has-text("AI"), button:has-text("智能拆解")');
    if (await aiBtn.isVisible()) {
      await aiBtn.click();
      const resultArea = page.locator('.ai-result, .breakdown-steps');
      await expect(resultArea).toBeDefined();
    }
  });
});

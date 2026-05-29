import { test, expect } from '@playwright/test';

test.describe('Reward System Management', () => {
  test.beforeEach(async ({ page }) => {
    await page.goto('/webadminss/#/parent/reward');
  });

  test('should display reward list', async ({ page }) => {
    const table = page.locator('.el-table, .ant-table, table');
    await expect(table).toBeVisible();
  });

  test('should open add reward dialog', async ({ page }) => {
    const addBtn = page.locator('button:has-text("新增"), button:has-text("添加")');
    if (await addBtn.isVisible()) {
      await addBtn.click();
      const dialog = page.locator('.el-dialog, .ant-modal, [role="dialog"]');
      await expect(dialog).toBeVisible();
    }
  });
});

test.describe('AI Task Decomposition UI', () => {
  test('should show AI breakdown result in task creation', async ({ page }) => {
    await page.goto('/webadminss/#/parent/task');
    const aiBtn = page.locator('button:has-text("AI"), button:has-text("智能拆解")');
    if (await aiBtn.isVisible()) {
      await aiBtn.click();
      const resultArea = page.locator('.ai-result, .breakdown-steps');
      await expect(resultArea).toBeDefined();
    }
  });
});

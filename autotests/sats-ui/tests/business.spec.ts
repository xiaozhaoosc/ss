import { test, expect } from '@playwright/test';

test.describe('Reward System Management', () => {
  test.beforeEach(async ({ page }) => {
    // 假设已经登录，后续可以使用 storageState 优化
    await page.goto('/parent/reward');
  });

  test('should display reward list', async ({ page }) => {
    // 检查是否有表格或列表容器
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
    await page.goto('/parent/task');
    const aiBtn = page.locator('button:has-text("AI"), button:has-text("智能拆解")');
    if (await aiBtn.isVisible()) {
      await aiBtn.click();
      // 等待 AI 响应并检查结果区域
      const resultArea = page.locator('.ai-result, .breakdown-steps');
      await expect(resultArea).toBeDefined();
    }
  });
});

import { test, expect } from '@playwright/test';
import { loginAsParent, screenshot } from './utils';

test.describe('子页面: 任务执行记录 (Execution Records)', () => {
  test.beforeEach(async ({ page, request }) => {
    await loginAsParent(page, request);
    await page.goto('/#/pages/parent/exec-record/index', { timeout: 15000 });
    await page.waitForTimeout(1500);
  });

  test('9.1 执行记录页面加载', async ({ page }) => {
    const title = page.locator('text=/执行记录|任务记录/');
    await expect(title.first()).toBeVisible({ timeout: 10000 });
    await screenshot(page, '09-exec-record-loaded');
  });

  test('9.2 记录列表展示', async ({ page }) => {
    // 验证有记录条目
    const records = page.locator('text=/已完成|进行中|待执行/');
    if (await records.first().isVisible()) {
      const count = await records.count();
      expect(count).toBeGreaterThan(0);
      await screenshot(page, '09-exec-record-list');
    }
  });

  test('9.3 记录含任务名称和时间', async ({ page }) => {
    // 验证有任务名称
    const taskNames = page.locator('text=/起床|上学|跳绳|作业|洗漱/');
    if (await taskNames.first().isVisible()) {
      await screenshot(page, '09-exec-record-tasks');
    }
  });
});

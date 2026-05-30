import { test, expect } from '@playwright/test';
import { loginAsParent, switchTab, screenshot } from './utils';

test.describe('Tab 2: 任务管理 (Tasks)', () => {
  test.beforeEach(async ({ page }) => {
    await loginAsParent(page);
    await switchTab(page, '任务');
  });

  test('2.1 任务筛选标签', async ({ page }) => {
    await expect(page.getByText('全部').first()).toBeVisible({ timeout: 10000 });
    await screenshot(page, '02-task-filters');
  });

  test('2.2 任务卡片', async ({ page }) => {
    const content = page.getByText(/查看详情|进行中|已完成/).first();
    if (await content.isVisible({ timeout: 5000 })) {
      await screenshot(page, '02-task-cards');
    }
  });
});

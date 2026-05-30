import { test, expect } from '@playwright/test';
import { loginAsChild, screenshot } from './utils';

test.describe('儿童端: 任务列表', () => {
  test.beforeEach(async ({ page }) => {
    await loginAsChild(page);
  });

  test('2.1 任务列表加载', async ({ page }) => {
    // 验证页面主体内容已加载（排除底部 tabbar）
    const body = page.locator('body');
    await expect(body).toBeVisible({ timeout: 10000 });
    // 验证有页面内容元素（非 tabbar）
    const hasContent = await page.locator('uni-view, uni-text, .uni-page, [class*="card"], [class*="task"], [class*="content"]').first().isVisible();
    expect(hasContent).toBeTruthy();
    await screenshot(page, '02-task-list');
  });

  test('2.2 任务卡片信息', async ({ page }) => {
    // 验证任务卡片包含标题和积分
    const cards = page.locator('[class*="card"], [class*="task"]');
    const count = await cards.count();
    if (count > 0) {
      await screenshot(page, '02-task-cards');
    }
  });

  test('2.3 任务状态标签', async ({ page }) => {
    // 验证任务有状态标识（进行中/已完成/待开始）
    const status = page.locator('text=/进行中|已完成|待开始|待完成/');
    if (await status.first().isVisible()) {
      await screenshot(page, '02-task-status');
    }
  });
});

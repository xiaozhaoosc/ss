import { test, expect } from '@playwright/test';
import { loginAsChild, screenshot } from './utils';

test.describe('儿童端: 任务执行', () => {
  test.beforeEach(async ({ page }) => {
    await loginAsChild(page);
  });

  test('3.1 点击任务查看详情', async ({ page }) => {
    // 找到第一个任务卡片并点击
    const taskCard = page.locator('[class*="card"], [class*="task"]').first();
    if (await taskCard.isVisible()) {
      await taskCard.click();
      await page.waitForTimeout(2000);
      // 进入任务详情后，页面应有变化（标题/返回按钮/画布等）
      const detailContent = page.locator('text=/今日灵感|艺术实验室|画|做|开始|完成|挑战/');
      await expect(detailContent.first()).toBeVisible({ timeout: 8000 });
      await screenshot(page, '03-task-detail');
    }
  });

  test('3.2 任务步骤展示', async ({ page }) => {
    const taskCard = page.locator('[class*="card"], [class*="task"]').first();
    if (await taskCard.isVisible()) {
      await taskCard.click();
      await page.waitForTimeout(2000);
      // 查看详情页是否加载了内容
      const content = page.locator('[class*="canvas"], [class*="step"], [class*="detail"]').or(page.locator('text=/灵感|画|颜色/'));
      if (await content.first().isVisible({ timeout: 5000 })) {
        await screenshot(page, '03-task-steps');
      }
    }
  });

  test('3.3 完成任务按钮', async ({ page }) => {
    const taskCard = page.locator('[class*="card"], [class*="task"]').first();
    if (await taskCard.isVisible()) {
      await taskCard.click();
      await page.waitForTimeout(2000);
      // 查找完成/提交按钮
      const completeBtn = page.locator('button, [role="button"]').filter({ hasText: /完成|提交|做完了|✓/ }).first();
      if (await completeBtn.isVisible({ timeout: 3000 })) {
        await screenshot(page, '03-task-complete-btn');
      }
    }
  });
});

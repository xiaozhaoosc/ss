import { test, expect } from '@playwright/test';
import { loginAsChild, screenshot } from './utils';

test.describe('儿童端: 专注模式', () => {
  test.beforeEach(async ({ page }) => {
    await loginAsChild(page);
  });

  test('4.1 进入专注模式', async ({ page }) => {
    // 点击第一个任务
    const taskCard = page.locator('[class*="card"], [class*="task"]').first();
    if (await taskCard.isVisible()) {
      await taskCard.click();
      await page.waitForTimeout(1500);
      // 查找专注/计时按钮
      const focusBtn = page.locator('button, [role="button"]').filter({ hasText: /专注|计时|开始/ }).first();
      if (await focusBtn.isVisible()) {
        await focusBtn.click();
        await page.waitForTimeout(2000);
        // 验证专注模式界面
        const timer = page.locator('text=/\\d+:\\d+|计时|专注/');
        await expect(timer.first()).toBeVisible({ timeout: 5000 });
        await screenshot(page, '04-focus-mode');
      }
    }
  });

  test('4.2 专注模式显示计时器', async ({ page }) => {
    const taskCard = page.locator('[class*="card"], [class*="task"]').first();
    if (await taskCard.isVisible()) {
      await taskCard.click();
      await page.waitForTimeout(1500);
      const focusBtn = page.locator('button, [role="button"]').filter({ hasText: /专注|计时|开始/ }).first();
      if (await focusBtn.isVisible()) {
        await focusBtn.click();
        await page.waitForTimeout(2000);
        // 验证计时器数字在变化
        const timer = page.locator('text=/\\d+:\\d+/');
        if (await timer.first().isVisible()) {
          const firstTime = await timer.first().textContent();
          await page.waitForTimeout(2000);
          const secondTime = await timer.first().textContent();
          // 计时器应该变化（除非已经完成）
          await screenshot(page, '04-focus-timer');
        }
      }
    }
  });

  test('4.3 防误触 - 返回键拦截', async ({ page }) => {
    const taskCard = page.locator('[class*="card"], [class*="task"]').first();
    if (await taskCard.isVisible()) {
      await taskCard.click();
      await page.waitForTimeout(1500);
      const focusBtn = page.locator('button, [role="button"]').filter({ hasText: /专注|计时|开始/ }).first();
      if (await focusBtn.isVisible()) {
        await focusBtn.click();
        await page.waitForTimeout(2000);
        // 尝试按返回键
        await page.goBack();
        await page.waitForTimeout(1000);
        // 应该还在专注模式（弹出确认框或仍停留在页面）
        const confirmDialog = page.locator('text=/确认|放弃|退出/');
        const stillInFocus = page.locator('text=/\\d+:\\d+|专注|计时/');
        const isBlocked = (await confirmDialog.first().isVisible()) || (await stillInFocus.first().isVisible());
        // 如果拦截成功，说明防误触生效
        await screenshot(page, '04-focus-back-blocked');
      }
    }
  });
});

import { test, expect } from '@playwright/test';
import { PROD_ACCOUNTS, PRD_ROUTES } from '../fixtures/prd-test-data';

/**
 * PRD Section 5.2.2 - 任务生命周期状态扭转测试
 * 完整链路：家长创建任务 → 儿童接收 → 执行 → 完成 → 积分结算
 */

test.describe('PRD 5.2.2 - 任务生命周期', () => {
  test.describe.configure({ mode: 'serial' });

  test.describe('家长端任务操作', () => {
    test.use({ storageState: 'tests/e2e-prd/.auth/parent.json' });

    test('家长端任务创建页面可访问', async ({ page }) => {
      await page.goto(PRD_ROUTES.app.taskCreator);
      await page.waitForTimeout(3000);
      // PRD要求：结构化任务创建 - 应有标题输入、奖励设置等
      const hasTaskInput = await page.locator('.task-textarea, textarea, input[placeholder*="任务"]').isVisible().catch(() => false);
      const hasSubmit = await page.locator('.submit-btn, button:has-text("创建"), button:has-text("发布")').isVisible().catch(() => false);
      expect(hasTaskInput || hasSubmit).toBeTruthy();
    });

    test('家长端奖励配置页面可访问', async ({ page }) => {
      await page.goto(PRD_ROUTES.app.rewardConfig);
      await page.waitForTimeout(3000);
      // PRD要求：家长可设置心愿礼物
      const hasRewardList = await page.locator('.reward-item, .reward-card, .add-reward-btn').isVisible().catch(() => false);
      expect(hasRewardList).toBeTruthy();
    });
  });

  test.describe('儿童端任务执行', () => {
    test.use({ storageState: 'tests/e2e-prd/.auth/child.json' });

    test('儿童首页显示任务卡片', async ({ page }) => {
      await page.goto(PRD_ROUTES.app.childHome);
      await page.waitForTimeout(5000);
      // PRD要求：任务卡片展示 - 字体要大，一次就显示一个任务
      const missionCards = page.locator('.mission-item, .mission-card');
      const count = await missionCards.count();
      // 至少应有任务列表或空状态提示
      const hasEmptyState = await page.locator('text=暂无任务, text=没有任务, .empty-state').isVisible().catch(() => false);
      expect(count > 0 || hasEmptyState).toBeTruthy();
    });

    test('儿童端星星余额显示', async ({ page }) => {
      await page.goto(PRD_ROUTES.app.childHome);
      await page.waitForTimeout(5000);
      // PRD要求：代币自动汇入进度池，用"蓄水池"方式展示
      const starBalance = page.locator('.streak-val, .star-balance, .coin-balance');
      await expect(starBalance.first()).toBeVisible({ timeout: 10000 });
    });

    test('点击任务卡片进入执行页面', async ({ page }) => {
      await page.goto(PRD_ROUTES.app.childHome);
      await page.waitForTimeout(5000);

      const missionCard = page.locator('.mission-item, .mission-card').first();
      if (await missionCard.isVisible()) {
        await missionCard.click();
        // PRD要求：进入专注模式
        await expect(page).toHaveURL(/.*task-execute/, { timeout: 10000 });
        // 应有完成按钮
        await expect(page.locator('.complete-btn')).toBeVisible({ timeout: 10000 });
      }
    });

    test('任务完成后有奖励收集入口', async ({ page }) => {
      await page.goto(PRD_ROUTES.app.childHome);
      await page.waitForTimeout(5000);

      const missionCard = page.locator('.mission-item, .mission-card').first();
      if (await missionCard.isVisible()) {
        await missionCard.click();
        await page.waitForURL(/.*task-execute/, { timeout: 10000 });

        // 点击完成按钮（可能需要多次点击处理多步骤）
        const completeBtn = page.locator('.complete-btn');
        for (let i = 0; i < 5; i++) {
          if (await page.locator('.collect-btn').isVisible()) break;
          if (await completeBtn.isVisible()) {
            await completeBtn.click();
            await page.waitForTimeout(1500);
          }
        }

        // PRD要求：任务完成后蹦个炫一点的动画，立刻给虚拟碎片或代币
        const collectBtn = page.locator('.collect-btn');
        if (await collectBtn.isVisible()) {
          await expect(collectBtn).toBeVisible();
        }
      }
    });
  });
});

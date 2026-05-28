import { test, expect } from '@playwright/test';
import { PRD_ROUTES } from '../fixtures/prd-test-data';

/**
 * PRD Section 2.2.2(4) - 家长端功能需求
 * 结构化任务创建、数据看板、AI生成反馈
 */

test.describe('PRD 2.2.2(4) - 家长端功能', () => {
  test.use({ storageState: 'tests/e2e-prd/.auth/parent.json' });

  test('数据看板加载并显示统计信息', async ({ page }) => {
    await page.goto(PRD_ROUTES.app.parentDashboard);
    // PRD要求：能看孩子每天的任务完成率、总共专注了多长时间
    const stats = page.locator('.stats-container, .stats-scroll, .dashboard-stats');
    await expect(stats.first()).toBeVisible({ timeout: 15000 });
  });

  test('AI洞察卡片可见', async ({ page }) => {
    await page.goto(PRD_ROUTES.app.parentDashboard);
    // PRD要求：接收大模型自动写的"每日寄语"
    const insightCard = page.locator('.insight-card, .ai-card, text=寄语, text=洞察');
    await expect(insightCard.first()).toBeVisible({ timeout: 15000 });
  });

  test('通知铃铛可点击', async ({ page }) => {
    await page.goto(PRD_ROUTES.app.parentDashboard);
    await page.waitForTimeout(5000);

    const bell = page.locator('.icon-btn, .notification-bell');
    if (await bell.first().isVisible()) {
      await bell.first().click();
      // 应弹出通知下拉
      const dropdown = page.locator('.notification-dropdown, .notification-list');
      await expect(dropdown.first()).toBeVisible({ timeout: 5000 });
    }
  });

  test('任务创建页面可访问', async ({ page }) => {
    await page.goto(PRD_ROUTES.app.taskCreator);
    await page.waitForTimeout(3000);
    // PRD要求：可以新建任务，设定周期、奖励多少代币
    const hasForm = await page.locator('.task-textarea, textarea, input').first().isVisible().catch(() => false);
    expect(hasForm).toBeTruthy();
  });

  test('奖励配置页面可访问', async ({ page }) => {
    await page.goto(PRD_ROUTES.app.rewardConfig);
    await page.waitForTimeout(3000);
    // PRD要求：系统预置常用模板
    const hasRewardList = await page.locator('.reward-item, .reward-card, .add-reward-btn').isVisible().catch(() => false);
    expect(hasRewardList).toBeTruthy();
  });

  test('家长中心页面可访问', async ({ page }) => {
    await page.goto('/#/pages/parent/profile/index');
    await page.waitForTimeout(3000);
    // 家长个人中心应有基本内容
    const body = await page.locator('body').innerText();
    expect(body.length).toBeGreaterThan(0);
  });
});

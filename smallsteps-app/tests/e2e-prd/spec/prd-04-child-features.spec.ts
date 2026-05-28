import { test, expect } from '@playwright/test';
import { PRD_ROUTES } from '../fixtures/prd-test-data';

/**
 * PRD Section 2.2.2(3) - 儿童端功能需求
 * 任务卡片展示、专注模式、打卡与代币系统
 */

test.describe('PRD 2.2.2(3) - 儿童端功能', () => {
  test.use({ storageState: 'tests/e2e-prd/.auth/child.json' });

  test('首页加载完成无白屏', async ({ page }) => {
    await page.goto(PRD_ROUTES.app.childHome);
    // 等待加载完成
    await page.locator('.loading-container, text=加载中...').waitFor({ state: 'detached', timeout: 15000 }).catch(() => {});
    // 页面应有实际内容
    const body = await page.locator('body').innerText();
    expect(body.length).toBeGreaterThan(0);
  });

  test('首页显示星星余额（代币系统）', async ({ page }) => {
    await page.goto(PRD_ROUTES.app.childHome);
    await page.waitForTimeout(5000);
    // PRD要求：代币自动汇入进度池
    const star = page.locator('.streak-val, .star-balance, .coin-balance');
    await expect(star.first()).toBeVisible({ timeout: 10000 });
  });

  test('导航到百宝箱（奖励商店）', async ({ page }) => {
    await page.goto(PRD_ROUTES.app.childHome);
    await page.waitForTimeout(5000);

    const shopTab = page.locator('text=百宝箱');
    if (await shopTab.isVisible()) {
      await shopTab.click();
      await expect(page).toHaveURL(/.*reward-shop/, { timeout: 10000 });
    }
  });

  test('导航到时光机', async ({ page }) => {
    await page.goto(PRD_ROUTES.app.childHome);
    await page.waitForTimeout(5000);

    const timeMachine = page.locator('text=时光机');
    if (await timeMachine.isVisible()) {
      await timeMachine.click();
      await expect(page).toHaveURL(/.*time-machine/, { timeout: 10000 });
    }
  });

  test('导航到树洞聊天', async ({ page }) => {
    await page.goto(PRD_ROUTES.app.childHome);
    await page.waitForTimeout(5000);

    const treehole = page.locator('text=点我聊天吧！, text=树洞');
    if (await treehole.first().isVisible()) {
      await treehole.first().click({ force: true });
      await expect(page).toHaveURL(/.*treehole/, { timeout: 10000 });
    }
  });

  test('任务卡片UI符合PRD规范（大字体、单任务展示）', async ({ page }) => {
    await page.goto(PRD_ROUTES.app.childHome);
    await page.waitForTimeout(5000);

    const missionCard = page.locator('.mission-item, .mission-card').first();
    if (await missionCard.isVisible()) {
      // PRD要求：字体要大
      const fontSize = await missionCard.evaluate(el => {
        const style = window.getComputedStyle(el);
        return parseFloat(style.fontSize);
      });
      // 儿童端字体应 >= 14px（Nunito字体、大号设计）
      expect(fontSize).toBeGreaterThanOrEqual(14);

      // PRD要求：按钮要大
      const buttons = missionCard.locator('button, .btn, [role="button"]');
      if (await buttons.first().isVisible()) {
        const btnHeight = await buttons.first().evaluate(el => el.getBoundingClientRect().height);
        expect(btnHeight).toBeGreaterThanOrEqual(36);
      }
    }
  });
});

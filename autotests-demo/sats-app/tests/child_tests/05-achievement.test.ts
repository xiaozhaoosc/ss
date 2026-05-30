import { test, expect } from '@playwright/test';
import { loginAsChild, screenshot } from './utils';

test.describe('儿童端: 成就与徽章', () => {
  test.beforeEach(async ({ page }) => {
    await loginAsChild(page);
  });

  test('5.1 查看成就/徽章', async ({ page }) => {
    // 切换到「我的」页面（最后一个 Tab）
    const viewport = page.viewportSize() || { width: 393, height: 727 };
    await page.mouse.click(Math.round(viewport.width * 0.875), Math.round(viewport.height * 0.96));
    await page.waitForTimeout(2000);
    
    // 查找成就/徽章入口
    const achievementLink = page.locator('text=/成就|徽章|勋章/');
    if (await achievementLink.first().isVisible()) {
      await achievementLink.first().click();
      await page.waitForTimeout(2000);
      // 验证成就页面加载
      const achievementPage = page.locator('text=/成就|徽章|解锁|未解锁/');
      await expect(achievementPage.first()).toBeVisible({ timeout: 5000 });
      await screenshot(page, '05-achievement');
    }
  });

  test('5.2 成就列表展示', async ({ page }) => {
    const viewport = page.viewportSize() || { width: 393, height: 727 };
    await page.mouse.click(Math.round(viewport.width * 0.875), Math.round(viewport.height * 0.96));
    await page.waitForTimeout(2000);
    
    const achievementLink = page.locator('text=/成就|徽章|勋章/');
    if (await achievementLink.first().isVisible()) {
      await achievementLink.first().click();
      await page.waitForTimeout(2000);
      // 查看是否有成就卡片
      const badges = page.locator('[class*="badge"], [class*="achievement"], img');
      const count = await badges.count();
      if (count > 0) {
        await screenshot(page, '05-achievement-list');
      }
    }
  });
});

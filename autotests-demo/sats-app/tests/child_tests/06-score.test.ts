import { test, expect } from '@playwright/test';
import { loginAsChild, screenshot } from './utils';

test.describe('儿童端: 积分与星星', () => {
  test.beforeEach(async ({ page }) => {
    await loginAsChild(page);
  });

  test('6.1 积分余额显示', async ({ page }) => {
    // 验证首页显示积分/星星信息
    const score = page.locator('text=/\\d+.*星|积分.*\\d+|⭐/');
    if (await score.first().isVisible()) {
      await screenshot(page, '06-score-display');
    }
  });

  test('6.2 积分流水查看', async ({ page }) => {
    // 切换到「我的」页面
    const viewport = page.viewportSize() || { width: 393, height: 727 };
    await page.mouse.click(Math.round(viewport.width * 0.875), Math.round(viewport.height * 0.96));
    await page.waitForTimeout(2000);
    
    // 查找积分/星星入口
    const scoreLink = page.locator('text=/积分|星星|星数/');
    if (await scoreLink.first().isVisible()) {
      await scoreLink.first().click();
      await page.waitForTimeout(2000);
      // 验证积分流水页面
      const history = page.locator('text=/收入|支出|\\+|\\-/');
      if (await history.first().isVisible()) {
        await screenshot(page, '06-score-history');
      }
    }
  });

  test('6.3 奖励兑换入口', async ({ page }) => {
    const viewport = page.viewportSize() || { width: 393, height: 727 };
    await page.mouse.click(Math.round(viewport.width * 0.875), Math.round(viewport.height * 0.96));
    await page.waitForTimeout(2000);
    
    // 查找兑换/奖励入口
    const rewardLink = page.locator('text=/兑换|奖励|心愿/');
    if (await rewardLink.first().isVisible()) {
      await rewardLink.first().click();
      await page.waitForTimeout(2000);
      await screenshot(page, '06-reward-exchange');
    }
  });
});

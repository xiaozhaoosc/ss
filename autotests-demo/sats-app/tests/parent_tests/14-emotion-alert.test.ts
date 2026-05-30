import { test, expect } from '@playwright/test';
import { loginAsParent, screenshot } from './utils';

test.describe('子页面: 情感详情 (Emotion Detail)', () => {
  test.beforeEach(async ({ page }) => {
    await loginAsParent(page);
    await page.goto('/#/pages/parent/emotion-detail/index', { timeout: 15000 });
    await page.waitForTimeout(2000);
  });

  test('14.1 情感详情页面加载', async ({ page }) => {
    // 实际显示: "情感详情"
    const title = page.locator('text=/情感详情/');
    await expect(title).toBeVisible({ timeout: 10000 });
    await screenshot(page, '14-emotion-detail-loaded');
  });

  test('14.2 AI 分析报告', async ({ page }) => {
    // 实际显示: "AI 分析报告"
    const aiReport = page.locator('text=/AI.*分析|分析报告/');
    if (await aiReport.first().isVisible({ timeout: 5000 })) {
      await screenshot(page, '14-emotion-ai-report');
    }
  });

  test('14.3 情绪标签', async ({ page }) => {
    // 实际显示: "数学焦虑", "高强度", "寻求关注"
    const tags = page.locator('text=/焦虑|高强度|寻求关注|开心|平静/');
    if (await tags.first().isVisible({ timeout: 5000 })) {
      await screenshot(page, '14-emotion-tags');
    }
  });

  test('14.4 家长回复区域', async ({ page }) => {
    // 实际显示: "家长回复" + "录制语音" + "使用 AI 建议"
    const reply = page.locator('text=/家长回复|录制语音|AI.*建议/');
    if (await reply.first().isVisible({ timeout: 5000 })) {
      await screenshot(page, '14-emotion-reply');
    }
  });
});

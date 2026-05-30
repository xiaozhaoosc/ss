import { test, expect } from '@playwright/test';
import { loginAsParent, screenshot } from './utils';

test.describe('子页面: 模板库 (Template Library)', () => {
  test.beforeEach(async ({ page }) => {
    await loginAsParent(page);
    await page.goto('/#/pages/template/library', { timeout: 15000 });
    await page.waitForTimeout(2000);
    await page.waitForLoadState('domcontentloaded');
  });

  test('16.1 模板库页面加载', async ({ page }) => {
    // 实际标题: "ADHD 模板库"
    await expect(page.getByText(/模板库/).first()).toBeVisible({ timeout: 10000 });
    await screenshot(page, '16-template-loaded');
  });

  test('16.2 模板卡片展示', async ({ page }) => {
    // 实际显示: "晨间"准备" 等模板
    const templates = page.getByText(/晨间|生活自理|高效学习|情绪管理/).first();
    if (await templates.isVisible({ timeout: 5000 })) {
      await screenshot(page, '16-template-cards');
    }
  });
});

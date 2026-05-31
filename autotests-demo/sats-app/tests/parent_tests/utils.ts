import { Page, expect } from '@playwright/test';

/** 家长账号凭据 */
export const PARENT_CREDS = { username: 'ken2zhao', password: 'admin123' };

/** 登录为家长 */
export async function loginAsParent(page: Page) {
  await page.goto('/', { timeout: 20000, waitUntil: 'domcontentloaded' });
  await page.waitForURL(/.*#/, { timeout: 15000 });
  await page.waitForTimeout(1000);

  await page.locator('input').first().fill(PARENT_CREDS.username);
  await page.locator('input[type="password"]').fill(PARENT_CREDS.password);

  const loginBtn = page.locator('button, [role="button"], [class*="btn"]').filter({ hasText: /登\s*录/ }).first();
  await loginBtn.click();

  // 等待首页加载完成
  await page.waitForTimeout(4000);
}

/** 切换到指定 Tab — 通过点击 tab 文字元素 */
export async function switchTab(page: Page, tabName: '首页' | '任务' | '洞察' | '我的') {
  const tabEls = page.locator(`text=${tabName}`);
  const count = await tabEls.count();
  for (let i = count - 1; i >= 0; i--) {
    const el = tabEls.nth(i);
    const box = await el.boundingBox();
    if (box && box.y > 700) {
      await el.click({ force: true });
      await page.waitForTimeout(3000);
      return;
    }
  }
  // fallback: 坐标点击（y=794 是实际 tab 栏位置）
  const viewport = page.viewportSize() || { width: 375, height: 812 };
  const tabPositions = { '首页': 0.125, '任务': 0.375, '洞察': 0.625, '我的': 0.875 };
  const x = Math.round(viewport.width * tabPositions[tabName]);
  await page.mouse.click(x, 794);
  await page.waitForTimeout(3000);
}

/** 截图并返回路径 */
export async function screenshot(page: Page, name: string) {
  const path = `test-results/parent/${name}.png`;
  await page.screenshot({ path, timeout: 15000 });
  return path;
}

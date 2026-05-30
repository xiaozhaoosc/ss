import { Page, expect } from '@playwright/test';

/** 家长账号凭据 */
export const PARENT_CREDS = { username: 'ken2zhao', password: 'Aa123456' };

/** Tab 名称到索引的映射 */
export const TAB_MAP = { '首页': 0, '任务': 1, '洞察': 2, '我的': 3 } as const;

/** 登录为家长 */
export async function loginAsParent(page: Page) {
  await page.goto('/', { timeout: 20000, waitUntil: 'domcontentloaded' });
  await page.waitForURL(/.*#/, { timeout: 15000 });
  await page.waitForTimeout(500);

  // 填写用户名和密码
  await page.locator('input').first().fill(PARENT_CREDS.username);
  await page.locator('input[type="password"]').fill(PARENT_CREDS.password);

  // 点击登录按钮
  const loginBtn = page.locator('button, [role="button"], [class*="btn"]').filter({ hasText: /登\s*录/ }).first();
  await loginBtn.click();

  // 等待登录完成
  await page.waitForTimeout(3000);
}

/** 切换到指定 Tab（底部导航栏） — 坐标点击法 */
export async function switchTab(page: Page, tabName: '首页' | '任务' | '洞察' | '我的') {
  const viewport = page.viewportSize() || { width: 375, height: 812 };
  const tabPositions = { '首页': 0.125, '任务': 0.375, '洞察': 0.625, '我的': 0.875 };
  const x = Math.round(viewport.width * tabPositions[tabName]);
  const y = Math.round(viewport.height * 0.96); // 底部 Tab 栏在视口 96% 高度处
  await page.mouse.click(x, y);
  await page.waitForTimeout(1500);
}

/** 截图并返回路径 */
export async function screenshot(page: Page, name: string) {
  const path = `test-results/parent/${name}.png`;
  await page.screenshot({ path });
  return path;
}

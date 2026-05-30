import { Page, expect } from '@playwright/test';

/** 家长账号凭据 */
export const PARENT_CREDS = { username: 'ken2zhao', password: 'Aa123456' };

/** 登录为家长 */
export async function loginAsParent(page: Page) {
  await page.goto('/', { timeout: 20000, waitUntil: 'domcontentloaded' });
  await page.waitForURL(/.*#/, { timeout: 15000 });
  await page.waitForTimeout(1000);

  // 填写用户名和密码
  await page.locator('input').first().fill(PARENT_CREDS.username);
  await page.locator('input[type="password"]').fill(PARENT_CREDS.password);

  // 点击登录按钮
  const loginBtn = page.locator('button, [role="button"], [class*="btn"]').filter({ hasText: /登\s*录/ }).first();
  await loginBtn.click();

  // 等待登录完成 — 等待首页内容出现
  await page.waitForSelector('text=/欢迎回来|今日焦点|首页/', { timeout: 15000 });
}

/** 切换到指定 Tab（底部导航栏）— 直接点击 tab 文字 */
export async function switchTab(page: Page, tabName: '首页' | '任务' | '洞察' | '我的') {
  // 直接点击底部导航栏的文字标签
  const tab = page.locator(`text=${tabName}`).last();
  await tab.click({ timeout: 5000 });
  await page.waitForTimeout(1500);
}

/** 截图并返回路径 */
export async function screenshot(page: Page, name: string) {
  const path = `test-results/parent/${name}.png`;
  await page.screenshot({ path, timeout: 15000 });
  return path;
}

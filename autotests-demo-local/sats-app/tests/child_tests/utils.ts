import { Page, expect } from '@playwright/test';

/** 儿童账号凭据 */
export const CHILD_CREDS = { username: 'child_xiaoming', password: 'admin123' };

/** 登录为儿童 */
export async function loginAsChild(page: Page) {
  await page.goto('/', { timeout: 20000, waitUntil: 'domcontentloaded' });
  await page.waitForURL(/.*#/, { timeout: 15000 });
  await page.waitForTimeout(1000);

  // 关闭可能弹出的 uni-modal（隐私协议/更新提示等）
  const modalConfirm = page.locator('uni-modal button, .uni-modal button, [class*="modal"] button').first();
  try {
    if (await modalConfirm.isVisible({ timeout: 2000 })) {
      await modalConfirm.click();
      await page.waitForTimeout(500);
    }
  } catch (_) { /* no modal, continue */ }

  // 填写用户名和密码
  await page.locator('input').first().fill(CHILD_CREDS.username);
  await page.locator('input[type="password"]').fill(CHILD_CREDS.password);

  // 点击登录按钮（用 force 绕过可能的遮挡）
  const loginBtn = page.locator('button, [role="button"], [class*="btn"]').filter({ hasText: /登\s*录/ }).first();
  await loginBtn.click({ force: true });

  // 等待登录完成
  await page.waitForTimeout(3000);
}

/** 截图并返回路径 */
export async function screenshot(page: Page, name: string) {
  const path = `test-results/child/${name}.png`;
  await page.screenshot({ path, timeout: 30000 });
  return path;
}

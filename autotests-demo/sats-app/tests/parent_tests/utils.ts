import { Page, expect, APIRequestContext } from '@playwright/test';

export const PARENT_CREDS = { username: 'ken2zhao', password: 'admin123' };

async function dismissModal(page: Page) {
  try {
    const btns = page.locator('text=知道了, text=确定, text=关闭');
    const count = await btns.count();
    for (let i = 0; i < count; i++) {
      const btn = btns.nth(i);
      if (await btn.isVisible({ timeout: 800 })) {
        await btn.click({ force: true });
        await page.waitForTimeout(300);
      }
    }
  } catch {}
}

/**
 * 登录为家长
 * 使用 pressSequentially 填写表单，让应用自己完成加密+API调用
 */
export async function loginAsParent(page: Page, _request?: APIRequestContext) {
  const currentUrl = page.url();
  if (currentUrl.includes('home') || currentUrl.includes('dashboard') ||
      currentUrl.includes('task') || currentUrl.includes('insight')) return;

  // 导航到应用
  await page.goto('/', { timeout: 20000, waitUntil: 'domcontentloaded' });
  await page.waitForURL(/.*#/, { timeout: 15000 });
  await page.waitForTimeout(3000);
  await dismissModal(page);

  // 等待页面渲染完成
  await page.waitForTimeout(3000);

  // 检查是否已在 dashboard（非登录页）
  const bodyText = await page.evaluate(() => document.body.innerText.substring(0, 200));
  if (bodyText.includes('今日焦点') || bodyText.includes('任务总数') || bodyText.includes('创建任务')) {
    return; // 已登录
  }

  // 等待输入框出现
  const usernameInput = page.locator('input').first();
  const passwordInput = page.locator('input[type="password"]');
  await usernameInput.waitFor({ state: 'visible', timeout: 10000 });
  await passwordInput.waitFor({ state: 'visible', timeout: 10000 });
  await page.waitForTimeout(1000);

  // 用 pressSequentially 填写表单（触发键盘事件 → Vue reactivity）
  // 清空并填写用户名
  await usernameInput.click({ clickCount: 3 });
  await page.waitForTimeout(200);
  await usernameInput.pressSequentially(PARENT_CREDS.username, { delay: 50 });
  await page.waitForTimeout(500);

  // 清空并填写密码
  await passwordInput.click({ clickCount: 3 });
  await page.waitForTimeout(200);
  await passwordInput.pressSequentially(PARENT_CREDS.password, { delay: 50 });
  await page.waitForTimeout(800);

  // 验证填写结果
  const uVal = await usernameInput.inputValue().catch(() => '');
  const pVal = await passwordInput.inputValue().catch(() => '');
  if (!uVal || !pVal) {
    console.log('WARNING: Input values empty after pressSequentially');
  }

  // 点击登录按钮
  await page.getByText('登 录').click({ force: true, timeout: 5000 });

  // 等待登录完成（最多 15 秒）
  for (let i = 0; i < 15; i++) {
    await page.waitForTimeout(1000);
    try {
      const text = await page.evaluate(() => document.body.innerText.substring(0, 300));
      if (text.includes('今日焦点') || text.includes('任务总数') || text.includes('创建任务')) return;
    } catch {}
  }

  // 关闭可能的弹窗
  await dismissModal(page);
  await page.waitForTimeout(2000);

  // 再检查一次
  try {
    const text2 = await page.evaluate(() => document.body.innerText.substring(0, 300));
    if (text2.includes('今日焦点') || text2.includes('任务总数') || text2.includes('创建任务')) return;
  } catch {}

  // 只有确认还在登录页才重试
  try {
    const stillLoginPage = await page.evaluate(() => document.body.innerText.includes('欢迎回来') && document.body.innerText.includes('记住密码'));
    if (!stillLoginPage) return; // 已经不在登录页了
  } catch { return; }

  console.log('WARNING: Still on login page, retrying...');
  await dismissModal(page);

  const usernameInput2 = page.locator('input').first();
  const passwordInput2 = page.locator('input[type="password"]');
  await usernameInput2.click({ force: true });
  await usernameInput2.fill('');
  await usernameInput2.pressSequentially(PARENT_CREDS.username, { delay: 30 });
  await passwordInput2.click({ force: true });
  await passwordInput2.fill('');
  await passwordInput2.pressSequentially(PARENT_CREDS.password, { delay: 30 });
  await page.waitForTimeout(500);

  await page.getByText('登 录').click({ force: true, timeout: 5000 });
  await page.waitForTimeout(15000);
  await dismissModal(page);

  const finalText = await page.evaluate(() => document.body.innerText.substring(0, 200));
  if (!finalText.includes('今日焦点') && !finalText.includes('任务总数')) {
    console.log('WARNING: Login failed for', PARENT_CREDS.username);
  }
}

/** 切换到指定 Tab */
export async function switchTab(page: Page, tabName: '首页' | '任务' | '洞察' | '我的') {
  await dismissModal(page);
  await page.waitForTimeout(500);

  const tabEls = page.locator(`text=${tabName}`);
  const count = await tabEls.count();
  for (let i = count - 1; i >= 0; i--) {
    const el = tabEls.nth(i);
    const box = await el.boundingBox();
    if (box && box.y > 600) {
      await el.click({ force: true });
      await page.waitForTimeout(3000);
      return;
    }
  }

  const viewport = page.viewportSize() || { width: 375, height: 812 };
  const tabPositions: Record<string, number> = { '首页': 0.125, '任务': 0.375, '洞察': 0.625, '我的': 0.875 };
  const x = Math.round(viewport.width * tabPositions[tabName]);
  await page.mouse.click(x, 794);
  await page.waitForTimeout(3000);
}

export async function screenshot(page: Page, name: string) {
  const dir = 'test-results/parent';
  const fs = require('fs');
  if (!fs.existsSync(dir)) fs.mkdirSync(dir, { recursive: true });
  const p = `${dir}/${name}.png`;
  await page.screenshot({ path: p, timeout: 15000 });
  return p;
}

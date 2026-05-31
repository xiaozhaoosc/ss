/**
 * get-token.js
 * 通过 Playwright 浏览器自动化登录并提取 Sa-Token
 *
 * 用法: node get-token.js
 * 输出: token-parent.txt, token-child.txt
 */
const { chromium } = require('playwright');
const fs = require('fs');

const BASE_URL = 'http://10.8.0.1:8043/#';

async function loginAndGetToken(username, password, label) {
  const browser = await chromium.launch({ headless: true });
  const context = await browser.newContext();
  const page = await context.newPage();

  // 监听所有 API 响应，捕获 token
  let token = null;
  page.on('response', async (response) => {
    const url = response.url();
    if (url.includes('/auth/login') && response.status() === 200) {
      try {
        const body = await response.json();
        if (body.data && body.data.access_token) {
          token = body.data.access_token;
          console.log(`  [网络] 从 login 响应捕获 token: ${token.substring(0, 30)}...`);
        }
      } catch (e) {}
    }
    // 也从响应头捕获
    const headers = response.headers();
    if (headers['satoken']) {
      token = headers['satoken'];
      console.log(`  [网络] 从响应头 satoken 捕获: ${token.substring(0, 30)}...`);
    }
  });

  console.log(`  导航到 ${BASE_URL} ...`);
  await page.goto(BASE_URL, { timeout: 30000, waitUntil: 'networkidle' });

  // 等待页面加载完成
  await page.waitForTimeout(2000);

  // 截图调试
  await page.screenshot({ path: `debug-${label}-before-login.png` });
  console.log(`  截图: debug-${label}-before-login.png`);

  // 查找并填写登录表单
  const textInputs = page.locator('input[type="text"], input[type="tel"], input:not([type])');
  const pwdInputs = page.locator('input[type="password"]');

  const textCount = await textInputs.count();
  const pwdCount = await pwdInputs.count();
  console.log(`  找到 ${textCount} 个文本输入框, ${pwdCount} 个密码输入框`);

  if (textCount > 0 && pwdCount > 0) {
    await textInputs.first().fill(username);
    await pwdInputs.first().fill(password);
    console.log(`  已填写: ${username} / ${'*'.repeat(password.length)}`);

    // 查找登录按钮
    const loginBtn = page.locator('button').filter({ hasText: /登录|login|sign/i }).first();
    const btnVisible = await loginBtn.isVisible().catch(() => false);
    if (btnVisible) {
      await loginBtn.click();
      console.log('  点击登录按钮');
    } else {
      // 尝试其他选择器
      const anyBtn = page.locator('button, .login-btn, [class*="login"]').first();
      await anyBtn.click();
      console.log('  点击备选登录按钮');
    }

    // 等待登录完成
    await page.waitForTimeout(5000);
    await page.screenshot({ path: `debug-${label}-after-login.png` });
    console.log(`  截图: debug-${label}-after-login.png`);
  } else {
    console.log('  未找到登录表单，可能页面结构不同');
  }

  // 从 localStorage 提取 token
  if (!token) {
    token = await page.evaluate(() => {
      // 检查 App-Token
      const appToken = localStorage.getItem('App-Token');
      if (appToken) return appToken;

      // 遍历所有 localStorage 键
      const keys = Object.keys(localStorage);
      for (const key of keys) {
        const val = localStorage.getItem(key);
        if (key.toLowerCase().includes('token')) {
          return val;
        }
        try {
          const parsed = JSON.parse(val);
          if (parsed.access_token) return parsed.access_token;
          if (parsed.token) return parsed.token;
        } catch (e) {}
      }
      return null;
    });
    if (token) {
      console.log(`  [localStorage] 捕获 token: ${token.substring(0, 30)}...`);
    }
  }

  // 列出所有 localStorage 键用于调试
  const allKeys = await page.evaluate(() => Object.keys(localStorage));
  console.log(`  localStorage 键: [${allKeys.join(', ')}]`);

  await browser.close();
  return token;
}

(async () => {
  console.log('=== Small Steps Token Extractor ===\n');

  // 家长账号登录
  console.log('[1/2] 登录家长账号 ken2zhao ...');
  const parentToken = await loginAndGetToken('ken2zhao', 'admin123', 'parent');
  if (parentToken) {
    fs.writeFileSync('token-parent.txt', parentToken.trim());
    console.log(`  ✓ 家长 Token 已保存: token-parent.txt\n`);
  } else {
    console.log('  ✗ 家长 Token 获取失败\n');
  }

  // 儿童账号登录
  console.log('[2/2] 登录儿童账号 child_xiaoming ...');
  const childToken = await loginAndGetToken('child_xiaoming', 'admin123', 'child');
  if (childToken) {
    fs.writeFileSync('token-child.txt', childToken.trim());
    console.log(`  ✓ 儿童 Token 已保存: token-child.txt\n`);
  } else {
    console.log('  ✗ 儿童 Token 获取失败\n');
  }

  console.log('完成。Token 文件用于 stress-test.sh 压测脚本。');
})();

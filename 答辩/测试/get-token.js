/**
 * get-token.js
 * 通过 Playwright 浏览器自动化登录并提取 Sa-Token
 *
 * 用法: node get-token.js
 * 输出: token-parent.txt, token-child.txt
 */
const { chromium } = require('playwright');

const BASE_URL = 'http://10.8.0.1:8043/#';
const API_BASE = 'http://10.8.0.1:8081/ssapi';

async function loginAndGetToken(username, password) {
  const browser = await chromium.launch({ headless: true });
  const context = await browser.newContext();
  const page = await context.newPage();

  // 监听所有 API 请求，捕获 token
  let token = null;
  page.on('response', async (response) => {
    const url = response.url();
    if (url.includes('/ssapi/') && response.status() === 200) {
      const headers = response.headers();
      // Sa-Token 可能在 header 中返回
      if (headers['satoken'] || headers['authorization']) {
        token = headers['satoken'] || headers['authorization'];
      }
      // 也检查 response body 中的 token
      try {
        const body = await response.json();
        if (body.data && body.data.token) {
          token = body.data.token;
        } else if (body.data && body.data.access_token) {
          token = body.data.access_token;
        }
      } catch (e) {}
    }
  });

  await page.goto(BASE_URL, { timeout: 20000, waitUntil: 'domcontentloaded' });
  await page.waitForURL(/.*#/, { timeout: 15000 });

  // 填写登录表单
  const textInputs = page.locator('input[type="text"], input[type="tel"], input:not([type])');
  const pwdInputs = page.locator('input[type="password"]');
  await textInputs.first().fill(username);
  await pwdInputs.first().fill(password);

  // 点击登录
  const loginBtn = page.locator('button, .login-btn, [class*="login"]').first();
  await loginBtn.click();
  await page.waitForTimeout(3000);

  // 从 localStorage 提取 token
  if (!token) {
    const storage = await context.storageState();
    for (const origin of storage.origins || []) {
      for (const item of origin.localStorage || []) {
        if (item.name.toLowerCase().includes('token') || item.name.toLowerCase().includes('satoken')) {
          token = item.value;
          break;
        }
      }
    }
  }

  // 尝试直接从 localStorage 读取
  if (!token) {
    token = await page.evaluate(() => {
      const keys = Object.keys(localStorage);
      for (const key of keys) {
        const val = localStorage.getItem(key);
        if (key.toLowerCase().includes('token') || key.toLowerCase().includes('satoken')) {
          return val;
        }
        // 检查 JSON 值中是否包含 token
        try {
          const parsed = JSON.parse(val);
          if (parsed.token) return parsed.token;
          if (parsed.access_token) return parsed.access_token;
        } catch (e) {}
      }
      return null;
    });
  }

  await browser.close();
  return token;
}

(async () => {
  console.log('=== Small Steps Token Extractor ===\n');

  // 家长账号登录
  console.log('[1/2] 登录家长账号 parent_zhang ...');
  const parentToken = await loginAndGetToken('parent_zhang', 'admin123');
  if (parentToken) {
    require('fs').writeFileSync('token-parent.txt', parentToken.trim());
    console.log(`  ✓ Token 已保存: token-parent.txt (${parentToken.trim().substring(0, 20)}...)`);
  } else {
    console.log('  ✗ 家长 Token 获取失败');
  }

  // 儿童账号登录
  console.log('[2/2] 登录儿童账号 child_xiaoming ...');
  const childToken = await loginAndGetToken('child_xiaoming', 'admin123');
  if (childToken) {
    require('fs').writeFileSync('token-child.txt', childToken.trim());
    console.log(`  ✓ Token 已保存: token-child.txt (${childToken.trim().substring(0, 20)}...)`);
  } else {
    console.log('  ✗ 儿童 Token 获取失败');
  }

  console.log('\n完成。Token 文件用于 stress-test.sh 压测脚本。');
})();

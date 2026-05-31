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
  const apiResponses = [];

  page.on('response', async (response) => {
    const url = response.url();
    try {
      const status = response.status();
      // 记录所有 API 响应
      if (url.includes('/api/') || url.includes('/auth/') || url.includes('/ssapi/')) {
        const bodyText = await response.text().catch(() => '');
        apiResponses.push({ url, status, body: bodyText.substring(0, 500) });
        console.log(`  [API] ${status} ${url}`);

        // 检查响应体中的 token
        if (bodyText.includes('access_token') || bodyText.includes('token')) {
          console.log(`  [API 响应体] ${bodyText.substring(0, 200)}`);
        }
      }

      // 检查 login 响应
      if (url.includes('/login') && status === 200) {
        try {
          const body = await response.json();
          if (body.data && body.data.access_token) {
            token = body.data.access_token;
            console.log(`  [Token] 从 login 响应捕获: ${token.substring(0, 30)}...`);
          } else if (body.access_token) {
            token = body.access_token;
            console.log(`  [Token] 从 login 响应根节点捕获: ${token.substring(0, 30)}...`);
          }
        } catch (e) {}
      }

      // 从响应头捕获 satoken
      const headers = response.headers();
      if (headers['satoken']) {
        token = headers['satoken'];
        console.log(`  [Token] 从响应头 satoken 捕获: ${token.substring(0, 30)}...`);
      }
    } catch (e) {}
  });

  console.log(`  导航到 ${BASE_URL} ...`);
  await page.goto(BASE_URL, { timeout: 30000, waitUntil: 'networkidle' });
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

    // 登录按钮可能是 div/span 而非 button，用文本选择器查找
    // 从截图看，按钮文字为 "登 录"（中间有空格）
    let loginClicked = false;

    // 尝试多种选择器
    const selectors = [
      'text=登 录',
      'text=登录',
      '[class*="login-btn"]',
      '[class*="btn"]',
      '.el-button',
      '[role="button"]',
      'div >> text=登',
    ];

    for (const sel of selectors) {
      try {
        const el = page.locator(sel).first();
        const visible = await el.isVisible().catch(() => false);
        if (visible) {
          console.log(`  找到登录元素: "${sel}"，点击中...`);
          await el.click({ force: true });
          loginClicked = true;
          console.log('  ✓ 已点击登录按钮');
          break;
        }
      } catch (e) {}
    }

    if (!loginClicked) {
      // 兜底：用坐标点击（从截图看，按钮大约在页面中间偏下）
      console.log('  未通过选择器找到按钮，尝试坐标点击...');
      // 先打印页面上所有可见的可点击元素
      const clickableInfo = await page.evaluate(() => {
        const elements = document.querySelectorAll('div, span, a, button, input[type="submit"]');
        const results = [];
        for (const el of elements) {
          const text = el.textContent?.trim();
          if (text && text.length < 20) {
            const rect = el.getBoundingClientRect();
            if (rect.width > 100 && rect.height > 30) {
              results.push({
                tag: el.tagName,
                class: el.className?.substring?.(0, 60),
                text: text,
                x: Math.round(rect.x + rect.width / 2),
                y: Math.round(rect.y + rect.height / 2),
                w: Math.round(rect.width),
                h: Math.round(rect.height),
              });
            }
          }
        }
        return results;
      });
      console.log('  页面上的大元素:');
      for (const el of clickableInfo) {
        console.log(`    <${el.tag}> class="${el.class}" text="${el.text}" ${el.w}x${el.h} @(${el.x},${el.y})`);
      }

      // 点击包含 "登录" 文本的元素
      for (const el of clickableInfo) {
        if (el.text.includes('登') && el.w > 200) {
          console.log(`  点击坐标: (${el.x}, ${el.y})`);
          await page.mouse.click(el.x, el.y);
          loginClicked = true;
          break;
        }
      }
    }

    // 等待登录响应
    console.log('  等待登录响应...');
    await page.waitForTimeout(5000);

    // 截图
    await page.screenshot({ path: `debug-${label}-after-login.png` });
    console.log(`  截图: debug-${label}-after-login.png`);

    // 打印 API 响应日志
    console.log(`  捕获到 ${apiResponses.length} 个 API 响应`);
    for (const resp of apiResponses) {
      console.log(`    ${resp.status} ${resp.url}`);
      if (resp.body) {
        console.log(`      body: ${resp.body.substring(0, 150)}`);
      }
    }
  } else {
    console.log('  未找到登录表单');
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

  // 列出所有 localStorage 键
  const allKeys = await page.evaluate(() => Object.keys(localStorage));
  console.log(`  localStorage 键: [${allKeys.join(', ')}]`);

  // 检查当前 URL
  console.log(`  当前页面 URL: ${page.url()}`);

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

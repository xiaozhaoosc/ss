const { chromium } = require('playwright');
const fs = require('fs');

const BUG_FILE = 'bug_20260427.md';
function logBug(bug) {
  const timestamp = new Date().toISOString();
  fs.appendFileSync(BUG_FILE, `- [${timestamp}] ${bug}\n`);
  console.log(`[BUG LOGGED] ${bug}`);
}

(async () => {
  const browser = await chromium.launch({ headless: true });
  const context = await browser.newContext();
  const page = await context.newPage();
  
  const issues = [];
  page.on('response', response => {
    if (response.status() >= 400 && response.url().includes('localhost')) {
      const msg = `API Error: ${response.status()} ${response.statusText()} on ${response.url()}`;
      issues.push(msg);
      logBug(msg);
    }
  });

  page.on('pageerror', error => {
    const msg = `Console Error: ${error.message}`;
    issues.push(msg);
    logBug(msg);
  });

  try {
    console.log('Navigating to login...');
    await page.goto('http://localhost:9090/#/login', { waitUntil: 'networkidle' });
    await page.waitForTimeout(2000); // give it time to render

    // Attempt to log in
    console.log('Logging in as ken2zhao...');
    // We saw the a11y tree has "账号 textbox" and "密码 textbox"
    const inputs = page.locator('input');
    await inputs.nth(0).fill('ken2zhao');
    await inputs.nth(1).fill('Aa123456');
    
    // Close any error popups like "知道了"
    const confirmBtn = page.locator('text=知道了');
    if (await confirmBtn.isVisible()) {
      console.log('Found error popup, dismissing...');
      await confirmBtn.click();
      await page.waitForTimeout(1000);
    }

    // Attempt to click login. We saw "登录" button or text
    await page.locator('button', { hasText: '登 录' }).click({ force: true }).catch(async () => {
      // fallback
      await page.locator('text=登 录').click({ force: true });
    });

    await page.waitForTimeout(3000);
    console.log('Login attempt finished. Current URL:', page.url());

    // If still on login page, there might be an error popup
    if (page.url().includes('login')) {
      const pageText = await page.locator('body').innerText();
      logBug(`Failed to login. URL is still login. Page text excerpt: ${pageText.substring(0, 200)}...`);
    } else {
      // Explore "家长中心" (Parent Center)
      console.log('Checking menus...');
      const snapshot = await page.locator('body').ariaSnapshot();
      console.log('A11y Snapshot:', snapshot);
      
      // Let's look for the menus. We don't know the exact text yet.
      // We will write another script once we see this snapshot, or we'll just log the snapshot for now.
    }
  } catch (err) {
    console.error('Test script crashed:', err);
    logBug(`Playwright script crashed: ${err.message}`);
  } finally {
    await browser.close();
    console.log('Finished exploratory login step.');
  }
})();